import 'package:flutter/material.dart';
import 'package:meditrack/l10n/app_localizations.dart';

class FamilyScreen extends StatefulWidget {
  const FamilyScreen({super.key});

  @override
  State<FamilyScreen> createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen> {
  final List<_FamilyMember> _members = [
    _FamilyMember(
      name: 'सुनीता देवी',
      relation: 'पत्नी',
      age: '62 वर्ष',
      bloodGroup: 'B+',
      emoji: '👩',
      color: Color(0xFFF43F5E),
      medicines: ['बीपी की दवा', 'थायरॉइड'],
    ),
    _FamilyMember(
      name: 'अमित शर्मा',
      relation: 'बेटा',
      age: '35 वर्ष',
      bloodGroup: 'O+',
      emoji: '👨',
      color: Color(0xFF2E82FF),
      medicines: [],
    ),
    _FamilyMember(
      name: 'प्रिया शर्मा',
      relation: 'बहू',
      age: '30 वर्ष',
      bloodGroup: 'A+',
      emoji: '👩‍🦰',
      color: Color(0xFF12B76A),
      medicines: [],
    ),
    _FamilyMember(
      name: 'आरव शर्मा',
      relation: 'पोता',
      age: '5 वर्ष',
      bloodGroup: 'O+',
      emoji: '👦',
      color: Color(0xFFF59E0B),
      medicines: ['विटामिन D3'],
    ),
  ];

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
          AppLocalizations.of(context)!.quickFamily.replaceAll('\n', ' '),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_rounded, color: Color(0xFF7F56D9)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('परिवार का सदस्य जोड़ें'),
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
      body: Column(
        children: [
          // Hero card
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Container(
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
                    child: const Icon(Icons.people_alt_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.quickFamily.replaceAll('\n', ' '),
                          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_members.length} सदस्य • सभी स्वस्थ',
                          style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('+ जोड़ें', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Members header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  width: 4, height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7F56D9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'परिवार के सदस्य',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                ),
                const Spacer(),
                Text('${_members.length} सदस्य', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF667085))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Members list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _members.length,
              itemBuilder: (_, i) => _buildMemberCard(_members[i], i == 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(_FamilyMember member, bool isSelf) {
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
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: member.color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(member.emoji, style: const TextStyle(fontSize: 28)),
                  ),
                ),
                if (isSelf)
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 18, height: 18,
                      decoration: const BoxDecoration(
                        color: Color(0xFF7F56D9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.star_rounded, color: Colors.white, size: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        member.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1D2939)),
                      ),
                      if (isSelf) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3E8FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('आप', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF7F56D9))),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${member.relation} • ${member.age}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF667085)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${AppLocalizations.of(context)!.bloodGroup} ${member.bloodGroup}',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF475467)),
                        ),
                      ),
                      if (member.medicines.isNotEmpty) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF3E8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '💊 ${member.medicines.length} दवाएँ',
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFF97316)),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFF9F5FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.chevron_right_rounded, color: Color(0xFF7F56D9), size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyMember {
  final String name;
  final String relation;
  final String age;
  final String bloodGroup;
  final String emoji;
  final Color color;
  final List<String> medicines;

  const _FamilyMember({
    required this.name,
    required this.relation,
    required this.age,
    required this.bloodGroup,
    required this.emoji,
    required this.color,
    required this.medicines,
  });
}
