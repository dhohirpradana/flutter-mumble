import 'dart:io';

import 'package:dumble/dumble.dart';

ConnectionOptions defaulConnectionOptions = ConnectionOptions(
    host: 's51440.kita-kita.online',
    port: 51440,
    name: 'Jateng40_Timur02_DhohirPradana_081335343635',
    password: 's51440');

/// Connect a Mumble server with a user certificate.
/// If you connect with certificate, you can register your self.
/// Instead of passwords, Mumble uses certificates to identify users.
final ConnectionOptions defaulConnectionOptionsWithCertificate =
    ConnectionOptions(
        host: defaulConnectionOptions.host,
        name: defaulConnectionOptions.name,
        port: defaulConnectionOptions.port,
        password: defaulConnectionOptions.password,
        context: SecurityContext(withTrustedRoots: true)
          ..usePrivateKey('assets/dumble_key.pem')
          ..useCertificateChain('assets/dumble_cert.pem'));
