import 'package:avocat/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        showSkipButton: false,
        isProgress: true,
        isTopSafeArea: true,
        rtl: false,
        pages: [
          PageViewModel(
            useScrollView: false,
            titleWidget: Center(
              child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'محامي أون لاين',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
            ),
            bodyWidget: Text(
              ' تطبيق محامي أون لاين مرتبط بتطبيق آخر وهو استشاراتي القانونية أين يتم تسجيل المستخدمين العاديين فيه ويمكنهم من خلاله طرح انشغالاتهم القانونية التي يجيب عنها المحامين المسجلين في التطبيق . أن الإجابة على الاستشارات تعتبر تعريف بالمحامي قد يجعل من طالب الاستشارة توكيلك في قضيته ',
              style: TextStyle(fontSize: 17),
              textAlign: TextAlign.center,
            ),
            image: Center(
                child: Image.asset(
              'assets/image/logo-dore.png',
              height: 300,
            )),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Container(
                  margin: EdgeInsets.only(top: 250),
                  alignment: Alignment.center,
                  child: Text(
                    'الانابۀ القضائیۀ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
            ),
            bodyWidget: Text(
              'خدمة تعمل اون لاين على مدار اليوم تتيح للمحامي عند الحاجه الاستعانة بأحد المحامين المسجلين في التطبيق والمتواجدين بالمكان المطلوب ، سواء بطلب أجل أو استلام مذكرة جوابية أو لاتخاذ الاجراء القانوني المطالب به ، وذلك من اجل الحصول على الخدمات و تنفيذ الاجراءات القانونية في اقل وقت متاح حفاظا على الوقت . كما يمكن تصوير المذكرة أو مقال الرد وإرساله لطالب الإنابة القضائية في حينه دون الانتظار مطولا ودون عناء التنقل',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Container(
                  margin: EdgeInsets.only(top: 250),
                  alignment: Alignment.center,
                  child: Text(
                    ' تسییر مکتب المحامی',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
            ),
            bodyWidget: Text(
              'مع ضغوطات العمل وكثرة التواريخ ينجر عنه نسيان تاریخ قضية ما أو موعد ، يوفر تطبيق محامي أونلاين خدمة تسيير مكتب المحامي التي تعمل على تسهيل مهام المحامي وتذكيره بجميع الآجال والمواعيد القانونية الخاصة بالاجابة على المذكرات وإيداع ملفات الموضوع وآجال اللاستئناف .',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
          PageViewModel(
            titleWidget: Center(
              child: Container(
                  margin: EdgeInsets.only(top: 250),
                  alignment: Alignment.center,
                  child: Text(
                    'تسجیل کمستشار',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )),
            ),
            bodyWidget: Text(
              'تطبيق محامي أون لاين يمنح لك ميزات سيتم اكتشافها من خلال استخدامه اليومي ، نسعد بانضمامك الى عائلتك الثانية ، أصحاب الجبة السوداء المعروفون بأصحاب مهنة الجبابرة .',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
          ),
        ],
        onDone: () {
          Get.offNamed('/home');
        },
        next: Icon(
          Icons.arrow_right_outlined,
          color: primaryColor,
        ),
        done: const Text("تسجيل الدخول",
            style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor)),
        dotsDecorator: DotsDecorator(
            activeColor: primaryColor,
            size: const Size.square(10.0),
            activeSize: const Size(20.0, 10.0),
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0))),
      ),
    );
  }
}
