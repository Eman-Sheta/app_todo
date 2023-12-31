import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_to_do/Model/My_user.dart';
import 'package:flutter_app_to_do/Model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskFireStore(Task task, String uId) {
    var taskCollection = getTasksCollection(uId);
    DocumentReference<Task> docRef = taskCollection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteTaskFormFireStore(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> editIsDone(Task task, String uId) {
    return getTasksCollection(uId)
        .doc(task.id)
        .update({'isDone': !task.isDone!});
  }

  static Future<void> editTask(Task task, String uId) {
    return getTasksCollection(uId).doc(task.id).update(task.toFireStore());
  }

  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (user, options) => user.toFireStore());
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uid) async {
    var querySnapshot = await getUsersCollection().doc(uid).get();
    return querySnapshot.data();
  }
}
