frr:
	flutter run --release
fc:
	flutter clean
ff:
	flutter build apk --release
fv:
	flutter run -d emulator-5554 --verbose > flutter_log.txt 2>&1
dgc:
	rd /s /q %USERPROFILE%\.gradle\caches
adb:
	adb kill-server && adb start-server
adbc:
	adb connect 127.0.0.1:16384

.PHONY:	frr dgc fc ff fv