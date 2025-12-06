import 'dart:io';

void main() {
  // Android: transparent launch background
  File('android/app/src/main/res/drawable/launch_background.xml').writeAsStringSync('''
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
    <item android:drawable="@android:color/transparent"/>
</layer-list>
''');

  // Remove meta-data from AndroidManifest.xml
  final manifestFile = File('android/app/src/main/AndroidManifest.xml');
  var content = manifestFile.readAsStringSync();
  content = content.replaceAll(RegExp(
      r'<meta-data android:name="io.flutter.embedding.android.SplashScreenDrawable"[\s\S]*?/>'), '');
  manifestFile.writeAsStringSync(content);

  // iOS LaunchScreen.storyboard: transparent
  File('ios/Runner/LaunchScreen.storyboard').writeAsStringSync('''
<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard">
    <scenes>
        <scene sceneID="default">
            <objects>
                <view key="view" contentMode="scaleToFill" id="view">
                    <rect key="frame" x="0.0" y="0.0" width="375" height="812"/>
                    <color key="backgroundColor" red="1" green="1" blue="1" alpha="0"/>
                </view>
            </objects>
        </scene>
    </scenes>
</document>
''');

  print('✅ flutter_native_splash removed and transparent splash applied.');
}
