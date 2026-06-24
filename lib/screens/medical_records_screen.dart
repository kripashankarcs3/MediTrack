import 'package:flutter/material.dart';
import 'package:meditrack/l10n/app_localizations.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  String _selectedFilter = 'all';

  final List<_Record> _records = [
    _Record(
      title: 'स्वास्थ्य जांच रिपोर्ट',
      doctor: 'डॉ. आर. के. गुप्ता',
      date: '20 जून 2026',
      type: 'ब्लड टेस्ट',
      icon: Icons.science_rounded,
      color: Color(0xFF7F56D9),
      summary: 'BP 120/80, शुगर 98 mg/dL, कोलेस्ट्रॉल सामान्य',
    ),
    _Record(
      title: 'हृदय जांच रिपोर्ट',
      doctor: 'डॉ. राजत शर्मा',
      date: '15 मई 2026',
      type: 'ईसीजी',
      icon: Icons.favorite_rounded,
      color: Color(0xFFF43F5E),
      summary: 'ईसीजी सामान्य, हृदय गति 72 bpm',
    ),
    _Record(
      title: 'डायबिटीज जांच',
      doctor: 'डॉ. नेहा वर्मा',
      date: '10 मई 2026',
      type: 'HbA1c',
      icon: Icons.bloodtype_rounded,
      color: Color(0xFF3B82F6),
      summary: 'HbA1c 6.2% - सामान्य सीमा में',
    ),
    _Record(
      title: 'एक्स-रे रिपोर्ट',
      doctor: 'डॉ. अमित पटेल',
      date: '2 अप्रैल 2026',
      type: 'एक्स-रे',
      icon: Icons.visibility_rounded,
      color: Color(0xFF12B76A),
      summary: 'छाती का एक्स-रे सामान्य, कोई असामान्यता नहीं',
    ),
    _Record(
      title: 'वार्षिक स्वास्थ्य जांच',
      doctor: 'डॉ. आर. के. गुप्ता',
      date: '15 मार्च 2026',
      type: 'फुल बॉडी चेकअप',
      icon: Icons.assignment_rounded,
      color: Color(0xFFF59E0B),
      summary: 'सभी पैरामीटर सामान्य, विटामिन D3 थोड़ा कम',
    ),
  ];

  List<_Record> get _filteredRecords {
    if (_selectedFilter == 'reports') {
      return _records.where((r) => r.type == 'ब्लड टेस्ट' || r.type == 'फुल बॉडी चेकअप' || r.type == 'HbA1c').toList();
    } else if (_selectedFilter == 'scans') {
      return _records.where((r) => r.type == 'ईसीजी' || r.type == 'एक्स-रे').toList();
    }
    return _records;
  }

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
          AppLocalizations.of(context)!.quickRecords.replaceAll('\n', ' '),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Summary cards
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                _buildSummaryCard(Icons.description_rounded, '${_records.length}', AppLocalizations.of(context)!.all, const Color(0xFF7F56D9)),
                const SizedBox(width: 12),
                _buildSummaryCard(Icons.calendar_today_rounded, '2026', 'यह वर्ष', const Color(0xFF12B76A)),
              ],
            ),
          ),
          // Filter tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildFilterTabs(),
          ),
          const SizedBox(height: 16),
          // Records list
          Expanded(
            child: _filteredRecords.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.folder_open_rounded, size: 56, color: Color(0xFFCBD5E1)),
                        const SizedBox(height: 12),
                        Text(
                          AppLocalizations.of(context)!.noRecords,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF475467)),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredRecords.length,
                    itemBuilder: (_, i) => _buildRecordCard(_filteredRecords[i]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontFamily: 'Outfit', fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF667085))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildFilterTab('all', AppLocalizations.of(context)!.filterAll),
          _buildFilterTab('reports', AppLocalizations.of(context)!.filterReports),
          _buildFilterTab('scans', AppLocalizations.of(context)!.filterScans),
        ],
      ),
    );
  }

  Widget _buildFilterTab(String filter, String label) {
    bool isActive = _selectedFilter == filter;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _selectedFilter = filter),
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 2))]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isActive ? const Color(0xFF7F56D9) : const Color(0xFF475467),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordCard(_Record record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
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
      child: InkWell(
        onTap: () => _showRecordDetail(record),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: record.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(record.icon, color: record.color, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.title,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${record.doctor} • ${record.date}',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF667085)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: record.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    record.type,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: record.color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  const Icon(Icons.summarize_rounded, size: 14, color: Color(0xFF475467)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      record.summary,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF475467)),
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF98A2B3)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRecordDetail(_Record record) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 48, height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 52, height: 52,
                  decoration: BoxDecoration(
                    color: record.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(record.icon, color: record.color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(record.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939))),
                      const SizedBox(height: 4),
                      Text('${record.doctor} • ${record.date}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF667085))),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.download_rounded, color: Color(0xFF7F56D9)),
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('रिपोर्ट डाउनलोड हो रही है...'),
                        backgroundColor: const Color(0xFF7F56D9),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('रिपोर्ट सारांश', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF475467))),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                record.summary,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1D2939), height: 1.5),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7F56D9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('बंद करें', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Record {
  final String title;
  final String doctor;
  final String date;
  final String type;
  final IconData icon;
  final Color color;
  final String summary;

  const _Record({
    required this.title,
    required this.doctor,
    required this.date,
    required this.type,
    required this.icon,
    required this.color,
    required this.summary,
  });
}
