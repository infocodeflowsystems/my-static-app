
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'business_config.dart';

void main() {
  runApp(const MyBusinessMiniApp());
}

class MyBusinessMiniApp extends StatelessWidget {
  const MyBusinessMiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: businessConfig.name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F6F1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: businessConfig.primary,
          primary: businessConfig.primary,
          secondary: businessConfig.accent,
          surface: const Color(0xFFF7F6F1),
        ),
        fontFamily: 'Roboto',
      ),
      home: const SalonHomePage(),
    );
  }
}

class SalonHomePage extends StatelessWidget {
  const SalonHomePage({super.key});

  Future<void> _openLink(
    BuildContext context,
    Uri uri,
    String action,
  ) async {
    try {
      final opened = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!opened && context.mounted) {
        _showMessage(context, '$action could not be opened.');
      }
    } catch (_) {
      if (context.mounted) {
        _showMessage(context, '$action is not available on this device.');
      }
    }
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _digitsOnly(String value) =>
      value.replaceAll(RegExp(r'[^0-9]'), '');

  @override
  Widget build(BuildContext context) {
    final business = businessConfig;
    final services = business.services;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
                decoration: BoxDecoration(
                  color: business.primary,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _BusinessLogo(
                          assetPath: business.logoAsset,
                          color: business.accent,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            business.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.verified_outlined,
                          color: Colors.white70,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'LOOK GOOD.\nFEEL CONFIDENT.',
                      style: TextStyle(
                        color: business.accent,
                        fontSize: 30,
                        height: 1.18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      business.tagline,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _ContactButton(
                            label: 'Call Now',
                            icon: Icons.call_rounded,
                            foreground: business.primary,
                            background: business.accent,
                            onPressed: () {
                              final phone = _digitsOnly(business.phone);
                              if (phone.isEmpty) {
                                _showMessage(
                                  context,
                                  'Business phone number not added yet.',
                                );
                                return;
                              }
                              _openLink(
                                context,
                                Uri(scheme: 'tel', path: phone),
                                'Phone dialler',
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ContactButton(
                            label: 'WhatsApp',
                            icon: Icons.chat_rounded,
                            foreground: Colors.white,
                            background: Colors.white24,
                            onPressed: () {
                              final number = _digitsOnly(business.whatsapp);
                              if (number.isEmpty) {
                                _showMessage(
                                  context,
                                  'WhatsApp number not added yet.',
                                );
                                return;
                              }
                              _openLink(
                                context,
                                Uri.https(
                                  'wa.me',
                                  '/$number',
                                ),
                                'WhatsApp',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Our Services',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF202624),
                        ),
                      ),
                    ),
                    Text(
                      '${services.length} services',
                      style: TextStyle(
                        color: business.primary.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (services.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text('Our services will be listed here soon.'),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final service = services[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFE8E6DE),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: business.accent.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(
                                Icons.content_cut_rounded,
                                color: business.primary,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.name,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if (service.description.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      service.description,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '₹${service.price}',
                              style: TextStyle(
                                color: business.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: services.length,
                  ),
                ),
              ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      business.about.trim().isEmpty
                          ? 'Business information will be added soon.'
                          : business.about,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.7,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _InfoCard(
                      icon: Icons.location_on_outlined,
                      title: 'Visit Us',
                      value: business.address.trim().isEmpty
                          ? 'Address will be added soon.'
                          : business.address,
                    ),
                    const SizedBox(height: 12),
                    _InfoCard(
                      icon: Icons.access_time_rounded,
                      title: 'Opening Hours',
                      value: business.openingHours.trim().isEmpty
                          ? 'Please contact us for timings.'
                          : business.openingHours,
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: Text(
                        'BUSINESS INFORMATION • MYBUSINESS MINI',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: business.primary.withValues(alpha: 0.6),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BusinessLogo extends StatelessWidget {
  const _BusinessLogo({
    required this.assetPath,
    required this.color,
  });

  final String assetPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final hasLogo = assetPath.trim().isNotEmpty;

    return Container(
      width: 48,
      height: 48,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(15),
      ),
      child: hasLogo
          ? Image.asset(
              assetPath,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Icon(
                Icons.content_cut_rounded,
                color: color,
                size: 27,
              ),
            )
          : Icon(
              Icons.content_cut_rounded,
              color: color,
              size: 27,
            ),
    );
  }
}

class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.label,
    required this.icon,
    required this.foreground,
    required this.background,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color foreground;
  final Color background;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      icon: Icon(icon, size: 18),
     label: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E6DE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF172B2A)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black54,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
