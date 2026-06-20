import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  final double medicineProgress;
  final Map<String, dynamic> nextMedicine;
  final VoidCallback onTakeMedicine;
  final bool isNextMedTaken;
  final VoidCallback onTriggerSos;
  final Function(int) onNavigate;

  const HomeScreen({
    super.key,
    required this.medicineProgress,
    required this.nextMedicine,
    required this.onTakeMedicine,
    required this.isNextMedTaken,
    required this.onTriggerSos,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Fixed Sticky Header — only logo + notification
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: SizedBox(
              height: 58,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo
                    Row(
                      children: [
                        HeartPulseIcon(
                          colors: const [Color(0xFF6C4DFF), Color(0xFF8A5FFF)],
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF6C4DFF), Color(0xFF8A5FFF)],
                          ).createShader(bounds),
                          child: const Text(
                            'MediTrack',
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Notification Bell
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFF2D2D2D),
                            size: 22,
                          ),
                        ),
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF3B30),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Scrollable Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Greeting Section — scrolls with content
                _buildGreetingHeader(),
                const SizedBox(height: 20),
                // Health Status Hero Card (Purple Gradient)
                _buildHealthStatusCard(context),
                
                const SizedBox(height: 20),
                
                // Section Title & 2x2 Daily Health Cards Grid
                _buildVitalsGridSection(context),
                
                const SizedBox(height: 16),
                
                // Today's Next Medicine Card
                _buildNextMedicineSection(context),
                
                const SizedBox(height: 20),
                
                // Emergency SOS Card
                _buildEmergencyCard(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Header Greeting Section
  Widget _buildGreetingHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          // Profile image
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
          const SizedBox(width: 14),
          
          // Greetings
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      'नमस्ते रमेश जी',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D2939),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '👋',
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'आशा है आप स्वस्थ हैं!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475467),
                  ),
                ),
              ],
            ),
          ),
          
          // Profile Tag Button (Matches mockup purple tag background)
          InkWell(
            onTap: () => onNavigate(4),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF7F56D9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7F56D9).withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: const [
                  Icon(Icons.person_add_rounded, size: 14, color: Colors.white),
                  SizedBox(width: 4),
                  Text(
                    'प्रोफाइल',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  // Health Status Hero Card (Purple Gradient)
  Widget _buildHealthStatusCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 142,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xFF7F56D9), Color(0xFF6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7F56D9).withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background wave with heartbeat line and heart outline at end
            Positioned.fill(
              child: CustomPaint(
                painter: HeartbeatPainter(),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Progress Ring
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 82,
                        height: 82,
                        child: CircularProgressIndicator(
                          value: medicineProgress,
                          strokeWidth: 8,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF22C55E)),
                        ),
                      ),
                      const SmileyFaceWidget(size: 54),
                    ],
                  ),
                  const SizedBox(width: 20),
                  
                  // Detail Columns
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'स्वास्थ्य स्थिति',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'अच्छा है 🙂',
                          style: TextStyle(
                            color: Color(0xFF86EFAC), // Bright Lime Green
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'आज आपकी तबीयत सामान्य है!',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'ऐसे ही ध्यान रखें!',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2x2 White Vitals Cards Section
  Widget _buildVitalsGridSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'आज के महत्वपूर्ण आंकड़े',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D2939),
                ),
              ),
              InkWell(
                onTap: () => onNavigate(1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Text(
                    'सभी देखें ›',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7F56D9),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.35,
            children: [
              _buildVitalCard(
                title: 'ब्लड प्रेशर',
                value: '120/80',
                iconData: Icons.favorite_rounded,
                iconBgColor: const Color(0xFFFFF0F2),
                iconColor: const Color(0xFFF43F5E),
                onTap: () => onNavigate(1),
              ),
              _buildVitalCard(
                title: 'शुगर (रक्त शर्करा)',
                value: '98 mg/dL',
                iconData: Icons.water_drop_rounded,
                iconBgColor: const Color(0xFFFFF0F2),
                iconColor: const Color(0xFFF43F5E),
                onTap: () => onNavigate(1),
              ),
              _buildVitalCard(
                title: 'ऑक्सीजन (SpO₂)',
                value: '98%',
                iconData: Icons.circle,
                textIcon: 'O₂',
                iconBgColor: const Color(0xFFEBF5FF),
                iconColor: const Color(0xFF3B82F6),
                onTap: () => onNavigate(1),
              ),
              _buildVitalCard(
                title: 'तापमान',
                value: '98.6°F',
                iconData: Icons.thermostat_rounded,
                iconBgColor: const Color(0xFFFFF4E5),
                iconColor: const Color(0xFFF97316),
                onTap: () => onNavigate(1),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard({
    required String title,
    required String value,
    required IconData iconData,
    required Color iconBgColor,
    required Color iconColor,
    String? textIcon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: textIcon != null
                        ? Text(
                            textIcon,
                            style: TextStyle(
                              color: iconColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          )
                        : Icon(
                            iconData,
                            color: iconColor,
                            size: 16,
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF475467),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1D2939),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'सामान्य',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF12B76A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Today's Next Medicine Card matching mockup columns exactly
  Widget _buildNextMedicineSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container Medicine Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF1F5F9)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'आज की अगली दवा',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D2939),
                      ),
                    ),
                    Text(
                      nextMedicine['time'] ?? '08:00 AM',
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF12B76A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Icon Wrapper
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text('💊', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    const SizedBox(width: 14),
                    
                    // Medicine details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nextMedicine['name'] ?? 'Metformin 500mg',
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1D2939),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            nextMedicine['instruction'] ?? '1 गोली - नाश्ते के बाद',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475467),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Checkmark toggle button
                    InkWell(
                      onTap: onTakeMedicine,
                      borderRadius: BorderRadius.circular(100),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isNextMedTaken ? const Color(0xFF12B76A) : Colors.white,
                          border: Border.all(
                            color: isNextMedTaken ? const Color(0xFF12B76A) : const Color(0xFFE2E8F0),
                            width: 2,
                          ),
                          boxShadow: isNextMedTaken
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF12B76A).withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  )
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check_rounded,
                            color: isNextMedTaken ? Colors.white : Colors.transparent,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Emergency SOS section matching the mockup pill SOS layout
  Widget _buildEmergencyCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF3F2),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFFEE2E2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title and description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'आपातकालीन मदद',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFD92D20),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'आपातकालीन स्थिति में यहाँ दबाएँ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475467),
                  ),
                ),
              ],
            ),
            
            // Giant SOS Trigger Button (Pill shaped with siren and SOS text)
            InkWell(
              onTap: onTriggerSos,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFD92D20),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD92D20).withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.notifications_active_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'SOS',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
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

