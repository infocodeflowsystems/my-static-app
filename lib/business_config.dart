
import 'package:flutter/material.dart';

class SalonService {
  const SalonService({
    required this.name,
    required this.price,
    this.description = '',
  });

  final String name;
  final int price;
  final String description;
}

class BusinessConfig {
  const BusinessConfig({
    required this.name,
    required this.tagline,
    required this.phone,
    required this.whatsapp,
    required this.address,
    required this.openingHours,
    required this.about,
    required this.primaryColor,
    required this.accentColor,
    required this.services,
    this.logoAsset = '',
    this.galleryAssets = const [],
  });

  // Replace all sample details before delivering to a real customer.
  final String name;
  final String tagline;
  final String phone;

  // International format with country code, digits only.
  // Example: India +91 9876543210 becomes 919876543210.
  final String whatsapp;

  final String address;
  final String openingHours;
  final String about;

  // Colors are stored as ARGB integer values.
  final int primaryColor;
  final int accentColor;

  // Optional local image paths.
  final String logoAsset;
  final List<String> galleryAssets;

  final List<SalonService> services;

  Color get primary => Color(primaryColor);
  Color get accent => Color(accentColor);
}

const businessConfig = BusinessConfig(
  // SAMPLE DATA — fictional salon, not a real business.
  name: 'Urban Trim Studio',
  tagline: 'Your Style, Your Statement',
  phone: '+91 98765 43210',
  whatsapp: '919876543210',
  address: 'Shop 4, Main Road, Pune, Maharashtra',
  openingHours: 'Mon–Sun: 10:00 AM – 9:00 PM',
  about:
      'Urban Trim Studio is a sample neighbourhood salon '
      'focused on grooming, personal style and a welcoming experience.',

  primaryColor: 0xFF172B2A,
  accentColor: 0xFFD6B477,

  logoAsset: '',
  galleryAssets: [],

  services: [
    SalonService(
      name: 'Classic Haircut',
      price: 199,
      description: 'A neat everyday haircut',
    ),
    SalonService(
      name: 'Beard Trim',
      price: 99,
      description: 'Shape and tidy your beard',
    ),
    SalonService(
      name: 'Haircut + Beard',
      price: 249,
      description: 'A complete grooming combo',
    ),
    SalonService(
      name: 'Hair Spa',
      price: 499,
      description: 'Relaxing hair-care treatment',
    ),
  ],
);
