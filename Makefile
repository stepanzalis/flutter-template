
.PHONY: dependencies
dependencies:
	@echo "╠ Running flutter pub get"
	flutter pub get

.PHONY: analyze
analyze:
	@echo "╠ Analyzing project ..."
	flutter analyze

.PHONY: format 
format:
	@echo "╠ Formatting whole project ..."
	flutter format lib/

.PHONY: format-analyze
format-analyze:
	flutter format --dry-run lib/
	flutter analyze

.PHONY: build-runner
build-runner:		
	@echo "╠ Running build runner with deleted outputs"
	flutter packages pub run build_runner build --delete-conflicting-outputs

.PHONY: run-stage
run-stage:
	@echo "╠ Running STAGE version of the app ..."
	flutter run --dart-define=environment=STAGE --target lib/main.dart

.PHONY: run-prod
run-prod:
	@echo "╠ Running PROD version of the app ..."
	flutter run --dart-define=environment=PROD --target lib/main.dart

.PHONY: run-stage-release
run-stage:
	@echo "╠ Running STAGE version of the app ..."
	flutter run --release --dart-define=environment=STAGE --target lib/main.dart 

.PHONY: run-prod-release
run-prod:
	@echo "╠ Running PROD version of the app ..."
	flutter run --release --dart-define=environment=PROD --target lib/main.dart

.PHONY: build-android-stage
build-android-stage:
	@echo "╠ Building Android STAGE version of the app ..."
	flutter build apk --dart-define=environment=STAGE --target lib/main.dart

.PHONY: build-android-prod
build-android-prod:
	@echo "╠ Building Android PROD version of the app ..."
	flutter build apk --release --dart-define=environment=PROD --target lib/main.dart

.PHONY: build-ios-stage
build-ios-stage:
	@echo "╠ Building iOS STAGE version of the app ..."
	flutter build ios --no-codesign --dart-define=environment=STAGE --target lib/main.dart

.PHONY: build-ios-prod
build-ios-prod:
	@echo "╠ Building iOS PROD version of the app ..."
	flutter build ios --release --no-codesign --dart-define=environment=PROD --target lib/main.dart
