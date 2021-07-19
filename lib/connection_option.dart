import 'dart:io';

import 'package:dumble/dumble.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

ConnectionOptions defaultConnectionOptions = ConnectionOptions(
    host: dotenv.env['host']!,
    port: int.parse(dotenv.env['port']!),
    name: dotenv.env['name']!,
    password: dotenv.env['password']!);

/// Connect a Mumble server with a user certificate.
/// If you connect with certificate, you can register your self.
/// Instead of passwords, Mumble uses certificates to identify users.
final ConnectionOptions defaulConnectionOptionsWithCertificate =
    ConnectionOptions(
        host: defaultConnectionOptions.host,
        name: defaultConnectionOptions.name,
        port: defaultConnectionOptions.port,
        password: defaultConnectionOptions.password,
        context: SecurityContext(withTrustedRoots: true)
        // ..usePrivateKey('assets/dumble_key.pem')
        // ..useCertificateChain('assets/dumble_cert.pem')
        );
