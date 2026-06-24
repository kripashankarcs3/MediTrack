import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  const ProfileScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'मेरा प्रोफाइल',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
            ),
            Text(
              'My Profile',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: const Color(0xFF667085)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF475467)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('सेटिंग्स जल्द आ रही हैं'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Profile Home Header (Ref: Screen 1)
            _buildProfileHeader(context),
            const SizedBox(height: 20),
            
            // Stats Row
            Row(
              children: [
                _buildStatItem('❤️', 'स्वास्थ्य स्कोर', 'Health Score', '85/100'),
                const SizedBox(width: 12),
                _buildStatItem('🗓️', 'अकाउंट उम्र', 'Member Since', 'Jan 2024'),
                const SizedBox(width: 12),
                _buildStatItem('👥', 'परिवार सदस्य', 'Family Members', '2'),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text(
              'मेरे विकल्प',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
            ),
            const Text(
              'My Options',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF667085)),
            ),
            const SizedBox(height: 16),
            
            // Options List
            _buildOptionItem(context, Icons.person_outline_rounded, 'व्यक्तिगत जानकारी', 'Personal Information', const Color(0xFF7F56D9), onTap: () => _navigateTo(context, const PersonalInfoSubScreen())),
            _buildOptionItem(context, Icons.favorite_outline_rounded, 'स्वास्थ्य जानकारी', 'Health Information', const Color(0xFFF43F5E), onTap: () => _navigateTo(context, const HealthInfoSubScreen())),
            _buildOptionItem(context, Icons.people_outline_rounded, 'आपातकालीन संपर्क', 'Emergency Contacts', const Color(0xFF2E90FA), onTap: () => _navigateTo(context, const EmergencyContactsSubScreen())),
            _buildOptionItem(context, Icons.language_rounded, 'भाषा और प्रदर्शन', 'Language & Display', const Color(0xFFF79009), onTap: () => _navigateTo(context, LanguageDisplaySubScreen(currentLocale: widget.currentLocale, onLocaleChanged: widget.onLocaleChanged))),
            _buildOptionItem(context, Icons.notifications_none_rounded, 'नोटिफिकेशन सेटिंग', 'Notification Settings', const Color(0xFF667085), onTap: () => _navigateTo(context, const NotificationSettingsSubScreen())),
            _buildOptionItem(context, Icons.shield_outlined, 'गोपनीयता और सुरक्षा', 'Privacy & Security', const Color(0xFF12B76A), onTap: () => _navigateTo(context, const PrivacySecuritySubScreen())),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  Widget _buildProfileHeader(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateTo(context, const EditProfileSubScreen()),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7F56D9), Color(0xFF6366F1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: const Color(0xFF7F56D9).withValues(alpha: 0.25), blurRadius: 20, offset: const Offset(0, 8)),
          ],
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/images/avatar.png')),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color(0xFF12B76A), shape: BoxShape.circle),
                  child: const Icon(Icons.check, color: Colors.white, size: 12),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('रमेश जी शर्मा', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                  const Text('Ramesh Ji Sharma', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(20)),
                        child: const Text('ID: MT-2024-5687', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 8),
                      const Text('Primary Account', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700, decoration: TextDecoration.underline)),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.qr_code_2_rounded, color: Colors.white70, size: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String emoji, String titleHi, String titleEn, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text(titleHi, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475467)), textAlign: TextAlign.center),
            Text(titleEn, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: Color(0xFF98A2B3)), textAlign: TextAlign.center),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context, IconData icon, String titleHi, String titleEn, Color color, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(titleHi, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1D2939))),
                    Text(titleEn, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF667085))),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Color(0xFF98A2B3), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// --- SUB SCREENS ---

// 2. Personal Information Screen
class PersonalInfoSubScreen extends StatelessWidget {
  const PersonalInfoSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildSubAppBar('व्यक्तिगत जानकारी', 'Personal Information', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInfoTile(Icons.person_outline, 'पूरा नाम', 'Full Name', 'रमेश जी शर्मा', 'Ramesh Ji Sharma'),
            _buildInfoTile(Icons.calendar_today_outlined, 'जन्म तिथि', 'Date of Birth', '15 मार्च 1958', '15 Mar 1958'),
            _buildInfoTile(Icons.transgender_rounded, 'लिंग', 'Gender', 'पुरुष', 'Male'),
            _buildInfoTile(Icons.phone_outlined, 'मोबाइल नंबर', 'Mobile Number', '+91 98765 43210', ''),
            _buildInfoTile(Icons.email_outlined, 'ईमेल आईडी', 'Email ID', 'ramesh.sharma@gmail.com', ''),
            _buildInfoTile(Icons.location_on_outlined, 'पता', 'Address', '25, शांति नगर, जयपुर, राजस्थान - 302001', '25, Shanti Nagar, Jaipur...'),
            _buildInfoTile(Icons.bloodtype_outlined, 'रक्त समूह', 'Blood Group', 'B+', ''),
            const SizedBox(height: 24),
            _buildMainButton('संपादित करें (Edit Information)', () {}),
          ],
        ),
      ),
    );
  }
}

