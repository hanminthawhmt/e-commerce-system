import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multi_store_app/models/user.dart';

// manage the state of Type User
// state notifier allows to update the state and notify listeners
class UserProvider extends StateNotifier<User?> {
  // constructor initializing with default User Object
  // manage the state of User Object allowing updates
  // super calls the constructor of StateNotifier and sets the Initial value to inital user state which is empty initally
  UserProvider()
      : super(User(
            id: '',
            fullName: '',
            email: '',
            state: '',
            city: '',
            locality: '',
            password: '',
            token: ''));
//  StateNotifier class already has a property called state -> in this case state is of type User
// no need to define state yourself, inherited from the StateNotifier

  User? get user => state;

  void setUser(String userJosn) {
    state = User.fromJson(userJosn);
  }
}

// <Notifer Class, Type of State inside the notifier)
// make the data accessible within the application
final userProvider =
    StateNotifierProvider<UserProvider, User?>((ref) => UserProvider());