// Draw a solid heart with heartbeat pulse stroke lines over it
class HeartPulseIcon extends StatelessWidget {
  final Color? color;
  final List<Color>? colors;
  final double size;
  const HeartPulseIcon({super.key, this.color, this.colors, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HeartPulseIconPainter(color: color, colors: colors),
    );
  }
}

class _HeartPulseIconPainter extends CustomPainter {
  final Color? color;
  final List<Color>? colors;
  _HeartPulseIconPainter({this.color, this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;
    if (colors != null && colors!.length >= 2) {
      paint.shader = LinearGradient(
        colors: colors!,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    } else {
      paint.color = color ?? Colors.black;
    }

    final path = Path();
    double width = size.width;
    double height = size.height;

    // Heart Path
    path.moveTo(width / 2, height * 0.22);
    path.cubicTo(width * 0.85, -height * 0.05, width * 1.1, height * 0.35, width / 2, height * 0.9);
    path.cubicTo(-width * 0.1, height * 0.35, width * 0.15, -height * 0.05, width / 2, height * 0.22);
    canvas.drawPath(path, paint);

    // Heartbeat line stroke on top
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final pulsePath = Path();
    pulsePath.moveTo(width * 0.15, height * 0.45);
    pulsePath.lineTo(width * 0.35, height * 0.45);
    pulsePath.lineTo(width * 0.42, height * 0.25);
    pulsePath.lineTo(width * 0.5, height * 0.65);
    pulsePath.lineTo(width * 0.58, height * 0.38);
    pulsePath.lineTo(width * 0.65, height * 0.45);
    pulsePath.lineTo(width * 0.85, height * 0.45);
    canvas.drawPath(pulsePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Vector Smiley Face Widget inside Health Circle
class SmileyFaceWidget extends StatelessWidget {
  final double size;
  const SmileyFaceWidget({super.key, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _SmileyFacePainter(),
    );
  }
}

class _SmileyFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Face Circle background
    final facePaint = Paint()
      ..color = const Color(0xFF4ADE80)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, facePaint);

    // Eyes
    final eyePaint = Paint()
      ..color = const Color(0xFF1B4332)
      ..style = PaintingStyle.fill;
    double eyeOffset = size.width * 0.22;
    double eyeRadius = size.width * 0.07;
    canvas.drawCircle(Offset(size.width / 2 - eyeOffset, size.height * 0.42), eyeRadius, eyePaint);
    canvas.drawCircle(Offset(size.width / 2 + eyeOffset, size.height * 0.42), eyeRadius, eyePaint);

    // Smiling mouth
    final mouthPaint = Paint()
      ..color = const Color(0xFF1B4332)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.075
      ..strokeCap = StrokeCap.round;

    final mouthPath = Path();
    mouthPath.addArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height * 0.52), radius: size.width * 0.22),
      0.08 * math.pi,
      0.84 * math.pi,
    );
    canvas.drawPath(mouthPath, mouthPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Background painter for the heartbeat illustration with heart outline at the right end
class HeartbeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final path = Path();
    double midY = size.height * 0.65;
    double width = size.width;

    path.moveTo(width * 0.45, midY);
    path.lineTo(width * 0.6, midY);
    path.lineTo(width * 0.64, midY - 12);
    path.lineTo(width * 0.68, midY + 16);
    path.lineTo(width * 0.72, midY - 6);
    path.lineTo(width * 0.76, midY);
    path.lineTo(width * 0.82, midY);

    canvas.drawPath(path, paint);

    // Draw the heart shape outline
    final heartPath = Path();
    double hCenterX = width * 0.87;
    double hCenterY = midY;
    double hSize = 14;

    heartPath.moveTo(hCenterX, hCenterY + hSize * 0.4);
    heartPath.cubicTo(
      hCenterX + hSize * 0.6, hCenterY - hSize * 0.3,
      hCenterX + hSize * 0.6, hCenterY - hSize * 0.9,
      hCenterX, hCenterY - hSize * 0.4,
    );
    heartPath.cubicTo(
      hCenterX - hSize * 0.6, hCenterY - hSize * 0.9,
      hCenterX - hSize * 0.6, hCenterY - hSize * 0.3,
      hCenterX, hCenterY + hSize * 0.4,
    );

    canvas.drawPath(heartPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
