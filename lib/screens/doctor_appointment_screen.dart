import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:meditrack/l10n/app_localizations.dart';

// ----------------------------------------------
// Data Models
// ----------------------------------------------

class Doctor {
  final String name;
  final String specialization;
  final String experience;
  final double rating;
  final int reviewCount;
  final String initials;
  final Color avatarColor;
  final String fee;
  final String location;
  final String imageUrl;
  const Doctor({
    required this.name,
    required this.specialization,
    required this.experience,
    required this.rating,
    required this.reviewCount,
    required this.initials,
    required this.avatarColor,
    required this.fee,
    required this.location,
    required this.imageUrl,
  });
}

class Specialty {
  final String name;
  final String displayName;
  final IconData icon;
  final Color color;
  final Color bgColor;
  const Specialty({
    required this.name,
    required this.displayName,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

// ----------------------------------------------
// Custom Vector Doctor Avatar Painter & Widget
// ----------------------------------------------

class _DoctorAvatarPainter extends CustomPainter {
  final String initials;
  _DoctorAvatarPainter(this.initials);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final center = Offset(w / 2, h / 2);
    final radius = math.min(w, h) / 2;

    // Draw background circle with gradient
    final bgPaint = Paint();
    if (initials == 'RS') {
      bgPaint.shader = const LinearGradient(
        colors: [Color(0xFF7F56D9), Color(0xFF9E77ED)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    } else if (initials == 'NV') {
      bgPaint.shader = const LinearGradient(
        colors: [Color(0xFF12B76A), Color(0xFF32D583)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    } else {
      bgPaint.shader = const LinearGradient(
        colors: [Color(0xFF2E90FA), Color(0xFF53B1FD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    }
    canvas.drawCircle(center, radius, bgPaint);

    // Save layer for clipping
    canvas.saveLayer(Rect.fromCircle(center: center, radius: radius), Paint());

    // Clip to circle
    final clipPath = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.clipPath(clipPath);

    // 1. Draw Torso / Shirt base (White coat body)
    final torsoPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final torsoPath = Path();
    torsoPath.moveTo(w * 0.15, h);
    torsoPath.quadraticBezierTo(w * 0.2, h * 0.65, w * 0.5, h * 0.65);
    torsoPath.quadraticBezierTo(w * 0.8, h * 0.65, w * 0.85, h);
    torsoPath.close();
    canvas.drawPath(torsoPath, torsoPaint);

    // 2. Draw Neck
    final neckPaint = Paint()
      ..color = const Color(0xFFFFE0D0) // Warm light skin tone
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTRB(w * 0.42, h * 0.48, w * 0.58, h * 0.66), neckPaint);

    // 3. Draw Ears
    final earPaint = Paint()
      ..color = const Color(0xFFFFE0D0)
      ..style = PaintingStyle.fill;
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.26, h * 0.40), width: w * 0.08, height: h * 0.10), earPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(w * 0.74, h * 0.40), width: w * 0.08, height: h * 0.10), earPaint);

    // 4. Draw Face
    final facePaint = Paint()
      ..color = const Color(0xFFFFE0D0) // skin tone
      ..style = PaintingStyle.fill;
    final faceRect = Rect.fromCenter(center: Offset(w * 0.5, h * 0.4), width: w * 0.44, height: h * 0.46);
    canvas.drawOval(faceRect, facePaint);

    // 5. Eyes & Eyebrows
    final eyePaint = Paint()
      ..color = const Color(0xFF1D2939)
      ..style = PaintingStyle.fill;
    // Left eye:
    canvas.drawCircle(Offset(w * 0.39, h * 0.37), 2.5, eyePaint);
    // Right eye:
    canvas.drawCircle(Offset(w * 0.61, h * 0.37), 2.5, eyePaint);

    // Eyebrows:
    final eyebrowPaint = Paint()
      ..color = const Color(0xFF1D2939)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromLTRB(w * 0.32, h * 0.28, w * 0.44, h * 0.34), math.pi, math.pi, false, eyebrowPaint);
    canvas.drawArc(Rect.fromLTRB(w * 0.56, h * 0.28, w * 0.68, h * 0.34), math.pi, math.pi, false, eyebrowPaint);

    // 6. Nose
    final nosePaint = Paint()
      ..color = const Color(0xFFE5B095) // darker skin tone for shadow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    final nosePath = Path();
    nosePath.moveTo(w * 0.5, h * 0.42);
    nosePath.quadraticBezierTo(w * 0.52, h * 0.45, w * 0.49, h * 0.46);
    canvas.drawPath(nosePath, nosePaint);

    // 7. Smile (Wide, open mouth showing white teeth)
    if (initials == 'RS') {
      // High detail open smile for main doctor
      final mouthPaint = Paint()
        ..color = const Color(0xFF8C1D18)
        ..style = PaintingStyle.fill;
      final mouthPath = Path();
      mouthPath.moveTo(w * 0.42, h * 0.48);
      mouthPath.quadraticBezierTo(w * 0.5, h * 0.49, w * 0.58, h * 0.48);
      mouthPath.quadraticBezierTo(w * 0.5, h * 0.55, w * 0.42, h * 0.48);
      canvas.drawPath(mouthPath, mouthPaint);

      final teethPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      final teethPath = Path();
      teethPath.moveTo(w * 0.43, h * 0.48);
      teethPath.quadraticBezierTo(w * 0.5, h * 0.49, w * 0.57, h * 0.48);
      teethPath.lineTo(w * 0.56, h * 0.515);
      teethPath.quadraticBezierTo(w * 0.5, h * 0.525, w * 0.44, h * 0.515);
      teethPath.close();
      canvas.drawPath(teethPath, teethPaint);
    } else {
      // Normal smile for others
      final smilePaint = Paint()
        ..color = const Color(0xFFF04438)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCenter(center: Offset(w * 0.5, h * 0.46), width: 10, height: 6),
        0,
        math.pi,
        false,
        smilePaint,
      );
    }

    // 8. Draw Hair
    final hairPaint = Paint()
      ..color = const Color(0xFF1D2939) // dark hair
      ..style = PaintingStyle.fill;
    if (initials == 'NV') {
      // Female Hair (longer / parted)
      final hairPath = Path();
      hairPath.moveTo(w * 0.26, h * 0.45);
      hairPath.quadraticBezierTo(w * 0.25, h * 0.15, w * 0.5, h * 0.15);
      hairPath.quadraticBezierTo(w * 0.75, h * 0.15, w * 0.74, h * 0.45);
      hairPath.quadraticBezierTo(w * 0.8, h * 0.65, w * 0.76, h * 0.85);
      hairPath.lineTo(w * 0.68, h * 0.85);
      hairPath.quadraticBezierTo(w * 0.7, h * 0.48, w * 0.62, h * 0.24);
      hairPath.quadraticBezierTo(w * 0.5, h * 0.28, w * 0.38, h * 0.24);
      hairPath.quadraticBezierTo(w * 0.3, h * 0.48, w * 0.32, h * 0.85);
      hairPath.lineTo(w * 0.24, h * 0.85);
      hairPath.quadraticBezierTo(w * 0.2, h * 0.65, w * 0.26, h * 0.45);
      hairPath.close();
      canvas.drawPath(hairPath, hairPaint);
    } else {
      // Male Hair - combed/side-parted style exactly as in the image
      final hairPath = Path();
      hairPath.moveTo(w * 0.26, h * 0.38); // Left sideburn
      hairPath.lineTo(w * 0.26, h * 0.30);
      // Top curve
      hairPath.cubicTo(w * 0.26, h * 0.16, w * 0.40, h * 0.11, w * 0.50, h * 0.11);
      hairPath.cubicTo(w * 0.62, h * 0.11, w * 0.74, h * 0.16, w * 0.74, h * 0.30);
      hairPath.lineTo(w * 0.74, h * 0.38); // Right sideburn
      hairPath.lineTo(w * 0.71, h * 0.38);
      // Hairline
      hairPath.cubicTo(w * 0.71, h * 0.28, w * 0.62, h * 0.22, w * 0.50, h * 0.26);
      hairPath.cubicTo(w * 0.42, h * 0.22, w * 0.29, h * 0.28, w * 0.29, h * 0.38);
      hairPath.close();
      canvas.drawPath(hairPath, hairPaint);
    }

    // 9. Draw Glasses (For Dr. Rajat Sharma)
    if (initials == 'RS') {
      final glassesPaint = Paint()
        ..color = const Color(0xFF1D2939) // Black frames
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round;
      // Left glass lens (larger, roundish)
      canvas.drawCircle(Offset(w * 0.39, h * 0.37), w * 0.08, glassesPaint);
      // Right glass lens
      canvas.drawCircle(Offset(w * 0.61, h * 0.37), w * 0.08, glassesPaint);
      // Bridge
      canvas.drawLine(Offset(w * 0.47, h * 0.37), Offset(w * 0.53, h * 0.37), glassesPaint);
      // Temples
      canvas.drawLine(Offset(w * 0.31, h * 0.37), Offset(w * 0.26, h * 0.35), glassesPaint);
      canvas.drawLine(Offset(w * 0.69, h * 0.37), Offset(w * 0.74, h * 0.35), glassesPaint);
    }

    // 10. Shirt Collar and Tie (under the coat lapels)
    if (initials != 'NV') {
      // Under-shirt V-neck shape
      final shirtPaint = Paint()
        ..color = const Color(0xFF84CAFF) // Light blue shirt
        ..style = PaintingStyle.fill;
      final shirtPath = Path();
      shirtPath.moveTo(w * 0.4, h * 0.65);
      shirtPath.lineTo(w * 0.5, h * 0.78);
      shirtPath.lineTo(w * 0.6, h * 0.65);
      shirtPath.lineTo(w * 0.5, h * 0.65);
      shirtPath.close();
      canvas.drawPath(shirtPath, shirtPaint);

      // Collar wings:
      final collarPaint = Paint()
        ..color = const Color(0xFF6BB5FF) // slightly darker shade for collar definition
        ..style = PaintingStyle.fill;

      final leftCollar = Path();
      leftCollar.moveTo(w * 0.41, h * 0.65);
      leftCollar.lineTo(w * 0.50, h * 0.69);
      leftCollar.lineTo(w * 0.45, h * 0.73);
      leftCollar.close();
      canvas.drawPath(leftCollar, collarPaint);

      final rightCollar = Path();
      rightCollar.moveTo(w * 0.59, h * 0.65);
      rightCollar.lineTo(w * 0.50, h * 0.69);
      rightCollar.lineTo(w * 0.55, h * 0.73);
      rightCollar.close();
      canvas.drawPath(rightCollar, collarPaint);

      // Dark blue Tie:
      final tiePaint = Paint()
        ..color = const Color(0xFF1E3A8A) // Dark blue
        ..style = PaintingStyle.fill;

      // Tie Knot:
      final tieKnotPath = Path();
      tieKnotPath.moveTo(w * 0.48, h * 0.67);
      tieKnotPath.lineTo(w * 0.52, h * 0.67);
      tieKnotPath.lineTo(w * 0.51, h * 0.72);
      tieKnotPath.lineTo(w * 0.49, h * 0.72);
      tieKnotPath.close();
      canvas.drawPath(tieKnotPath, tiePaint);

      // Tie Body:
      final tieBodyPath = Path();
      tieBodyPath.moveTo(w * 0.49, h * 0.72);
      tieBodyPath.lineTo(w * 0.51, h * 0.72);
      tieBodyPath.lineTo(w * 0.525, h * 0.83);
      tieBodyPath.lineTo(w * 0.5, h * 0.86);
      tieBodyPath.lineTo(w * 0.475, h * 0.83);
      tieBodyPath.close();
      canvas.drawPath(tieBodyPath, tiePaint);
    }

    // 11. Doctor White Coat Lapels
    final coatPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final lapelBorderPaint = Paint()
      ..color = const Color(0xFFD0D5DD)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final leftLapel = Path();
    leftLapel.moveTo(w * 0.24, h);
    leftLapel.lineTo(w * 0.38, h * 0.65);
    leftLapel.lineTo(w * 0.44, h * 0.75);
    leftLapel.lineTo(w * 0.32, h);
    leftLapel.close();
    canvas.drawPath(leftLapel, coatPaint);
    canvas.drawPath(leftLapel, lapelBorderPaint);

    final rightLapel = Path();
    rightLapel.moveTo(w * 0.76, h);
    rightLapel.lineTo(w * 0.62, h * 0.65);
    rightLapel.lineTo(w * 0.56, h * 0.75);
    rightLapel.lineTo(w * 0.68, h);
    rightLapel.close();
    canvas.drawPath(rightLapel, coatPaint);
    canvas.drawPath(rightLapel, lapelBorderPaint);

    // 12. Stethoscope (on top of white coat / lapels)
    final stethPaint = Paint()
      ..color = const Color(0xFF475467) // dark slate grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Tube hanging on left (doctor's right)
    final leftSteth = Path();
    leftSteth.moveTo(w * 0.36, h * 0.60);
    leftSteth.quadraticBezierTo(w * 0.33, h * 0.66, w * 0.33, h * 0.74);
    canvas.drawPath(leftSteth, stethPaint);

    // Tube hanging on right (doctor's left)
    final rightSteth = Path();
    rightSteth.moveTo(w * 0.64, h * 0.60);
    rightSteth.quadraticBezierTo(w * 0.67, h * 0.66, w * 0.67, h * 0.74);
    canvas.drawPath(rightSteth, stethPaint);

    // Left chestpiece assembly:
    final metalPaint = Paint()
      ..color = const Color(0xFF98A2B3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawLine(Offset(w * 0.33, h * 0.74), Offset(w * 0.33, h * 0.77), metalPaint);

    final cpOuter = Paint()
      ..color = const Color(0xFF475467)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.33, h * 0.79), w * 0.04, cpOuter);

    final cpInner = Paint()
      ..color = const Color(0xFFD0D5DD)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.33, h * 0.79), w * 0.025, cpInner);

