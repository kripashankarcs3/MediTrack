import 'package:flutter/material.dart';
import 'package:meditrack/l10n/app_localizations.dart';

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({super.key});

  @override
  State<HealthTipsScreen> createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  final List<_TipCategory> _categories = [
    _TipCategory(
      name: 'डायबिटीज',
      icon: Icons.bloodtype_rounded,
      color: Color(0xFF3B82F6),
      tips: [
        _HealthTip('नियमित जांच', 'हर 3 महीने में HbA1c जांच कराएं', '📊', false),
        _HealthTip('डाइट', 'मीठे से परहेज करें और फाइबर लें', '🥗', true),
        _HealthTip('व्यायाम', 'रोज 30 मिनट टहलें', '🚶', false),
      ],
    ),
    _TipCategory(
      name: 'हृदय स्वास्थ्य',
      icon: Icons.favorite_rounded,
      color: Color(0xFFF43F5E),
      tips: [
        _HealthTip('बीपी नियंत्रण', 'नमक कम खाएं, बीपी नियमित जांचें', '❤️', false),
        _HealthTip('कोलेस्ट्रॉल', 'तेल-घी कम लें, हरी सब्जी खाएं', '🥬', true),
        _HealthTip('तनाव मुक्त', 'ध्यान और योग करें, तनाव कम लें', '🧘', false),
      ],
    ),
    _TipCategory(
      name: 'पोषण',
      icon: Icons.restaurant_rounded,
      color: Color(0xFFF59E0B),
      tips: [
        _HealthTip('संतुलित आहार', 'प्रोटीन, विटामिन और मिनरल्स लें', '🍎', false),
        _HealthTip('पानी पिएं', 'दिन में 8-10 गिलास पानी पिएं', '💧', true),
        _HealthTip('समय पर खाएं', 'नाश्ता, दोपहर और रात का भोजन समय पर करें', '⏰', false),
      ],
    ),
    _TipCategory(
      name: 'दवा प्रबंधन',
      icon: Icons.medication_rounded,
      color: Color(0xFF7F56D9),
      tips: [
        _HealthTip('समय पर दवा', 'दवा समय पर लें, अलार्म लगाएं', '💊', false),
        _HealthTip('डॉक्टर से सलाह', 'बिना डॉक्टर की सलाह दवा न बदलें', '👨‍⚕️', true),
        _HealthTip('दवा सूची', 'सभी दवाओं की सूची अपने पास रखें', '📋', false),
      ],
    ),
  ];

  int _expandedCategory = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1D2939), size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context)!.quickTips.replaceAll('\n', ' '),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _categories.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) return _buildHeroSection();
          final cat = _categories[index - 1];
          final isExpanded = _expandedCategory == index - 1;
          return _buildCategoryCard(cat, isExpanded, index - 1);
        },
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7F56D9), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7F56D9).withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lightbulb_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'स्वस्थ रहने के टिप्स',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_categories.length} श्रेणियाँ • ${_categories.fold(0, (sum, c) => sum + c.tips.length)} टिप्स',
                  style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(_TipCategory cat, bool isExpanded, int catIndex) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedCategory = isExpanded ? -1 : catIndex;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: cat.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(cat.icon, color: cat.color, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${cat.tips.length} टिप्स',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF667085)),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(Icons.keyboard_arrow_down_rounded, color: cat.color, size: 24),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                const Divider(color: Color(0xFFF1F5F9), height: 1),
                ...cat.tips.map((tip) => _buildTipTile(tip)),
              ],
            ),
            crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildTipTile(_HealthTip tip) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(tip.emoji, style: const TextStyle(fontSize: 18))),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                ),
                const SizedBox(height: 2),
                Text(
                  tip.desc,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF667085)),
                ),
              ],
            ),
          ),
          if (tip.isFavorite)
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E8),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.bookmark_rounded, color: Color(0xFFF59E0B), size: 14),
            ),
        ],
      ),
    );
  }
}

class _TipCategory {
  final String name;
  final IconData icon;
  final Color color;
  final List<_HealthTip> tips;

  const _TipCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.tips,
  });
}

class _HealthTip {
  final String title;
  final String desc;
  final String emoji;
  final bool isFavorite;

  const _HealthTip(this.title, this.desc, this.emoji, this.isFavorite);
}