// 3. Health Information Screen
class HealthInfoSubScreen extends StatelessWidget {
  const HealthInfoSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildSubAppBar('स्वास्थ्य जानकारी', 'Health Information', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('प्राथमिक स्वास्थ्य स्थितियाँ', 'Primary Conditions'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12, runSpacing: 12,
              children: [
                _buildConditionChip('हाइपरटेंशन', 'Hypertension', Colors.red, Icons.favorite),
                _buildConditionChip('डायबिटीज टाइप 2', 'Diabetes Type 2', Colors.blue, Icons.water_drop),
                _buildConditionChip('अर्थराइटिस', 'Arthritis', Colors.purple, Icons.accessibility_new),
                _buildAddChip('नई स्थिति जोड़ें', 'Add New Condition'),
              ],
            ),
            const SizedBox(height: 30),
            _buildSectionHeader('एलर्जी', 'Allergies'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12, runSpacing: 12,
              children: [
                _buildAllergyChip('धूल से एलर्जी', 'Dust Allergy', Colors.green),
                _buildAllergyChip('पेनिसिलिन', 'Penicillin', Colors.orange),
                _buildAddChip('नई एलर्जी जोड़ें', 'Add New Allergy'),
              ],
            ),
            const SizedBox(height: 30),
            _buildSectionHeader('नियमित दवाएं', 'Regular Medicines'),
            const SizedBox(height: 12),
            _buildMedInfoTile('Amlodipine 5mg', 'सुबह - 1 गोली'),
            _buildMedInfoTile('Metformin 500mg', 'सुबह और शाम - 1 गोली'),
          ],
        ),
      ),
    );
  }
}

