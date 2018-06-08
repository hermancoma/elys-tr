import 'dart:async';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<RemoteConfig> getHomeUrl() async {
    
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));

  // final defaults = <String, dynamic>{
  //   'elystr_homeurl' : 'https://google.com/',
  //   'elystr_appbar_title' : 'Now Loading'
  //   };
  // await remoteConfig.setDefaults(defaults);
  await remoteConfig.fetch(expiration: const Duration(hours: 12));
  await remoteConfig.activateFetched();

  print('\nHome URL : ' + remoteConfig.getString('elystr_homeurl') + '\nTitle : ' +
  remoteConfig.getString('elystr_appbar_title'));

  return remoteConfig;
}