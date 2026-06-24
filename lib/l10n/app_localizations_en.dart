// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MediTrack';

  @override
  String get appName => 'MediTrack';

  @override
  String get navHome => 'Home';

  @override
  String get navVitals => 'Vitals';

  @override
  String get navMedicines => 'Medicines';

  @override
  String get navProfile => 'Profile';

  @override
  String get seeAll => 'See all ›';

  @override
  String get seeAllOptions => 'See all options ›';

  @override
  String get seeAllGt => 'See all >';

  @override
  String get normal => 'Normal';

  @override
  String get taken => 'Taken';

  @override
  String get pending => 'Pending';

  @override
  String get all => 'All';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get done => 'Done';

  @override
  String get add => 'Add';

  @override
  String get back => 'Back';

  @override
  String get confirm => 'Confirm';

  @override
  String get greeting => 'Hello Ramesh ji';

  @override
  String get greetingSuffix => '👋';

  @override
  String get greetingSubtitle => 'Hope you are healthy!';

  @override
  String get profile => 'Profile';

  @override
  String get healthStatus => 'Health Status';

  @override
  String get healthStatusValue => 'Good 🙂';

  @override
  String get healthMessage1 => 'Your health is normal today!';

  @override
  String get healthMessage2 => 'Keep it up!';

  @override
  String get todayVitals => 'Today\'s Important Vitals';

  @override
  String get todayNextMedicine => 'Today\'s Next Medicine';

  @override
  String get emergencyHelp => 'Emergency Help';

  @override
  String get emergencySubtitle => 'Press here in emergency';

  @override
  String get sosButton => 'SOS';

  @override
  String medicineProgress(Object count, Object total) {
    return '$count/$total medicines taken';
  }

  @override
  String get medicineDefaultName => 'Metformin 500mg';

  @override
  String get medicineDefaultInstruction => '1 pill - after breakfast';

  @override
  String get medicineDefaultTime => '08:00 AM';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get quickDoctor => 'Doctor\nAppointment';

  @override
  String get quickRecords => 'Medical\nRecords';

  @override
  String get quickFamily => 'Family\nConnect';

  @override
  String get quickReport => 'My Health\nReport';

  @override
  String get quickTips => 'Health\nTips';

  @override
  String get badgeNew => 'NEW';

  @override
  String get vitalsTitle => 'My Vitals';

  @override
  String get bp => 'BP';

  @override
  String get bpFull => 'Blood Pressure (BP)';

  @override
  String get sugar => 'Sugar';

  @override
  String get sugarFull => 'Sugar (Blood Glucose)';

  @override
  String get oxygen => 'SpO₂';

  @override
  String get oxygenFull => 'Oxygen (SpO₂)';

  @override
  String get temperature => 'Temperature';

  @override
  String get temperatureFull => 'Temperature';

  @override
  String get unitMmhg => 'mmHg';

  @override
  String get unitMgdl => 'mg/dL';

  @override
  String get unitPercent => '%';

  @override
  String get unitF => '°F';

  @override
  String get periodDay => 'Day';

  @override
  String get periodWeek => 'Week';

  @override
  String get periodMonth => 'Month';

  @override
  String get periodYear => 'Year';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get todayLatest => 'Today\'s Latest';

  @override
  String get todaySummary => 'Today\'s Summary';

  @override
  String get todayReadings => 'Today\'s Readings';

  @override
  String todayTrend(Object title) {
    return 'Today\'s $title Trend';
  }

  @override
  String addReading(Object title) {
    return '+ $title Reading';
  }

  @override
  String newReading(Object title) {
    return 'New $title Reading';
  }

  @override
  String valueIn(Object unit) {
    return 'Value ($unit)';
  }

  @override
  String egValue(Object value) {
    return 'e.g. $value';
  }

  @override
  String get noteOptional => 'Note (optional)';

  @override
  String readingSaved(Object title) {
    return '$title Reading saved';
  }

  @override
  String get saveReading => 'Save Reading';

  @override
  String takenAt(Object unit, Object time) {
    return '$unit • Taken at $time';
  }

  @override
  String checkedCount(Object count) {
    return 'Checked $count times';
  }

  @override
  String latestReading(Object time) {
    return 'Latest reading: $time';
  }

  @override
  String get overallStatus => 'Overall status: Normal';

  @override
  String get medicinesTitle => 'Medicines & Reminders';

  @override
  String get todayMedicines => 'Today\'s Medicines';

  @override
  String get addMedicine => 'Add New Medicine';

  @override
  String get addMedicineSubtitle => 'Set medicine time and reminder';

  @override
  String get medicineName => 'Medicine Name';

  @override
  String get medicineNameHint => 'e.g. Telmisartan 40mg';

  @override
  String get time => 'Time';

  @override
  String get dose => 'Dose';

  @override
  String get doseHint => 'e.g. 1 pill';

  @override
  String get instruction => 'Instruction';

  @override
  String get instructionAfterBreakfast => 'After breakfast';

  @override
  String get instructionAfterLunch => 'After lunch';

  @override
  String get instructionAfterDinner => 'After dinner';

  @override
  String get instructionBeforeSleep => 'Before sleep';

  @override
  String get instructionEmptyStomach => 'Empty stomach';

  @override
  String get scheduleMedicine => 'Schedule Medicine';

  @override
  String get noMedicines => 'No medicines found';

  @override
  String get noMedicinesSubtitle => 'Add new medicine using the button below.';

  @override
  String get noRecords => 'No records found';

  @override
  String get filterReports => 'Reports';

  @override
  String get filterScans => 'Scans';

  @override
  String get filterTaken => 'Taken';

  @override
  String get filterPending => 'Active';

  @override
  String get filterAll => 'All';

  @override
  String get doctorAppointment => 'Doctor Appointment';

  @override
  String get appointmentBooking => 'Book Appointment';

  @override
  String get bannerTitle => 'Meet the right\ndoctor, live healthy';

  @override
  String get bannerSubtitle => 'Choose a doctor\naccording to your condition';

  @override
  String get searchDoctorHint => 'Search doctor, specialty or symptom...';

  @override
  String get searchDoctor => 'Search Doctor';

  @override
  String get bySpecialty => 'By Specialty';

  @override
  String get popularDoctors => 'Popular Doctors';

  @override
  String doctorCount(Object count) {
    return '$count doctors';
  }

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectTime => 'Select Time';

  @override
  String get clinicHours => 'Clinic Hours';

  @override
  String get clinicDays => 'Mon - Sat';

  @override
  String get clinicTiming => '09:00 AM - 07:00 PM';

  @override
  String get consultationFee => 'Consultation Fee';

  @override
  String get nextStep => 'Next Step';

  @override
  String get patientInfo => 'Patient Information';

  @override
  String get fullName => 'Full Name';

  @override
  String get age => 'Age';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get mobileNumber => 'Mobile Number';

  @override
  String get emailOptional => 'Email (optional)';

  @override
  String get symptomsLabel => 'Problem / Symptoms (optional)';

  @override
  String get reviewAppointment => 'Review Appointment';

  @override
  String get appointmentDetails => 'Your Appointment Details';

  @override
  String get date => 'Date';

  @override
  String get location => 'Location';

  @override
  String get problemSymptoms => 'Problem / Symptoms';

  @override
  String get confirmNote => 'You will receive SMS/WhatsApp on confirmation';

  @override
  String get confirmAppointment => 'Confirm Appointment';

  @override
  String get appointmentSuccess => 'Appointment booked successfully!';

  @override
  String get appointmentInfoSent =>
      'Information has been sent via SMS and WhatsApp.';

  @override
  String get appointmentDetails2 => 'Appointment Details';

  @override
  String appointmentId(Object id) {
    return 'ID: $id';
  }

  @override
  String get myAppointments => 'My Appointments';

  @override
  String get goHome => 'Go to Home';

  @override
  String get stepperDoctor => 'Doctor';

  @override
  String get stepperTime => 'Time';

  @override
  String get stepperInfo => 'Info';

  @override
  String get stepperConfirm => 'Confirm';

  @override
  String get specCardiology => 'Cardiology';

  @override
  String get specCardiologyFull => 'Cardiology';

  @override
  String get specGeneralPhysician => 'General Physician';

  @override
  String get specGeneralPhysicianFull => 'General\nPhysician';

  @override
  String get specDiabetes => 'Diabetes Specialist';

  @override
  String get specDiabetesFull => 'Diabetes\nSpecialist';

  @override
  String get specOrthopedic => 'Orthopedic';

  @override
  String get specOrthopedicFull => 'Orthopedic';

  @override
  String get notifications => 'Notifications';

  @override
  String newNotifications(Object count) {
    return '$count new notifications';
  }

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get emergencyAlert => 'Emergency Alert';

  @override
  String get sosSending => 'Sending help message...';

  @override
  String get sosInforming =>
      'Doctor and your family are being notified immediately.';

  @override
  String get sosCancel => 'Cancel';

  @override
  String get sosSent => 'Alert sent!';

  @override
  String get sosDontWorry => 'Don\'t worry Ramesh ji.';

  @override
  String get sosSmsSent => 'SMS sent to son Amit.';

  @override
  String get sosCallingDoctor => 'Calling Dr. R. K. Gupta.';

  @override
  String get sosLocationShared => 'Your location (New Delhi) has been shared.';

  @override
  String get sosClose => 'OK (Close)';

  @override
  String get sosCancelled => 'Emergency alert cancelled.';

  @override
  String get sosAlertTitle => 'SOS Alert Sent';

  @override
  String get emergencyContacts => 'Emergency Contacts (Caretakers)';

  @override
  String get myProfile => 'My Profile';

  @override
  String get userName => 'Ramesh Kumar Sharma';

  @override
  String get userInfo => 'Age: 70 yrs | Gender: Male';

  @override
  String get bloodGroup => 'Blood Group:';

  @override
  String get height => 'Height:';

  @override
  String get weight => 'Weight:';

  @override
  String get city => 'City:';

  @override
  String get bloodGroupVal => 'O+ Pos';

  @override
  String get heightVal => '170 cm';

  @override
  String get weightVal => '72 kg';

  @override
  String get cityVal => 'New Delhi';

  @override
  String get voiceListening => 'Listening...';

  @override
  String get voicePrompt =>
      'Please speak (e.g. \'medicine\', \'BP\', \'help\', \'home\')';

  @override
  String get voiceProcessing => 'Processing...';

  @override
  String get voiceTranscript => '...';

  @override
  String get voiceAssistantTitle => 'MediTrack Voice Assistant';

  @override
  String get voiceMedicine => '💊 Medicines';

  @override
  String get voiceVitals => '📊 Vitals';

  @override
  String get voiceSos => '🚨 Help (SOS)';

  @override
  String get voiceHome => '🏠 Home';

  @override
  String get voiceCmdMedicine => 'Open medicines screen';

  @override
  String get voiceCmdVitals => 'Show reports';

  @override
  String get voiceCmdSos => 'I need help';

  @override
  String get voiceCmdHome => 'Go home';

  @override
  String get voiceRespMedicine => 'Opening medicines screen';

  @override
  String get voiceRespVitals => 'Showing your vitals';

  @override
  String get voiceRespSos => 'Emergency alert is being started!';

  @override
  String get voiceRespHome => 'Opening home dashboard';

  @override
  String get voiceRespFallback => 'Sorry, I didn\'t understand.';

  @override
  String get voiceKeywordMedicine => 'medicine';

  @override
  String get voiceKeywordVital => 'vital';

  @override
  String get voiceKeywordReport => 'report';

  @override
  String get voiceKeywordSos => 'sos';

  @override
  String get voiceKeywordHelp => 'help';

  @override
  String get voiceKeywordHome => 'home';

  @override
  String get voiceKeywordDashboard => 'dashboard';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'हिन्दी';

  @override
  String get english => 'English';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get caretakerSon => 'Amit Sharma (Son)';

  @override
  String get caretakerDoctor => 'Dr. R. K. Gupta (Family Doctor)';

  @override
  String get phoneAmit => '+91 98765 43210';

  @override
  String get phoneDoctor => '+91 99999 88888';

  @override
  String get medMetformin => 'Metformin 500mg';

  @override
  String get medTelmisartan => 'Telmisartan 40mg';

  @override
  String get medVitaminD3 => 'Vitamin D3';

  @override
  String get medAtorvastatin => 'Atorvastatin 10mg';

  @override
  String get dose1Pill => '1 pill';

  @override
  String get instAfterBreakfast => 'After breakfast';

  @override
  String get instAfterLunch => 'After lunch';

  @override
  String get instAfterDinner => 'After dinner';

  @override
  String get instBeforeSleep => 'Before sleep';

  @override
  String get drRajatSharma => 'Dr. Rajat Sharma';

  @override
  String get drNehaVerma => 'Dr. Neha Verma';

  @override
  String get drAmitPatel => 'Dr. Amit Patel';

  @override
  String get specRajat => 'MBBS, MD (Cardiology)\nCardiologist';

  @override
  String get specNeha => 'MBBS, MD (General Medicine)\nGeneral Physician';

  @override
  String get specAmit => 'MBBS, MS (Orthopedics)\nOrthopedic Surgeon';

  @override
  String get exp10plus => '10+ years experience';

  @override
  String get exp8plus => '8+ years experience';

  @override
  String get exp12plus => '12+ years experience';

  @override
  String get fee500 => '₹500';

  @override
  String get fee400 => '₹400';

  @override
  String get fee600 => '₹600';

  @override
  String get locHeartCare =>
      'Heart Care Clinic\nCivil Lines, Jaipur, Rajasthan';

  @override
  String get locLifeCare =>
      'Life Care Clinic\nMalviya Nagar, Jaipur, Rajasthan';

  @override
  String get locOrthofit =>
      'Orthofit Clinic\nVaishali Nagar, Jaipur, Rajasthan';

  @override
  String get patientName => 'Ram Sharma';

  @override
  String get patientAge => '58 years';

  @override
  String get patientPhone => '+91 98765 43210';

  @override
  String get patientEmail => 'ram.sharma@email.com';

  @override
  String get patientSymptoms => 'Chest pain, fatigue, and shortness of breath.';
}