    // Right binaural assembly:
    canvas.drawLine(Offset(w * 0.67, h * 0.74), Offset(w * 0.65, h * 0.79), metalPaint);
    canvas.drawLine(Offset(w * 0.67, h * 0.74), Offset(w * 0.69, h * 0.79), metalPaint);

    final earpiecePaint = Paint()
      ..color = const Color(0xFF344054)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.65, h * 0.79), 2.2, earpiecePaint);
    canvas.drawCircle(Offset(w * 0.69, h * 0.79), 2.2, earpiecePaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DoctorAvatar extends StatelessWidget {
  final String initials;
  final String? imageUrl;
  final double size;
  const _DoctorAvatar({required this.initials, this.imageUrl, this.size = 64});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return CustomPaint(
                    size: Size(size, size),
                    painter: _DoctorAvatarPainter(initials),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return CustomPaint(
                    size: Size(size, size),
                    painter: _DoctorAvatarPainter(initials),
                  );
                },
              )
            : CustomPaint(
                size: Size(size, size),
                painter: _DoctorAvatarPainter(initials),
              ),
      ),
    );
  }
}

// ----------------------------------------------
// Sample Data
// ----------------------------------------------

const List<Specialty> _specialties = [
  Specialty(
    name: 'हृदय रोग',
    displayName: 'हृदय रोग\n(कार्डियोलॉजिस्ट)',
    icon: Icons.favorite_rounded,
    color: Color(0xFFD92D20),
    bgColor: Color(0xFFFEF3F2),
  ),
  Specialty(
    name: 'जनरल फिजिशियन',
    displayName: 'जनरल\nफिजिशियन',
    icon: Icons.local_hospital_rounded,
    color: Color(0xFF079455),
    bgColor: Color(0xFFECFDF3),
  ),
  Specialty(
    name: 'डायबिटीज विशेषज्ञ',
    displayName: 'डायबिटीज\nविशेषज्ञ',
    icon: Icons.bloodtype_rounded,
    color: Color(0xFFE04F5F),
    bgColor: Color(0xFFFFF1F3),
  ),
  Specialty(
    name: 'हड्डी रोग',
    displayName: 'हड्डी रोग\n(ऑर्थोपेडिक)',
    icon: Icons.accessibility_new_rounded,
    color: Color(0xFF2E90FA),
    bgColor: Color(0xFFF2F8FF),
  ),
];

