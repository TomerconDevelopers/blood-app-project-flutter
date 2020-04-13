import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'utils.dart' as ut;

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  //required variables
  CarouselSlider cs;
  int index = 0;
  //list of titles
  List h = [
    "Privacy Policy",
    "Acceptance of terms",
    "Eligibility",
    "Creation of an account and registration",
    "Term and termination",
    "Non-commercial use by users",
    "Account security",
    "Interaction with other users",
    "Proprietary rights",
    "Content posted by the user",
    "Prohibited Activities",
    "Disclaimers",
    "Limitation of liability",
    "Information collected from users device",
    "Collection of personal and other information",
    "User's Consent",
    "Grievance Officer",
    "Dispute Resolution & Jurisdiction"
      ];
      //maps titles to their respective contents
  Map<String, String> d = {
    "Privacy Policy":
        "-  This document is an electronic record in terms of Information Technology Act, 2000 and rules there under as applicable and the amended provisions pertaining to electronic records in various statutes as amended by the Information Technology Act, 2000. \n\n- This electronic record is generated by a computer system and does not require any physical or digital signature.This document is published in accordance with the provisions of Rule 3 (1) of the Information Technology (Intermediaries guidelines) Rules, 2011 that require publishing the rules and regulations, privacy policy and terms of use for access or usage of the application (“Application”).\n\n- By accessing the Website or Application, whether through a mobile device, mobile application or computer, the User agrees to be bound by the Terms of Use (‘Terms’) and this Privacy Policy (‘Policy’) whether or not the User creates an account to avail of the Service.\n\n- If the User wishes to avail of the Service, the User does hereby unequivocally accept and agree to the contents of the Terms and Policy.\n\n- For the purpose of these Terms, wherever the context so requires: \n   i.  The term 'the User' & 'User' & 'Member' & 'You' shall mean any legal person or entity accessing or using the Service (defined below) provided on the Application, who is competent to enter into binding contracts, as per the provisions of the Indian Contract Act, 1872; \n  ii. The terms 'Party' & 'Parties' shall respectively be used to refer to the User and the Company individually and collectively, as the context so requires; and \n   iii.  The terms 'We' and 'Us' shall be used to refer to the Company.\n\n- The headings of each section in these Terms are only for the purpose of organizing the various provisions under these Terms in an orderly manner, and shall not be used by either Party to interpret the provisions contained herein in any manner.\n\n- Further, it is specifically agreed to by the Parties that the headings shall have no legal or contractual value.\n\n- The Application has been designed by the Company to assist the User in connecting with other Users of the application, in providing technical accessibility between the Users, and creating a common platform wherein transactions between the Users are carried out in a seamless and efficient manner, using various third party products/services to be decided at the discretion of the Company, to be added to the Application from time to time, including but not limited to third party payment gateways ('Service'').The use of the Website and Application by the User is solely governed by these Terms read with the Privacy Policy and any modifications or amendments made thereto by the Company from time to time, at its sole discretion.\n\n- Accessing the Application and/or using any of the information or Services provided therein shall be deemed to signify the User's unequivocal acceptance of these Terms and the aforementioned Policy, and the User expressly agrees to be bound by the same, regardless of however the User or anyone on the User's behalf has accessed, installed, downloaded or used the Application.\n\n- The User expressly agrees and acknowledges that the Terms and Policy are co-terminus, and that expiry / termination of either one will lead to the termination of the other. The User may not access the Application or avail of any of the Services provided by the Company if the User does not accept and agree to be bound by the Terms and Policy.\n\n- In the event that the User or anyone acting on the User's behalf does not wish to be bound by the Terms and the Policy, the User (or the legal person/entity acting on the User's behalf) unequivocally agrees to refrain from accessing, using or retaining the Application on any device in any manner whatsoever.\n\n- The User agrees that anything done or caused to be done by the User or anyone acting on the User's behalf, whether expressly or impliedly in contravention with the Terms or Policy, will render the User liable for legal and punitive action.",
    "Acceptance of terms":
        "-  These Terms form an electronic contract that establishes legally binding terms that the User must accept to use the Service provided through the Application. \n\n- These Terms include by reference the Company's Policy, and any other terms disclosed and agreed to by the User in the event the User purchases or accepts additional features, products or services in addition to the Service, including but not limited to terms governing features, billing, free trials, discounts, promotions, etc.\n\n- The User is aware and agrees that the Company reserves the sole and exclusive right to amend or modify these Terms without any prior permission or intimation to the User, and the User expressly agrees that any such amendments or modifications shall come into effect immediately. \n\n- The User has a duty to periodically check the terms and stay updated on its requirements. \n\n- If the User continues to use the Application following such a change, the User will be deemed to have consented to any and all amendments / modifications made to the Terms. \n\n- In so far as the User complies with these Terms, he/she is granted a personal, non-exclusive, non-transferable, revocable, limited privilege to access and use the Application.",
    "Eligibility":
        "-  The User represents and warrants that he/she is competent and eligible to enter into legally binding agreements and that he/she has the requisite authority to bind himself/herself to these Terms, as determined solely by the provisions of the Indian Contract Act, 1872. \n\n- The User may not use the Application if he/she is not competent to contract under the Indian Contract Act, 1872, or is disqualified from doing so by any other applicable law, rule, regulation or judicial order/verdict currently in force.",
    "Creation of an account and registration":
        "-  In order to use Service, the User must first provide certain details to the Company through the Application, including but not limited to the User's name, age, sex, blood type, blood requirement, eligibility, mobile phone number, email address, photographs, user name, password, geographical location, etc., to create an account that can subsequently be used to avail of the Service.\n\n- The User agrees that all information provided to the Company shall be accurate to the best of the User's knowledge, belief and information, and shall be updated whenever appropriate, in a timely manner.\n\n- The User hereby authorises the Company to access and use any and all such information provided, as governed by these Terms and the Policy.",
    "Term and termination":
        "-  These Terms will remain in full force and effect while the User avails of the Service and/or is in possession of an active account. The User is aware that the Company may terminate or suspend the User's account at any time, without cause or notice, if the Company believes that the User has breached the Terms or Policy, or for any other reason, in its sole discretion.\n\n- The User is further aware and expressly agrees that even after the User's account is terminated for any reason, these Terms and the Policy shall survive such termination, and continue to operate in full force and effect, except for any terms that by their nature expire or are fully satisfied.",
    "Non-commercial use by users":
        "-  The Service is only for the personal use of the User.\n\n- The User may not use the Service or any content contained in the Service (including, but not limited to, content of other users or establishments, designs, text, graphics, images, video, information, logos, software, audio files and computer code) in connection with any commercial endeavours, including but not limited to advertising or soliciting any User to buy or sell any products or services not offered by the Company or through the Application.\n\n- The User may not use any information obtained from the Service to contact, advertise to, solicit, or sell any product/service to any other User, either within the Application or otherwise. Organizations, companies, and/or businesses may not use the Application or the Service for any purpose.\n\n- The Company may investigate and take any available legal action in response to illegal and/or unauthorized uses of the Service, including the collection of usernames and/or email addresses of other users by electronic or other means, for the purpose of sending unsolicited email and unauthorized framing of or linking to the Application or Service.",
    "Account security":
        "-  The User is responsible for maintaining the confidentiality of his/her username and password, assigned to the User during the registration process, and the User is solely responsible for all activities that occur under the User's username and password.\n\n- The User agrees to immediately notify the Company of any disclosure or unauthorized use of the User's username or password, or any other breach of security with respect to the User's account, and also ensure that he/she logs out from his/her account at the end of each session.",
    "Interaction with other users":
        "-  The User agrees and acknowledges that the User is solely responsible for his/her interactions with other users.\n\n- The User understands that the Company does not conduct any background checks, medical checks or screenings on any of its Users.\n\n- The User is further aware that the Company also does not inquire into the backgrounds of any of its users, or attempt to verify the statements of its Users.\n\n- The Company makes no representations or warranties as to the conduct of its Users, or the information / material made available by them to other Users, and the User expressly agrees and acknowledges that the Company will not be liable for the same in any manner whatsoever.",
    "Proprietary rights":
        "-  The User is aware that the Company owns and retains all proprietary rights in the Application and Service, and in all content, trademarks, trade names, service marks and other intellectual property rights related thereto.\n\n- The Application and Service contain the copyrighted material, trademarks, and other proprietary information of the Company, and the User agrees not to copy, modify, transmit, create any derivative works from, make use of, or reproduce in any way any copyrighted material, trademarks, trade names, service marks, or other intellectual property or proprietary information accessible through the Service, without first obtaining the prior written consent of the Company.",
    "Content posted by the user":
        "-  The User acknowledges and agrees that he/she is solely responsible for the content and information that he/she posts, uploads, publishes, links to, transmits, records, displays or otherwise makes available on the Service or transmits to other users, including text messages, chat, photographs, whether posted on the Website or Application, or privately transmitted to other Users.\n\n- The User may not Post as part of the Service, or transmit to the Company or to any other user (either on or off the Service), any offensive, inaccurate, incomplete, abusive, obscene, profane, threatening, intimidating, harassing, racially offensive, or illegal material, or any material that infringes or violates another person's rights (including intellectual property rights, and rights of privacy and publicity).\n\n- The User represents and warrants that all information that the User submits upon creation of the account is accurate and truthful, and that the User will promptly update any information that subsequently becomes inaccurate, incomplete, misleading or false.\n\n- The User understands and agrees that the Company may, but is not obligated to, monitor or review any content the User posts as part of the Service.\n\n- The Company may delete any content, in whole or in part, that in the sole judgment of the Company violates these Terms or may harm the reputation of the Application, Website, Service or Company.\n\n- The User may not post, upload, display or otherwise make available contents.",
    "Prohibited Activities":
        "*  Impersonate any person or entity.\n\n* Post any content that is prohibited by these Terms or any applicable law currently in force.\n\n*  Stalk or otherwise harass any person.express or imply that any statements the User makes are endorsed by the Company without the Company's specific prior written consent.\n\n*  Use the Service in an illegal manner or to commit an illegal act.\n\n* Ask or use users to conceal the identity, source, or destination of any illegally gained money or products.\n\n*  Use any robot, spider, site search/retrieval application, or other manual or automatic device or process to retrieve, index, 'data mine', or in any way reproduce or circumvent the navigational structure or presentation of the Service or its contents.\n\n* Collect usernames and/or email addresses of users by electronic or other means for the purpose of sending unsolicited email or unauthorized framing of or linking to the Service.\n\n*  Interfere with or disrupt the Service or the servers or networks connected to the Service.\n\n* Email or otherwise transmit any material that contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer software or hardware or telecommunications equipment.\n\n*  Forge headers or otherwise manipulate identifiers in order to disguise the origin of any information transmitted to or through the Service (either directly or indirectly through use of third party software),'frame' or 'mirror' any part of the Service, without the Company's prior written authorization.\n\n* Use meta tags or code or other devices containing any reference to the Company or the Service (or any trademark, trade name, service mark, logo or slogan of the Company) to direct any person to any other website for any purpose.modify, adapt, sublicense, translate, sell, reverse engineer, decipher, decompile or otherwise disassemble any portion of the Service any software used on or for the Service, or cause others to do so.post, use, transmit or distribute, directly or indirectly, (e.g. screen scrape) in any manner or media any content or information obtained from the Service other than solely in connection with the User use of the Service in accordance with these Terms",
    "Disclaimers":
        "-  The User acknowledges and agrees that neither the Company nor its affiliates or third party partners are responsible for, and shall not be deemed to have any liability - directly or indirectly, any loss or damage, including personal injury or death, as a result of or alleged to be the result of:any incorrect or inaccurate content posted in the Service, whether caused by users or any of the equipment or programming associated with or utilized in the Service/the timeliness, deletion or removal, incorrect delivery or failure to store any content, communications or personalization settings/the conduct, whether online or offline, of any user/any error, omission or defect in, interruption, deletion, alteration, delay in operation or transmission, theft or destruction of, or unauthorized access to, any user or user communications/any problems, failure or technical malfunction of any telephone network or lines, computer online systems, servers or providers, computer equipment, software, failure of email or any other online portal/facility on account of technical problems or traffic congestion on the Internet or at any website or combination thereof, including injury or damage to users or to any other person\'s computer or device related to or resulting from participating or downloading materials in connection with the Internet and/or in connection with the Service, and the User hereby expressly acknowledges and agrees that the Company has no responsibility or control over the same.\n\n-The User is aware and acknowledges that to the maximum extent allowed by applicable laws, the Company provides the Service on an 'as is' and 'as available' basis, and grants no warranties of any kind, whether express, implied, statutory or otherwise with respect to the Service (including all content contained therein), including (without limitation) any implied warranties of satisfactory quality, merchantability, fitness for a particular purpose or non-infringement. \n-The Company does not represent or warrant that the Service will be uninterrupted or error free, secure or that any defects or errors in the Service will be corrected.\n\n- The Company may make third party opinions, advice, statements, offers, or other third party information or content available through the Service.\n\n- The User is aware that all such third party content is the responsibility of the respective authors thereof, and the Company does not make any warranties or guarantees with respect to the same.\n\n- The User is further aware that the Company does not:guarantee the accuracy, completeness, or usefulness of any third party content provided through the Service, or/adopt, endorse or accept responsibility for the accuracy or reliability of any opinion, advice, or statement made by any party that appears in the Service. \n- The User agrees and acknowledges that under no circumstances will the Company or its affiliates be responsible or liable for any loss or damage resulting from the user reliance on information or other Content posted in the Service, or transmitted to or by any users.",
    "Limitation of liability":
        "- To the fullest extent allowed by applicable law, in no event will the Company, or its affiliates be liable to the User or any third person for any indirect, reliance, consequential, exemplary, incidental, special or punitive damages, including, without limitation, loss of goodwill, damages for loss, corruption or breaches of data or programs, service interruptions and procurement of substitute services, even if the Company has been advised of the possibility of such damages.",
    "Information collected from users device":
        "-  The User is aware and hereby expressly acknowledges and agrees that the Company may access, store and disseminate information collected from the User\'s device through the Application, whether or not such information/material is supplied directly by the User or has been collected by the Application, including without limitation the User\'s geographical location, pictures, videos, contacts, chat transcriptions and web browsing history.",
    "Collection of personal and other information":
        "- The User is aware and acknowledges that the Company collects and stores the User’s personal information, which is provided by the User from time to time through the Application, including but not limited to the User’s user name, passwords, email address, name, address, age, date of birth, sex, nationality, geographical location, web browsing history, etc., as well as any images, chat messages or other information uploaded / published by the User through the Application.\n\n- The User is aware that this information will be used by the Company/Application to provide services and features targeted at the User, that are most likely to meet the User’s needs, and also to customize and improve the Application to make its users’ experiences safer and easier.\n\n- The User is aware that the Company/Application may automatically track certain information about the User, based upon but not limited to, the User’s IP address and the User’s use of the Application, and the User expressly consents to the same. \n\n- The User is expressly made aware that such information may include the browsing history of the User, whether or not a part of/through the ApplicationIf the User chooses to avail of the Service through the Application, the User consents to allowing the Company/Application to collect information about the User’s behaviour and trendsThe User is aware that any and all information pertaining to the User collected by the Company, whether or not directly provided by the User to the Company/Application, including but not limited to personal correspondence such as emails, feedback from other users or third parties regarding the User’s activities or postings on the Application, etc., may be collected and complied by the Company/Application into a file/folder specifically created for / allotted to the User, and the User hereby expressly consents to the sameThe User is aware that while he/she may be able to browse/access some sections/features of the Application without being a registered user, certain activities, including but not limited to availing of the Service may require the User to provide valid personal information to the Company/Application for the purpose of registration",
    "User's Consent":"- By using the Application and/ or by providing information to the Company through the Application, the User consents to the collection and use of the information disclosed by the User on the Application in accordance with this Policy, including but not limited to the User’s consent to the Company/Application sharing/divulging the User’s information, as per the terms contained herein.",
    "Grievance Officer":"-  In accordance with Information Technology Act, 2000 and rules made there under, the contact details of the Grievance Officer are provided below: Grievance Officer",
    "Dispute Resolution & Jurisdiction":"-  It is expressly agreed to by the Parties hereto that the formation, interpretation and performance of this Policy and any disputes arising therefrom will be resolved through a two-step Alternate Dispute Resolution (“ADR”) mechanism. It is further expressly agreed to by the Parties that the contents of this Section shall survive even after the termination or expiry of the Policy and/or Terms.\n    * Mediation: In case of any dispute between the parties, the Parties will attempt to resolve the same amicably amongst themselves, to the mutual satisfaction of both Parties. In the event that the Parties are unable to reach such an amicable solution within thirty (30) days of one Party communicating the existence of a dispute to the other Party, the dispute will be resolved by arbitration, as detailed hereinbelow.\n    *Arbitration. In the event that the Parties are unable to amicably resolve a dispute by mediation, said dispute will be referred to arbitration by a sole arbitrator to be appointed by the Company, and the award passed by such sole arbitrator will be valid and binding on both Parties.",
  };
  int _current = 0;//to control page indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text(
            'Terms & Conditions',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.red[400],
          leading: InkWell(child:Icon(Icons.arrow_back_ios),onTap: (){
            Navigator.pop(context);
          }),
          elevation: 0.0,
        ),
        body: Container(
            decoration:ut.bg(),  //background image
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                cs=CarouselSlider(          //for sliding containers
                  height: 400,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  pauseAutoPlayOnTouch: Duration(seconds: 10),
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  items: h.map((s) {          //for each headings a container is returned
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 600,
                          margin: EdgeInsets.all(20),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(   //to give double color
                                colors: [Colors.red[900], Colors.red],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          child: ListView(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //title
                                  Text(
                                    s,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //content of each title
                                  Text(
                                    d[s],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15,letterSpacing: 1.0,height: 1.5),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[

                      InkWell(child:
                      ut.roundicon(Icons.keyboard_arrow_left,
                          Colors.white, Colors.grey[700], 30, 2),
                      onTap: (){prev();},),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(h,(index,s){
                    return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,color: _current==index?Colors.red[900]:Colors.grey
                        ),
                    );
                  }),
                ),
                      InkWell(child:
                      ut.roundicon(Icons.keyboard_arrow_right,
                          Colors.white, Colors.grey[700], 30, 2),
                        onTap: (){next();},),
                ]
                ),
                SizedBox(height: 20,),
              ],
            )));
  }
  //function to add page indicator
  List<T> map<T>(List list,Function handler){
    List<T> result=[];
    for(var i=0;i<list.length;i++){
      result.add(handler(i,list[i]));
    }
          return result;

  }
  //function to navigate to the previous slide
  prev(){
    cs.previousPage(duration: Duration(milliseconds: 300),curve: Curves.decelerate);
  }
  //function to navigate to the next slide
  next(){
    cs.nextPage(duration: Duration(milliseconds: 300),curve: Curves.decelerate);
  }
}
