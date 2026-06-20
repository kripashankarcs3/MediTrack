import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/vitals_screen.dart';
import 'screens/medicines_screen.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const MediTrackApp());
}

class MediTrackApp extends StatelessWidget {
  const MediTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7F56D9),
          primary: const Color(0xFF7F56D9),
          secondary: const Color(0xFF6366F1),
        ),
        // Google fonts configuration for high contrast and elder-readability
        textTheme: GoogleFonts.notoSansDevanagariTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          titleLarge: GoogleFonts.notoSansDevanagari(
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
          bodyMedium: GoogleFonts.notoSansDevanagari(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  // Master Medicines List
  final List<Map<String, dynamic>> _medicines = [
    {
      'name': 'Metformin 500mg',
      'time': '08:00 AM',
      'dose': '1 गोली',
      'instruction': 'नाश्ते के बाद',
      'isTaken': true,
    },
    {
      'name': 'Telmisartan 40mg',
      'time': '01:00 PM',
      'dose': '1 गोली',
      'instruction': 'दोपहर के भोजन के बाद',
      'isTaken': false,
    },
    {
      'name': 'Vitamin D3',
      'time': '08:00 PM',
      'dose': '1 गोली',
      'instruction': 'रात के भोजन के बाद',
      'isTaken': false,
    },
    {
      'name': 'Atorvastatin 10mg',
      'time': '10:00 PM',
      'dose': '1 गोली',
      'instruction': 'सोने से पहले',
      'isTaken': false,
    },
  ];

  // SOS Countdown state
  bool _isSosCountdownActive = false;
  int _sosCountdownVal = 3;
  Timer? _sosTimer;
  bool _isSosAlertSent = false;

  // Voice overlay animation helper
  bool _isVoiceAssistantActive = false;
  String _voicePromptText = "सुन रहा हूँ...";
  String _voiceSubText = "कृपया बोलिए (जैसे: 'दवा', 'बीपी', 'मदद', 'होम')";
  String _voiceTranscript = "...";

  // Triggering the Voice Assistant dialog
  void _openVoiceAssistant() {
    setState(() {
      _isVoiceAssistantActive = true;
      _voicePromptText = "सुन रहा हूँ...";
      _voiceSubText = "कृपया बोलिए (जैसे: 'दवा', 'बीपी', 'मदद', 'होम')";
      _voiceTranscript = "...";
    });
  }

  // Simulate parsing speaking keywords
  void _processVoiceCommand(String command) {
    setState(() {
      _voiceTranscript = '"$command"';
      _voicePromptText = "प्रोसेस कर रहा हूँ...";
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      
      String responseText = "";
      int targetIndex = _currentIndex;

      if (command.contains("दवा") || command.contains("remind") || command.contains("medicine")) {
        targetIndex = 3; // Medicine Screen
        responseText = "दवाइयाँ स्क्रीन खोल रहा हूँ";
      } else if (command.contains("बीपी") || command.contains("शुगर") || command.contains("आंकड़े") || command.contains("vital") || command.contains("report")) {
        targetIndex = 1; // Vitals Screen
        responseText = "आपके स्वास्थ्य आंकड़े दिखा रहा हूँ";
      } else if (command.contains("मदद") || command.contains("sos") || command.contains("help") || command.contains("आपातकाल")) {
        responseText = "आपातकालीन अलर्ट शुरू किया जा रहा है!";
        _triggerSOSFlow();
      } else if (command.contains("होम") || command.contains("home") || command.contains("डैशबोर्ड")) {
        targetIndex = 0; // Home Screen
        responseText = "होम डैशबोर्ड खोल रहा हूँ";
      } else {
        responseText = "माफ़ कीजिये, समझ नहीं आया।";
      }

      setState(() {
        _voicePromptText = responseText;
        _currentIndex = targetIndex;
      });

      // Automatically close helper after 1.5s
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _isVoiceAssistantActive = false;
          });
        }
      });
    });
  }

  // Start SOS countdown flow
  void _triggerSOSFlow() {
    setState(() {
      _isVoiceAssistantActive = false; // Hide voice helper if active
      _isSosCountdownActive = true;
      _sosCountdownVal = 3;
      _isSosAlertSent = false;
    });

    _sosTimer?.cancel();
    _sosTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sosCountdownVal > 1) {
        setState(() {
          _sosCountdownVal--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isSosCountdownActive = false;
          _isSosAlertSent = true;
        });
      }
    });
  }

  // Cancel active SOS countdown
  void _cancelSOS() {
    _sosTimer?.cancel();
    setState(() {
      _isSosCountdownActive = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'आपातकालीन अलर्ट रद्द कर दिया गया है।',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Calculate percentage of taken medicines
  double _calculateProgress() {
    if (_medicines.isEmpty) return 0.0;
    int takenCount = _medicines.where((med) => med['isTaken'] == true).length;
    return takenCount / _medicines.length;
  }

  // Toggle medicine check state
  void _toggleMedicineStatus(int index) {
    setState(() {
      _medicines[index]['isTaken'] = !_medicines[index]['isTaken'];
    });
  }

  // Add new medicine dynamically
  void _addNewMedicine(String name, String time, String dose, String instruction) {
    setState(() {
      _medicines.add({
        'name': name,
        'time': time,
        'dose': dose,
        'instruction': instruction,
        'isTaken': false,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Dua "$name" scheduled successfully!',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7F56D9),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  void dispose() {
    _sosTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the next medicine details (first incomplete or the next in list)
    var nextMed = _medicines.firstWhere((med) => med['isTaken'] == false, orElse: () => _medicines.first);
    bool isNextMedTaken = nextMed['isTaken'];

    // Screens list
    final List<Widget> screens = [
      HomeScreen(
        medicineProgress: _calculateProgress(),
        nextMedicine: nextMed,
        isNextMedTaken: isNextMedTaken,
        onTakeMedicine: () {
          int idx = _medicines.indexOf(nextMed);
          _toggleMedicineStatus(idx);
        },
        onTriggerSos: _triggerSOSFlow,
        onNavigate: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      VitalsScreen(onBack: () {
        setState(() {
          _currentIndex = 0;
        });
      }),
      const SizedBox(), // Placeholder for Floating mic button actions
      MedicinesScreen(
        medicinesList: _medicines,
        onToggleStatus: _toggleMedicineStatus,
        onAddMedicine: _addNewMedicine,
      ),
      _buildProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Current Screen View
          screens[_currentIndex],
          
          // Floating Bottom Navigation Bar
          _buildFloatingBottomNav(),
          
          // Voice Assistant Siri Overlay dialog
          if (_isVoiceAssistantActive) _buildVoiceOverlay(),
          
          // SOS Countdown Overlay
          if (_isSosCountdownActive) _buildSosCountdownOverlay(),
          
          // SOS Sent Success Dialog
          if (_isSosAlertSent) _buildSosSuccessOverlay(),
        ],
      ),
    );
  }

  // Custom Floating Bottom Navigation Bar
  Widget _buildFloatingBottomNav() {
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    double bottomPosition = bottomPadding > 0 ? bottomPadding + 8 : 16;

    return Positioned(
      bottom: bottomPosition,
      left: 16,
      right: 16,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.92),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: const Color(0xFF7F56D9).withValues(alpha: 0.02),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, 'होम', icon: Icons.home_rounded),
            _buildNavItem(1, 'आँकड़े', icon: Icons.favorite_rounded),
            
            // Central floating voice mic button
            _buildFloatingMicButton(),
            
            _buildNavItem(
              3,
              'दवाइयाँ',
              customIcon: CapsuleIcon(
                color: _currentIndex == 3 ? const Color(0xFF7F56D9) : const Color(0xFF98A2B3),
                size: 24,
              ),
            ),
            _buildNavItem(4, 'प्रोफाइल', icon: Icons.person_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, {IconData? icon, Widget? customIcon}) {
    bool isActive = _currentIndex == index;
    Color iconColor = isActive ? const Color(0xFF7F56D9) : const Color(0xFF98A2B3);
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customIcon ?? Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingMicButton() {
    return GestureDetector(
      onTap: _openVoiceAssistant,
      child: Container(
        width: 76,
        height: 76,
        margin: const EdgeInsets.only(bottom: 28),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF7F56D9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7F56D9).withValues(alpha: 0.35),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.mic_rounded,
            color: Colors.white,
            size: 34,
          ),
        ),
      ),
    );
  }

  // Voice Assistant Siri Overlay Dialog UI
  Widget _buildVoiceOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black45,
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, -5),
              )
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'MediTrack Voice Assistant',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF475467),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Color(0xFF98A2B3)),
                    onPressed: () {
                      setState(() {
                        _isVoiceAssistantActive = false;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Pulsating mic waves illustration
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      color: const Color(0xFF7F56D9).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: Color(0xFF7F56D9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mic_rounded, color: Colors.white, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              
              Text(
                _voicePromptText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D2939),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _voiceSubText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475467),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Quick Actions simulated tap tags
              Wrap(
                spacing: 10,
                children: [
                  ActionChip(
                    label: const Text('💊 दवाइयाँ'),
                    onPressed: () => _processVoiceCommand('दवाइयाँ स्क्रीन खोलो'),
                    backgroundColor: const Color(0xFFF3E8FF),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  ActionChip(
                    label: const Text('📊 आंकड़े'),
                    onPressed: () => _processVoiceCommand('रिपोर्ट दिखाओ'),
                    backgroundColor: const Color(0xFFEBF5FF),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  ActionChip(
                    label: const Text('🚨 मदद (SOS)'),
                    onPressed: () => _processVoiceCommand('मदद चाहिए'),
                    backgroundColor: const Color(0xFFFEF3F2),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  ActionChip(
                    label: const Text('🏠 होम'),
                    onPressed: () => _processVoiceCommand('होम जाओ'),
                    backgroundColor: const Color(0xFFF2F4F7),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Dynamic speech output
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _voiceTranscript,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF7F56D9),
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Full screen SOS Countdown UI dialog
  Widget _buildSosCountdownOverlay() {
    return Positioned.fill(
      child: Container(
        color: const Color(0xFF0F172A).withValues(alpha: 0.96),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '🚨',
                style: TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 16),
              const Text(
                'आपातकालीन अलर्ट',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'मदद के लिए संदेश भेजा जा रहा है...',
                style: TextStyle(
                  color: Color(0xFF94A3B8),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),
              
              // Large numeric countdown circle
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD92D20).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFFD92D20),
                    width: 6,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFD92D20).withValues(alpha: 0.3),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$_sosCountdownVal',
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                      fontSize: 64,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  'डॉक्टर और आपके परिवार को तुरंत सूचना दी जा रही है।',
                  style: TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 15,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
              
              // Cancel Button
              GestureDetector(
                onTap: _cancelSOS,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.close_rounded, color: Color(0xFFD92D20), size: 22),
                      SizedBox(width: 8),
                      Text(
                        'रद्द करें (Cancel)',
                        style: TextStyle(
                          color: Color(0xFFD92D20),
                          fontSize: 18,
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
      ),
    );
  }

  // SOS Success details overlay
  Widget _buildSosSuccessOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFF12B76A),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 48),
              ),
              const SizedBox(height: 18),
              const Text(
                'अलर्ट भेज दिया गया!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF12B76A),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'रमेश जी, घबराएं नहीं।',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF475467),
                ),
              ),
              const SizedBox(height: 20),
              
              // Activity log
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _buildLogItem('💬 बेटे अमित को SMS भेज दिया गया है।'),
                    const SizedBox(height: 10),
                    _buildLogItem('📞 डॉ. आर. के. गुप्ता को कॉल किया जा रहा है।'),
                    const SizedBox(height: 10),
                    _buildLogItem('📍 आपकी लोकेशन (नई दिल्ली) शेयर कर दी गई है।'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSosAlertSent = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7F56D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'ठीक है (Close)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogItem(String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('•', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF7F56D9))),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 13, color: Color(0xFF1D2939), fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  // Profile Screen Widget
  Widget _buildProfileScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '👤 मेरी प्रोफाइल',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1D2939),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 160),
        child: Column(
          children: [
            const SizedBox(height: 16),
            
            // Profile Card Details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFF1F5F9)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFF3E8FF), width: 4),
                    ),
                    child: const CircleAvatar(
                      radius: 46,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'रमेश कुमार शर्मा',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'उम्र: 70 वर्ष | लिंग: पुरुष',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475467),
                    ),
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: Color(0xFFF1F5F9)),
                  ),
                  
                  // Vital details parameters grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: 2.2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _buildProfileDetailItem('रक्त समूह (Blood):', 'O+ Pos'),
                      _buildProfileDetailItem('ऊँचाई (Height):', '170 cm'),
                      _buildProfileDetailItem('वजन (Weight):', '72 kg'),
                      _buildProfileDetailItem('शहर (City):', 'नई दिल्ली'),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Caretakers List Contact Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: const Border(
                  left: BorderSide(color: Color(0xFFD92D20), width: 4),
                  top: BorderSide(color: Color(0xFFF1F5F9)),
                  right: BorderSide(color: Color(0xFFF1F5F9)),
                  bottom: BorderSide(color: Color(0xFFF1F5F9)),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🚨 आपातकालीन संपर्क (Caretakers)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildCaretakerRow('👨‍👦', 'अमित शर्मा (बेटा)', '+91 98765 43210'),
                  const Divider(color: Color(0xFFF8FAFC), height: 20),
                  _buildCaretakerRow('🩺', 'डॉ. आर. के. गुप्ता (फैमिली डॉक्टर)', '+91 99999 88888'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetailItem(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF98A2B3)),
        ),
        const SizedBox(height: 2),
        Text(
          val,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1D2939),
          ),
        ),
      ],
    );
  }

  Widget _buildCaretakerRow(String avatarStub, String name, String phone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(avatarStub, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1D2939)),
                ),
                Text(
                  phone,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475467),
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Center(
            child: Icon(Icons.phone_enabled_rounded, color: Color(0xFF12B76A), size: 16),
          ),
        ),
      ],
    );
  }
}

// Custom Rotating Capsule Icon Widget for Bottom Navigation Bar
class CapsuleIcon extends StatelessWidget {
  final Color color;
  final double size;
  const CapsuleIcon({super.key, required this.color, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _CapsuleIconPainter(color),
    );
  }
}

class _CapsuleIconPainter extends CustomPainter {
  final Color color;
  _CapsuleIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(math.pi / 4); // Rotate 45 degrees

    final rect = Rect.fromCenter(
      center: const Offset(0, 0),
      width: size.width * 0.36,
      height: size.height * 0.8,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(size.width * 0.18));
    canvas.drawRRect(rrect, paint);

    // Divider line splitting capsule halves
    canvas.drawLine(Offset(-size.width * 0.18, 0), Offset(size.width * 0.18, 0), paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _CapsuleIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

