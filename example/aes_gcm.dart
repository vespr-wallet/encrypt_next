// ignore_for_file: avoid_print

import "dart:convert";
import "dart:typed_data";

import "package:encrypt_next/encrypt.dart";

void main() {
  const plainText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit";
  const messageAuthenticationCode = "flutter is awesome";

  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);
  final macValue = Uint8List.fromList(utf8.encode(messageAuthenticationCode));

  final encrypter = Encrypter(AES(key, mode: AESMode.gcm));

  final encrypted = encrypter.encrypt(
    plainText,
    iv: iv,
    associatedData: macValue,
  );
  final decrypted = encrypter.decrypt(
    encrypted,
    iv: iv,
    associatedData: macValue,
  );

  print(decrypted);
  print(encrypted.bytes);
  print(encrypted.base16);
  print(encrypted.base64);
}
