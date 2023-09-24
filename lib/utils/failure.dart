enum FailureReason { authError, normalError }

class FailTure {
  final String message;
  final FailureReason reason;

  FailTure(this.message, {this.reason = FailureReason.normalError});
}
