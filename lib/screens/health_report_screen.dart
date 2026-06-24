import 'package:flutter/material.dart';
import 'package:meditrack/l10n/app_localizations.dart';

class HealthReportScreen extends StatelessWidget {
  const HealthReportScreen({super.key});

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
          AppLocalizations.of(context)!.quickReport.replaceAll('\n', ' '),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded, color: Color(0xFF7F56D9)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('रिपोर्ट शेयर की जा रही है...'),
                  backgroundColor: const Color(0xFF7F56D9),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Date selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 18, color: Color(0xFF7F56D9)),
                  const SizedBox(width: 10),
                  const Text(
                    'जून 2026',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1D2939)),
                  ),
                  const Spacer(),
                  const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF98A2B3)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Overall status card
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.assignment_turned_in_rounded, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'आपकी स्वास्थ्य रिपोर्ट',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'स्वस्थ',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Color(0xFF86EFAC)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'सभी महत्वपूर्ण आंकड़े सामान्य सीमा में हैं',
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.75), fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Health parameters grid
            const Text('स्वास्थ्य पैरामीटर', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
            const SizedBox(height: 12),
            _buildParamGrid(),
            const SizedBox(height: 20),
            // Recommendations
            const Text('सुझाव', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
            const SizedBox(height: 12),
            _buildRecommendationCard(
              Icons.wb_sunny_rounded,
              'विटामिन D3 थोड़ा कम',
              'धूप में बैठें और विटामिन D3 सप्लीमेंट लें',
              const Color(0xFFF59E0B),
            ),
            const SizedBox(height: 10),
            _buildRecommendationCard(
              Icons.directions_walk_rounded,
              'रोजाना व्यायाम',
              '30 मिनट टहलना या हल्का व्यायाम करें',
              const Color(0xFF12B76A),
            ),
            const SizedBox(height: 10),
            _buildRecommendationCard(
              Icons.water_drop_rounded,
              'पानी पिएं',
              'दिन में 8-10 गिलास पानी पिएं',
              const Color(0xFF2E82FF),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParamGrid() {
    final params = [
      _HealthParam('बीपी', '120/80', 'mmHg', const Color(0xFFF43F5E), Icons.favorite_rounded, true),
      _HealthParam('शुगर', '98', 'mg/dL', const Color(0xFF3B82F6), Icons.water_drop_rounded, true),
      _HealthParam('SpO₂', '98%', '', const Color(0xFF8B5CF6), Icons.circle, true),
      _HealthParam('तापमान', '98.6°F', '', const Color(0xFFF97316), Icons.thermostat_rounded, true),
      _HealthParam('कोलेस्ट्रॉल', '180', 'mg/dL', const Color(0xFFEC4899), Icons.opacity_rounded, true),
      _HealthParam('HbA1c', '6.2', '%', const Color(0xFF7F56D9), Icons.bloodtype_rounded, true),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: params.length,
      itemBuilder: (_, i) => _buildParamCard(params[i]),
    );
  }

  Widget _buildParamCard(_HealthParam param) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: param.color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(param.icon, color: param.color, size: 12),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(param.label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF475467))),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                param.value,
                style: const TextStyle(fontFamily: 'Outfit', fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
              ),
              if (param.unit.isNotEmpty)
                Text(param.unit, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Color(0xFF667085))),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE6F7ED),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('सामान्य', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: Color(0xFF12B76A))),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(IconData icon, String title, String desc, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                const SizedBox(height: 2),
                Text(desc, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF667085))),
              ],
            ),
          ),
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward_rounded, color: color, size: 16),
          ),
        ],
      ),
    );
  }
}

class _HealthParam {
  final String label;
  final String value;
  final String unit;
  final Color color;
  final IconData icon;
  final bool isNormal;

  const _HealthParam(this.label, this.value, this.unit, this.color, this.icon, this.isNormal);
}
