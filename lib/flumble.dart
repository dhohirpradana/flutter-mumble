import 'dart:io';
import 'package:dumble/dumble.dart';
import 'connection_option.dart';

class Flumble {
  static MumbleClient? mc;
  static Future<void> connect() async {
    MumbleClient client = await MumbleClient.connect(
        options: defaulConnectionOptionsWithCertificate,
        onBadCertificate: (X509Certificate certificate) {
          //Accept every certificate
          return true;
        });
    MumbleExampleCallback callback = MumbleExampleCallback(client);
    client.add(callback);
    mc = client;
    print('Client synced with server!');
    print('Listing channels...');
    final channel = client.getChannels();
    print(channel);
    print('Listing users...');
    print(client.getUsers());
    // Watch all users that are already on the server
    // New users will reported to the callback (because of line 14) and we will
    // watch these new users in onUserAdded below
    client.getUsers().values.forEach((User element) => element.add(callback));
    // Also, watch self
    client.self.add(callback);

    // Set a comment for us
    // client.self.setComment(comment: 'I\'m a bot!');
// Create a channel. If the channel is succesfully created, our callback is invoked.
    // client.createChannel(name: 'Dumble Test Channel');

    final currChannel = client.self.channel.name;
    print('aku ada di channel ' + currChannel.toString());
  }

  static moveChannel() async {
    if (mc != null) {
      // mc!.self.mute == false;
      mc!.self.channel.channelId == 258;
      mc = null;
      print('mengdone');
    }
    print('tidak dalam channel!');
  }

  static leftServer() async {
    if (mc != null) {
      mc!.close();
      mc = null;
    }

    print('tidak dalam channel!');
  }
}

class MumbleExampleCallback with MumbleClientListener, UserListener {
  final MumbleClient client;

  const MumbleExampleCallback(this.client);

  @override
  void onBanListReceived(List<BanEntry> bans) {}

  @override
  void onChannelAdded(Channel channel) {
    if (channel.channelId == 258) {
      // This is our channel
      // join it
      client.self.moveToChannel(channel: channel);
      print('pindah channel');
    }

    print('gagal pindah channel');
  }

  @override
  void onCryptStateChanged() {}

  @override
  void onDone() {}

  @override
  void onDropAllChannelPermissions() {}

  @override
  void onError(error, [StackTrace? stackTrace]) {
    throw error;
  }

  @override
  void onQueryUsersResult(Map<int, String> idToName) {}

  @override
  void onTextMessage(IncomingTextMessage message) {
    print('[${new DateTime.now()}] ${message.actor?.name}: ${message.message}');
  }

  @override
  void onUserAdded(User user) {
    //Keep an eye on the user
    user.add(this);
  }

  @override
  void onUserListReceived(List<RegisteredUser> users) {}

  @override
  void onUserChanged(User? user, User? actor, UserChanges changes) {
    print('User $user changed $changes');
    // The user changed
    if (changes.channel) {
      // ...his channel
      if (user?.channel == client.self.channel) {
        // ... to our channel
        // So greet him
        client.self.channel
            .sendMessageToChannel(message: 'Hello ${user?.name}!');
      }
    }
  }

  @override
  void onUserRemoved(User user, User? actor, String? reason, bool? ban) {
    if (user == actor) {
      //The user left the server
    } else if (ban ?? false) {
      // The user was baned from the server
    } else {
      // The user was kicked from the server
    }
  }

  @override
  void onUserStats(User user, UserStats stats) {}
}
