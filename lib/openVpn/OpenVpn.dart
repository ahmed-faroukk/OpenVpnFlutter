// openvpn_service.dart
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';


String config = "YOUR OPENVPN CONFIG HERE";
// handles route configuration automatically based on the server configuration and settings
class OpenVpnService {
  late OpenVPN _engine;
  VpnStatus? _status;
  VPNStage? _stage;
  bool _granted = false;

  OpenVpnService() {
    _engine = OpenVPN(
      onVpnStatusChanged: (data) {
        _status = data;
      },
      onVpnStageChanged: (data, raw) {
        _stage = data;
      },
    );

    _engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier:
      "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (stage) {
        _stage = stage;
      },
      lastStatus: (status) {
        _status = status;
      },
    );
  }

  // "USA" for country
  Future<void> connectToVpn(String username , String password , String country) async {
    _engine.connect(config, country,
        username: username,
        password: password,
        certIsRequired: true);
  }

  void disconnectFromVpn() {
    _engine.disconnect();
  }


  VpnStatus? get vpnStatus => _status;
  VPNStage? get vpnStage => _stage;
  bool get isPermissionGranted => _granted;
}