const List<Doctor> _doctors = [
  Doctor(
    name: 'Dr. Rajat Sharma',
    specialization: 'MBBS, MD (Cardiology)\nहृदय रोग विशेषज्ञ',
    experience: '10+ वर्ष अनुभव',
    rating: 4.8,
    reviewCount: 256,
    initials: 'RS',
    avatarColor: Color(0xFF7F56D9),
    fee: '₹500',
    location: 'Heart Care Clinic\nसिविल लाइन्स, जयपुर, राजस्थान',
    imageUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=256&q=80',
  ),
  Doctor(
    name: 'Dr. Neha Verma',
    specialization: 'MBBS, MD (General Medicine)\nजनरल फिजिशियन',
    experience: '8+ वर्ष अनुभव',
    rating: 4.7,
    reviewCount: 189,
    initials: 'NV',
    avatarColor: Color(0xFF12B76A),
    fee: '₹400',
    location: 'Life Care Clinic\nमालवीय नगर, जयपुर, राजस्थान',
    imageUrl: 'https://images.unsplash.com/photo-1594824813573-246434de83fb?auto=format&fit=crop&w=256&q=80',
  ),
  Doctor(
    name: 'Dr. Amit Patel',
    specialization: 'MBBS, MS (Orthopedics)\nहड्डी रोग विशेषज्ञ',
    experience: '12+ वर्ष अनुभव',
    rating: 4.6,
    reviewCount: 132,
    initials: 'AP',
    avatarColor: Color(0xFF2E90FA),
    fee: '₹600',
    location: 'Orthofit Clinic\nवैशाली नगर, जयपुर, राजस्थान',
    imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?auto=format&fit=crop&w=256&q=80',
  ),
];

