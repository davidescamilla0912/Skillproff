// Pantalla de registro de nuevo usuario. Al completarse,
// redirige al flujo de onboarding (Onboarding2Screen).
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/shared_widgets.dart';
import '../onboarding/onboarding2_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String _registerAs = 'student';

  String? _emailError;
  String? _passwordError;
  String? _phoneError;

  bool _validate() {
    String? emailErr;
    String? passErr;
    String? phoneErr;

    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text;
    final phone = _phoneCtrl.text.trim();

    if (email.isEmpty) {
      emailErr = 'El email no puede estar vacío';
    } else if (!email.contains('@') || !email.contains('.')) {
      emailErr = 'Ingresa un email válido';
    }

    if (password.isEmpty) {
      passErr = 'La contraseña no puede estar vacía';
    } else if (password.length < 6) {
      passErr = 'Mínimo 6 caracteres';
    }

    if (phone.isEmpty) {
      phoneErr = 'El teléfono no puede estar vacío';
    } else if (phone.length < 7) {
      phoneErr = 'Número de teléfono inválido';
    }

    setState(() {
      _emailError = emailErr;
      _passwordError = passErr;
      _phoneError = phoneErr;
    });

    return emailErr == null && passErr == null && phoneErr == null;
  }

  void _register() async {
    if (!_validate()) return;

    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Cuenta creada exitosamente!'),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Onboarding2Screen()));
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _phoneCtrl.dispose();
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
              const SizedBox(height: 36),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Register', style: AppTextStyles.heading3)),
              const SizedBox(height: 16),
              SPTextField(
                label: 'Email',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                errorText: _emailError,
              ),
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
              const SizedBox(height: 20),
              SPTextField(
                label: 'Phone Number',
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                errorText: _phoneError,
              ),
              const SizedBox(height: 24),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Register As?', style: AppTextStyles.caption)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Radio<String>(
                      value: 'student',
                      groupValue: _registerAs,
                      onChanged: (v) => setState(() => _registerAs = v!),
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity.compact),
                  const Text('Student', style: AppTextStyles.body),
                  const SizedBox(width: 20),
                  Radio<String>(
                      value: 'company',
                      groupValue: _registerAs,
                      onChanged: (v) => setState(() => _registerAs = v!),
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity.compact),
                  const Text('Empresa', style: AppTextStyles.body),
                ],
              ),
              const SizedBox(height: 32),
              SPButton(
                  label: 'Register', onTap: _register, isLoading: _loading),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account? ', style: AppTextStyles.caption),
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Text('Login', style: AppTextStyles.link)),
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
