import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:meditrack/l10n/app_localizations.dart';
import 'providers/language_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/vitals_provider.dart';
import 'models/vital_reading.dart';
import 'services/openrouter_service.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/vitals_screen.dart';
import 'screens/medicines_screen.dart';
import 'screens/vital_detail_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/profile_screen.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()..loadLocale()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => VitalsProvider()),
      ],
      child: const MediTrackApp(),
    ),
  );
}

class MediTrackApp extends StatelessWidget {
  const MediTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageProvider>().locale;
    final themeMode = context.watch<ThemeProvider>().themeMode;
    return MaterialApp(
      title: 'MediTrack',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
      ],
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      themeMode: themeMode,
      theme: buildLightTheme().copyWith(
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
      darkTheme: buildDarkTheme().copyWith(
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

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  // Master Medicines List
  List<Map<String, dynamic>> _medicines = [];

  // SOS Countdown state
  bool _isSosCountdownActive = false;
  int _sosCountdownVal = 3;
  Timer? _sosTimer;
  bool _isSosAlertSent = false;

  // Voice overlay state
  bool _isVoiceAssistantActive = false;
  String _voicePromptText = "";
  String _voiceSubText = "";
  String _voiceTranscript = "";

  // Speech-to-text
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _speechAvailable = false;
  String _voiceSavedMessage = '';
  double _soundLevel = 0.0;

  // Notification state
  List<Map<String, dynamic>> _notifications = [];
  bool _dataInitialized = false;

  void _initSampleData() {
    if (_dataInitialized) return;
    _dataInitialized = true;
    final l = AppLocalizations.of(context)!;
    _medicines = [
      {'name': l.medMetformin, 'time': '08:00 AM', 'dose': l.dose1Pill, 'instruction': l.instAfterBreakfast, 'isTaken': true},
      {'name': l.medTelmisartan, 'time': '01:00 PM', 'dose': l.dose1Pill, 'instruction': l.instAfterLunch, 'isTaken': false},
      {'name': l.medVitaminD3, 'time': '08:00 PM', 'dose': l.dose1Pill, 'instruction': l.instAfterDinner, 'isTaken': false},
      {'name': l.medAtorvastatin, 'time': '10:00 PM', 'dose': l.dose1Pill, 'instruction': l.instBeforeSleep, 'isTaken': false},
    ];
    _notifications = [
      {
        'id': '1',
        'icon': Icons.check_circle_rounded,
        'iconColor': const Color(0xFF12B76A),
        'title': l.notifMedTaken,
        'body': l.notifMedTakenBody(l.medMetformin, '8:00'),
        'time': '${l.today}, 8:05 AM',
        'isRead': false,
      },
      {
        'id': '2',
        'icon': Icons.access_alarm_rounded,
        'iconColor': const Color(0xFF7F56D9),
        'title': l.notifMedReminder,
        'body': l.notifMedReminderBody(l.medTelmisartan, '1:00'),
        'time': '${l.today}, 12:30 PM',
        'isRead': false,
      },
      {
        'id': '3',
        'icon': Icons.favorite_rounded,
        'iconColor': const Color(0xFFF43F5E),
        'title': l.notifBpReading('130/85'),
        'body': l.notifBpReadingBody,
        'time': '${l.today}, 10:15 AM',
        'isRead': false,
      },
      {
        'id': '4',
        'icon': Icons.calendar_today_rounded,
        'iconColor': const Color(0xFF2E82FF),
        'title': l.notifAppointment,
        'body': l.notifAppointmentBody(l.recordDocGupta, '10:00'),
        'time': '${l.today}, 9:00 AM',
        'isRead': false,
      },
    ];
  }

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
            title: Text(
              AppLocalizations.of(context)!.notifications,
              style: const TextStyle(
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
      _voicePromptText = AppLocalizations.of(context)!.voiceListening;
      _voiceSubText = AppLocalizations.of(context)!.voicePrompt;
      _voiceTranscript = '';
      _voiceSavedMessage = '';
      _soundLevel = 0.0;
    });
    _initAndListen();
  }

  Future<void> _initAndListen() async {
    if (!_speechAvailable) {
      setState(() {
        _voiceSubText = 'Requesting microphone permission...';
      });
      final available = await _speech.initialize(
        onStatus: (status) {
          if (status == 'notListening' && _isListening && mounted) {
            if (_voiceTranscript.trim().isNotEmpty) {
              _stopListeningAndProcess();
            }
          }
        },
        onError: (error) {
          if (mounted) {
            setState(() {
              _speechAvailable = false;
              _voicePromptText = 'Error: ${error.errorMsg}';
            });
          }
        },
      );
      if (!mounted) return;
      if (!available) {
        setState(() {
          _speechAvailable = false;
          _voicePromptText = 'Permission denied. Allow mic access in settings.';
        });
        return;
      }
      setState(() {
        _speechAvailable = true;
      });
    }
    _startListening();
  }

  void _startListening() {
    _speech.listen(
      onResult: (result) {
        setState(() {
          _voiceTranscript = result.recognizedWords;
          if (_voiceTranscript.isNotEmpty) {
            _voiceSubText = '';
          }
        });
      },
      onSoundLevelChange: (level) {
        setState(() {
          _soundLevel = level;
        });
      },
      listenOptions: stt.SpeechListenOptions(
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
      ),
    );
    setState(() {
      _isListening = true;
      _voicePromptText = AppLocalizations.of(context)!.voiceListening;
    });
  }

  void _stopListeningAndProcess() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
      _soundLevel = 0.0;
    });
    if (_voiceTranscript.trim().isNotEmpty) {
      _processVoiceCommand(_voiceTranscript);
    } else {
      setState(() {
        _voicePromptText = AppLocalizations.of(context)!.voiceRespFallback;
      });
      _closeVoiceAfterDelay();
    }
  }

  Map<String, String>? _parseVitalFromText(String text) {
    final lower = text.toLowerCase();

    RegExp bpRegex = RegExp(r'(\d{2,3})\s*(?:/|over|by|upon|par)\s*(\d{2,3})');
    var bpMatch = bpRegex.firstMatch(lower);
    if (bpMatch != null &&
        (lower.contains('bp') ||
            lower.contains('blood') ||
            lower.contains('बीपी') ||
            lower.contains('ब्लड') ||
            lower.contains('press'))) {
      return {'type': 'bp', 'value': '${bpMatch.group(1)}/${bpMatch.group(2)}'};
    }

    RegExp numRegex = RegExp(r'(\d{2,3}(?:\.\d)?)');
    var numMatch = numRegex.firstMatch(lower);
    if (numMatch == null) return null;

    var num = numMatch.group(1)!;

    if (lower.contains('sugar') || lower.contains('शुगर') || lower.contains('glucose') || lower.contains('ग्लूकोज')) {
      return {'type': 'sugar', 'value': num};
    }
    if (lower.contains('oxygen') || lower.contains('ऑक्सीजन') || lower.contains('spo2') || lower.contains('saturat')) {
      return {'type': 'oxygen', 'value': '$num%'};
    }
    if (lower.contains('temperature') || lower.contains('तापमान') || lower.contains('temp')) {
      return {'type': 'temperature', 'value': '$num°F'};
    }

    if (bpMatch != null) {
      return {'type': 'bp', 'value': '${bpMatch.group(1)}/${bpMatch.group(2)}'};
    }

    return null;
  }

  String _vitalTypeLabel(String type) {
    final l = AppLocalizations.of(context)!;
    switch (type) {
      case 'bp': return l.vitalBp;
      case 'sugar': return l.vitalSugar;
      case 'oxygen': return l.vitalOxygen;
      case 'temperature': return l.vitalTemp;
      default: return type;
    }
  }

  void _saveVitalReading(String type, String value) {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final timeStr = '${hour.toString().padLeft(2, '0')}:$minute $period';
    final dateStr = '${now.day}/${now.month}/${now.year}';

    final reading = VitalReading(
      type: type,
      value: value,
      time: timeStr,
      date: dateStr,
      timestamp: now,
    );

    context.read<VitalsProvider>().addReading(reading);

    setState(() {
      _voiceSavedMessage = '${_vitalTypeLabel(type)}: $value ${AppLocalizations.of(context)!.readingSavedLabel}';
      _currentIndex = 1;
    });
  }

  void _closeVoiceAfterDelay() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          _isVoiceAssistantActive = false;
          _soundLevel = 0.0;
        });
      }
    });
  }

  void _processVoiceCommand(String command) async {
    setState(() {
      _voicePromptText = AppLocalizations.of(context)!.voiceProcessing;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    var vital = _parseVitalFromText(command);
    if (vital == null) {
      setState(() {
        _voiceSubText = 'Asking AI...';
      });
      vital = await OpenRouterService.parseVitalFromSpeech(command);
    }

    if (vital != null) {
      final v = vital;
      _saveVitalReading(v['type']!, v['value']!);
      setState(() {
        _voicePromptText = '${_vitalTypeLabel(v['type']!)}: ${v['value']} ${AppLocalizations.of(context)!.readingSavedLabel}';
        _voiceTranscript = '"$command"';
      });
      _closeVoiceAfterDelay();
      return;
    }

    String responseText = "";
    int targetIndex = _currentIndex;

    if (command.contains(AppLocalizations.of(context)!.voiceKeywordMedicine) || command.contains("remind") || command.contains("medicine")) {
      targetIndex = 3;
      responseText = AppLocalizations.of(context)!.voiceRespMedicine;
    } else if (command.contains(AppLocalizations.of(context)!.voiceKeywordVital) || command.contains(AppLocalizations.of(context)!.voiceKeywordReport) || command.contains("vital") || command.contains("report")) {
      targetIndex = 1;
      responseText = AppLocalizations.of(context)!.voiceRespVitals;
    } else if (command.contains(AppLocalizations.of(context)!.voiceKeywordSos) || command.contains("sos") || command.contains("help") || command.contains(AppLocalizations.of(context)!.voiceKeywordHelp)) {
      responseText = AppLocalizations.of(context)!.voiceRespSos;
      _triggerSOSFlow();
    } else if (command.contains(AppLocalizations.of(context)!.voiceKeywordHome) || command.contains("home") || command.contains(AppLocalizations.of(context)!.voiceKeywordDashboard)) {
      targetIndex = 0;
      responseText = AppLocalizations.of(context)!.voiceRespHome;
    } else {
      responseText = AppLocalizations.of(context)!.voiceRespFallback;
    }

    setState(() {
      _voicePromptText = responseText;
      _voiceTranscript = '"$command"';
      _currentIndex = targetIndex;
    });

    _closeVoiceAfterDelay();
  }

  void _triggerSOSFlow() {
    setState(() {
      _isVoiceAssistantActive = false;
      _soundLevel = 0.0;
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
    context.watch<ThemeProvider>();
    final c = context.appColors;
    _initSampleData();
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
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: c.scaffoldBg,
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
    final cnv = context.appColors;
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
              color: cnv.cardBg.withValues(alpha: 0.95),
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
    final c = context.appColors;
    return Positioned.fill(
      child: Container(
        color: Colors.black45,
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: c.cardBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: const Offset(0, -5),
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
                  Flexible(
                    child: Text(
                      AppLocalizations.of(context)!.voiceAssistantTitle,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: c.secondaryText,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: c.tertiaryText),
                    onPressed: () {
                      if (_isListening) _speech.stop();
                      setState(() {
                        _isVoiceAssistantActive = false;
                        _soundLevel = 0.0;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _isListening ? _stopListeningAndProcess : null,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isListening)
                      for (int i = 0; i < 3; i++)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 150 + i * 50),
                          width: 64 + (_soundLevel.clamp(0, 10) * (6 + i * 4)),
                          height: 64 + (_soundLevel.clamp(0, 10) * (6 + i * 4)),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF7F56D9)
                                .withValues(alpha: (0.12 - i * 0.035) * (_soundLevel / 8).clamp(0.3, 1.0)),
                          ),
                        ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      width: _isListening ? 96 : 76,
                      height: _isListening ? 96 : 76,
                      decoration: BoxDecoration(
                        color: _isListening
                            ? const Color(0xFF7F56D9).withValues(alpha: 0.12)
                            : const Color(0xFF7F56D9).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: _isListening ? const Color(0xFF7F56D9) : const Color(0xFF7F56D9),
                        shape: BoxShape.circle,
                        boxShadow: _isListening
                            ? [
                                BoxShadow(
                                  color: const Color(0xFF7F56D9).withValues(alpha: 0.4 * (_soundLevel / 8).clamp(0.2, 1.0)),
                                  blurRadius: 20 + _soundLevel * 2,
                                  spreadRadius: _soundLevel * 0.5,
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(
                        _isListening ? Icons.mic_rounded : Icons.mic_none_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    if (_isListening)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF12B76A),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
                        ),
                      ),
                  ],
                ),
              ),
              if (_isListening)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    AppLocalizations.of(context)!.tapToStop,
                    style: TextStyle(
                      fontSize: 12,
                      color: c.tertiaryText,
                    ),
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                _voicePromptText,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: c.primaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _voiceSubText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: c.secondaryText,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                children: [
                  ActionChip(
                    label: Text(AppLocalizations.of(context)!.voiceMedicine),
                    onPressed: () {
                      if (_isListening) _speech.stop();
                      _processVoiceCommand(AppLocalizations.of(context)!.voiceCmdMedicine);
                    },
                    backgroundColor: const Color(0xFFF3E8FF),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  ActionChip(
                    label: Text(AppLocalizations.of(context)!.voiceVitals),
                    onPressed: () {
                      if (_isListening) _speech.stop();
                      _processVoiceCommand(AppLocalizations.of(context)!.voiceCmdVitals);
                    },
                    backgroundColor: const Color(0xFFEBF5FF),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  ActionChip(
                    label: Text(AppLocalizations.of(context)!.voiceSos),
                    onPressed: () {
                      if (_isListening) _speech.stop();
                      _processVoiceCommand(AppLocalizations.of(context)!.voiceCmdSos);
                    },
                    backgroundColor: const Color(0xFFFEF3F2),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  ActionChip(
                    label: Text(AppLocalizations.of(context)!.voiceHome),
                    onPressed: () {
                      if (_isListening) _speech.stop();
                      _processVoiceCommand(AppLocalizations.of(context)!.voiceCmdHome);
                    },
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
                  color: _voiceSavedMessage.isNotEmpty
                      ? const Color(0xFFDCFCE7)
                      : c.scaffoldBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _voiceSavedMessage.isNotEmpty
                      ? '$_voiceSavedMessage $_voiceTranscript'
                      : (_voiceTranscript.isNotEmpty
                          ? _voiceTranscript
                          : AppLocalizations.of(context)!.voiceTranscript),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: _voiceSavedMessage.isNotEmpty
                        ? const Color(0xFF16A34A)
                        : const Color(0xFF7F56D9),
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
              Text(
                AppLocalizations.of(context)!.emergencyAlert,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                AppLocalizations.of(context)!.sosSending,
                style: const TextStyle(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  AppLocalizations.of(context)!.sosInforming,
                  style: const TextStyle(
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
                    children: [
                      const Icon(Icons.close_rounded, color: Color(0xFFD92D20), size: 22),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.sosCancel,
                        style: const TextStyle(
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
              Text(
                AppLocalizations.of(context)!.sosSent,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF12B76A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppLocalizations.of(context)!.sosDontWorry,
                style: const TextStyle(
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
                    _buildLogItem(AppLocalizations.of(context)!.sosSmsSent),
                    const SizedBox(height: 10),
                    _buildLogItem(AppLocalizations.of(context)!.sosCallingDoctor),
                    const SizedBox(height: 10),
                    _buildLogItem(AppLocalizations.of(context)!.sosLocationShared),
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
                  child: Text(
                    AppLocalizations.of(context)!.sosClose,
                    style: const TextStyle(
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