// ----------------------------------------------
// Shared Widgets
// ----------------------------------------------

PreferredSizeWidget _buildAppBar(BuildContext context, String title, {List<Widget>? actions, VoidCallback? onBackPressed}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1D2939), size: 26),
      onPressed: onBackPressed ?? () => Navigator.pop(context),
    ),
    title: Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
    ),
    centerTitle: false,
    actions: actions,
  );
}

// ----------------------------------------------
// Screen 1 - Choose Doctor
// ----------------------------------------------

class ChooseDoctorScreen extends StatefulWidget {
  const ChooseDoctorScreen({super.key});

  @override
  State<ChooseDoctorScreen> createState() => _ChooseDoctorScreenState();
}

class _ChooseDoctorScreenState extends State<ChooseDoctorScreen> {
  final _searchController = TextEditingController();
  List<Doctor> _filteredDoctors = List.from(_doctors);
  int? _selectedSpecialtyIndex;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _selectedSpecialtyIndex = null;
      if (query.isEmpty) {
        _filteredDoctors = List.from(_doctors);
      } else {
        _filteredDoctors = _doctors.where((d) =>
          d.name.toLowerCase().contains(query.toLowerCase()) ||
          d.specialization.toLowerCase().contains(query.toLowerCase())
        ).toList();
      }
    });
  }

  void _filterBySpecialty(int index) {
    setState(() {
      if (_selectedSpecialtyIndex == index) {
        _selectedSpecialtyIndex = null;
        _filteredDoctors = List.from(_doctors);
      } else {
        _selectedSpecialtyIndex = index;
        _searchController.clear();
        final spec = _specialties[index];
        _filteredDoctors = _doctors.where((d) =>
          d.specialization.contains(spec.name)
        ).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(
        context,
        AppLocalizations.of(context)!.doctorAppointment,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Color(0xFF1D2939), size: 24),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7F56D9), Color(0xFF53389E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.bannerTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.bannerSubtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const _DoctorAvatar(
                    initials: 'RS',
                    imageUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?auto=format&fit=crop&w=256&q=80',
                    size: 90,
                  ),
                ],
              ),
            ),
          ),
          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              style: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w600, fontSize: 15),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchDoctorHint,
                hintStyle: const TextStyle(fontFamily: 'Outfit', color: Color(0xFF98A2B3), fontWeight: FontWeight.normal),
                prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF98A2B3), size: 22),
                suffixIcon: const Icon(Icons.tune_rounded, color: Color(0xFF7F56D9), size: 22),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF7F56D9), width: 2),
                ),
              ),
            ),
          ),
          // Specialty Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.bySpecialty,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    AppLocalizations.of(context)!.seeAllGt,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF7F56D9)),
                  ),
                ),
              ],
            ),
          ),
          // Specialty Categories
          SizedBox(
            height: 104,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _specialties.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (_, i) => _buildSpecialtyCard(i),
            ),
          ),
          const SizedBox(height: 8),
          // Doctor List Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.popularDoctors,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                ),
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.doctorCount('${_filteredDoctors.length}'),
                  style: const TextStyle(fontFamily: 'Outfit', fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF667085)),
                ),
              ],
            ),
          ),
          // Doctor List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredDoctors.length,
              itemBuilder: (_, i) => _DoctorCard(
                doctor: _filteredDoctors[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SelectDateTimeScreen(doctor: _filteredDoctors[i]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyCard(int index) {
    final s = _specialties[index];
    final isSelected = _selectedSpecialtyIndex == index;
    return GestureDetector(
      onTap: () => _filterBySpecialty(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 90,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7F56D9) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF7F56D9) : const Color(0xFFE2E8F0),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withValues(alpha: 0.2) : s.bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(s.icon, color: isSelected ? Colors.white : s.color, size: 20),
            ),
            const SizedBox(height: 6),
            Text(
              s.displayName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w800,
                color: isSelected ? Colors.white : const Color(0xFF475467),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------
// Doctor Card
// ----------------------------------------------

class _DoctorCard extends StatefulWidget {
  final Doctor doctor;
  final VoidCallback onTap;
  const _DoctorCard({required this.doctor, required this.onTap});

  @override
  State<_DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<_DoctorCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) { _controller.reverse(); widget.onTap(); },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) => Transform.scale(scale: _scale.value, child: child),
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              _DoctorAvatar(initials: widget.doctor.initials, imageUrl: widget.doctor.imageUrl, size: 64),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.doctor.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.verified_rounded,
                          color: Color(0xFF2E90FA),
                          size: 16,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.doctor.specialization,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF475467), height: 1.3),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.doctor.rating} (${widget.doctor.reviewCount})',
                          style: const TextStyle(fontFamily: 'Outfit', fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.business_center_rounded, size: 14, color: Color(0xFF667085)),
                        const SizedBox(width: 4),
                        Text(
                          widget.doctor.experience,
                          style: const TextStyle(fontFamily: 'Outfit', fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF667085)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 32, height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9F5FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chevron_right_rounded, color: Color(0xFF7F56D9), size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------
// Screen 2 - Select Date & Time
// ----------------------------------------------

const _months = ['जनवरी', 'फरवरी', 'मार्च', 'अप्रैल', 'मई', 'जून', 'जुलाई', 'अगस्त', 'सितंबर', 'अक्टूबर', 'नवंबर', 'दिसंबर'];

class SelectDateTimeScreen extends StatefulWidget {
  final Doctor doctor;
  const SelectDateTimeScreen({super.key, required this.doctor});

  @override
  State<SelectDateTimeScreen> createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<SelectDateTimeScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime = '10:00 AM'; // Default selected time as in mockup
  final _dates = List.generate(7, (i) => DateTime.now().add(Duration(days: i)));
  
  final _timeSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM',
    '12:00 PM', '02:00 PM', '03:00 PM',
    '04:00 PM', '05:00 PM', '06:00 PM',
  ];

  String _formatDay(DateTime d) {
    final now = DateTime.now();
    if (d.day == now.day && d.month == now.month) return AppLocalizations.of(context)!.today;
    if (d.day == now.add(const Duration(days: 1)).day && d.month == now.month) return AppLocalizations.of(context)!.tomorrow;
    
    const days = ['सोम', 'मंगल', 'बुध', 'गुरु', 'शुक्र', 'शनि', 'रवि'];
    return days[d.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context, AppLocalizations.of(context)!.appointmentBooking),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 12),
                // Selected Doctor Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      _DoctorAvatar(initials: widget.doctor.initials, imageUrl: widget.doctor.imageUrl, size: 52),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(widget.doctor.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified_rounded, color: Color(0xFF2E90FA), size: 16),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(widget.doctor.specialization,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF475467), height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Date Selector Header with Calendar Icon on the right
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.selectDate, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                    const Spacer(),
                    const Icon(Icons.calendar_month_rounded, color: Color(0xFF7F56D9), size: 22),
                  ],
                ),
                const SizedBox(height: 12),
                // Date Selector list
                SizedBox(
                  height: 96,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _dates.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 10),
                    itemBuilder: (_, i) {
                      final d = _dates[i];
                      final isSelected = d.day == _selectedDate.day && d.month == _selectedDate.month;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDate = d),
                        child: Container(
                          width: 80,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF7F56D9) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF7F56D9) : const Color(0xFFE2E8F0),
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? [BoxShadow(color: const Color(0xFF7F56D9).withValues(alpha: 0.25), blurRadius: 10, offset: const Offset(0, 4))]
                                : null,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _formatDay(d),
                                style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w800,
                                  color: isSelected ? Colors.white : const Color(0xFF667085),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${d.day}',
                                style: TextStyle(
                                  fontFamily: 'Outfit', fontSize: 20, fontWeight: FontWeight.w800,
                                  color: isSelected ? Colors.white : const Color(0xFF1D2939),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _months[d.month - 1],
                                style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white70 : const Color(0xFF98A2B3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Time Slots Header
                Text(AppLocalizations.of(context)!.selectTime, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                const SizedBox(height: 12),
                // Time slots 3-column Grid
                Column(
                  children: [
                    for (int row = 0; row < (_timeSlots.length / 3).ceil(); row++) ...[
                      Row(
                        children: [
                          for (int col = 0; col < 3; col++) ...[
                            if (row * 3 + col < _timeSlots.length) ...[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: col == 0 ? 0 : 5,
                                    right: col == 2 ? 0 : 5,
                                    bottom: 10,
                                  ),
                                  child: GestureDetector(
                                    onTap: () => setState(() => _selectedTime = _timeSlots[row * 3 + col]),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 150),
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _selectedTime == _timeSlots[row * 3 + col] ? const Color(0xFF7F56D9) : Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: _selectedTime == _timeSlots[row * 3 + col] ? const Color(0xFF7F56D9) : const Color(0xFFE2E8F0),
                                          width: 1.5,
                                        ),
                                        boxShadow: _selectedTime == _timeSlots[row * 3 + col]
                                            ? [BoxShadow(color: const Color(0xFF7F56D9).withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))]
                                            : null,
                                      ),
                                      child: Text(
                                        _timeSlots[row * 3 + col],
                                        style: TextStyle(
                                          fontFamily: 'Outfit', fontSize: 14, fontWeight: FontWeight.w800,
                                          color: _selectedTime == _timeSlots[row * 3 + col] ? Colors.white : const Color(0xFF1D2939),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ] else ...[
                              const Spacer(),
                            ],
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                // Clinic Info & Fee Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Left Column: Clinic Time
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32, height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF9F5FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.access_time_rounded, color: Color(0xFF7F56D9), size: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.clinicHours, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF667085))),
                                  const SizedBox(height: 2),
                                  Text(AppLocalizations.of(context)!.clinicDays, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                                  const SizedBox(height: 1),
                                  Text(AppLocalizations.of(context)!.clinicTiming, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: Color(0xFF667085))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider line
                      Container(
                        height: 54,
                        width: 1.5,
                        color: const Color(0xFFF1F5F9),
                      ),
                      const SizedBox(width: 16),
                      // Right Column: Consultation Fee
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32, height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF9F5FF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.currency_rupee_rounded, color: Color(0xFF7F56D9), size: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppLocalizations.of(context)!.consultationFee, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF667085))),
                                  const SizedBox(height: 2),
                                  Text(widget.doctor.fee, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF7F56D9))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          // Bottom CTA
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedTime == null ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PatientDetailsScreen(
                        doctor: widget.doctor,
                        date: _selectedDate,
                        time: _selectedTime!,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7F56D9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shadowColor: const Color(0xFF7F56D9).withValues(alpha: 0.25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.nextStep, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------
// Custom Process Stepper Widget
// ----------------------------------------------

Widget _buildProcessStepper(BuildContext context, int activeStep) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    color: Colors.white,
    child: Row(
      children: [
        _stepperNode(1, AppLocalizations.of(context)!.stepperDoctor, Icons.person_rounded, activeStep),
        _stepperLine(1, activeStep),
        _stepperNode(2, AppLocalizations.of(context)!.stepperTime, Icons.access_time_rounded, activeStep),
        _stepperLine(2, activeStep),
        _stepperNode(3, AppLocalizations.of(context)!.stepperInfo, Icons.edit_note_rounded, activeStep),
        _stepperLine(3, activeStep),
        _stepperNode(4, AppLocalizations.of(context)!.stepperConfirm, Icons.assignment_turned_in_rounded, activeStep),
      ],
    ),
  );
}

Widget _stepperNode(int step, String label, IconData icon, int activeStep) {
  final isCompleted = step < activeStep;
  final isActive = step == activeStep;

  Color bgColor = const Color(0xFFF1F5F9);
  Color iconColor = const Color(0xFF98A2B3);
  Color textColor = const Color(0xFF667085);

  if (isCompleted) {
    bgColor = const Color(0xFF12B76A); // Completed Green
    iconColor = Colors.white;
    textColor = const Color(0xFF12B76A);
  } else if (isActive) {
    bgColor = const Color(0xFF7F56D9); // Active Purple
    iconColor = Colors.white;
    textColor = const Color(0xFF7F56D9);
  }

  return Expanded(
    child: Column(
      children: [
        Container(
          width: 38, height: 38,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isActive || isCompleted ? FontWeight.w800 : FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    ),
  );
}

Widget _stepperLine(int step, int activeStep) {
  final isCompleted = step < activeStep;
  return Container(
    width: 24,
    height: 3,
    margin: const EdgeInsets.only(bottom: 17),
    color: isCompleted ? const Color(0xFF12B76A) : const Color(0xFFE2E8F0),
  );
}

// ----------------------------------------------
// Screen 3 - Patient Details
// ----------------------------------------------

class PatientDetailsScreen extends StatefulWidget {
  final Doctor doctor;
  final DateTime date;
  final String time;
  const PatientDetailsScreen({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
  });

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  final _nameController = TextEditingController(text: 'राम शर्मा');
  final _ageController = TextEditingController(text: '58 वर्ष');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _emailController = TextEditingController(text: 'ram.sharma@email.com');
  final _symptomsController = TextEditingController(
      text: 'छाती में दर्द, थकान और सांस लेने में दिक्कत हो रही है।');
  String _gender = 'पुरुष';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  bool get _isValid =>
      _nameController.text.trim().isNotEmpty &&
      _ageController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty;

  Widget _buildFormLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 14),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF475467)),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF1D2939)),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF98A2B3), size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF7F56D9), width: 2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context, AppLocalizations.of(context)!.appointmentBooking),
      body: Column(
        children: [
          _buildProcessStepper(context, 3),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  AppLocalizations.of(context)!.patientInfo,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                ),
                const SizedBox(height: 6),
                
                _buildFormLabel(AppLocalizations.of(context)!.fullName),
                _buildInputField(controller: _nameController, prefixIcon: Icons.person_rounded),

                _buildFormLabel(AppLocalizations.of(context)!.age),
                _buildInputField(controller: _ageController, prefixIcon: Icons.calendar_today_rounded, keyboardType: TextInputType.text),

                _buildFormLabel(AppLocalizations.of(context)!.gender),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _gender = 'पुरुष'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _gender == 'पुरुष' ? const Color(0xFF7F56D9) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _gender == 'पुरुष' ? const Color(0xFF7F56D9) : const Color(0xFFE2E8F0),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.male_rounded,
                                  color: _gender == 'पुरुष' ? Colors.white : const Color(0xFF667085),
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  AppLocalizations.of(context)!.male,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: _gender == 'पुरुष' ? Colors.white : const Color(0xFF1D2939),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _gender = 'महिला'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: _gender == 'महिला' ? const Color(0xFF7F56D9) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _gender == 'महिला' ? const Color(0xFF7F56D9) : const Color(0xFFE2E8F0),
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.female_rounded,
                                  color: _gender == 'महिला' ? Colors.white : const Color(0xFF667085),
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  AppLocalizations.of(context)!.female,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: _gender == 'महिला' ? Colors.white : const Color(0xFF1D2939),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),
                  ],
                ),

                _buildFormLabel(AppLocalizations.of(context)!.mobileNumber),
                _buildInputField(controller: _phoneController, prefixIcon: Icons.phone_rounded, keyboardType: TextInputType.phone),

                _buildFormLabel(AppLocalizations.of(context)!.emailOptional),
                _buildInputField(controller: _emailController, prefixIcon: Icons.email_rounded, keyboardType: TextInputType.emailAddress),

                _buildFormLabel(AppLocalizations.of(context)!.symptomsLabel),
                TextField(
                  controller: _symptomsController,
                  maxLines: 4,
                  style: const TextStyle(fontFamily: 'Outfit', fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF1D2939)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF7F56D9), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          // Bottom CTA
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: !_isValid ? null : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReviewAppointmentScreen(
                        doctor: widget.doctor,
                        date: widget.date,
                        time: widget.time,
                        patientName: _nameController.text.trim(),
                        patientAge: _ageController.text.trim(),
                        patientGender: _gender,
                        patientPhone: _phoneController.text.trim(),
                        patientEmail: _emailController.text.trim(),
                        symptoms: _symptomsController.text.trim(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7F56D9),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  elevation: 0,
                  shadowColor: const Color(0xFF7F56D9).withValues(alpha: 0.25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.nextStep, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_rounded, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------
// Screen 4 - Review Appointment
// ----------------------------------------------

class ReviewAppointmentScreen extends StatelessWidget {
  final Doctor doctor;
  final DateTime date;
  final String time;
  final String patientName;
  final String patientAge;
  final String patientGender;
  final String patientPhone;
  final String patientEmail;
  final String symptoms;

  const ReviewAppointmentScreen({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
    required this.patientName,
    required this.patientAge,
    required this.patientGender,
    required this.patientPhone,
    required this.patientEmail,
    required this.symptoms,
  });

  @override
  Widget build(BuildContext context) {
    final dateStr = 'मंगलवार, ${date.day} ${_months[date.month - 1]} ${date.year}';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(context, AppLocalizations.of(context)!.reviewAppointment),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.appointmentDetails,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                    const Spacer(),
                    const Icon(Icons.calendar_month_rounded, color: Color(0xFF7F56D9), size: 18),
                  ],
                ),
                const SizedBox(height: 12),
                
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                       _DoctorAvatar(initials: doctor.initials, imageUrl: doctor.imageUrl, size: 56),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(doctor.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                                const SizedBox(width: 4),
                                const Icon(Icons.verified_rounded, color: Color(0xFF2E90FA), size: 16),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Text(doctor.specialization,
                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF475467), height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _detailRow(Icons.calendar_month_rounded, AppLocalizations.of(context)!.date, dateStr, const Color(0xFF7F56D9)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Color(0xFFF1F5F9), height: 1),
                      ),
                      _detailRow(Icons.access_time_rounded, AppLocalizations.of(context)!.selectTime, time, const Color(0xFF12B76A)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Color(0xFFF1F5F9), height: 1),
                      ),
                      _detailRow(Icons.location_on_rounded, AppLocalizations.of(context)!.location, doctor.location, const Color(0xFFE04F5F)),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Color(0xFFF1F5F9), height: 1),
                      ),
                      _detailRow(Icons.currency_rupee_rounded, AppLocalizations.of(context)!.consultationFee, doctor.fee, const Color(0xFF7F56D9)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Text(AppLocalizations.of(context)!.patientInfo,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patientName,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.phone_rounded, size: 14, color: Color(0xFF667085)),
                          const SizedBox(width: 6),
                          Text(patientPhone, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475467))),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.wc_rounded, size: 14, color: Color(0xFF667085)),
                          const SizedBox(width: 6),
                          Text('$patientAge, $patientGender', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF475467))),
                        ],
                      ),
                      if (symptoms.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFF1F5F9), height: 1),
                        ),
                        Text(AppLocalizations.of(context)!.problemSymptoms, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF7F56D9))),
                        const SizedBox(height: 6),
                        Text(symptoms, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF475467), height: 1.4)),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.of(context)!.confirmNote,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF667085)),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookingSuccessScreen(
                          doctor: doctor,
                          date: date,
                          time: time,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7F56D9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.confirmAppointment,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          width: 32, height: 32,
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF98A2B3))),
              const SizedBox(height: 1),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1D2939))),
            ],
          ),
        ),
      ],
    );
  }
}

