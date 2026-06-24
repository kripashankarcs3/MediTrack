import 'package:flutter/material.dart';
import 'package:meditrack/l10n/app_localizations.dart';

enum VitalType {
  bloodPressure,
  bloodSugar,
  oxygen,
  temperature,
}

class VitalDetailScreen extends StatefulWidget {
  final VitalType vitalType;

  const VitalDetailScreen({super.key, required this.vitalType});

  @override
  State<VitalDetailScreen> createState() => _VitalDetailScreenState();
}

class _VitalDetailScreenState extends State<VitalDetailScreen> {
  final String _selectedDate = 'आज';

  late final String _title;
  late final String _unit;
  late final Color _accentColor;
  late final IconData _icon;
  late List<_Reading> _readings;
  @override
  void initState() {
    super.initState();
    _initVitalData();
  }

  void _initVitalData() {
    switch (widget.vitalType) {
      case VitalType.bloodPressure:
        _title = 'ब्लड प्रेशर';
        _unit = 'mmHg';
        _accentColor = const Color(0xFFF43F5E);
        _icon = Icons.favorite_rounded;
        _readings = [
          _Reading('08:00 AM', '120/80', 'सामान्य', true),
          _Reading('10:30 AM', '122/82', 'सामान्य', true),
          _Reading('01:30 PM', '125/85', 'सामान्य', true),
          _Reading('04:00 PM', '118/78', 'सामान्य', true),
          _Reading('08:00 PM', '121/80', 'सामान्य', true),
        ];
      case VitalType.bloodSugar:
        _title = 'शुगर (रक्त शर्करा)';
        _unit = 'mg/dL';
        _accentColor = const Color(0xFFEC4899);
        _icon = Icons.water_drop_rounded;
        _readings = [
          _Reading('08:00 AM', '98', 'सामान्य (उपवास)', true),
          _Reading('10:30 AM', '110', 'सामान्य', true),
          _Reading('01:30 PM', '105', 'सामान्य (भोजनोपरांत)', true),
          _Reading('05:00 PM', '95', 'सामान्य', true),
          _Reading('08:00 PM', '108', 'सामान्य', true),
        ];
      case VitalType.oxygen:
        _title = 'ऑक्सीजन (SpO₂)';
        _unit = '%';
        _accentColor = const Color(0xFF8B5CF6);
        _icon = Icons.circle;
        _readings = [
          _Reading('08:00 AM', '98%', 'सामान्य', true),
          _Reading('10:30 AM', '97%', 'सामान्य', true),
          _Reading('01:30 PM', '99%', 'सामान्य', true),
          _Reading('04:00 PM', '98%', 'सामान्य', true),
          _Reading('08:00 PM', '97%', 'सामान्य', true),
        ];
      case VitalType.temperature:
        _title = 'तापमान';
        _unit = '°F';
        _accentColor = const Color(0xFFF97316);
        _icon = Icons.thermostat_rounded;
        _readings = [
          _Reading('08:00 AM', '98.4°F', 'सामान्य', true),
          _Reading('10:30 AM', '98.6°F', 'सामान्य', true),
          _Reading('01:30 PM', '98.5°F', 'सामान्य', true),
          _Reading('04:00 PM', '98.2°F', 'सामान्य', true),
          _Reading('08:00 PM', '98.6°F', 'सामान्य', true),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1D2939), size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1D2939),
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today_rounded, size: 14, color: Color(0xFF475467)),
                const SizedBox(width: 6),
                Text(
                  _selectedDate,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475467),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Latest Temperature Hero Card
            _buildCurrentReadingCard(),
            const SizedBox(height: 20),
            // 2. Today's Trend Graph
            _buildTrendGraph(),
            const SizedBox(height: 20),
            // 3. Today's Summary Card
            _buildSummaryCard(),
            const SizedBox(height: 20),
            // 4. Today's Readings Timeline
            _buildReadingsSection(),
            const SizedBox(height: 24),
            // 5. Add New Reading Button
            _buildInlineAddButton(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentReadingCard() {
    final latest = _readings.first;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_accentColor, _accentColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background subtle illustration
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.thermostat_rounded,
                size: 140,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Icon(
                Icons.medical_services_rounded,
                size: 60,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_icon, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        AppLocalizations.of(context)!.todayLatest,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    latest.value,
                    style: const TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.takenAt(_unit, latest.time),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.75),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          latest.status,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
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

  Widget _buildSummaryCard() {
    final latest = _readings.first;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _accentColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: _accentColor.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assignment_rounded, size: 18, color: _accentColor),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.todaySummary,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1D2939),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _buildSummaryRow(Icons.check_circle_outline, AppLocalizations.of(context)!.checkedCount('${_readings.length}')),
            const SizedBox(height: 10),
            _buildSummaryRow(Icons.schedule_rounded, AppLocalizations.of(context)!.latestReading(latest.time)),
            const SizedBox(height: 10),
            _buildSummaryRow(Icons.emoji_emotions_outlined, AppLocalizations.of(context)!.overallStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: _accentColor.withValues(alpha: 0.7)),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475467),
          ),
        ),
      ],
    );
  }

  Widget _buildReadingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: _accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.todayReadings,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D2939),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ..._readings.asMap().entries.map((entry) {
          final index = entry.key;
          final reading = entry.value;
          final isLast = index == _readings.length - 1;
          return _buildReadingTimelineItem(reading, isLast: isLast);
        }),
      ],
    );
  }

  Widget _buildReadingTimelineItem(_Reading reading, {required bool isLast}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line and dot
            SizedBox(
              width: 20,
              child: Column(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: _accentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 1.5,
                        color: _accentColor.withValues(alpha: 0.15),
                      ),
                    ),
                ],
              ),
            ),
            // Reading card
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: isLast ? 0 : 6),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.schedule_rounded, size: 13, color: _accentColor.withValues(alpha: 0.6)),
                              const SizedBox(width: 4),
                              Text(
                                reading.time,
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _accentColor.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            reading.value,
                            style: const TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1D2939),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              reading.status,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF16A34A),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_rounded, color: Color(0xFF16A34A), size: 18),
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

  Widget _buildTrendGraph() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: _accentColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.todayTrend(_title),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1D2939),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 240,
            padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
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
            child: CustomPaint(
              size: Size.infinite,
              painter: _TrendLinePainter(
                readings: _readings,
                color: _accentColor,
                unit: _unit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInlineAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: _accentColor.withValues(alpha: 0.25),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: _showAddReadingDialog,
            icon: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
            label: Text(
              AppLocalizations.of(context)!.addReading(_title),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: _accentColor,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddReadingDialog() {
    final valueController = TextEditingController();
    final noteController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.newReading(_title),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1D2939),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: valueController,
              keyboardType: widget.vitalType == VitalType.bloodPressure ? TextInputType.text : TextInputType.number,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.valueIn(_unit),
                hintText: AppLocalizations.of(context)!.egValue(_getExampleValue()),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: _accentColor, width: 2),
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _accentColor,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded, size: 16, color: Color(0xFF475467)),
                const SizedBox(width: 8),
                Text(
                  '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')} • ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475467),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: noteController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.noteOptional,
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(color: Color(0xFF98A2B3)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  if (valueController.text.trim().isNotEmpty) {
                    final now = TimeOfDay.now();
                    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
                    final minute = now.minute.toString().padLeft(2, '0');
                    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
                    final timeStr = '${hour.toString().padLeft(2, '0')}:$minute $period';

                    setState(() {
                      _readings.insert(0, _Reading(
                        timeStr,
                        valueController.text.trim(),
                        'सामान्य',
                        true,
                      ));
                    });
                  }
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.readingSaved(_title),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: _accentColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  AppLocalizations.of(context)!.saveReading,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getExampleValue() {
    switch (widget.vitalType) {
      case VitalType.bloodPressure: return '120/80';
      case VitalType.bloodSugar: return '100';
      case VitalType.oxygen: return '98';
      case VitalType.temperature: return '98.6';
    }
  }
}

