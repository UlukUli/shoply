import 'package:flutter/material.dart';
import 'package:shoply_app/core/theme/app_theme.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double iconSize;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.iconSize = 48,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('demo://')) {
      final style = _getDemoStyle(imageUrl);
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: style.colors,
          ),
        ),
        child: Center(
          child: Icon(
            style.icon,
            size: iconSize,
            color: style.iconColor,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      color: const Color(0xFFF1F5F9),
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Icon(
                Icons.shopping_bag_outlined,
                size: iconSize,
                color: AppTheme.textSecondaryColor,
              ),
            )
          : Icon(
              Icons.shopping_bag_outlined,
              size: iconSize,
              color: AppTheme.textSecondaryColor,
            ),
    );
  }

  _DemoImageStyle _getDemoStyle(String url) {
    switch (url) {
      case 'demo://headphones':
        return const _DemoImageStyle(
          icon: Icons.headphones_rounded,
          colors: [Color(0xFFDBEAFE), Color(0xFFBFDBFE)],
          iconColor: Color(0xFF1D4ED8),
        );
      case 'demo://smartwatch':
        return const _DemoImageStyle(
          icon: Icons.watch_rounded,
          colors: [Color(0xFFE0E7FF), Color(0xFFC7D2FE)],
          iconColor: Color(0xFF4338CA),
        );
      case 'demo://hoodie':
        return const _DemoImageStyle(
          icon: Icons.checkroom_rounded,
          colors: [Color(0xFFFEF3C7), Color(0xFFFDE68A)],
          iconColor: Color(0xFFB45309),
        );
      case 'demo://sneakers':
        return const _DemoImageStyle(
          icon: Icons.directions_run_rounded,
          colors: [Color(0xFFD1FAE5), Color(0xFFA7F3D0)],
          iconColor: Color(0xFF047857),
        );
      case 'demo://backpack':
        return const _DemoImageStyle(
          icon: Icons.backpack_rounded,
          colors: [Color(0xFFFCE7F3), Color(0xFFFBCFE8)],
          iconColor: Color(0xFFBE185D),
        );
      case 'demo://lamp':
        return const _DemoImageStyle(
          icon: Icons.light_rounded,
          colors: [Color(0xFFCCFBF1), Color(0xFF99F6E4)],
          iconColor: Color(0xFF0F766E),
        );
      default:
        return const _DemoImageStyle(
          icon: Icons.shopping_bag_rounded,
          colors: [Color(0xFFE2E8F0), Color(0xFFCBD5E1)],
          iconColor: Color(0xFF475569),
        );
    }
  }
}

class _DemoImageStyle {
  final IconData icon;
  final List<Color> colors;
  final Color iconColor;

  const _DemoImageStyle({
    required this.icon,
    required this.colors,
    required this.iconColor,
  });
}