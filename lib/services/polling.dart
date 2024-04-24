import 'dart:async';
import 'package:http/http.dart' as http;

class PollingClass {
  Timer? _timer;
  final String _apiEndpoint;
  final void Function(http.Response) _onSuccess;
  final void Function() _onTimeout;

  PollingClass(this._apiEndpoint, this._onSuccess, this._onTimeout);

  void startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final response = await http.get(Uri.parse(_apiEndpoint));
        if (response.statusCode == 200) {
          _onSuccess(response);
          stopPolling();
        }
      } catch (error) {
        print(error);
      }
    });

    // Automatic timeout after 30 seconds
    Future.delayed(const Duration(seconds: 30), () {
      if (_timer?.isActive ?? false) {
        stopPolling();
        _onTimeout();
      }
    });
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }
}