// 4. Emergency Contacts Screen
class EmergencyContactsSubScreen extends StatelessWidget {
  const EmergencyContactsSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildSubAppBar('आपातकालीन संपर्क', 'Emergency Contacts', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  Icon(Icons.verified_user_rounded, color: Color(0xFF6366F1)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'आपातकालीन स्थिति में हम इन संपर्कों को सूचित करेंगे।\nWe will notify these contacts in emergency situations.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF475467), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _buildContactTile('सीता शर्मा (पत्नी)', 'Seeta Sharma (Wife)', '+91 98765 12345', 'Primary', 'assets/images/avatar.png'),
            _buildContactTile('अमित शर्मा (पुत्र)', 'Amit Sharma (Son)', '+91 87654 32109', 'Secondary', 'assets/images/avatar.png'),
            _buildContactTile('नेहा शर्मा (पुत्री)', 'Neha Sharma (Daughter)', '+91 76543 21098', 'Secondary', 'assets/images/avatar.png'),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('नया संपर्क जोड़ने की सुविधा जल्द आ रही है'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('नया संपर्क जोड़ें (Add New Contact)'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: const BorderSide(color: Color(0xFF7F56D9)),
                foregroundColor: const Color(0xFF7F56D9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 5. Language & Display Screen
class LanguageDisplaySubScreen extends StatefulWidget {
  final Locale currentLocale;
  final ValueChanged<Locale> onLocaleChanged;

  const LanguageDisplaySubScreen({
    super.key,
    required this.currentLocale,
    required this.onLocaleChanged,
  });

  @override
  State<LanguageDisplaySubScreen> createState() => _LanguageDisplaySubScreenState();
}

class _LanguageDisplaySubScreenState extends State<LanguageDisplaySubScreen> {
  String _selectedSize = 'Medium';
  bool _darkMode = false;
  bool _highContrast = false;

  Future<void> _changeLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', languageCode);
    widget.onLocaleChanged(Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    bool isHindi = widget.currentLocale.languageCode == 'hi';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildSubAppBar('भाषा और प्रदर्शन', 'Language & Display', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('भाषा चुनें', 'Choose Language'),
            const SizedBox(height: 12),
            _buildRadioOption('English', !isHindi, () => _changeLocale('en')),
            _buildRadioOption('हिन्दी (Hindi)', isHindi, () => _changeLocale('hi')),
            
            const SizedBox(height: 30),
            _buildSectionHeader('टेक्स्ट आकार', 'Text Size'),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildSizeOption('A छोटा', 'Small', _selectedSize == 'Small'),
                const SizedBox(width: 10),
                _buildSizeOption('A मध्यम', 'Medium', _selectedSize == 'Medium'),
                const SizedBox(width: 10),
                _buildSizeOption('A बड़ा', 'Large', _selectedSize == 'Large'),
              ],
            ),
            
            const SizedBox(height: 30),
            _buildSwitchTile(Icons.dark_mode_outlined, 'डार्क मोड', 'Dark Mode', _darkMode, (v) => setState(() => _darkMode = v)),
            _buildSwitchTile(Icons.contrast_rounded, 'हाई कंट्रास्ट मोड', 'High Contrast Mode', _highContrast, (v) => setState(() => _highContrast = v)),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeOption(String hi, String en, bool isSelected) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSize = en),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEEF2FF) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? const Color(0xFF7F56D9) : const Color(0xFFF1F5F9)),
          ),
          child: Column(
            children: [
              Text(hi, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isSelected ? const Color(0xFF7F56D9) : const Color(0xFF475467))),
              Text(en, style: TextStyle(fontSize: 10, color: isSelected ? const Color(0xFF7F56D9) : const Color(0xFF98A2B3))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioOption(String text, bool isSelected, VoidCallback onChange) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? const Color(0xFF7F56D9) : const Color(0xFFF1F5F9))),
      child: InkWell(
        onTap: onChange,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(text, style: TextStyle(fontSize: 15, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
              ),
              Container(
                width: 20, height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: isSelected ? const Color(0xFF7F56D9) : const Color(0xFF98A2B3), width: 2),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10, height: 10,
                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF7F56D9)),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 6. Notification Settings Screen
class NotificationSettingsSubScreen extends StatefulWidget {
  const NotificationSettingsSubScreen({super.key});

  @override
  State<NotificationSettingsSubScreen> createState() => _NotificationSettingsSubScreenState();
}

class _NotificationSettingsSubScreenState extends State<NotificationSettingsSubScreen> {
  final Map<String, bool> _settings = {
    'All': true, 'Meds': true, 'Appts': true, 'Alerts': true, 'Family': true, 'Tips': false
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildSubAppBar('नोटिफिकेशन सेटिंग', 'Notification Settings', context),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSwitchTile(Icons.notifications_active_outlined, 'सभी नोटिफिकेशन', 'All Notifications', _settings['All']!, (v) => setState(() => _settings['All'] = v)),
          const Divider(height: 32),
          _buildSwitchTile(Icons.medication_rounded, 'दवा रिमाइंडर', 'Medicine Reminders', _settings['Meds']!, (v) => setState(() => _settings['Meds'] = v)),
          _buildSwitchTile(Icons.calendar_month_rounded, 'अपॉइंटमेंट रिमाइंडर', 'Appointment Reminders', _settings['Appts']!, (v) => setState(() => _settings['Appts'] = v)),
          _buildSwitchTile(Icons.favorite_rounded, 'स्वास्थ्य अलर्ट', 'Health Alerts', _settings['Alerts']!, (v) => setState(() => _settings['Alerts'] = v)),
          _buildSwitchTile(Icons.people_alt_rounded, 'परिवार अपडेट', 'Family Updates', _settings['Family']!, (v) => setState(() => _settings['Family'] = v)),
          _buildSwitchTile(Icons.lightbulb_outline_rounded, 'प्रचार और सुझाव', 'Promotions & Tips', _settings['Tips']!, (v) => setState(() => _settings['Tips'] = v)),
        ],
      ),
    );
  }
}

// 7. Privacy & Security Screen
class PrivacySecuritySubScreen extends StatelessWidget {
  const PrivacySecuritySubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildSubAppBar('गोपनीयता और सुरक्षा', 'Privacy & Security', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildSecurityTile(Icons.lock_outline_rounded, 'पासकोड / बायोमेट्रिक लॉक', 'Passcode / Biometric Lock', 'सक्षम', Colors.green),
            _buildSecurityTile(Icons.password_rounded, 'पासकोड बदलें', 'Change Passcode', '', null),
            _buildSecurityTile(Icons.security_rounded, '2-फैक्टर ऑथेंटिकेशन', 'Two-Factor Authentication', 'बंद', Colors.grey),
            _buildSecurityTile(Icons.data_usage_rounded, 'डेटा शेयरिंग प्रेफरेंस', 'Data Sharing Preference', '', null),
            _buildSecurityTile(Icons.description_outlined, 'प्राइवेसी पॉलिसी', 'Privacy Policy', '', null),
            const SizedBox(height: 40),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityTile(IconData icon, String hi, String en, String status, Color? statusColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF667085), size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hi, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                Text(en, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
              ],
            ),
          ),
          if (status.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: statusColor?.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
              child: Text(status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor)),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFF98A2B3), size: 20),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('लॉगआउट (Logout)'),
            content: const Text('क्या आप लॉगआउट करना चाहते हैं?'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('रद्द करें')),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('लॉगआउट किया गया'), behavior: SnackBarBehavior.floating),
                  );
                },
                child: const Text('लॉगआउट', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.logout_rounded, color: Color(0xFFD92D20), size: 20),
      label: const Text('लॉगआउट करें (Logout)', style: TextStyle(color: Color(0xFFD92D20), fontWeight: FontWeight.bold, fontSize: 16)),
    );
  }
}