// ----------------------------------------------
// Screen 5 - Booking Success
// ----------------------------------------------

class BookingSuccessScreen extends StatefulWidget {
  final Doctor doctor;
  final DateTime date;
  final String time;
  const BookingSuccessScreen({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
  });

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _checkScale;
  late Animation<double> _fadeIn;
  final _confettiParticles = <_ConfettiParticle>[];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..forward();
    _checkScale = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _generateConfetti();
  }

  void _generateConfetti() {
    final rng = math.Random();
    for (int i = 0; i < 50; i++) {
      _confettiParticles.add(_ConfettiParticle(
        x: rng.nextDouble(),
        delay: rng.nextDouble() * 0.4,
        color: _confettiColors[rng.nextInt(_confettiColors.length)],
        size: rng.nextDouble() * 8 + 4,
        speed: rng.nextDouble() * 0.4 + 0.3,
        rotationSpeed: rng.nextDouble() * 6 + 2,
      ));
    }
  }

  static const _confettiColors = [
    Color(0xFF7F56D9), Color(0xFF12B76A), Color(0xFFF59E0B),
    Color(0xFF2196F3), Color(0xFFD92D20), Color(0xFF8A5FFF),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateStr = 'मंगलवार, ${widget.date.day} ${_months[widget.date.month - 1]} ${widget.date.year}';
    final randomId = '#APT${math.Random().nextInt(9000) + 1000}';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1D2939), size: 26),
          onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
        ),
        title: Text(
          AppLocalizations.of(context)!.confirmAppointment,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => CustomPaint(
              size: Size.infinite,
              painter: _ConfettiPainter(
                particles: _confettiParticles,
                progress: _controller.value,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  AnimatedBuilder(
                    animation: _checkScale,
                    builder: (_, child) => Transform.scale(
                      scale: _checkScale.value,
                      child: child,
                    ),
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF12B76A),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF12B76A).withValues(alpha: 0.24),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.check_rounded, color: Colors.white, size: 48),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AnimatedBuilder(
                    animation: _fadeIn,
                    builder: (_, child) => Opacity(opacity: _fadeIn.value, child: child),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.appointmentSuccess,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF12B76A)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context)!.appointmentInfoSent,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF667085)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  AnimatedBuilder(
                    animation: _fadeIn,
                    builder: (_, child) => Opacity(opacity: _fadeIn.value, child: child),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.appointmentDetails2,
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFECFDF3),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.appointmentId(randomId),
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF027A48)),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(color: Color(0xFFF1F5F9), height: 1),
                          ),
                          Row(
                            children: [
                              _DoctorAvatar(initials: widget.doctor.initials, imageUrl: widget.doctor.imageUrl, size: 52),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(widget.doctor.name,
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                                        const SizedBox(width: 4),
                                        const Icon(Icons.verified_rounded, color: Color(0xFF2E90FA), size: 16),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Text(widget.doctor.specialization,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF475467), height: 1.3)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(color: Color(0xFFF1F5F9), height: 1),
                          ),
                          _successRow(Icons.calendar_month_rounded, dateStr),
                          const SizedBox(height: 12),
                          _successRow(Icons.access_time_rounded, widget.time),
                          const SizedBox(height: 12),
                          _successRow(Icons.location_on_rounded, widget.doctor.location),
                          const SizedBox(height: 12),
                          _successRow(Icons.currency_rupee_rounded, '${AppLocalizations.of(context)!.consultationFee}: ${widget.doctor.fee}'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  AnimatedBuilder(
                    animation: _fadeIn,
                    builder: (_, child) => Opacity(opacity: _fadeIn.value, child: child),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7F56D9),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              elevation: 0,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.myAppointments,
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                            icon: const Icon(Icons.home_rounded, size: 22),
                            label: Text(AppLocalizations.of(context)!.goHome),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF7F56D9),
                              side: const BorderSide(color: Color(0xFF7F56D9), width: 2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _successRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF12B76A)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1D2939), height: 1.3)),
        ),
      ],
    );
  }
}

class _ConfettiParticle {
  final double x;
  final double delay;
  final Color color;
  final double size;
  final double speed;
  final double rotationSpeed;

  const _ConfettiParticle({
    required this.x,
    required this.delay,
    required this.color,
    required this.size,
    required this.speed,
    required this.rotationSpeed,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (final p in particles) {
      if (progress < p.delay) continue;
      
      final t = (progress - p.delay) / (1.0 - p.delay);
      if (t <= 0 || t > 1.0) continue;

      final y = size.height * t * p.speed;
      final x = size.width * p.x + math.sin(t * 10 + p.x * 5) * 20;

      paint.color = p.color;
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(t * p.rotationSpeed);
      
      if (p.size.round() % 2 == 0) {
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.6), paint);
      } else {
        canvas.drawCircle(Offset.zero, p.size / 2, paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) => true;
}
