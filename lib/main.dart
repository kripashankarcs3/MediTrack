import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meditrack/l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/vitals_screen.dart';
import 'screens/medicines_screen.dart';
import 'screens/vital_detail_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile_screen.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MediTrackApp());
}

class MediTrackApp extends StatefulWidget {
  const MediTrackApp({super.key});

  @override
  State<MediTrackApp> createState() => _MediTrackAppState();
}

class _MediTrackAppState extends State<MediTrackApp> {
  Locale _locale = const Locale('hi');

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('locale') ?? 'hi';
    if (mounted) {
      setState(() {
        _locale = Locale(code);
      });
    }
  }

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediTrack',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7F56D9),
          primary: const Color(0xFF7F56D9),
          secondary: const Color(0xFF6366F1),
        ),
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
      home: MainShell(
        locale: _locale,
        onLocaleChanged: _setLocale,
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  const MainShell({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
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

  // Voice overlay state
  bool _isVoiceAssistantActive = false;
  String _voicePromptText = "सुन रहा हूँ...";
  String _voiceSubText = "कृपया बोलिए (जैसे: 'दवा', 'बीपी', 'मदद', 'होम')";
  String _voiceTranscript = "...";

  // Notification state
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'icon': Icons.check_circle_rounded,
      'iconColor': const Color(0xFF12B76A),
      'title': 'दवा ले ली गई',
      'body': 'Metformin 500mg सुबह 8:00 बजे ले ली गई है।',
      'time': 'आज, 8:05 AM',
      'isRead': false,
    },
    {
      'id': '2',
      'icon': Icons.access_alarm_rounded,
      'iconColor': const Color(0xFF7F56D9),
      'title': 'दवा लेने का समय',
      'body': 'Telmisartan 40mg दोपहर 1:00 बजे लेनी है। खाने के बाद लें।',
      'time': 'आज, 12:30 PM',
      'isRead': false,
    },
    {
      'id': '3',
      'icon': Icons.favorite_rounded,
      'iconColor': const Color(0xFFF43F5E),
      'title': 'BP रीडिंग: 130/85',
      'body': 'आपका ब्लड प्रेशर सामान्य से थोड़ा ऊपर है। कृपया डॉक्टर से सलाह लें।',
      'time': 'आज, 10:15 AM',
      'isRead': false,
    },
    {
      'id': '4',
      'icon': Icons.calendar_today_rounded,
      'iconColor': const Color(0xFF2E82FF),
      'title': 'डॉक्टर अपॉइंटमेंट',
      'body': 'डॉ. आर. के. गुप्ता से कल सुबह 10:00 बजे अपॉइंटमेंट है।',
      'time': 'आज, 9:00 AM',
      'isRead': false,
    },
  ];

  int get _unreadCount => _notifications.where((n) => n['isRead'] == false).length;

  void _markNotificationRead(String id) {
    setState(() {
      final idx = _notifications.indexWhere((n) => n['id'] == id);
      if (idx != -1) _notifications[idx]['isRead'] = true;
    });
  }

  void _markAllNotificationsRead() {
    setState(() {
      for (var n in _notifications) {
        n['isRead'] = true;
      }
    });
  }

  void _openNotifications() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1D2939)),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'सूचनाएँ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1D2939),
              ),
            ),
            centerTitle: false,
          ),
          body: NotificationsScreen(
            notifications: _notifications,
            onMarkRead: _markNotificationRead,
            onMarkAllRead: _markAllNotificationsRead,
          ),
        ),
      ),
    );
  }

  void _openVoiceAssistant() {
    setState(() {
      _isVoiceAssistantActive = true;
      _voicePromptText = "सुन रहा हूँ...";
      _voiceSubText = "कृपया बोलिए (जैसे: 'दवा', 'बीपी', 'मदद', 'होम')";
      _voiceTranscript = "...";
    });
  }

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
        targetIndex = 3; // Medicines
        responseText = "दवाइयाँ स्क्रीन खोल रहा हूँ";
      } else if (command.contains("बीपी") || command.contains("शुगर") || command.contains("आंकड़े") || command.contains("vital") || command.contains("report")) {
        targetIndex = 1; // Vitals
        responseText = "आपके आंकड़े दिखा रहा हूँ";
      } else if (command.contains("मदद") || command.contains("sos") || command.contains("help") || command.contains("आपातकाल")) {
        responseText = "आपातकालीन अलर्ट शुरू किया जा रहा है!";
        _triggerSOSFlow();
      } else if (command.contains("होम") || command.contains("home") || command.contains("डैशबोर्ड")) {
        targetIndex = 0; // Home
        responseText = "होम डैशबोर्ड खोल रहा हूँ";
      } else {
        responseText = "माफ़ कीजिये, समझ नहीं आया।";
      }

      setState(() {
        _voicePromptText = responseText;
        _currentIndex = targetIndex;
      });

      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          setState(() {
            _isVoiceAssistantActive = false;
          });
        }
      });
    });
  }

  void _triggerSOSFlow() {
    setState(() {
      _isVoiceAssistantActive = false;
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

  void _cancelSOS() {
    _sosTimer?.cancel();
    setState(() {
      _isSosCountdownActive = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.sosCancelled,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  double _calculateProgress() {
    if (_medicines.isEmpty) return 0.0;
    int takenCount = _medicines.where((med) => med['isTaken'] == true).length;
    return takenCount / _medicines.length;
  }

  void _toggleMedicineStatus(int index) {
    setState(() {
      _medicines[index]['isTaken'] = !_medicines[index]['isTaken'];
    });
  }

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
          AppLocalizations.of(context)!.scheduleMedicine,
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
    var nextMed = _medicines.isEmpty
        ? <String, dynamic>{}
        : _medicines.firstWhere((med) => med['isTaken'] == false, orElse: () => _medicines.first);
    bool isNextMedTaken = nextMed['isTaken'] ?? false;

    final List<Widget> screens = [
      HomeScreen(
        medicineProgress: _calculateProgress(),
        nextMedicine: nextMed,
        isNextMedTaken: isNextMedTaken,
        medicineTakenCount: _medicines.where((m) => m['isTaken'] == true).length,
        medicineTotalCount: _medicines.length,
        notificationCount: _unreadCount,
        onOpenNotifications: _openNotifications,
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
        onOpenVitalDetail: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VitalDetailScreen(
                vitalType: VitalType.values[index],
              ),
            ),
          );
        },
      ),
      VitalsScreen(onBack: () {
        setState(() {
          _currentIndex = 0;
        });
      }),
      const SizedBox(), // Spacer
      MedicinesScreen(
        medicinesList: _medicines,
        onToggleStatus: _toggleMedicineStatus,
        onAddMedicine: _addNewMedicine,
        notificationCount: _unreadCount,
        onOpenNotifications: _openNotifications,
      ),
      ProfileScreen(
        currentLocale: widget.locale,
        onLocaleChanged: widget.onLocaleChanged,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Current Screen View (Fills body area and resizes automatically above bottom navigation bar)
          screens[_currentIndex],
          
          // Voice Assistant Siri Overlay dialog
          if (_isVoiceAssistantActive) _buildVoiceOverlay(),
          
          // SOS Countdown Overlay
          if (_isSosCountdownActive) _buildSosCountdownOverlay(),
          
          // SOS Sent Success Dialog
          if (_isSosAlertSent) _buildSosSuccessOverlay(),
        ],
      ),
      // Placed inside the bottomNavigationBar parameter so body content stops exactly above it
      bottomNavigationBar: _buildFloatingBottomNav(),
    );
  }

  // Custom Floating Bottom Navigation Bar
  Widget _buildFloatingBottomNav() {
    double bottomInset = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: bottomInset + 14,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // Nav bar
          Container(
            height: 74,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 28,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, AppLocalizations.of(context)!.navHome, icon: Icons.home_rounded),
                _buildNavItem(1, AppLocalizations.of(context)!.navVitals, icon: Icons.favorite_rounded),
                const SizedBox(width: 68),
                _buildNavItem(
                  3,
                  AppLocalizations.of(context)!.navMedicines,
                  customIcon: CapsuleIcon(
                    color: _currentIndex == 3 ? const Color(0xFF6C4DFF) : const Color(0xFFB0B7C3),
                    size: 22,
                  ),
                ),
                _buildNavItem(4, AppLocalizations.of(context)!.navProfile, icon: Icons.person_rounded),
              ],
            ),
          ),
          // Floating mic button above nav bar
          Positioned(
            top: -14,
            child: _buildFloatingMicButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, {IconData? icon, Widget? customIcon}) {
    bool isActive = _currentIndex == index;
    Color iconColor = isActive ? const Color(0xFF6C4DFF) : const Color(0xFFB0B7C3);
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 52,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customIcon ?? Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
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
        width: 62,
        height: 62,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFF5B3DFF), Color(0xFF7B61FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.white, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5B3DFF).withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.mic_rounded,
            color: Colors.white,
            size: 28,
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