class _Reading {
  final String time;
  final String value;
  final String status;
  final bool isNormal;

  const _Reading(this.time, this.value, this.status, this.isNormal);
}

class _TrendLinePainter extends CustomPainter {
  final List<_Reading> readings;
  final Color color;
  final String unit;

  _TrendLinePainter({required this.readings, required this.color, this.unit = ''});

  @override
  void paint(Canvas canvas, Size size) {
    if (readings.isEmpty) return;
    final values = readings.map((r) => _parseValue(r.value)).toList();
    if (values.isEmpty) return;

    final dataMin = values.reduce((a, b) => a < b ? a : b);
    final dataMax = values.reduce((a, b) => a > b ? a : b);
    final dataRange = dataMax - dataMin;
    final buffer = dataRange < 1 ? 1.0 : dataRange * 0.5;
    final minVal = dataMin - buffer;
    final maxVal = dataMax + buffer;
    final range = maxVal - minVal;

    final paddingL = 40.0;
    final paddingR = 12.0;
    final paddingT = 16.0;
    final paddingB = 28.0;
    final chartW = size.width - paddingL - paddingR;
    final chartH = size.height - paddingT - paddingB;

    // Grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1;
    for (int i = 0; i <= 4; i++) {
      final y = paddingT + (chartH / 4) * i;
      canvas.drawLine(Offset(paddingL, y), Offset(size.width - paddingR, y), gridPaint);
    }

    // Y-axis labels
    final labelStyle = TextStyle(
      color: const Color(0xFF98A2B3),
      fontSize: 11,
      fontWeight: FontWeight.w600,
      fontFamily: 'Outfit',
    );
    for (int i = 0; i <= 4; i++) {
      final y = paddingT + (chartH / 4) * i;
      final val = maxVal - (range / 4) * i;
      final tp = TextPainter(
        text: TextSpan(
          text: '${val.toStringAsFixed(1)} $unit',
          style: labelStyle,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(paddingL - tp.width - 6, y - tp.height / 2));
    }

    // X-axis labels
    final xLabelStyle = TextStyle(
      color: const Color(0xFF98A2B3),
      fontSize: 11,
      fontWeight: FontWeight.w600,
      fontFamily: 'Outfit',
    );
    for (int i = 0; i < readings.length; i++) {
      final x = paddingL + (chartW / (readings.length - 1)) * i;
      final tp = TextPainter(
        text: TextSpan(text: readings[i].time, style: xLabelStyle),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      )..layout(maxWidth: 56);
      tp.paint(canvas, Offset(x - tp.width / 2, size.height - paddingB + 6));
    }

    // Gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withValues(alpha: 0.3), color.withValues(alpha: 0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Data line
    final linePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final fillPath = Path();

    // Compute min/max indices for highlighting
    final minIdx = values.indexOf(dataMin);
    final maxIdx = values.indexOf(dataMax);
    final hlIndices = {0, values.length - 1, minIdx, maxIdx};

    for (int i = 0; i < values.length; i++) {
      final x = paddingL + (chartW / (values.length - 1)) * i;
      final y = paddingT + chartH - ((values[i] - minVal) / range) * chartH;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, paddingT + chartH);
        fillPath.lineTo(x, y);
      } else {
        final prevX = paddingL + (chartW / (values.length - 1)) * (i - 1);
        final prevY = paddingT + chartH - ((values[i - 1] - minVal) / range) * chartH;
        final ctrlX = (prevX + x) / 2;
        path.cubicTo(ctrlX, prevY, ctrlX, y, x, y);
        fillPath.cubicTo(ctrlX, prevY, ctrlX, y, x, y);
      }

      if (i == values.length - 1) {
        fillPath.lineTo(x, paddingT + chartH);
        fillPath.close();
      }

      // Base dot
      canvas.drawCircle(
        Offset(x, y),
        3.5,
        Paint()..color = Colors.white,
      );
      canvas.drawCircle(
        Offset(x, y),
        2.5,
        Paint()..color = color,
      );

      // Highlighted points (first, last, min, max)
      if (hlIndices.contains(i)) {
        // Glow ring
        canvas.drawCircle(
          Offset(x, y),
          10,
          Paint()
            ..color = color.withValues(alpha: 0.12)
            ..style = PaintingStyle.fill,
        );
        // White inner
        canvas.drawCircle(
          Offset(x, y),
          6,
          Paint()..color = Colors.white,
        );
        // Color dot
        canvas.drawCircle(
          Offset(x, y),
          4.5,
          Paint()..color = color,
        );
        // Value label
        final hlStyle = TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFamily: 'Outfit',
        );
        final valStr = values[i].toStringAsFixed(1);
        final hlTp = TextPainter(
          text: TextSpan(text: '$valStr $unit', style: hlStyle),
          textDirection: TextDirection.ltr,
        )..layout();
        hlTp.paint(canvas, Offset(x - hlTp.width / 2, y - 20));
      }
    }

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);
  }

  double _parseValue(String v) {
    if (v.contains('/')) {
      final systolic = v.split('/').first.trim();
      return double.tryParse(systolic.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
    }
    final cleaned = v.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }

  @override
  bool shouldRepaint(covariant _TrendLinePainter oldDelegate) {
    return oldDelegate.readings != readings ||
        oldDelegate.color != color ||
        oldDelegate.unit != unit;
  }
}
