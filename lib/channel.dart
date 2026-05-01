import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class Channel {
  const Channel({
    required this.name,
    required this.thumbnail,
    required this.streamUrl,
    this.userAgent,
  });

  final String name;

  final String thumbnail;

  final String streamUrl;

  final String? userAgent;
}
