import 'package:data_bottle/Page/choose_TA_page.dart';
import 'package:data_bottle/Page/calculate_progress.dart';
import 'package:data_bottle/Page/choose_data_source_page.dart';
import 'package:data_bottle/Page/data_access_records_page.dart';
import 'package:data_bottle/Page/expense_tracker.dart';
import 'package:data_bottle/Page/home_page.dart';
import 'package:data_bottle/Page/identity_verify_page.dart';
import 'package:data_bottle/Page/input_page.dart';
import 'package:data_bottle/Page/show_score_page.dart';
import 'package:data_bottle/Page/verify_pass_page.dart';
import 'package:data_bottle/Page/accept_or_not_page.dart';
import 'package:data_bottle/Page/local_TEE_verify_page.dart';
import 'package:data_bottle/Page/page_container.dart';
import 'package:data_bottle/assets/constant.dart';
import 'package:data_bottle/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RouteGenerator {
  static const homeRoute = '/';

  static const chooseDataSourceRoute = '/chooseDataSource';
  static const nfcVerify = '/nfcVerify';
  static const identityVerifyPassForImportRoute = '/identityVerifyPassForImport';

  static const viewPersonalData = '/viewPersonalData';

  static const inputPassword = '/inputPassword';

  static const chooseTA = '/chooseTA';
  static const installTARoute = '/installTA';
  static const localTEEVerifyRoute = '/localTEEVerify';
  static const localTEEVerifyPassRoute = '/localTEEVerifyPass';
  static const identityVerifyForInstallTARoute = '/identityVerifyForInstallTA';
  static const identityVerifyPassForInstallTARoute = '/identityVerifyPassForInstallTA';

  static const calculateScoreRoute = '/calculateScore';
  static const calculateProgressRoute = '/calculateProgress';
  static const dataAccessedRecordsRoute = '/dataAccessedRecords';
  static const ifSendReportRoute = '/ifSendReport';
  static const sendReportRoute = '/sendReport';
  static const sendReportSuccessRoute = '/sendReportSuccess';

  static const showScorePage = '/showScorePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case nfcVerify:
        return MaterialPageRoute(
            builder: (_) =>
                PageContainer("??????", IdentityVerifyPage(homeRoute), needLeadBack: false,));
      case chooseDataSourceRoute:
        return MaterialPageRoute(
            builder: (_) => ChooseDataSourcePage(
                ChooseDataSourceType.ImportData, inputPassword));
      case inputPassword:
        return MaterialPageRoute(
            builder: (_) => PageContainer("?????????????????????????????????", InputPage(viewPersonalData)));
      case identityVerifyPassForImportRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                "??????", VerifyPassPage("????????????", "??????????????????", "??????????????????")));
      case viewPersonalData:
        return MaterialPageRoute(
            builder: (_) => PageContainer("??????????????????", ExpenseTracker(), bottom: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(Icon(Icons.arrow_back_rounded), "????????????", "/", 300, 70, color: Colors.greenAccent),
                ],
              ),
            ),));
      case installTARoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                "??????????????????????????????",
                AcceptOrNotPage("????????????????????????????????????", Icon(Icons.info, size: 100.0),
                    localTEEVerifyRoute)));
      case localTEEVerifyRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer("??????????????????????????????", LocalTEEVerifyPage()));
      case localTEEVerifyPassRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                "??????????????????????????????",
                VerifyPassPage(
                  "???????????????TEE??????",
                  "?????????????????????",
                  null,
                  route: calculateScoreRoute,
                )));
      case chooseTA:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                  "??????????????????",
                  ChooseTAPage(),
                ));
      case identityVerifyPassForInstallTARoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                "??????????????????????????????",
                VerifyPassPage(
                  "????????????",
                  "????????????",
                  "????????????",
                  route: calculateScoreRoute,
                )));
      case calculateScoreRoute:
        return MaterialPageRoute(
            builder: (_) => ChooseDataSourcePage(
                ChooseDataSourceType.UseData, calculateProgressRoute));
      case calculateProgressRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer("????????????", CalculateProgressPage()));
      case showScorePage:
        return MaterialPageRoute(builder: (_) =>
          PageContainer("????????????", ShowScorePage())
        );
      case dataAccessedRecordsRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer("??????????????????", DataAccessRecordsPage()));
      case ifSendReportRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                "????????????",
                AcceptOrNotPage(
                    "??????????????????????????????????????????",
                    CustomButton(
                        Icon(
                          Icons.description,
                          size: 60.0,
                        ),
                        "????????????",
                        null,
                        300,
                        70),
                    sendReportRoute)));
      case sendReportRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                "????????????",
                VerifyPassPage(
                  "???????????????????????????",
                  "????????????????????????????????????",
                  null,
                  route: sendReportSuccessRoute,
                )));
      case sendReportSuccessRoute:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                "????????????",
                VerifyPassPage(
                  "????????????",
                  null,
                  null,
                )));
      default:
        return MaterialPageRoute(
            builder: (_) => PageContainer(
                  "??????",
                  HomePage(),
                  needLeadBack: true,
                ));
    }
  }
}
