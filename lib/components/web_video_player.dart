import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

@NowaGenerated()
class WebVideoPlayer extends StatefulWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const WebVideoPlayer({required this.url, super.key});

  final String url;

  @override
  State<WebVideoPlayer> createState() {
    return _WebVideoPlayerState();
  }
}

@NowaGenerated()
class _WebVideoPlayerState extends State<WebVideoPlayer> {
  InAppWebViewController? _webViewController;

  static final Set<String> _adBlockList = {
    'doubleclick',
    'popads',
    'popcash',
    'adsterra',
    'onclickads',
  };

  List<ContentBlocker> _generateBlockers() {
    List<ContentBlocker> blockers = [];
    for (var domain in _adBlockList) {
      blockers.add(
        ContentBlocker(
          trigger: ContentBlockerTrigger(urlFilter: '.*${domain}.*'),
          action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
        ),
      );
    }
    blockers.add(
      ContentBlocker(
        trigger: ContentBlockerTrigger(urlFilter: '.*/ads/.*'),
        action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
      ),
    );
    blockers.add(
      ContentBlocker(
        trigger: ContentBlockerTrigger(urlFilter: '.*/banner/.*'),
        action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
      ),
    );
    blockers.add(
      ContentBlocker(
        trigger: ContentBlockerTrigger(urlFilter: '.*ad.*'),
        action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
      ),
    );
    blockers.add(
      ContentBlocker(
        trigger: ContentBlockerTrigger(urlFilter: '.*\\.m3u8\\?token=.*'),
        action: ContentBlockerAction(type: ContentBlockerActionType.BLOCK),
      ),
    );
    return blockers;
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.url)),
      initialSettings: InAppWebViewSettings(
        mediaPlaybackRequiresUserGesture: false,
        javaScriptEnabled: true,
        useShouldOverrideUrlLoading: true,
        javaScriptCanOpenWindowsAutomatically: false,
        contentBlockers: _generateBlockers(),
        allowsInlineMediaPlayback: true,
      ),
      onWebViewCreated: (controller) {
        _webViewController = controller;
      },
      onCreateWindow: (controller, createWindowAction) async => false,
      onLoadStop: (controller, url) async {
        await controller.evaluateJavascript(
          source:
              '            (function() {\n              // Remove advertising iframes and common UI clutter\n              const adSelectors = [\n                \'iframe\', \'header\', \'footer\', \'nav\', \'aside\', \n                \'.ads\', \'.banner\', \'.pop-up\', \'#ads\', \'.ad-container\',\n                \'[id*="google_ads"]\', \'[class*="advertisement"]\'\n              ];\n              \n              function cleanUI() {\n                adSelectors.forEach(selector => {\n                  document.querySelectorAll(selector).forEach(el => {\n                    el.style.display = \'none\';\n                    el.remove();\n                  });\n                });\n              }\n\n              cleanUI();\n              // Periodically clean in case of dynamic ads\n              setInterval(cleanUI, 3000);\n\n              // Find video and attempt auto-play/fullscreen\n              const video = document.querySelector(\'video\');\n              if (video) {\n                video.play().catch(e => console.log("Autoplay blocked"));\n                \n                // Look for native fullscreen button or use API\n                const fullscreenBtn = document.querySelector(\'.fullscreen, [class*="fullscreen"], [id*="fullscreen"]\');\n                if (fullscreenBtn) {\n                  fullscreenBtn.click();\n                } else {\n                  if (video.requestFullscreen) video.requestFullscreen();\n                  else if (video.webkitRequestFullscreen) video.webkitRequestFullscreen();\n                }\n              }\n            })();\n          ',
        );
      },
    );
  }
}
