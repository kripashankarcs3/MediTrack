// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'MediTrack';

  @override
  String get appName => 'MediTrack';

  @override
  String get navHome => 'होम';

  @override
  String get navVitals => 'आँकड़े';

  @override
  String get navMedicines => 'दवाइयाँ';

  @override
  String get navProfile => 'प्रोफाइल';

  @override
  String get seeAll => 'सभी देखें ›';

  @override
  String get seeAllOptions => 'सभी विकल्प देखें ›';

  @override
  String get seeAllGt => 'सभी देखें >';

  @override
  String get normal => 'सामान्य';

  @override
  String get taken => 'ले ली';

  @override
  String get pending => 'लेनी बाकी';

  @override
  String get all => 'सभी';

  @override
  String get save => 'सेव करें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get done => 'ठीक है';

  @override
  String get add => 'जोड़ें';

  @override
  String get back => 'वापस';

  @override
  String get confirm => 'पुष्टि करें';

  @override
  String get greeting => 'नमस्ते रमेश जी';

  @override
  String get greetingSuffix => '👋';

  @override
  String get greetingSubtitle => 'आशा है आप स्वस्थ हैं!';

  @override
  String get profile => 'प्रोफाइल';

  @override
  String get healthStatus => 'स्वास्थ्य स्थिति';

  @override
  String get healthStatusValue => 'अच्छा है 🙂';

  @override
  String get healthMessage1 => 'आज आपकी तबीयत सामान्य है!';

  @override
  String get healthMessage2 => 'ऐसे ही ध्यान रखें!';

  @override
  String get todayVitals => 'आज के महत्वपूर्ण आंकड़े';

  @override
  String get todayNextMedicine => 'आज की अगली दवा';

  @override
  String get emergencyHelp => 'आपातकालीन मदद';

  @override
  String get emergencySubtitle => 'आपातकालीन स्थिति में यहाँ दबाएँ';

  @override
  String get sosButton => 'SOS';

  @override
  String medicineProgress(Object count, Object total) {
    return '$count/$total दवाइयाँ ली गईं';
  }

  @override
  String get medicineDefaultName => 'Metformin 500mg';

  @override
  String get medicineDefaultInstruction => '1 गोली - नाश्ते के बाद';

  @override
  String get medicineDefaultTime => '08:00 AM';

  @override
  String get quickAccess => 'त्वरित विकल्प';

  @override
  String get quickDoctor => 'डॉक्टर\nअपॉइंटमेंट';

  @override
  String get quickRecords => 'मेडिकल\nरिकॉर्ड';

  @override
  String get quickFamily => 'परिवार\nकनेक्ट';

  @override
  String get quickReport => 'मेरी सेहत\nरिपोर्ट';

  @override
  String get quickTips => 'स्वास्थ्य\nसुझाव';

  @override
  String get badgeNew => 'नया';

  @override
  String get vitalsTitle => 'मेरे आंकड़े (Vitals)';

  @override
  String get bp => 'BP';

  @override
  String get bpFull => 'ब्लड प्रेशर (BP)';

  @override
  String get sugar => 'शुगर';

  @override
  String get sugarFull => 'शुगर (रक्त शर्करा)';

  @override
  String get oxygen => 'SpO₂';

  @override
  String get oxygenFull => 'ऑक्सीजन (SpO₂)';

  @override
  String get temperature => 'तापमान';

  @override
  String get temperatureFull => 'तापमान';

  @override
  String get unitMmhg => 'mmHg';

  @override
  String get unitMgdl => 'mg/dL';

  @override
  String get unitPercent => '%';

  @override
  String get unitF => '°F';

  @override
  String get periodDay => 'दिन';

  @override
  String get periodWeek => 'सप्ताह';

  @override
  String get periodMonth => 'महीना';

  @override
  String get periodYear => 'वर्ष';

  @override
  String get today => 'आज';

  @override
  String get yesterday => 'बीता कल';

  @override
  String get tomorrow => 'आने वाला कल';

  @override
  String get todayLatest => 'आज का नवीनतम';

  @override
  String get todaySummary => 'आज का सारांश';

  @override
  String get todayReadings => 'आज की रीडिंग्स';

  @override
  String todayTrend(Object title) {
    return 'आज का $title ट्रेंड';
  }

  @override
  String addReading(Object title) {
    return '+ $title रीडिंग जोड़ें';
  }

  @override
  String newReading(Object title) {
    return 'नई $title रीडिंग';
  }

  @override
  String valueIn(Object unit) {
    return 'मान ($unit)';
  }

  @override
  String egValue(Object value) {
    return 'उदा: $value';
  }

  @override
  String get noteOptional => 'नोट (वैकल्पिक)';

  @override
  String readingSaved(Object title) {
    return '$title रीडिंग सहेज ली गई है';
  }

  @override
  String get saveReading => 'रीडिंग सेव करें';

  @override
  String takenAt(Object unit, Object time) {
    return '$unit • $time पर लिया गया';
  }

  @override
  String checkedCount(Object count) {
    return 'कुल $count बार जाँच किया गया';
  }

  @override
  String latestReading(Object time) {
    return 'नवीनतम रीडिंग: $time';
  }

  @override
  String get overallStatus => 'समग्र स्थिति: सामान्य';

  @override
  String get medicinesTitle => 'दवाइयाँ और रिमाइंडर';

  @override
  String get todayMedicines => 'आज की दवाइयाँ';

  @override
  String get addMedicine => 'नई दवा जोड़ें';

  @override
  String get addMedicineSubtitle => 'दवा का समय और रिमाइंडर सेट करें';

  @override
  String get medicineName => 'दवा का नाम (Medicine Name)';

  @override
  String get medicineNameHint => 'जैसे: Telmisartan 40mg';

  @override
  String get time => 'समय (Time)';

  @override
  String get dose => 'खुराक (Dose)';

  @override
  String get doseHint => 'जैसे: 1 गोली';

  @override
  String get instruction => 'निर्देश (Instruction)';

  @override
  String get instructionAfterBreakfast => 'नाश्ते के बाद';

  @override
  String get instructionAfterLunch => 'दोपहर के भोजन के बाद';

  @override
  String get instructionAfterDinner => 'रात के भोजन के बाद';

  @override
  String get instructionBeforeSleep => 'सोने से पहले';

  @override
  String get instructionEmptyStomach => 'खाली पेट';

  @override
  String get scheduleMedicine => 'दवा शेड्यूल करें';

  @override
  String get noMedicines => 'कोई दवा नहीं मिली';

  @override
  String get noMedicinesSubtitle => 'नीचे बटन दबाकर नई दवा जोड़ें।';

  @override
  String get noRecords => 'कोई रिकॉर्ड नहीं मिला';

  @override
  String get filterReports => 'रिपोर्ट';

  @override
  String get filterScans => 'स्कैन';

  @override
  String get filterTaken => 'पूर्ण';

  @override
  String get filterPending => 'सक्रिय';

  @override
  String get filterAll => 'सभी';

  @override
  String get doctorAppointment => 'Doctor Appointment';

  @override
  String get appointmentBooking => 'अपॉइंटमेंट बुक करें';

  @override
  String get bannerTitle => 'सही डॉक्टर से\nमिलें, स्वस्थ जीवन जियें';

  @override
  String get bannerSubtitle => 'अपनी स्थिति के अनुसार\nडॉक्टर चुनें';

  @override
  String get searchDoctorHint => 'डॉक्टर, विशेषज्ञता या लक्षण खोजें...';

  @override
  String get searchDoctor => 'डॉक्टर खोजें';

  @override
  String get bySpecialty => 'विशेषज्ञता के अनुसार';

  @override
  String get popularDoctors => 'लोकप्रिय डॉक्टर';

  @override
  String doctorCount(Object count) {
    return '$count डॉक्टर';
  }

  @override
  String get selectDate => 'तारीख चुनें';

  @override
  String get selectTime => 'समय चुनें';

  @override
  String get clinicHours => 'क्लिनिक का समय';

  @override
  String get clinicDays => 'सोम - शनि';

  @override
  String get clinicTiming => '09:00 AM - 07:00 PM';

  @override
  String get consultationFee => 'कंसल्टेशन शुल्क';

  @override
  String get nextStep => 'आगे बढ़ें';

  @override
  String get patientInfo => 'मरीज़ की जानकारी';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get age => 'उम्र';

  @override
  String get gender => 'लिंग';

  @override
  String get male => 'पुरुष';

  @override
  String get female => 'महिला';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get emailOptional => 'ईमेल (वैकल्पिक)';

  @override
  String get symptomsLabel => 'समस्या / लक्षण (वैकल्पिक)';

  @override
  String get reviewAppointment => 'अपॉइंटमेंट की समीक्षा';

  @override
  String get appointmentDetails => 'आपका अपॉइंटमेंट विवरण';

  @override
  String get date => 'तारीख';

  @override
  String get location => 'स्थान';

  @override
  String get problemSymptoms => 'समस्या / लक्षण';

  @override
  String get confirmNote => 'कन्फर्म करने पर आपको SMS/WhatsApp प्राप्त होगा';

  @override
  String get confirmAppointment => 'अपॉइंटमेंट कन्फर्म करें';

  @override
  String get appointmentSuccess => 'अपॉइंटमेंट सफलतापूर्वक बुक हो गया!';

  @override
  String get appointmentInfoSent =>
      'आपको SMS और WhatsApp पर जानकारी भेज दी गई है।';

  @override
  String get appointmentDetails2 => 'अपॉइंटमेंट विवरण';

  @override
  String appointmentId(Object id) {
    return 'ID: $id';
  }

  @override
  String get myAppointments => 'मेरे अपॉइंटमेंट देखें';

  @override
  String get goHome => 'होम पर जाएँ';

  @override
  String get stepperDoctor => 'डॉक्टर';

  @override
  String get stepperTime => 'समय';

  @override
  String get stepperInfo => 'जानकारी';

  @override
  String get stepperConfirm => 'पुष्टि';

  @override
  String get specCardiology => 'हृदय रोग';

  @override
  String get specCardiologyFull => 'हृदय रोग\n(कार्डियोलॉजिस्ट)';

  @override
  String get specGeneralPhysician => 'जनरल फिजिशियन';

  @override
  String get specGeneralPhysicianFull => 'जनरल\nफिजिशियन';

  @override
  String get specDiabetes => 'डायबिटीज विशेषज्ञ';

  @override
  String get specDiabetesFull => 'डायबिटीज\nविशेषज्ञ';

  @override
  String get specOrthopedic => 'हड्डी रोग';

  @override
  String get specOrthopedicFull => 'हड्डी रोग\n(ऑर्थोपेडिक)';

  @override
  String get notifications => 'सूचनाएँ';

  @override
  String newNotifications(Object count) {
    return '$count नई सूचनाएँ';
  }

  @override
  String get markAllRead => 'सभी पढ़ें';

  @override
  String get noNotifications => 'कोई सूचना नहीं';

  @override
  String get emergencyAlert => 'आपातकालीन अलर्ट';

  @override
  String get sosSending => 'मदद के लिए संदेश भेजा जा रहा है...';

  @override
  String get sosInforming =>
      'डॉक्टर और आपके परिवार को तुरंत सूचना दी जा रही है।';

  @override
  String get sosCancel => 'रद्द करें (Cancel)';

  @override
  String get sosSent => 'अलर्ट भेज दिया गया!';

  @override
  String get sosDontWorry => 'रमेश जी, घबराएं नहीं।';

  @override
  String get sosSmsSent => '💬 बेटे अमित को SMS भेज दिया गया है।';

  @override
  String get sosCallingDoctor => '📞 डॉ. आर. के. गुप्ता को कॉल किया जा रहा है।';

  @override
  String get sosLocationShared =>
      '📍 आपकी लोकेशन (नई दिल्ली) शेयर कर दी गई है।';

  @override
  String get sosClose => 'ठीक है (Close)';

  @override
  String get sosCancelled => 'आपातकालीन अलर्ट रद्द कर दिया गया है।';

  @override
  String get sosAlertTitle => 'SOS अलर्ट भेजा गया';

  @override
  String get emergencyContacts => '🚨 आपातकालीन संपर्क (Caretakers)';

  @override
  String get myProfile => '👤 मेरी प्रोफाइल';

  @override
  String get userName => 'रमेश कुमार शर्मा';

  @override
  String get userInfo => 'उम्र: 70 वर्ष | लिंग: पुरुष';

  @override
  String get bloodGroup => 'रक्त समूह (Blood):';

  @override
  String get height => 'ऊँचाई (Height):';

  @override
  String get weight => 'वजन (Weight):';

  @override
  String get city => 'शहर (City):';

  @override
  String get bloodGroupVal => 'O+ Pos';

  @override
  String get heightVal => '170 cm';

  @override
  String get weightVal => '72 kg';

  @override
  String get cityVal => 'नई दिल्ली';

  @override
  String get voiceListening => 'सुन रहा हूँ...';

  @override
  String get voicePrompt =>
      'कृपया बोलिए (जैसे: \'दवा\', \'बीपी\', \'मदद\', \'होम\')';

  @override
  String get voiceProcessing => 'प्रोसेस कर रहा हूँ...';

  @override
  String get voiceTranscript => '...';

  @override
  String get voiceAssistantTitle => 'MediTrack Voice Assistant';

  @override
  String get voiceMedicine => '💊 दवाइयाँ';

  @override
  String get voiceVitals => '📊 आंकड़े';

  @override
  String get voiceSos => '🚨 मदद (SOS)';

  @override
  String get voiceHome => '🏠 होम';

  @override
  String get voiceCmdMedicine => 'दवाइयाँ स्क्रीन खोलो';

  @override
  String get voiceCmdVitals => 'रिपोर्ट दिखाओ';

  @override
  String get voiceCmdSos => 'मदद चाहिए';

  @override
  String get voiceCmdHome => 'होम जाओ';

  @override
  String get voiceRespMedicine => 'दवाइयाँ स्क्रीन खोल रहा हूँ';

  @override
  String get voiceRespVitals => 'आपके आंकड़े दिखा रहा हूँ';

  @override
  String get voiceRespSos => 'आपातकालीन अलर्ट शुरू किया जा रहा है!';

  @override
  String get voiceRespHome => 'होम डैशबोर्ड खोल रहा हूँ';

  @override
  String get voiceRespFallback => 'माफ़ कीजिये, समझ नहीं आया।';

  @override
  String get voiceKeywordMedicine => 'दवा';

  @override
  String get voiceKeywordVital => 'बीपी';

  @override
  String get voiceKeywordReport => 'शुगर';

  @override
  String get voiceKeywordSos => 'मदद';

  @override
  String get voiceKeywordHelp => 'आपातकाल';

  @override
  String get voiceKeywordHome => 'होम';

  @override
  String get voiceKeywordDashboard => 'डैशबोर्ड';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get languageEnglish => '🇺🇸 English';

  @override
  String get languageHindi => '🇮🇳 हिन्दी';

  @override
  String get english => 'English';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get caretakerSon => 'अमित शर्मा (बेटा)';

  @override
  String get caretakerDoctor => 'डॉ. आर. के. गुप्ता (फैमिली डॉक्टर)';

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
  String get dose1Pill => '1 गोली';

  @override
  String get instAfterBreakfast => 'नाश्ते के बाद';

  @override
  String get instAfterLunch => 'दोपहर के भोजन के बाद';

  @override
  String get instAfterDinner => 'रात के भोजन के बाद';

  @override
  String get instBeforeSleep => 'सोने से पहले';

  @override
  String get drRajatSharma => 'Dr. Rajat Sharma';

  @override
  String get drNehaVerma => 'Dr. Neha Verma';

  @override
  String get drAmitPatel => 'Dr. Amit Patel';

  @override
  String get specRajat => 'MBBS, MD (Cardiology)\nहृदय रोग विशेषज्ञ';

  @override
  String get specNeha => 'MBBS, MD (General Medicine)\nजनरल फिजिशियन';

  @override
  String get specAmit => 'MBBS, MS (Orthopedics)\nहड्डी रोग विशेषज्ञ';

  @override
  String get exp10plus => '10+ वर्ष अनुभव';

  @override
  String get exp8plus => '8+ वर्ष अनुभव';

  @override
  String get exp12plus => '12+ वर्ष अनुभव';

  @override
  String get fee500 => '₹500';

  @override
  String get fee400 => '₹400';

  @override
  String get fee600 => '₹600';

  @override
  String get locHeartCare => 'Heart Care Clinic\nसिविल लाइन्स, जयपुर, राजस्थान';

  @override
  String get locLifeCare => 'Life Care Clinic\nमालवीय नगर, जयपुर, राजस्थान';

  @override
  String get locOrthofit => 'Orthofit Clinic\nवैशाली नगर, जयपुर, राजस्थान';

  @override
  String get patientName => 'राम शर्मा';

  @override
  String get patientAge => '58 वर्ष';

  @override
  String get patientPhone => '+91 98765 43210';

  @override
  String get patientEmail => 'ram.sharma@email.com';

  @override
  String get patientSymptoms =>
      'छाती में दर्द, थकान और सांस लेने में दिक्कत हो रही है।';
}
