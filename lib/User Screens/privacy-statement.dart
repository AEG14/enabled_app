import 'package:enabled_app/main.dart';
import 'package:flutter/material.dart';
import '../../app_styles.dart';
import '../../size_config.dart';
import '../push_animation.dart';

class PrivacyStatementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff75D481), Color(0xff169d53)],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff75D481), Color(0xff169d53)],
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.blockSizeHorizontal! * 20,
                      height: SizeConfig.blockSizeVertical! * 7.5,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteUtils.createSlidePageRoute(
                                MyHomePage(title: 'ENABLED')),
                          );
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: SizeConfig.blockSizeHorizontal! * 7.5,
                            color: tWhite,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Privacy Statement and Legal Information',
                        overflow: TextOverflow.ellipsis,
                        style: tPoppinsSemiBold.copyWith(
                          color: tWhite,
                          fontSize: SizeConfig.blockSizeHorizontal! * 4.5,
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal! * 20,
                      height: SizeConfig.blockSizeVertical! * 7.5,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView(
                      children: [
                        Text(
                          'Privacy Statement',
                          style: tPoppinsBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                        Text(
                          'Last Updated: April 9, 2024', // Updated date
                          style: tPoppinsSemiBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "We at A-AH Inc. operate the ENABLED mobile application (the \"App\"). This Privacy Statement informs you of our policies regarding the collection, use, and disclosure of personal information we receive from users of the App.\n\nBy using ENABLED, you agree to the collection and use of information in accordance with this Privacy Statement.",
                          style: tPoppinsRegular.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Information Collection and Use',
                          style: tPoppinsBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                        Text(
                          "• Personal Information: While using ENABLED, we may ask you to provide certain personally identifiable information that can be used to contact or identify you. Personal information may include, but is not limited to, your name, email address, phone number, and vehicle information.\n\n• Log Data: Like many app operators, we collect information that your device sends whenever you use ENABLED (\"Log Data\"). This Log Data may include information such as your device's Internet Protocol (\"IP\") address, device name, operating system version, configuration of the app when utilizing our service, and other statistics.",
                          style: tPoppinsRegular.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Security',
                          style: tPoppinsBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                        Text(
                          "The security of your personal information is important to us, especially as ENABLED serves disabled persons. While we strive to use commercially acceptable means to protect your personal information, we cannot guarantee its absolute security.",
                          style: tPoppinsRegular.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Legal Information',
                          style: tPoppinsBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                        Text(
                          'Terms and Conditions',
                          style: tPoppinsSemiBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 4.5,
                          ),
                        ),
                        Text(
                          "By downloading and using ENABLED, you agree to abide by our Terms and Conditions. Please read these terms carefully before using the App.",
                          style: tPoppinsRegular.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Changes to This Privacy Statement',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: tPoppinsSemiBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 4.5,
                          ),
                        ),
                        Text(
                          "This Privacy Statement is effective as of April 9, 2024 and will remain in effect except concerning any changes in its provisions in the future, which will be in effect immediately after being posted on this page.\n\nWe reserve the right to update or change our Privacy Statement at any time, and you should check this Privacy Statement periodically. Your continued use of the App after we post any modifications to the Privacy Statement on this page will constitute your acknowledgment of the modifications and your consent to abide and be bound by the modified Privacy Statement.",
                          style: tPoppinsRegular.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Contact Us',
                          style: tPoppinsBold.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 5,
                          ),
                        ),
                        Text(
                          "If you have any questions about this Privacy Statement, please contact us at support@aahinc.com",
                          style: tPoppinsRegular.copyWith(
                            color: tWhite,
                            fontSize: SizeConfig.blockSizeHorizontal! * 3.5,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
