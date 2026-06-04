// Pantalla de detalle de una oferta laboral. Muestra descripción
// de la empresa, requisitos del cargo y botón para postularse.
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../domain/entities/entities.dart';
import '../../widgets/shared_widgets.dart';

class EmpresaDetailScreen extends StatelessWidget {
  final JobModel job;
  const EmpresaDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1), child: Divider(height: 1)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 16),
          Center(
              child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: job.logoColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.network(job.imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (ctx, e, s) => Icon(Icons.business,
                              size: 52, color: job.logoColor)),
                    ),
                  ))),
          const SizedBox(height: 12),
          Center(
              child: Text(job.company,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary))),
          const SizedBox(height: 20),
          const Text('Description', style: AppTextStyles.heading3),
          const SizedBox(height: 8),
          Text(
              '${job.company} entidad financiera lider en Colombia con mas de 50 anos de experiencia. Ofrece servicios a personas y empresas en 6 paises, destacando por su banca digital.',
              style: AppTextStyles.body),
          const SizedBox(height: 20),
          const Text('Conocimientos basicos solicitados',
              style: AppTextStyles.heading3),
          const SizedBox(height: 12),
          _Req('Nivel intermedio de Flask'),
          _Req('Nivel alto de python'),
          _Req('Conocimiento en backend base de datos'),
          _Req('Microservicios'),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Entrevista', style: AppTextStyles.heading3),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(4)),
                child: const Text('1st phase',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 8),
          const Text('Programar entrevista',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 32),
          SPButton(
              label: 'Siguiente', onTap: () => Navigator.of(context).pop()),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}

class _Req extends StatelessWidget {
  final String text;
  const _Req(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
                color: AppColors.textSecondary, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Text(text, style: AppTextStyles.body),
      ]),
    );
  }
}
