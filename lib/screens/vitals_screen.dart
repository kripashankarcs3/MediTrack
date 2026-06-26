import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meditrack/l10n/app_localizations.dart';
import 'package:meditrack/providers/vitals_provider.dart';
import 'package:meditrack/theme/app_theme.dart';

class VitalsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const VitalsScreen({super.key, required this.onBack});

  @override
  State<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  String _selectedPeriod = 'week'; // 'day', 'week', 'month', 'year'

  Map<String, List<String>> get _labelsMap {
    final l = AppLocalizations.of(context)!;
    return {
      'day': ['08:00', '11:00', '02:00', '05:00', '08:00', '11:00'],
      'week': ['15 ${l.monthMayLabel}', '16 ${l.monthMayLabel}', '17 ${l.monthMayLabel}', '18 ${l.monthMayLabel}', '19 ${l.monthMayLabel}', '20 ${l.monthMayLabel}', '21 ${l.monthMayLabel}'],
      'month': ['1-5', '6-10', '11-15', '16-20', '21-25', '26-31'],
      'year': [l.monthJan, l.monthMar, l.monthMayLabel, l.monthJul, l.monthSep, l.monthNov],
    };
  }

  // Data sets for Custom Painters
  final Map<String, List<double>> _bpData = {
    'day': [118, 122, 120, 119, 121, 120],
    'week': [120, 118, 124, 120, 122, 119, 120],
    'month': [122, 120, 121, 119, 123, 120],
    'year': [121, 123, 120, 122, 119, 120],
  };

  final Map<String, List<double>> _sugarData = {
    'day': [96, 102, 98, 100, 97, 98],
    'week': [98, 95, 105, 96, 99, 94, 98],
    'month': [99, 96, 101, 98, 95, 98],
    'year': [98, 100, 97, 99, 96, 98],
  };

  final Map<String, List<double>> _oxygenData = {
    'day': [98, 99, 98, 98, 99, 98],
    'week': [98, 98, 99, 98, 97, 98, 98],
    'month': [97, 98, 99, 98, 98, 98],
    'year': [98, 98, 99, 97, 98, 98],
  };

  final Map<String, List<double>> _tempData = {
    'day': [98.4, 98.6, 98.5, 98.7, 98.6, 98.6],
    'week': [98.5, 98.2, 98.8, 98.4, 98.6, 98.3, 98.6],
    'month': [98.6, 98.5, 98.4, 98.7, 98.6, 98.6],
    'year': [98.5, 98.6, 98.4, 98.7, 98.6, 98.6],
  };

  @override
  Widget build(BuildContext context) {
    final c = context.appColors;
    List<String> xLabels = _labelsMap[_selectedPeriod]!;

    return Scaffold(
      backgroundColor: c.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: c.primaryText, size: 28),
          onPressed: widget.onBack,
        ),
        title: Text(
          AppLocalizations.of(context)!.vitalsTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: c.primaryText,
          ),
        ),
        actions: [
          const SizedBox(width: 8),
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Column(
          children: [
            const SizedBox(height: 12),
            
            // Segmented Period Selector
            _buildSegmentedControl(),
            
            // Voice-saved readings section
            _buildVoiceReadingsSection(),
            
            const SizedBox(height: 20),
            
            // Vital Graph Card 1: BP
            _buildGraphCard(
              title: AppLocalizations.of(context)!.bpFull,
              value: '120/80',
              unit: AppLocalizations.of(context)!.unitMmhg,
              emoji: '❤️',
              emojiBg: const Color(0xFFFFF0F2),
              lineColor: const Color(0xFFF43F5E),
              dataPoints: _bpData[_selectedPeriod]!,
              xLabels: xLabels,
              yMin: 60,
              yMax: 180,
            ),
            
            const SizedBox(height: 20),
            
            // Vital Graph Card 2: Sugar
            _buildGraphCard(
              title: AppLocalizations.of(context)!.sugarFull,
              value: '98',
              unit: AppLocalizations.of(context)!.unitMgdl,
              emoji: '🩸',
              emojiBg: const Color(0xFFEBF5FF),
              lineColor: const Color(0xFF3B82F6),
              dataPoints: _sugarData[_selectedPeriod]!,
              xLabels: xLabels,
              yMin: 70,
              yMax: 210,
            ),
            
            const SizedBox(height: 20),
            
            // Vital Graph Card 3: Oxygen SpO2
            _buildGraphCard(
              title: AppLocalizations.of(context)!.oxygenFull,
              value: '98%',
              unit: '',
              emoji: '🫁',
              emojiBg: const Color(0xFFF3E8FF),
              lineColor: const Color(0xFF8B5CF6),
              dataPoints: _oxygenData[_selectedPeriod]!,
              xLabels: xLabels,
              yMin: 90,
              yMax: 100,
            ),
            
            const SizedBox(height: 20),
            
            // Vital Graph Card 4: Temp
            _buildGraphCard(
              title: AppLocalizations.of(context)!.temperatureFull,
              value: '98.6°F',
              unit: '',
              emoji: '🌡️',
              emojiBg: const Color(0xFFFFF4E5),
              lineColor: const Color(0xFFF97316),
              dataPoints: _tempData[_selectedPeriod]!,
              xLabels: xLabels,
              yMin: 95,
              yMax: 105,
            ),
          ],
        ),
      ),
    );
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

  Widget _buildVoiceReadingsSection() {
    final vitalsProvider = context.watch<VitalsProvider>();
    final readings = vitalsProvider.readings;
    if (readings.isEmpty) return const SizedBox.shrink();

    final latest = readings.last;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF86EFAC)),
      ),
      child: Row(
        children: [
          const Icon(Icons.mic_rounded, color: Color(0xFF16A34A), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_vitalTypeLabel(latest.type)}: ${latest.value}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF166534),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${latest.date} • ${latest.time}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF22C55E),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF86EFAC).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${readings.length}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Color(0xFF166534),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Styled Segmented Tab bar
  Widget _buildSegmentedControl() {
    final c = context.appColors;
    return Container(
      decoration: BoxDecoration(
        color: c.divider,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          _buildSegmentTab('day', AppLocalizations.of(context)!.periodDay),
          _buildSegmentTab('week', AppLocalizations.of(context)!.periodWeek),
          _buildSegmentTab('month', AppLocalizations.of(context)!.periodMonth),
          _buildSegmentTab('year', AppLocalizations.of(context)!.periodYear),
        ],
      ),
    );
  }

  Widget _buildSegmentTab(String period, String label) {
    final c = context.appColors;
    bool isActive = _selectedPeriod == period;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPeriod = period;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? c.cardBg : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isActive ? const Color(0xFF7F56D9) : c.secondaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Premium Graph Card Card
  Widget _buildGraphCard({
    required String title,
    required String value,
    required String unit,
    required String emoji,
    required Color emojiBg,
    required Color lineColor,
    required List<double> dataPoints,
    required List<String> xLabels,
    required double yMin,
    required double yMax,
  }) {
    final c = context.appColors;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.border),
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
          // Header info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: emojiBg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(emoji, style: const TextStyle(fontSize: 20))),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: c.secondaryText,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              fontFamily: 'Outfit',
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: c.primaryText,
                            ),
                          ),
                          if (unit.isNotEmpty) ...[
                            const SizedBox(width: 4),
                            Text(
                              unit,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: c.secondaryText,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  AppLocalizations.of(context)!.normal,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF12B76A),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Graph Custom Paint
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(
              painter: LineChartPainter(
                dataPoints: dataPoints,
                lineColor: lineColor,
                yMin: yMin,
                yMax: yMax,
              ),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // X-Axis Labels
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: xLabels
                  .map((label) => Flexible(
                        child: Text(
                          label,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: c.secondaryText,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter to draw Bezier Curved Charts and Gradient areas
class LineChartPainter extends CustomPainter {
  final List<double> dataPoints;
  final Color lineColor;
  final double yMin;
  final double yMax;

  const LineChartPainter({
    required this.dataPoints,
    required this.lineColor,
    required this.yMin,
    required this.yMax,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (dataPoints.isEmpty) return;

    final axisPaint = Paint()
      ..color = const Color(0xFFF1F5F9)
      ..strokeWidth = 1;

    // Draw background horizontal gridlines (3 lines)
    double axisLeft = 30; // Leave space for Y axis text label
    double graphWidth = size.width - axisLeft;
    double stepY = size.height / 3;
    
    for (int i = 0; i < 4; i++) {
      double y = i * stepY;
      canvas.drawLine(Offset(axisLeft, y), Offset(size.width, y), axisPaint);
      
      // Draw grid line numeric tags
      double tagVal = yMax - ((yMax - yMin) * (i / 3));
      final textSpan = TextSpan(
        text: tagVal.toStringAsFixed(0),
        style: const TextStyle(
          fontFamily: 'Outfit',
          color: Color(0xFF98A2B3),
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(axisLeft - textPainter.width - 6, y - textPainter.height / 2));
    }

    // Map dataPoints to canvas points
    final List<Offset> points = [];
    double segmentWidth = dataPoints.length > 1 ? graphWidth / (dataPoints.length - 1) : graphWidth;

    for (int i = 0; i < dataPoints.length; i++) {
      double val = dataPoints[i];
      // Bound it inside yMin and yMax
      double normalizedY = (val - yMin) / (yMax - yMin);
      normalizedY = normalizedY.clamp(0.0, 1.0);
      
      double x = axisLeft + (i * segmentWidth);
      // In Flutter canvas, Y goes downwards, so subtract from size.height
      double y = size.height - (normalizedY * size.height);
      points.add(Offset(x, y));
    }

    // Draw bezier lines connecting the points
    final strokePath = Path();
    strokePath.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      
      // Control points for smooth bezier curvature
      final controlX1 = p0.dx + (p1.dx - p0.dx) / 2;
      final controlY1 = p0.dy;
      final controlX2 = p0.dx + (p1.dx - p0.dx) / 2;
      final controlY2 = p1.dy;
      
      strokePath.cubicTo(controlX1, controlY1, controlX2, controlY2, p1.dx, p1.dy);
    }

    // Shading/Fill area path
    final fillPath = Path.from(strokePath);
    fillPath.lineTo(points.last.dx, size.height);
    fillPath.lineTo(points.first.dx, size.height);
    fillPath.close();

    // Paint for the gradient fill
    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [lineColor.withValues(alpha: 0.3), lineColor.withValues(alpha: 0.0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(axisLeft, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Paint for the stroke path line
    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(strokePath, linePaint);

    // Draw white dots with colored borders over points
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final dotBorderPaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    for (var pt in points) {
      canvas.drawCircle(pt, 5, dotPaint);
      canvas.drawCircle(pt, 5, dotBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    return oldDelegate.dataPoints != dataPoints || oldDelegate.lineColor != lineColor;
  }
}

