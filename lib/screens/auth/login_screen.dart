// Pantalla de inicio de sesión. Contiene el formulario de email
// y contraseña, y navega a MainScreen al autenticarse.
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../../application/usecases/save_login_usecase.dart';
import '../../infrastructure/repositories/session_repository_impl.dart';
import '../../data/services/backend_service.dart';
import 'register_screen.dart';
import '../home/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;

  final _sessionRepo = SessionRepositoryImpl();
  late final _saveLogin = SaveLoginUseCase(_sessionRepo);
  final _backendService = BackendService();

  String? _emailError;
  String? _passwordError;

  bool _validate() {
    String? emailErr;
    String? passErr;
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;

    if (email.isEmpty) {
      emailErr = 'El email no puede estar vacio';
    } else if (!email.contains('@') || !email.contains('.')) {
      emailErr = 'Ingresa un email valido';
    }
    if (password.isEmpty) {
      passErr = 'La contrasena no puede estar vacia';
    } else if (password.length < 6) {
      passErr = 'Minimo 6 caracteres';
    }

    setState(() {
      _emailError = emailErr;
      _passwordError = passErr;
    });
    return emailErr == null && passErr == null;
  }

  void _login() async {
    if (!_validate()) return;
    setState(() => _loading = true);

    try {
      final response = await _backendService.login(
        _emailCtrl.text.trim(),
        _passwordCtrl.text,
      );

      if (!mounted) return;

      // Suponiendo que el backend devuelve algo como:
      // { "user": { "name": "...", "email": "...", "role": "..." }, "token": "..." }
      final userData = response['user'] ?? {};

      // Guarda la sesion localmente
      await _saveLogin.call(
        name: userData['name'] ?? 'Usuario',
        email: userData['email'] ?? _emailCtrl.text.trim(),
        role: userData['role'] ?? 'student',
      );

      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bienvenido de vuelta!'),
          backgroundColor: AppColors.success,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()));
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const SPLogo(fontSize: 26),
              const SizedBox(height: 40),
              const Text('Welcome Back',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 36),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Login', style: AppTextStyles.heading3)),
              const SizedBox(height: 16),
              SPTextField(
                  label: 'Username/Email',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  errorText: _emailError),
              const SizedBox(height: 20),
              SPTextField(
                label: 'Password',
                controller: _passwordCtrl,
                obscureText: _obscure,
                errorText: _passwordError,
                suffixIcon: IconButton(
                  icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.textHint, size: 20),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: const Text('Forgot password?',
                      style: AppTextStyles.caption),
                ),
              ),
              const SizedBox(height: 32),
              SPButton(label: 'Login', onTap: _login, isLoading: _loading),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ",
                      style: AppTextStyles.caption),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => const RegisterScreen())),
                    child: const Text('Register', style: AppTextStyles.link),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
