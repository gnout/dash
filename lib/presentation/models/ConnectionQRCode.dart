class ConnectionQRCode {
  final String? qrCodeLink;
  final String? sessionID;

  ConnectionQRCode({
    this.qrCodeLink,
    this.sessionID,
  });

  ConnectionQRCode copyWith({
    String? qrCodeLink,
    String? sessionID,
  }) {
    return ConnectionQRCode(
      qrCodeLink: qrCodeLink ?? this.qrCodeLink,
      sessionID: sessionID ?? this.sessionID,
    );
  }
}