import 'package:template/io/repository/user_repository.dart';
import 'package:template/ui/feature/board/app_board_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [TemplateNotifier] provider
final templateProvider = StateNotifierProvider<TemplateNotifier, TemplateState>(
  (ref) {
    final UserRepository userRepository = ref.read(userRepoProvider);
    return TemplateNotifier(userRepository).._checkAppStart();
  },
);

class TemplateNotifier extends StateNotifier<TemplateState> {
  final UserRepository _userRepository;

  TemplateNotifier(UserRepository userRepository)
      : _userRepository = userRepository,
        super(TemplateState.initial());

  Future<void> _checkAppStart() async {
    final isLoggedIn = await _userRepository.isLoggedIn();
    if (isLoggedIn) {
      state = const TemplateState(RedirectPage.home);
    }
  }
}