// 8. Edit Profile Screen
class EditProfileSubScreen extends StatelessWidget {
  const EditProfileSubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildSubAppBar('प्रोफाइल संपादित करें', 'Edit Profile', context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(radius: 50, backgroundImage: AssetImage('assets/images/avatar.png')),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(color: Color(0xFF7F56D9), shape: BoxShape.circle),
                  child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildTextField('पूरा नाम', 'Full Name', 'रमेश जी शर्मा'),
            _buildTextField('मोबाइल नंबर', 'Mobile Number', '+91 98765 43210'),
            _buildTextField('ईमेल आईडी', 'Email ID', 'ramesh.sharma@gmail.com'),
            _buildTextField('पता', 'Address', '25, शांति नगर, जयपुर, राजस्थान - 302001'),
            const SizedBox(height: 40),
            _buildMainButton('सेव करें (Save Changes)', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hi, String en, String initialVal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$hi ($en)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475467))),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initialVal,
            decoration: InputDecoration(
              filled: true, fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFF1F5F9))),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFF1F5F9))),
            ),
          ),
        ],
      ),
    );
  }
}

// --- GLOBAL HELPER WIDGETS ---

PreferredSizeWidget _buildSubAppBar(String hi, String en, BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: Color(0xFF1D2939)), onPressed: () => Navigator.pop(context)),
    title: Column(
      children: [
        Text(hi, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
        Text(en, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF667085))),
      ],
    ),
    centerTitle: true,
  );
}

Widget _buildInfoTile(IconData icon, String hi, String en, String val1, String val2) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
    child: Row(
      children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFF8FAFC), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: const Color(0xFF7F56D9), size: 20)),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$hi ($en)', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF98A2B3))),
              const SizedBox(height: 4),
              Text(val1, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1D2939))),
              if (val2.isNotEmpty) Text(val2, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String hi, String en) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(hi, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
    Text(en, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
  ]);
}

Widget _buildConditionChip(String hi, String en, Color color, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withValues(alpha: 0.2))),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, color: color, size: 14),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(hi, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        Text(en, style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
      ]),
    ]),
  );
}

Widget _buildAllergyChip(String hi, String en, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFF1F5F9))),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.warning_amber_rounded, color: color, size: 16),
      const SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(hi, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        Text(en, style: const TextStyle(fontSize: 9, color: Color(0xFF667085))),
      ]),
    ]),
  );
}

Widget _buildAddChip(String hi, String en) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF7F56D9), style: BorderStyle.solid)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.add, size: 14, color: Color(0xFF7F56D9)),
      const SizedBox(width: 6),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(hi, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF7F56D9))),
        Text(en, style: const TextStyle(fontSize: 8, color: Color(0xFF7F56D9))),
      ]),
    ]),
  );
}

Widget _buildMedInfoTile(String name, String desc) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFF1F5F9))),
    child: Row(children: [
      const Icon(Icons.medication_outlined, color: Color(0xFF7F56D9)),
      const SizedBox(width: 12),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        Text(desc, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
      ]),
    ]),
  );
}

Widget _buildContactTile(String hi, String en, String phone, String tag, String img) {
  bool isPrimary = tag == 'Primary';
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFFF1F5F9))),
    child: Row(
      children: [
        CircleAvatar(radius: 24, backgroundImage: AssetImage(img)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(hi, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              Text(en, style: const TextStyle(fontSize: 11, color: Color(0xFF667085))),
              const SizedBox(height: 4),
              Text(phone, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475467))),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(color: isPrimary ? const Color(0xFFECFDF3) : const Color(0xFFF2F4F7), borderRadius: BorderRadius.circular(4)),
          child: Text(tag, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isPrimary ? const Color(0xFF027A48) : const Color(0xFF344054))),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.more_vert, size: 18, color: Color(0xFF98A2B3)),
      ],
    ),
  );
}

Widget _buildSwitchTile(IconData icon, String hi, String en, bool val, Function(bool) onChange) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFF1F5F9))),
    child: Row(
      children: [
        Icon(icon, color: const Color(0xFF667085), size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(hi, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              Text(en, style: const TextStyle(fontSize: 11, color: Color(0xFF98A2B3))),
            ],
          ),
        ),
        Switch(value: val, onChanged: onChange, activeTrackColor: const Color(0xFF7F56D9), activeThumbColor: Colors.white),
      ],
    ),
  );
}

Widget _buildMainButton(String text, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity, height: 54,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7F56D9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
    ),
  );
}
