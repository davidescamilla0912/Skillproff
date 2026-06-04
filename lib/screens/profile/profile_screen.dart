import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../application/usecases/get_user_data_usecase.dart';
import '../../application/usecases/logout_usecase.dart';
import '../../infrastructure/repositories/session_repository_impl.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _tab = 'general';
  String _userName  = 'Christina Angela';
  String _userEmail = 'admin@mail.com';
  final _sessionRepo = SessionRepositoryImpl();
  late final _getUserData = GetUserDataUseCase(_sessionRepo);
  late final _logoutUse = LogoutUseCase(_sessionRepo);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Carga los datos guardados en shared_preferences
  void _loadUserData() async {
    final data = await _getUserData.call();
    if (mounted) {
      setState(() {
        _userName  = data['name']  ?? 'Christina Angela';
        _userEmail = data['email'] ?? 'admin@mail.com';
      });
    }
  }

  // Cierra sesion: borra shared_preferences y regresa al Login
  void _logout() async {
    await _logoutUse.call();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: Column(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(children: [
              Container(
                  width: 80, height: 80,
                  decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                  child: const Icon(Icons.person, size: 50, color: Colors.grey)),
              const SizedBox(height: 10),
              // Muestra el nombre guardado en shared_preferences
              Text(_userName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              const Text('@admin123', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(child: _TabBtn(label: 'General', isSelected: _tab == 'general',
                    onTap: () => setState(() => _tab = 'general'))),
                const SizedBox(width: 8),
                Expanded(child: _TabBtn(label: 'Pruebas Verificadas', isSelected: _tab == 'verified',
                    onTap: () => setState(() => _tab = 'verified'))),
              ]),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 8),
                Container(
                  color: Colors.white,
                  child: _tab == 'general' ? _buildGeneral() : _buildVerified(),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _logout,
                  child: const Text('Cerrar Sesion',
                      style: TextStyle(fontSize: 16, color: AppColors.primary, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildGeneral() {
    final fields = [
      {'icon': Icons.person_outline,  'label': 'Nombre',     'value': _userName},
      {'icon': Icons.email_outlined,  'label': 'Email',      'value': _userEmail},
      {'icon': Icons.lock_outline,    'label': 'Contrasena', 'value': 'Toca para cambiarla'},
      {'icon': Icons.phone_outlined,  'label': 'Telefono',   'value': '(684) 555-0102'},
    ];
    return Column(
        children: fields.map((f) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
          child: Row(children: [
            Icon(f['icon'] as IconData, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(f['label'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              Text(f['value'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
            const Text('Editar', style: TextStyle(fontSize: 11, color: AppColors.primary)),
          ]),
        )).toList());
  }

  Widget _buildVerified() {
    final skills = [
      {'emoji': '🥇', 'title': 'React',      'desc': 'Creacion de componentes, manejo de estado con Hooks'},
      {'emoji': '🥇', 'title': 'Git - GitHub','desc': 'Control de versiones, pull requests y colaboracion'},
      {'emoji': '🥇', 'title': 'HTML - CSS',  'desc': 'Maquetacion web semantica, diseno responsivo'},
    ];
    return Column(
        children: skills.map((s) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.divider))),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(s['emoji']!, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s['title']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(s['desc']!, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
          ]),
        )).toList());
  }
}

class _TabBtn extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _TabBtn({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.border)),
        child: Text(label, textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textSecondary)),
      ),
    );
  }
}
