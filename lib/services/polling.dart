import 'dart:async';
import 'package:http/http.dart' as http;

class PollingClass {
  Timer? _timer;
  final String _apiEndpoint = 'your_api_endpoint';
  final void Function(http.Response) _onSuccess;
  final void Function() _onTimeout;
  final void Function() _onCancel;

  PollingClass(this._onSuccess, this._onTimeout, this._onCancel);

  void startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        final response = await http.get(Uri.parse(_apiEndpoint));
        if (response.statusCode == 200) {
          _onSuccess(response);
          stopPolling();
        }
      } catch (error) {
      }
    });
  }

  void stopPolling() {
    _timer?.cancel();
    _timer = null;
  }
}