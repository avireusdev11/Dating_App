import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:matri_app/age_notifier.dart';
import 'package:matri_app/distance_provider.dart';
import 'package:matri_app/first_page.dart';
import 'package:matri_app/main_page.dart';
import 'package:matri_app/message_page.dart';
import 'package:matri_app/photo_widget.dart';
import 'package:matri_app/show_matches.dart';
import 'package:matri_app/user/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Settings_page extends StatefulWidget {
  final Usersclass user;
  Settings_page({this.user});

  @override
  _Settings_pageState createState() => _Settings_pageState();
}

class _Settings_pageState extends State<Settings_page> {
  Future getLocation() async
  {
    print('kkk');
    Coordinates coordinate=new Coordinates(widget.user.location.latitude, widget.user.location.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinate).onError((error, stackTrace) {print(error.toString());});
    var first = addresses.first;
    return first;
  }
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: MaterialButton(
            onPressed: () {
              final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
              _scaffoldKey.currentState.openDrawer();
            },
            child: SvgPicture.string(
              '<svg viewBox="20.0 34.5 20.0 15.0" ><path transform="translate(654.0, 187.48)" d="M -632.500244140625 -137.9997100830078 C -633.3281860351562 -137.9997100830078 -633.9996337890625 -138.6719970703125 -633.9996337890625 -139.5 C -633.9996337890625 -140.3280029296875 -633.3281860351562 -141.0003051757812 -632.500244140625 -141.0003051757812 L -615.5001220703125 -141.0003051757812 C -614.6712036132812 -141.0003051757812 -613.9998168945312 -140.3280029296875 -613.9998168945312 -139.5 C -613.9998168945312 -138.6719970703125 -614.6712036132812 -137.9997100830078 -615.5001220703125 -137.9997100830078 L -632.500244140625 -137.9997100830078 Z M -632.500244140625 -144 C -633.3281860351562 -144 -633.9996337890625 -144.6714019775391 -633.9996337890625 -145.5003051757812 C -633.9996337890625 -146.3283081054688 -633.3281860351562 -146.9997100830078 -632.500244140625 -146.9997100830078 L -618.4998168945312 -146.9997100830078 C -617.6718139648438 -146.9997100830078 -617.0004272460938 -146.3283081054688 -617.0004272460938 -145.5003051757812 C -617.0004272460938 -144.6714019775391 -617.6718139648438 -144 -618.4998168945312 -144 L -632.500244140625 -144 Z M -632.500244140625 -150.0003051757812 C -633.3281860351562 -150.0003051757812 -633.9996337890625 -150.6717071533203 -633.9996337890625 -151.4997100830078 C -633.9996337890625 -152.3285980224609 -633.3281860351562 -153 -632.500244140625 -153 L -615.5001220703125 -153 C -614.6712036132812 -153 -613.9998168945312 -152.3285980224609 -613.9998168945312 -151.4997100830078 C -613.9998168945312 -150.6717071533203 -614.6712036132812 -150.0003051757812 -615.5001220703125 -150.0003051757812 L -632.500244140625 -150.0003051757812 Z" fill="#383838" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),

          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              color: const Color(0xff383838),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Column(
                children: [
                  ClipOval(child: Container(height: size.height*0.20,width: size.height*0.20,
                    child: Photo_widget(
                      photolink: widget.user.photo,

                    ),),),
                  Text(
                    widget.user.name.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 35,
                      color: const Color(0xff383838),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => main_page(user: widget.user,),
                        //builder: (context) => messages(userid: uid),
                      ),
                    );
                  },
                  child: Row(children: [
                    SvgPicture.string(
                      '<svg viewBox="24.0 257.9 14.0 13.0" ><path transform="translate(24.0, 275.0)" d="M 4.31212043762207 -10.62740993499756 C 3.526776552200317 -10.60317134857178 2.884442567825317 -10.29291152954102 2.385118722915649 -9.696632385253906 L 1.410710453987122 -9.696632385253906 C 1.013190627098083 -9.696632385253906 0.6786924004554749 -9.794800758361816 0.407215416431427 -9.99113655090332 C 0.1357384473085403 -10.18747234344482 -7.068291421490124e-16 -10.47470378875732 -7.068291421490124e-16 -10.85283279418945 C -7.068291421490124e-16 -12.56410694122314 0.3005637228488922 -13.41974449157715 0.901691198348999 -13.41974449157715 C 0.9307780265808105 -13.41974449157715 1.03621768951416 -13.36884212493896 1.218010425567627 -13.26703834533691 C 1.399802923202515 -13.16523456573486 1.636133432388306 -13.06221866607666 1.927001595497131 -12.9579906463623 C 2.217869520187378 -12.85376358032227 2.506313800811768 -12.80164813995361 2.792334079742432 -12.80164813995361 C 3.11713695526123 -12.80164813995361 3.439515829086304 -12.85739898681641 3.759470701217651 -12.96889877319336 C 3.735231399536133 -12.78952980041504 3.723112344741821 -12.62955188751221 3.723112344741821 -12.48896598815918 C 3.723112344741821 -11.8151216506958 3.919448375701904 -11.19460296630859 4.31212043762207 -10.62740993499756 Z M 12.1001148223877 -5.995335102081299 C 12.1001148223877 -5.413599014282227 11.92317008972168 -4.954269409179688 11.56928062438965 -4.617347717285156 C 11.21539115905762 -4.280425071716309 10.74515438079834 -4.111963748931885 10.15857028961182 -4.111963748931885 L 3.803101062774658 -4.111963748931885 C 3.216516971588135 -4.111963748931885 2.746280193328857 -4.280425071716309 2.392390489578247 -4.617347717285156 C 2.038501024246216 -4.954269409179688 1.861556172370911 -5.413599014282227 1.861556172370911 -5.995335102081299 C 1.861556172370911 -6.25226879119873 1.870039820671082 -6.503142356872559 1.887007117271423 -6.747956275939941 C 1.903974413871765 -6.992770195007324 1.937909007072449 -7.256976127624512 1.988810896873474 -7.540572166442871 C 2.039712905883789 -7.82416820526123 2.103946447372437 -8.087162017822266 2.181511163711548 -8.329551696777344 C 2.259075880050659 -8.571942329406738 2.363303661346436 -8.808272361755371 2.494194269180298 -9.038543701171875 C 2.62508487701416 -9.268814086914062 2.77536678314209 -9.465149879455566 2.945039987564087 -9.627551078796387 C 3.114712953567505 -9.789951324462891 3.321956396102905 -9.919631004333496 3.566770315170288 -10.01658821105957 C 3.811584711074829 -10.11354351043701 4.081849098205566 -10.16202068328857 4.377565383911133 -10.16202068328857 C 4.42604398727417 -10.16202068328857 4.530271530151367 -10.10990810394287 4.690248966217041 -10.00568008422852 C 4.850226402282715 -9.90145206451416 5.02717113494873 -9.785103797912598 5.221083164215088 -9.656638145446777 C 5.414995670318604 -9.528170585632324 5.674353122711182 -9.411823272705078 5.999155521392822 -9.307596206665039 C 6.323958396911621 -9.203368186950684 6.651184558868408 -9.151254653930664 6.9808349609375 -9.151254653930664 C 7.310486316680908 -9.151254653930664 7.637713432312012 -9.203368186950684 7.962515354156494 -9.307596206665039 C 8.287318229675293 -9.411823272705078 8.546675682067871 -9.528170585632324 8.74058723449707 -9.656638145446777 C 8.934500694274902 -9.785103797912598 9.111444473266602 -9.90145206451416 9.271421432495117 -10.00568008422852 C 9.431399345397949 -10.10990810394287 9.535627365112305 -10.16202068328857 9.584105491638184 -10.16202068328857 C 9.87982177734375 -10.16202068328857 10.15008640289307 -10.11354351043701 10.39490032196045 -10.01658821105957 C 10.63971328735352 -9.919631004333496 10.84695720672607 -9.789951324462891 11.01663017272949 -9.627551078796387 C 11.18630313873291 -9.465149879455566 11.33658599853516 -9.268814086914062 11.4674768447876 -9.038543701171875 C 11.59836578369141 -8.808272361755371 11.70259475708008 -8.571942329406738 11.78015995025635 -8.329551696777344 C 11.8577241897583 -8.087162017822266 11.92195796966553 -7.82416820526123 11.97286033630371 -7.540572166442871 C 12.02376174926758 -7.256976127624512 12.05769634246826 -6.992770195007324 12.07466316223145 -6.747956275939941 C 12.09163093566895 -6.503142356872559 12.1001148223877 -6.25226879119873 12.1001148223877 -5.995335102081299 Z M 4.653890132904053 -15.28130054473877 C 4.653890132904053 -14.76743316650391 4.472097873687744 -14.32870674133301 4.108512401580811 -13.96512222290039 C 3.744927167892456 -13.60153675079346 3.306201219558716 -13.41974449157715 2.792334079742432 -13.41974449157715 C 2.278467178344727 -13.41974449157715 1.839740991592407 -13.60153675079346 1.476155757904053 -13.96512222290039 C 1.112570643424988 -14.32870674133301 0.9307780861854553 -14.76743316650391 0.9307780861854553 -15.28130054473877 C 0.9307780861854553 -15.79516696929932 1.112570643424988 -16.23389434814453 1.476155757904053 -16.59747886657715 C 1.839740991592407 -16.9610652923584 2.278467178344727 -17.14285659790039 2.792334079742432 -17.14285659790039 C 3.306201219558716 -17.14285659790039 3.744927167892456 -16.9610652923584 4.108512401580811 -16.59747886657715 C 4.472097873687744 -16.23389434814453 4.653890132904053 -15.79516696929932 4.653890132904053 -15.28130054473877 Z M 9.77316951751709 -12.48896598815918 C 9.77316951751709 -11.71816539764404 9.500480651855469 -11.06007671356201 8.955102920532227 -10.51469898223877 C 8.409725189208984 -9.969321250915527 7.751636028289795 -9.696632385253906 6.9808349609375 -9.696632385253906 C 6.210034847259521 -9.696632385253906 5.551945686340332 -9.969321250915527 5.006567478179932 -10.51469898223877 C 4.461189746856689 -11.06007671356201 4.188501358032227 -11.71816539764404 4.188501358032227 -12.48896598815918 C 4.188501358032227 -13.25976657867432 4.461189746856689 -13.91785526275635 5.006567478179932 -14.46323394775391 C 5.551945686340332 -15.00861167907715 6.210034847259521 -15.28130054473877 6.9808349609375 -15.28130054473877 C 7.751636028289795 -15.28130054473877 8.409725189208984 -15.00861167907715 8.955102920532227 -14.46323394775391 C 9.500480651855469 -13.91785526275635 9.77316951751709 -13.25976657867432 9.77316951751709 -12.48896598815918 Z M 13.961669921875 -10.85283279418945 C 13.961669921875 -10.47470378875732 13.82593154907227 -10.18747234344482 13.5544548034668 -9.99113655090332 C 13.28297805786133 -9.794800758361816 12.94847869873047 -9.696632385253906 12.55096054077148 -9.696632385253906 L 11.57655143737793 -9.696632385253906 C 11.07722854614258 -10.29291152954102 10.43489456176758 -10.60317134857178 9.649550437927246 -10.62740993499756 C 10.04222202301025 -11.19460296630859 10.23855781555176 -11.8151216506958 10.23855781555176 -12.48896598815918 C 10.23855781555176 -12.62955188751221 10.22643947601318 -12.78952980041504 10.20219993591309 -12.96889877319336 C 10.52215576171875 -12.85739898681641 10.8445348739624 -12.80164813995361 11.16933631896973 -12.80164813995361 C 11.45535755157471 -12.80164813995361 11.74380111694336 -12.85376358032227 12.03466892242432 -12.9579906463623 C 12.32553672790527 -13.06221866607666 12.56186771392822 -13.16523456573486 12.74366092681885 -13.26703834533691 C 12.92545223236084 -13.36884212493896 13.03089332580566 -13.41974449157715 13.05998039245605 -13.41974449157715 C 13.66110610961914 -13.41974449157715 13.961669921875 -12.56410694122314 13.961669921875 -10.85283279418945 Z M 13.03089332580566 -15.28130054473877 C 13.03089332580566 -14.76743316650391 12.84910011291504 -14.32870674133301 12.48551464080811 -13.96512222290039 C 12.1219310760498 -13.60153675079346 11.68320369720459 -13.41974449157715 11.16933631896973 -13.41974449157715 C 10.65546894073486 -13.41974449157715 10.21674346923828 -13.60153675079346 9.853157997131348 -13.96512222290039 C 9.48957347869873 -14.32870674133301 9.307780265808105 -14.76743316650391 9.307780265808105 -15.28130054473877 C 9.307780265808105 -15.79516696929932 9.48957347869873 -16.23389434814453 9.853157997131348 -16.59747886657715 C 10.21674346923828 -16.9610652923584 10.65546894073486 -17.14285659790039 11.16933631896973 -17.14285659790039 C 11.68320369720459 -17.14285659790039 12.1219310760498 -16.9610652923584 12.48551464080811 -16.59747886657715 C 12.84910011291504 -16.23389434814453 13.03089332580566 -15.79516696929932 13.03089332580566 -15.28130054473877 Z" fill="#b4b4b4" stroke="#000000" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                      height: 30,
                    ),
                    SizedBox(width: 20,),
                    Text(
                      'Browse',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 30,
                        color: const Color(0xff383838),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),

                  ],),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => messages(userid: widget.user.uid,),
                        //builder: (context) => messages(userid: uid),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.string(
                        '<svg viewBox="24.0 315.9 14.3 14.1" ><path transform="translate(24.0, 315.92)" d="M 3.076313734054565 11.0430383682251 C 1.2174973487854 9.949798583984375 0 8.12495231628418 0 6.058313369750977 C 0 2.712159872055054 3.190930366516113 0 7.127197265625 0 C 11.06346416473389 0 14.25439453125 2.712159872055054 14.25439453125 6.058313369750977 C 14.25439453125 9.403813362121582 11.06346416473389 12.11597347259521 7.127197265625 12.11597347259521 C 6.984488010406494 12.11597347259521 6.842898845672607 12.11238384246826 6.702265739440918 12.10535430908203 L 3.076313734054565 14.08476066589355 L 3.076313734054565 11.0430383682251 Z" fill="#b4b4b4" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                        height: 30,
                      ),
                      SizedBox(width: 20,),
                      Text(
                        'Messages',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 30,
                          color: const Color(0xff383838),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Show_matches(user: widget.user,),
                        //builder: (context) => messages(userid: uid),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SvgPicture.string(
                        '<svg viewBox="22.4 370.0 17.2 17.2" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 22.37, 378.59)" d="M 7.469616413116455 12.09989929199219 L 0 12.09989929199219 L 0 4.016565799713135 L 7.757970888633281e-05 4.016565799713135 C 0.01348254922777414 1.795917153358459 1.817841291427612 0 4.041644096374512 0 C 6.26549243927002 0 8.069849967956543 1.795917153358459 8.083256721496582 4.016565799713135 L 8.083333015441895 4.016565799713135 L 8.083333015441895 4.041644096374512 L 8.083333015441895 4.066845893859863 C 8.091632843017578 4.066795349121094 8.100101470947266 4.066767692565918 8.108412742614746 4.066767692565918 C 10.3405704498291 4.066767692565918 12.15010166168213 5.876299381256104 12.15010166168213 8.108412742614746 C 12.15010166168213 10.3405704498291 10.3405704498291 12.15010166168213 8.108412742614746 12.15010166168213 C 7.891112804412842 12.15010166168213 7.67762565612793 12.13292026519775 7.469616413116455 12.09989929199219 Z" fill="#b4b4b4" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fill,
                        height: 30,
                      ),
                      SizedBox(width: 20,),
                      Text(
                        'My matches',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 30,
                          color: const Color(0xff383838),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Settings_page(user: widget.user,),
                        //builder: (context) => messages(userid: uid),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.settings,size: 40,),
                      SizedBox(width: 20,),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 30,
                          color: const Color(0xff383838),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            )

          ],
        ),
      ),
      body:FutureBuilder(
        future: getLocation(),
        builder: (context,snapshot){
          if(snapshot.data!=null)
            {
              return Material(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('images/background.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                    child: Center(
                      child: ListView(
                        padding: EdgeInsets.all(40),
                        children: [
                          CircleAvatar(
                            radius: size.height*0.08,
                            child: ClipOval(child: Container(height: size.height*0.15,width: size.height*0.15,
                              child: Photo_widget(
                                photolink: widget.user.photo,
                                
                              ),),),
                          ),
                          Text(
                            'HI! '+widget.user.name.toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 30,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: size.height*0.04,),
                          Row(
                            children: [
                              Text(
                                'Your Location: ',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 25,
                                  color:  Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(width: size.width*0.08,),
                              Text(
                                "${snapshot.data.featureName}",
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 25,
                                  color: const Color(0xfff24e86),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height*0.04,),
                          Row(
                            children: [
                              Text(
                                'Gender Preference: ',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 25,
                                  color:  Colors.white,
                                ),
                                textAlign: TextAlign.left,
                              ),

                              Text(
                                widget.user.interested,
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 25,
                                  color: const Color(0xfff24e86),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          SizedBox(height: size.height*0.04,),
                          Consumer<Age_provider>(builder: (context,age,child){
                            double min=age.minage.toDouble();
                            double max=age.maxage.toDouble();
                            print('aaa '+min.toString());
                            RangeValues val=new RangeValues(min,max);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Min Age: ',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 25,
                                        color:  Colors.white,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(width: size.width*0.02,),
                                    Text(
                                      age.minage.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 35,
                                        color: const Color(0xfff24e86),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Max Age: ',
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 25,
                                        color:  Colors.white,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(width: size.width*0.02,),
                                    Text(
                                      age.maxage.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 35,
                                        color: const Color(0xfff24e86),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                RangeSlider(activeColor:const Color(0xfff24e86),
                                  values: val,
                                  min: 18,
                                  max: 100,
                                  labels: RangeLabels(
                                    'minimum age',
                                    'max age',
                                  ),onChanged: (values){
                                  val=values;
                                  age.changemin(values.start.toInt());
                                  age.changemax(values.end.toInt());
                                  },),
                              ],
                            );
                          }),
                          SizedBox(height: size.height*0.04,),
                         Consumer<Distance_provider>(builder: (context,distance,child){
                           return Column(
                             children: [
                               Row(
                                 children: [
                                   Text(
                                     'Max Distance: ',
                                     style: TextStyle(
                                       fontFamily: 'Lato',
                                       fontSize: 25,
                                       color:  Colors.white,
                                     ),
                                     textAlign: TextAlign.left,
                                   ),
                                   SizedBox(width: size.width*0.02,),
                                   Text(
                                     distance.distance.toString(),
                                     style: TextStyle(
                                       fontFamily: 'Lato',
                                       fontSize: 35,
                                       color: const Color(0xfff24e86),
                                     ),
                                     textAlign: TextAlign.left,
                                   ),

                                 ],
                               ),
                               Slider(activeColor:const Color(0xfff24e86),
                                 min: 0,max: 100,
                                 value: distance.distance.toDouble(),
                                 onChanged: (val){
                                   distance.changeDistance(val.toInt());
                                 },)
                             ],
                           );
                         }),
                          FlatButton(
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 13,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              color: Color(0xff2A4755),
                              onPressed: () async {
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.clear();
                                _firebaseAuth.signOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => First_page()
                                    ),
                                    ModalRoute.withName("/first")
                                );

                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          else{
            return Column(
                children: [
                  Container(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.orange,
                      strokeWidth: 10,
                    ),
                    height: size.height/2,
                    width: size.width,
                  ),
                ]
            );
          }
        },
      )
    );
  }
}
