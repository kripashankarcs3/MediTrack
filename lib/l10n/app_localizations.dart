import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MediTrack'**
  String get appTitle;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'MediTrack'**
  String get appName;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navVitals.
  ///
  /// In en, this message translates to:
  /// **'Vitals'**
  String get navVitals;

  /// No description provided for @navMedicines.
  ///
  /// In en, this message translates to:
  /// **'Medicines'**
  String get navMedicines;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all ›'**
  String get seeAll;

  /// No description provided for @seeAllOptions.
  ///
  /// In en, this message translates to:
  /// **'See all options ›'**
  String get seeAllOptions;

  /// No description provided for @seeAllGt.
  ///
  /// In en, this message translates to:
  /// **'See all >'**
  String get seeAllGt;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @taken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get taken;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hello Ramesh ji'**
  String get greeting;

  /// No description provided for @greetingSuffix.
  ///
  /// In en, this message translates to:
  /// **'👋'**
  String get greetingSuffix;

  /// No description provided for @greetingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hope you are healthy!'**
  String get greetingSubtitle;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @healthStatus.
  ///
  /// In en, this message translates to:
  /// **'Health Status'**
  String get healthStatus;

  /// No description provided for @healthStatusValue.
  ///
  /// In en, this message translates to:
  /// **'Good 🙂'**
  String get healthStatusValue;

  /// No description provided for @healthMessage1.
  ///
  /// In en, this message translates to:
  /// **'Your health is normal today!'**
  String get healthMessage1;

  /// No description provided for @healthMessage2.
  ///
  /// In en, this message translates to:
  /// **'Keep it up!'**
  String get healthMessage2;

  /// No description provided for @todayVitals.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Important Vitals'**
  String get todayVitals;

  /// No description provided for @todayNextMedicine.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Next Medicine'**
  String get todayNextMedicine;

  /// No description provided for @emergencyHelp.
  ///
  /// In en, this message translates to:
  /// **'Emergency Help'**
  String get emergencyHelp;

  /// No description provided for @emergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Press here in emergency'**
  String get emergencySubtitle;

  /// No description provided for @sosButton.
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get sosButton;

  /// No description provided for @medicineProgress.
  ///
  /// In en, this message translates to:
  /// **'{count}/{total} medicines taken'**
  String medicineProgress(Object count, Object total);

  /// No description provided for @medicineDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Metformin 500mg'**
  String get medicineDefaultName;

  /// No description provided for @medicineDefaultInstruction.
  ///
  /// In en, this message translates to:
  /// **'1 pill - after breakfast'**
  String get medicineDefaultInstruction;

  /// No description provided for @medicineDefaultTime.
  ///
  /// In en, this message translates to:
  /// **'08:00 AM'**
  String get medicineDefaultTime;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @quickDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor\nAppointment'**
  String get quickDoctor;

  /// No description provided for @quickRecords.
  ///
  /// In en, this message translates to:
  /// **'Medical\nRecords'**
  String get quickRecords;

  /// No description provided for @quickFamily.
  ///
  /// In en, this message translates to:
  /// **'Family\nConnect'**
  String get quickFamily;

  /// No description provided for @quickReport.
  ///
  /// In en, this message translates to:
  /// **'My Health\nReport'**
  String get quickReport;

  /// No description provided for @quickTips.
  ///
  /// In en, this message translates to:
  /// **'Health\nTips'**
  String get quickTips;

  /// No description provided for @badgeNew.
  ///
  /// In en, this message translates to:
  /// **'NEW'**
  String get badgeNew;

  /// No description provided for @vitalsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Vitals'**
  String get vitalsTitle;

  /// No description provided for @bp.
  ///
  /// In en, this message translates to:
  /// **'BP'**
  String get bp;

  /// No description provided for @bpFull.
  ///
  /// In en, this message translates to:
  /// **'Blood Pressure (BP)'**
  String get bpFull;

  /// No description provided for @sugar.
  ///
  /// In en, this message translates to:
  /// **'Sugar'**
  String get sugar;

  /// No description provided for @sugarFull.
  ///
  /// In en, this message translates to:
  /// **'Sugar (Blood Glucose)'**
  String get sugarFull;

  /// No description provided for @oxygen.
  ///
  /// In en, this message translates to:
  /// **'SpO₂'**
  String get oxygen;

  /// No description provided for @oxygenFull.
  ///
  /// In en, this message translates to:
  /// **'Oxygen (SpO₂)'**
  String get oxygenFull;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @temperatureFull.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperatureFull;

  /// No description provided for @unitMmhg.
  ///
  /// In en, this message translates to:
  /// **'mmHg'**
  String get unitMmhg;

  /// No description provided for @unitMgdl.
  ///
  /// In en, this message translates to:
  /// **'mg/dL'**
  String get unitMgdl;

  /// No description provided for @unitPercent.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get unitPercent;

  /// No description provided for @unitF.
  ///
  /// In en, this message translates to:
  /// **'°F'**
  String get unitF;

  /// No description provided for @periodDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get periodDay;

  /// No description provided for @periodWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get periodWeek;

  /// No description provided for @periodMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get periodMonth;

  /// No description provided for @periodYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get periodYear;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @todayLatest.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Latest'**
  String get todayLatest;

  /// No description provided for @todaySummary.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Summary'**
  String get todaySummary;

  /// No description provided for @todayReadings.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Readings'**
  String get todayReadings;

  /// No description provided for @todayTrend.
  ///
  /// In en, this message translates to:
  /// **'Today\'s {title} Trend'**
  String todayTrend(Object title);

  /// No description provided for @addReading.
  ///
  /// In en, this message translates to:
  /// **'+ {title} Reading'**
  String addReading(Object title);

  /// No description provided for @newReading.
  ///
  /// In en, this message translates to:
  /// **'New {title} Reading'**
  String newReading(Object title);

  /// No description provided for @valueIn.
  ///
  /// In en, this message translates to:
  /// **'Value ({unit})'**
  String valueIn(Object unit);

  /// No description provided for @egValue.
  ///
  /// In en, this message translates to:
  /// **'e.g. {value}'**
  String egValue(Object value);

  /// No description provided for @noteOptional.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptional;

  /// No description provided for @readingSaved.
  ///
  /// In en, this message translates to:
  /// **'{title} Reading saved'**
  String readingSaved(Object title);

  /// No description provided for @saveReading.
  ///
  /// In en, this message translates to:
  /// **'Save Reading'**
  String get saveReading;

  /// No description provided for @takenAt.
  ///
  /// In en, this message translates to:
  /// **'{unit} • Taken at {time}'**
  String takenAt(Object unit, Object time);

  /// No description provided for @checkedCount.
  ///
  /// In en, this message translates to:
  /// **'Checked {count} times'**
  String checkedCount(Object count);

  /// No description provided for @latestReading.
  ///
  /// In en, this message translates to:
  /// **'Latest reading: {time}'**
  String latestReading(Object time);

  /// No description provided for @overallStatus.
  ///
  /// In en, this message translates to:
  /// **'Overall status: Normal'**
  String get overallStatus;

  /// No description provided for @medicinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Medicines & Reminders'**
  String get medicinesTitle;

  /// No description provided for @todayMedicines.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Medicines'**
  String get todayMedicines;

  /// No description provided for @addMedicine.
  ///
  /// In en, this message translates to:
  /// **'Add New Medicine'**
  String get addMedicine;

  /// No description provided for @addMedicineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set medicine time and reminder'**
  String get addMedicineSubtitle;

  /// No description provided for @medicineName.
  ///
  /// In en, this message translates to:
  /// **'Medicine Name'**
  String get medicineName;

  /// No description provided for @medicineNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Telmisartan 40mg'**
  String get medicineNameHint;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @dose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get dose;

  /// No description provided for @doseHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1 pill'**
  String get doseHint;

  /// No description provided for @instruction.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get instruction;

  /// No description provided for @instructionAfterBreakfast.
  ///
  /// In en, this message translates to:
  /// **'After breakfast'**
  String get instructionAfterBreakfast;

  /// No description provided for @instructionAfterLunch.
  ///
  /// In en, this message translates to:
  /// **'After lunch'**
  String get instructionAfterLunch;

  /// No description provided for @instructionAfterDinner.
  ///
  /// In en, this message translates to:
  /// **'After dinner'**
  String get instructionAfterDinner;

  /// No description provided for @instructionBeforeSleep.
  ///
  /// In en, this message translates to:
  /// **'Before sleep'**
  String get instructionBeforeSleep;

  /// No description provided for @instructionEmptyStomach.
  ///
  /// In en, this message translates to:
  /// **'Empty stomach'**
  String get instructionEmptyStomach;

  /// No description provided for @scheduleMedicine.
  ///
  /// In en, this message translates to:
  /// **'Schedule Medicine'**
  String get scheduleMedicine;

  /// No description provided for @noMedicines.
  ///
  /// In en, this message translates to:
  /// **'No medicines found'**
  String get noMedicines;

  /// No description provided for @noMedicinesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add new medicine using the button below.'**
  String get noMedicinesSubtitle;

  /// No description provided for @noRecords.
  ///
  /// In en, this message translates to:
  /// **'No records found'**
  String get noRecords;

  /// No description provided for @filterReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get filterReports;

  /// No description provided for @filterScans.
  ///
  /// In en, this message translates to:
  /// **'Scans'**
  String get filterScans;

  /// No description provided for @filterTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get filterTaken;

  /// No description provided for @filterPending.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get filterPending;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @doctorAppointment.
  ///
  /// In en, this message translates to:
  /// **'Doctor Appointment'**
  String get doctorAppointment;

  /// No description provided for @appointmentBooking.
  ///
  /// In en, this message translates to:
  /// **'Book Appointment'**
  String get appointmentBooking;

  /// No description provided for @bannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Meet the right\ndoctor, live healthy'**
  String get bannerTitle;

  /// No description provided for @bannerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a doctor\naccording to your condition'**
  String get bannerSubtitle;

  /// No description provided for @searchDoctorHint.
  ///
  /// In en, this message translates to:
  /// **'Search doctor, specialty or symptom...'**
  String get searchDoctorHint;

  /// No description provided for @searchDoctor.
  ///
  /// In en, this message translates to:
  /// **'Search Doctor'**
  String get searchDoctor;

  /// No description provided for @bySpecialty.
  ///
  /// In en, this message translates to:
  /// **'By Specialty'**
  String get bySpecialty;

  /// No description provided for @popularDoctors.
  ///
  /// In en, this message translates to:
  /// **'Popular Doctors'**
  String get popularDoctors;

  /// No description provided for @doctorCount.
  ///
  /// In en, this message translates to:
  /// **'{count} doctors'**
  String doctorCount(Object count);

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @clinicHours.
  ///
  /// In en, this message translates to:
  /// **'Clinic Hours'**
  String get clinicHours;

  /// No description provided for @clinicDays.
  ///
  /// In en, this message translates to:
  /// **'Mon - Sat'**
  String get clinicDays;

  /// No description provided for @clinicTiming.
  ///
  /// In en, this message translates to:
  /// **'09:00 AM - 07:00 PM'**
  String get clinicTiming;

  /// No description provided for @consultationFee.
  ///
  /// In en, this message translates to:
  /// **'Consultation Fee'**
  String get consultationFee;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @patientInfo.
  ///
  /// In en, this message translates to:
  /// **'Patient Information'**
  String get patientInfo;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @emailOptional.
  ///
  /// In en, this message translates to:
  /// **'Email (optional)'**
  String get emailOptional;

  /// No description provided for @symptomsLabel.
  ///
  /// In en, this message translates to:
  /// **'Problem / Symptoms (optional)'**
  String get symptomsLabel;

  /// No description provided for @reviewAppointment.
  ///
  /// In en, this message translates to:
  /// **'Review Appointment'**
  String get reviewAppointment;

  /// No description provided for @appointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Your Appointment Details'**
  String get appointmentDetails;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @problemSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Problem / Symptoms'**
  String get problemSymptoms;

  /// No description provided for @confirmNote.
  ///
  /// In en, this message translates to:
  /// **'You will receive SMS/WhatsApp on confirmation'**
  String get confirmNote;

  /// No description provided for @confirmAppointment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Appointment'**
  String get confirmAppointment;

  /// No description provided for @appointmentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Appointment booked successfully!'**
  String get appointmentSuccess;

  /// No description provided for @appointmentInfoSent.
  ///
  /// In en, this message translates to:
  /// **'Information has been sent via SMS and WhatsApp.'**
  String get appointmentInfoSent;

  /// No description provided for @appointmentDetails2.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get appointmentDetails2;

  /// No description provided for @appointmentId.
  ///
  /// In en, this message translates to:
  /// **'ID: {id}'**
  String appointmentId(Object id);

  /// No description provided for @myAppointments.
  ///
  /// In en, this message translates to:
  /// **'My Appointments'**
  String get myAppointments;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go to Home'**
  String get goHome;

  /// No description provided for @stepperDoctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get stepperDoctor;

  /// No description provided for @stepperTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get stepperTime;

  /// No description provided for @stepperInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get stepperInfo;

  /// No description provided for @stepperConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get stepperConfirm;

  /// No description provided for @specCardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get specCardiology;

  /// No description provided for @specCardiologyFull.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get specCardiologyFull;

  /// No description provided for @specGeneralPhysician.
  ///
  /// In en, this message translates to:
  /// **'General Physician'**
  String get specGeneralPhysician;

  /// No description provided for @specGeneralPhysicianFull.
  ///
  /// In en, this message translates to:
  /// **'General\nPhysician'**
  String get specGeneralPhysicianFull;

  /// No description provided for @specDiabetes.
  ///
  /// In en, this message translates to:
  /// **'Diabetes Specialist'**
  String get specDiabetes;

  /// No description provided for @specDiabetesFull.
  ///
  /// In en, this message translates to:
  /// **'Diabetes\nSpecialist'**
  String get specDiabetesFull;

  /// No description provided for @specOrthopedic.
  ///
  /// In en, this message translates to:
  /// **'Orthopedic'**
  String get specOrthopedic;

  /// No description provided for @specOrthopedicFull.
  ///
  /// In en, this message translates to:
  /// **'Orthopedic'**
  String get specOrthopedicFull;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @newNotifications.
  ///
  /// In en, this message translates to:
  /// **'{count} new notifications'**
  String newNotifications(Object count);

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get noNotifications;

  /// No description provided for @emergencyAlert.
  ///
  /// In en, this message translates to:
  /// **'Emergency Alert'**
  String get emergencyAlert;

  /// No description provided for @sosSending.
  ///
  /// In en, this message translates to:
  /// **'Sending help message...'**
  String get sosSending;

  /// No description provided for @sosInforming.
  ///
  /// In en, this message translates to:
  /// **'Doctor and your family are being notified immediately.'**
  String get sosInforming;

  /// No description provided for @sosCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get sosCancel;

  /// No description provided for @sosSent.
  ///
  /// In en, this message translates to:
  /// **'Alert sent!'**
  String get sosSent;

  /// No description provided for @sosDontWorry.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry Ramesh ji.'**
  String get sosDontWorry;

  /// No description provided for @sosSmsSent.
  ///
  /// In en, this message translates to:
  /// **'SMS sent to son Amit.'**
  String get sosSmsSent;

  /// No description provided for @sosCallingDoctor.
  ///
  /// In en, this message translates to:
  /// **'Calling Dr. R. K. Gupta.'**
  String get sosCallingDoctor;

  /// No description provided for @sosLocationShared.
  ///
  /// In en, this message translates to:
  /// **'Your location (New Delhi) has been shared.'**
  String get sosLocationShared;

  /// No description provided for @sosClose.
  ///
  /// In en, this message translates to:
  /// **'OK (Close)'**
  String get sosClose;

  /// No description provided for @sosCancelled.
  ///
  /// In en, this message translates to:
  /// **'Emergency alert cancelled.'**
  String get sosCancelled;

  /// No description provided for @sosAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'SOS Alert Sent'**
  String get sosAlertTitle;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts (Caretakers)'**
  String get emergencyContacts;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Ramesh Kumar Sharma'**
  String get userName;

  /// No description provided for @userInfo.
  ///
  /// In en, this message translates to:
  /// **'Age: 70 yrs | Gender: Male'**
  String get userInfo;

  /// No description provided for @bloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood Group:'**
  String get bloodGroup;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height:'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight:'**
  String get weight;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City:'**
  String get city;

  /// No description provided for @bloodGroupVal.
  ///
  /// In en, this message translates to:
  /// **'O+ Pos'**
  String get bloodGroupVal;

  /// No description provided for @heightVal.
  ///
  /// In en, this message translates to:
  /// **'170 cm'**
  String get heightVal;

  /// No description provided for @weightVal.
  ///
  /// In en, this message translates to:
  /// **'72 kg'**
  String get weightVal;

  /// No description provided for @cityVal.
  ///
  /// In en, this message translates to:
  /// **'New Delhi'**
  String get cityVal;

  /// No description provided for @voiceListening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get voiceListening;

  /// No description provided for @voicePrompt.
  ///
  /// In en, this message translates to:
  /// **'Please speak (e.g. \'medicine\', \'BP\', \'help\', \'home\')'**
  String get voicePrompt;

  /// No description provided for @voiceProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get voiceProcessing;

  /// No description provided for @voiceTranscript.
  ///
  /// In en, this message translates to:
  /// **'...'**
  String get voiceTranscript;

  /// No description provided for @voiceAssistantTitle.
  ///
  /// In en, this message translates to:
  /// **'MediTrack Voice Assistant'**
  String get voiceAssistantTitle;

  /// No description provided for @voiceMedicine.
  ///
  /// In en, this message translates to:
  /// **'💊 Medicines'**
  String get voiceMedicine;

  /// No description provided for @voiceVitals.
  ///
  /// In en, this message translates to:
  /// **'📊 Vitals'**
  String get voiceVitals;

  /// No description provided for @voiceSos.
  ///
  /// In en, this message translates to:
  /// **'🚨 Help (SOS)'**
  String get voiceSos;

  /// No description provided for @voiceHome.
  ///
  /// In en, this message translates to:
  /// **'🏠 Home'**
  String get voiceHome;

  /// No description provided for @voiceCmdMedicine.
  ///
  /// In en, this message translates to:
  /// **'Open medicines screen'**
  String get voiceCmdMedicine;

  /// No description provided for @voiceCmdVitals.
  ///
  /// In en, this message translates to:
  /// **'Show reports'**
  String get voiceCmdVitals;

  /// No description provided for @voiceCmdSos.
  ///
  /// In en, this message translates to:
  /// **'I need help'**
  String get voiceCmdSos;

  /// No description provided for @voiceCmdHome.
  ///
  /// In en, this message translates to:
  /// **'Go home'**
  String get voiceCmdHome;

  /// No description provided for @voiceRespMedicine.
  ///
  /// In en, this message translates to:
  /// **'Opening medicines screen'**
  String get voiceRespMedicine;

  /// No description provided for @voiceRespVitals.
  ///
  /// In en, this message translates to:
  /// **'Showing your vitals'**
  String get voiceRespVitals;

  /// No description provided for @voiceRespSos.
  ///
  /// In en, this message translates to:
  /// **'Emergency alert is being started!'**
  String get voiceRespSos;

  /// No description provided for @voiceRespHome.
  ///
  /// In en, this message translates to:
  /// **'Opening home dashboard'**
  String get voiceRespHome;

  /// No description provided for @voiceRespFallback.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I didn\'t understand.'**
  String get voiceRespFallback;

  /// No description provided for @voiceKeywordMedicine.
  ///
  /// In en, this message translates to:
  /// **'medicine'**
  String get voiceKeywordMedicine;

  /// No description provided for @voiceKeywordVital.
  ///
  /// In en, this message translates to:
  /// **'vital'**
  String get voiceKeywordVital;

  /// No description provided for @voiceKeywordReport.
  ///
  /// In en, this message translates to:
  /// **'report'**
  String get voiceKeywordReport;

  /// No description provided for @voiceKeywordSos.
  ///
  /// In en, this message translates to:
  /// **'sos'**
  String get voiceKeywordSos;

  /// No description provided for @voiceKeywordHelp.
  ///
  /// In en, this message translates to:
  /// **'help'**
  String get voiceKeywordHelp;

  /// No description provided for @voiceKeywordHome.
  ///
  /// In en, this message translates to:
  /// **'home'**
  String get voiceKeywordHome;

  /// No description provided for @voiceKeywordDashboard.
  ///
  /// In en, this message translates to:
  /// **'dashboard'**
  String get voiceKeywordDashboard;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get languageHindi;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get hindi;

  /// No description provided for @caretakerSon.
  ///
  /// In en, this message translates to:
  /// **'Amit Sharma (Son)'**
  String get caretakerSon;

  /// No description provided for @caretakerDoctor.
  ///
  /// In en, this message translates to:
  /// **'Dr. R. K. Gupta (Family Doctor)'**
  String get caretakerDoctor;

  /// No description provided for @phoneAmit.
  ///
  /// In en, this message translates to:
  /// **'+91 98765 43210'**
  String get phoneAmit;

  /// No description provided for @phoneDoctor.
  ///
  /// In en, this message translates to:
  /// **'+91 99999 88888'**
  String get phoneDoctor;

  /// No description provided for @medMetformin.
  ///
  /// In en, this message translates to:
  /// **'Metformin 500mg'**
  String get medMetformin;

  /// No description provided for @medTelmisartan.
  ///
  /// In en, this message translates to:
  /// **'Telmisartan 40mg'**
  String get medTelmisartan;

  /// No description provided for @medVitaminD3.
  ///
  /// In en, this message translates to:
  /// **'Vitamin D3'**
  String get medVitaminD3;

  /// No description provided for @medAtorvastatin.
  ///
  /// In en, this message translates to:
  /// **'Atorvastatin 10mg'**
  String get medAtorvastatin;

  /// No description provided for @dose1Pill.
  ///
  /// In en, this message translates to:
  /// **'1 pill'**
  String get dose1Pill;

  /// No description provided for @instAfterBreakfast.
  ///
  /// In en, this message translates to:
  /// **'After breakfast'**
  String get instAfterBreakfast;

  /// No description provided for @instAfterLunch.
  ///
  /// In en, this message translates to:
  /// **'After lunch'**
  String get instAfterLunch;

  /// No description provided for @instAfterDinner.
  ///
  /// In en, this message translates to:
  /// **'After dinner'**
  String get instAfterDinner;

  /// No description provided for @instBeforeSleep.
  ///
  /// In en, this message translates to:
  /// **'Before sleep'**
  String get instBeforeSleep;

  /// No description provided for @drRajatSharma.
  ///
  /// In en, this message translates to:
  /// **'Dr. Rajat Sharma'**
  String get drRajatSharma;

  /// No description provided for @drNehaVerma.
  ///
  /// In en, this message translates to:
  /// **'Dr. Neha Verma'**
  String get drNehaVerma;

  /// No description provided for @drAmitPatel.
  ///
  /// In en, this message translates to:
  /// **'Dr. Amit Patel'**
  String get drAmitPatel;

  /// No description provided for @specRajat.
  ///
  /// In en, this message translates to:
  /// **'MBBS, MD (Cardiology)\nCardiologist'**
  String get specRajat;

  /// No description provided for @specNeha.
  ///
  /// In en, this message translates to:
  /// **'MBBS, MD (General Medicine)\nGeneral Physician'**
  String get specNeha;

  /// No description provided for @specAmit.
  ///
  /// In en, this message translates to:
  /// **'MBBS, MS (Orthopedics)\nOrthopedic Surgeon'**
  String get specAmit;

  /// No description provided for @exp10plus.
  ///
  /// In en, this message translates to:
  /// **'10+ years experience'**
  String get exp10plus;

  /// No description provided for @exp8plus.
  ///
  /// In en, this message translates to:
  /// **'8+ years experience'**
  String get exp8plus;

  /// No description provided for @exp12plus.
  ///
  /// In en, this message translates to:
  /// **'12+ years experience'**
  String get exp12plus;

  /// No description provided for @fee500.
  ///
  /// In en, this message translates to:
  /// **'₹500'**
  String get fee500;

  /// No description provided for @fee400.
  ///
  /// In en, this message translates to:
  /// **'₹400'**
  String get fee400;

  /// No description provided for @fee600.
  ///
  /// In en, this message translates to:
  /// **'₹600'**
  String get fee600;

  /// No description provided for @locHeartCare.
  ///
  /// In en, this message translates to:
  /// **'Heart Care Clinic\nCivil Lines, Jaipur, Rajasthan'**
  String get locHeartCare;

  /// No description provided for @locLifeCare.
  ///
  /// In en, this message translates to:
  /// **'Life Care Clinic\nMalviya Nagar, Jaipur, Rajasthan'**
  String get locLifeCare;

  /// No description provided for @locOrthofit.
  ///
  /// In en, this message translates to:
  /// **'Orthofit Clinic\nVaishali Nagar, Jaipur, Rajasthan'**
  String get locOrthofit;

  /// No description provided for @patientName.
  ///
  /// In en, this message translates to:
  /// **'Ram Sharma'**
  String get patientName;

  /// No description provided for @patientAge.
  ///
  /// In en, this message translates to:
  /// **'58 years'**
  String get patientAge;

  /// No description provided for @patientPhone.
  ///
  /// In en, this message translates to:
  /// **'+91 98765 43210'**
  String get patientPhone;

  /// No description provided for @patientEmail.
  ///
  /// In en, this message translates to:
  /// **'ram.sharma@email.com'**
  String get patientEmail;

  /// No description provided for @patientSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Chest pain, fatigue, and shortness of breath.'**
  String get patientSymptoms;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
