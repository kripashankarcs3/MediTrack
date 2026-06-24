import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';
import 'package:meditrack/l10n/app_localizations.dart';
import 'doctor_appointment_screen.dart';
import 'medical_records_screen.dart';
import 'family_screen.dart';
import 'health_report_screen.dart';
import 'health_tips_screen.dart';

class HomeScreen extends StatelessWidget {
  final double medicineProgress;
  final Map<String, dynamic> nextMedicine;
  final VoidCallback onTakeMedicine;
  final bool isNextMedTaken;
  final VoidCallback onTriggerSos;
  final Function(int) onNavigate;
  final Function(int) onOpenVitalDetail;
  final int medicineTakenCount;
  final int medicineTotalCount;
  final int notificationCount;
  final VoidCallback onOpenNotifications;

  const HomeScreen({
    super.key,
    required this.medicineProgress,
    required this.nextMedicine,
    required this.onTakeMedicine,
    required this.isNextMedTaken,
    required this.onTriggerSos,
    required this.onNavigate,
    required this.onOpenVitalDetail,
    required this.medicineTakenCount,
    required this.medicineTotalCount,
    required this.notificationCount,
    required this.onOpenNotifications,
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
                          child: Text(
                            AppLocalizations.of(context)!.appTitle,
                            style: const TextStyle(
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
                    InkWell(
                      onTap: onOpenNotifications,
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
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
                          if (notificationCount > 0)
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
                                child: Center(
                                  child: Text(
                                    notificationCount > 9 ? '9+' : '$notificationCount',
                                    style: const TextStyle(
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
                _buildGreetingHeader(context),
                const SizedBox(height: 20),
                // Health Status Hero Card (Purple Gradient)
                _buildHealthStatusCard(context),
                
                // Quick Access Section
                _buildQuickAccessSection(context),

                const SizedBox(height: 4),
                
                // Section Title & 2x2 Daily Health Cards Grid
                _buildVitalsGridSection(context),
                
                const SizedBox(height: 16),
                
                // Today's Next Medicine Card
                _buildNextMedicineSection(context),
                
                const SizedBox(height: 20),
                
                // Emergency SOS Card
                _buildEmergencyCard(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Header Greeting Section
  Widget _buildGreetingHeader(BuildContext context) {
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
                  children: [
                    Text(
                      AppLocalizations.of(context)!.greeting,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D2939),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context)!.greetingSuffix,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.greetingSubtitle,
                  style: const TextStyle(
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
                children: [
                  const Icon(Icons.person_add_rounded, size: 14, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(context)!.profile,
                    style: const TextStyle(
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
                      children: [
                        Text(
                          AppLocalizations.of(context)!.healthStatus,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppLocalizations.of(context)!.healthStatusValue,
                          style: const TextStyle(
                            color: Color(0xFF86EFAC), // Bright Lime Green
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          AppLocalizations.of(context)!.healthMessage1,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.healthMessage2,
                          style: const TextStyle(
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

  // Today's Vitals Cards Section with Horizontal Scroll
  Widget _buildVitalsGridSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Red-tinted card with heart icon on the left
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0F2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.favorite_rounded,
                    color: Color(0xFFF43F5E),
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.todayVitals,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1D2939),
                  ),
                ),
              ),
              InkWell(
                onTap: () => onNavigate(1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Text(
                    AppLocalizations.of(context)!.seeAll,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF7F56D9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          clipBehavior: Clip.none,
          child: Row(
            children: [
              _buildVitalCard(
                context: context,
                title: AppLocalizations.of(context)!.bp,
                value: '120/80',
                unit: AppLocalizations.of(context)!.unitMmhg,
                leadingWidget: const HeartPulseIcon(
                  color: Color(0xFFF43F5E),
                  size: 16,
                ),
                bgColor: const Color(0xFFFFF5F5),
                borderColor: const Color(0xFFFFF0F1),
                onTap: () => onOpenVitalDetail(0),
              ),
              const SizedBox(width: 12),
              _buildVitalCard(
                context: context,
                title: AppLocalizations.of(context)!.sugar,
                value: '98',
                unit: AppLocalizations.of(context)!.unitMgdl,
                leadingWidget: const Icon(
                  Icons.water_drop_rounded,
                  color: Color(0xFF3B82F6),
                  size: 18,
                ),
                bgColor: const Color(0xFFF0F7FF),
                borderColor: const Color(0xFFEEF6FF),
                onTap: () => onOpenVitalDetail(1),
              ),
              const SizedBox(width: 12),
              _buildVitalCard(
                context: context,
                title: 'SpO₂',
                value: '98%',
                leadingWidget: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'O',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF12B76A),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: '₂',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF12B76A),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                bgColor: const Color(0xFFF3FAF6),
                borderColor: const Color(0xFFEDF7F1),
                onTap: () => onOpenVitalDetail(2),
              ),
              const SizedBox(width: 12),
              _buildVitalCard(
                context: context,
                title: AppLocalizations.of(context)!.temperature,
                value: '98.6°F',
                leadingWidget: const Icon(
                  Icons.thermostat_rounded,
                  color: Color(0xFFF97316),
                  size: 18,
                ),
                bgColor: const Color(0xFFFFFDF5),
                borderColor: const Color(0xFFFFF9EE),
                onTap: () => onOpenVitalDetail(3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVitalCard({
    required BuildContext context,
    required String title,
    required String value,
    String? unit,
    required Widget leadingWidget,
    required Color bgColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 125,
        height: 136,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Icon/Text leading, Title, Chevron
            Row(
              children: [
                leadingWidget,
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475467),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 16,
                  color: Color(0xFF1D2939),
                ),
              ],
            ),
            
            // Middle Row: Value & Unit
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (unit != null && title == AppLocalizations.of(context)!.sugar) ...[
                  // Sugar inline layout matching screenshot: "98 mg/dL"
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value,
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1D2939),
                          ),
                        ),
                        const TextSpan(text: ' '),
                        TextSpan(
                          text: unit,
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Normal value text
                  Text(
                    value,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1D2939),
                      height: 1.1,
                    ),
                  ),
                  if (unit != null)
                    Text(
                      unit,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF667085),
                        height: 1.1,
                      ),
                    ),
                ],
              ],
            ),

            // Bottom Row: Status Badge (Green dot + "सामान्य")
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7ED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF12B76A),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      AppLocalizations.of(context)!.normal,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF12B76A),
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
                    Text(
                      AppLocalizations.of(context)!.todayNextMedicine,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D2939),
                      ),
                    ),
                    Text(
                      nextMedicine['time'] ?? AppLocalizations.of(context)!.medicineDefaultTime,
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
                            nextMedicine['name'] ?? AppLocalizations.of(context)!.medicineDefaultName,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1D2939),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            nextMedicine['instruction'] ?? AppLocalizations.of(context)!.medicineDefaultInstruction,
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
                const SizedBox(height: 16),
                // Progress dots
                Row(
                  children: [
                    ...List.generate(medicineTotalCount, (i) {
                      final isFilled = i < medicineTakenCount;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFilled ? const Color(0xFF12B76A) : const Color(0xFFE2E8F0),
                          border: Border.all(
                            color: isFilled ? const Color(0xFF12B76A) : const Color(0xFFCBD5E1),
                            width: 2,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.medicineProgress(medicineTakenCount.toString(), medicineTotalCount.toString()),
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1D2939),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF12B76A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${(medicineTakenCount / medicineTotalCount * 100).round()}%',
                        style: const TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
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
  Widget _buildEmergencyCard(BuildContext context) {
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
              children: [
                Text(
                  AppLocalizations.of(context)!.emergencyHelp,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFD92D20),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  AppLocalizations.of(context)!.emergencySubtitle,
                  style: const TextStyle(
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
                  children: [
                    const Icon(
                      Icons.notifications_active_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.sosButton,
                      style: const TextStyle(
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

  // Quick Access Section
  Widget _buildQuickAccessSection(BuildContext context) {
    final quickItems = [
      _QuickAccessItem(
        icon: DoctorIcon(size: 20),
        label: AppLocalizations.of(context)!.quickDoctor,
        circleColor: const Color(0xFF6C4DFF),
        chevronBgColor: const Color(0xFFF1EEFF),
        chevronIconColor: const Color(0xFF6C4DFF),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ChooseDoctorScreen())),
      ),
      _QuickAccessItem(
        icon: const MedicalFolderIcon(size: 20),
        label: AppLocalizations.of(context)!.quickRecords,
        circleColor: const Color(0xFF00B050),
        chevronBgColor: const Color(0xFFE6F7ED),
        chevronIconColor: const Color(0xFF00B050),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MedicalRecordsScreen())),
      ),
      _QuickAccessItem(
        icon: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 20),
        label: AppLocalizations.of(context)!.quickFamily,
        circleColor: const Color(0xFF2E82FF),
        chevronBgColor: const Color(0xFFEFF6FF),
        chevronIconColor: const Color(0xFF2E82FF),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FamilyScreen())),
      ),
      _QuickAccessItem(
        icon: const HealthReportChartIcon(size: 20),
        label: AppLocalizations.of(context)!.quickReport,
        circleColor: const Color(0xFF8A5FFF),
        chevronBgColor: const Color(0xFFF5F1FF),
        chevronIconColor: const Color(0xFF8A5FFF),
        isNew: true,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HealthReportScreen())),
      ),
      _QuickAccessItem(
        icon: const Icon(Icons.lightbulb_outline_rounded, color: Colors.white, size: 20),
        label: AppLocalizations.of(context)!.quickTips,
        circleColor: const Color(0xFFFF9800),
        chevronBgColor: const Color(0xFFFFF7ED),
        chevronIconColor: const Color(0xFFFF9800),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const HealthTipsScreen())),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header with purple accent bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 6,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF8A5FFF),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.quickAccess,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1D2939),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Cards horizontal scroll
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 20),
          clipBehavior: Clip.none,
          child: Row(
            children: quickItems.map((item) {
              return Padding(
                padding: EdgeInsets.only(
                  right: item == quickItems.last ? 0 : 12,
                ),
                child: _QuickAccessCard(item: item, onTap: item.onTap),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// Quick Access card model
class _QuickAccessItem {
  final Widget icon;
  final String label;
  final Color circleColor;
  final Color chevronBgColor;
  final Color chevronIconColor;
  final bool isNew;
  final VoidCallback? onTap;
  const _QuickAccessItem({
    required this.icon,
    required this.label,
    required this.circleColor,
    required this.chevronBgColor,
    required this.chevronIconColor,
    this.isNew = false,
    this.onTap,
  });
}

// Quick Access card widget with scale animation
class _QuickAccessCard extends StatefulWidget {
  final _QuickAccessItem item;
  final VoidCallback? onTap;
  const _QuickAccessCard({required this.item, this.onTap});

  @override
  State<_QuickAccessCard> createState() => _QuickAccessCardState();
}

class _QuickAccessCardState extends State<_QuickAccessCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: child,
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 154,
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Icon circle
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: widget.item.circleColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: widget.item.icon,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Label
                  Expanded(
                    child: Text(
                      widget.item.label,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1D2939),
                        height: 1.15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Chevron button
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: widget.item.chevronBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 16,
                        color: widget.item.chevronIconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (widget.item.isNew)
              Positioned(
                top: -8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C4DFF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.badgeNew,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DoctorIcon extends StatelessWidget {
  final double size;
  const DoctorIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _DoctorIconPainter(),
    );
  }
}

class _DoctorIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Doctor Cap:
    final capPath = Path();
    capPath.moveTo(w * 0.3, h * 0.28);
    capPath.lineTo(w * 0.3, h * 0.18);
    capPath.quadraticBezierTo(w * 0.5, h * 0.08, w * 0.7, h * 0.18);
    capPath.lineTo(w * 0.7, h * 0.28);
    capPath.close();
    canvas.drawPath(capPath, paint);

    // Head/Face:
    double cx = w * 0.5;
    double cy = h * 0.42;
    canvas.drawCircle(Offset(cx, cy), w * 0.16, paint);

    // Cap Cross Sign:
    final crossPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(w * 0.5, h * 0.13), Offset(w * 0.5, h * 0.23), crossPaint);
    canvas.drawLine(Offset(w * 0.45, h * 0.18), Offset(w * 0.55, h * 0.18), crossPaint);

    // Shoulders/Coat:
    final coatPath = Path();
    coatPath.moveTo(w * 0.18, h * 0.82);
    coatPath.quadraticBezierTo(w * 0.2, h * 0.62, w * 0.34, h * 0.62);
    coatPath.lineTo(w * 0.66, h * 0.62);
    coatPath.quadraticBezierTo(w * 0.8, h * 0.62, w * 0.82, h * 0.82);
    canvas.drawPath(coatPath, paint);

    // Plus symbol on chest:
    double px = w * 0.64;
    double py = h * 0.72;
    canvas.drawLine(Offset(px, py - 4), Offset(px, py + 4), paint);
    canvas.drawLine(Offset(px - 4, py), Offset(px + 4, py), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MedicalFolderIcon extends StatelessWidget {
  final double size;
  const MedicalFolderIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _MedicalFolderIconPainter(),
    );
  }
}

class _MedicalFolderIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Folder shape:
    final folderPath = Path();
    folderPath.moveTo(w * 0.12, h * 0.8);
    folderPath.lineTo(w * 0.12, h * 0.3);
    folderPath.lineTo(w * 0.42, h * 0.3);
    folderPath.lineTo(w * 0.48, h * 0.2);
    folderPath.lineTo(w * 0.72, h * 0.2);
    folderPath.quadraticBezierTo(w * 0.8, h * 0.2, w * 0.82, h * 0.3);
    folderPath.lineTo(w * 0.88, h * 0.3);
    folderPath.lineTo(w * 0.88, h * 0.8);
    folderPath.close();
    canvas.drawPath(folderPath, paint);

    // Plus sign in center:
    double px = w * 0.5;
    double py = h * 0.55;
    canvas.drawLine(Offset(px, py - 4), Offset(px, py + 4), paint);
    canvas.drawLine(Offset(px - 4, py), Offset(px + 4, py), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HealthReportChartIcon extends StatelessWidget {
  final double size;
  const HealthReportChartIcon({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HealthReportChartIconPainter(),
    );
  }
}

class _HealthReportChartIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Document sheet outline with folded top-right corner:
    final docPath = Path();
    docPath.moveTo(w * 0.15, h * 0.82);
    docPath.lineTo(w * 0.15, h * 0.18);
    docPath.lineTo(w * 0.62, h * 0.18);
    docPath.lineTo(w * 0.85, h * 0.4);
    docPath.lineTo(w * 0.85, h * 0.82);
    docPath.close();
    canvas.drawPath(docPath, paint);

    // Corner Fold:
    canvas.drawLine(Offset(w * 0.62, h * 0.18), Offset(w * 0.62, h * 0.4), paint);
    canvas.drawLine(Offset(w * 0.62, h * 0.4), Offset(w * 0.85, h * 0.4), paint);

    // Mini bar graph inside:
    final fillPaintOrange = Paint()
      ..color = const Color(0xFFFF9800)
      ..style = PaintingStyle.fill;
    final fillPaintBlue = Paint()
      ..color = const Color(0xFF2196F3)
      ..style = PaintingStyle.fill;

    // Bar 1 (left):
    canvas.drawRect(
      Rect.fromLTWH(w * 0.3, h * 0.58, w * 0.08, h * 0.18),
      fillPaintOrange,
    );
    // Bar 2 (middle):
    canvas.drawRect(
      Rect.fromLTWH(w * 0.43, h * 0.5, w * 0.08, h * 0.26),
      fillPaintBlue,
    );
    // Bar 3 (right):
    canvas.drawRect(
      Rect.fromLTWH(w * 0.56, h * 0.45, w * 0.08, h * 0.31),
      fillPaintOrange,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
