import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fund_sample/data/models/media.dart';
import 'package:fund_sample/data/models/media_item.dart';
import 'package:fund_sample/data/models/responses/house.dart';
import 'package:fund_sample/data/repository/remote/house_repository.dart';
import 'package:fund_sample/resources/constants.dart';
import 'package:fund_sample/resources/resources.dart';
import 'package:fund_sample/screens/gallery/photo_gallery_screen.dart';
import 'package:fund_sample/utils/network/network_service.dart';
import 'package:fund_sample/utils/utils.dart';
import 'package:fund_sample/screens/webview/webview_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const HOME_ROUTE = '/Home';

  @override
  _HomeScreenState createState() => _HomeScreenState();

  static void open(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        ModalRoute.withName(HOME_ROUTE));
  }
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin<HomeScreen> {
  double mapElevation = 2;
  AnimationController? _hideFabAnimation;

  var currentPhotoIndex = 0;
  var photos = [
    'http://cloud.funda.nl/valentina_media/146/898/180_groot.jpg',
    'http://cloud.funda.nl/valentina_media/146/898/184_groot.jpg',
    'http://cloud.funda.nl/valentina_media/146/898/187_groot.jpg',
    'http://cloud.funda.nl/valentina_media/146/898/188_groot.jpg',
    'http://cloud.funda.nl/valentina_media/146/898/192_groot.jpg',
    'http://cloud.funda.nl/valentina_media/146/898/193_groot.jpg',
  ];

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation?.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent !=
                userScroll.metrics.minScrollExtent) {
              _hideFabAnimation?.reverse();
            }
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    initFabAnimation();
  }

  initFabAnimation() {
    _hideFabAnimation =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  Widget build(BuildContext context) {

    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBarWidget(),
          body: _bodyWidget(),
          floatingActionButton: _fabWidget()),
    );
  }

  _appBarWidget() {
    return AppBar(
      backgroundColor: Resources.APP_PRIMARY_COLOR,
      title: Hero(
          tag: 'logo',
          child: Image.asset('assets/ic_splash_logo.png', height: 24)),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: InkWell(
              customBorder: CircleBorder(),
              onTap: () => handleOnRedirectClicked(),
              child: Container(
                padding: EdgeInsets.all(10),
                width: 40,
                height: 40,
                child: ColorFiltered(
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    child: Image.asset('assets/ic_redirect.png')),
              )),
        ),
      ],
      brightness: Brightness.dark,
    );
  }

  _bodyWidget() {
    return Container(
        color: Colors.grey[100],
        child: SingleChildScrollView(
          child: Column(
            children: [
              _imageSliderWidget(),
              _detailsWidget(),
            ],
          ),
        ));
  }

  _fabWidget() {
    return ScaleTransition(
      scale: _hideFabAnimation!,
      alignment: Alignment.bottomCenter,
      child: FloatingActionButton(
        child: Icon(
          Icons.call,
          color: Colors.white,
        ),
        onPressed: () => handleOnCallClicked(),
      ),
    );
  }

  _imageSliderWidget() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                currentPhotoIndex = index;
              });
            },
            height: 200.0,
            autoPlay: true,
            enlargeCenterPage: false,
            viewportFraction: 1,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
            autoPlayInterval: Duration(seconds: 16),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
          ),
          items: photos.map((image) {
            return Builder(
              builder: (BuildContext context) {
                return Hero(
                  tag: 'photo-' + image.hashCode.toString(),
                  child: GestureDetector(
                    onTap: () => handleOnSlidePhotoClicked(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.cover,
                        memCacheHeight: 500,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Container(
          constraints: BoxConstraints(
            minHeight: 20,
            maxWidth: MediaQuery.of(context).size.width, // minimum width
          ),
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  const Color(0x00000000),
                  Colors.black12,
                  Colors.black26,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 0.5, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 4),
          alignment: Alignment.bottomCenter,
          child: AnimatedSmoothIndicator(
            activeIndex: currentPhotoIndex,
            count: photos.length,
            effect: ScrollingDotsEffect(
              dotColor: Colors.white54,
              activeDotColor: Resources.APP_PRIMARY_COLOR,
              dotWidth: 8,
              dotHeight: 8,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          alignment: Alignment.bottomRight,
          child: Text(
            Resources.getStringWithPlaceholder('photo_gallery__count_indicator',
                [(currentPhotoIndex + 1).toString(), photos.length.toString()]),
            style: Resources.getNormalLightTextStyle(),
          ),
        )
      ],
    );
  }

  _detailsWidget() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _overviewWidget(),
            Divider(),
            _descriptionWidget(),
            Divider(),
            _specificationWidget(),
          ],
        ));
  }

  _overviewWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              child:
                  Text('Vondelstraat 51 hs', style: Resources.getTitleStyle())),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey[600]!, BlendMode.srcIn),
                          child: Image.asset(
                            'assets/ic_meter.png',
                            width: 16,
                          ),
                        ),
                        Html(
                          shrinkWrap: true,
                          data: Resources.getStringWithPlaceholder(
                              'general__mm', ['319']),
                          style: {
                            'body': Style(color: Colors.grey[700]),
                            'b': Style(color: Colors.black)
                          },
                        ),
                        SizedBox(width: 8),
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey[600]!, BlendMode.srcIn),
                          child: Image.asset(
                            'assets/ic_bed.png',
                            width: 16,
                          ),
                        ),
                        Html(
                          shrinkWrap: true,
                          data: Resources.getStringWithPlaceholder(
                              'home__rooms', ['7']),
                          style: {
                            'body': Style(color: Colors.grey[700]),
                            'b': Style(color: Colors.black)
                          },
                        ),
                      ]),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Row(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                Colors.grey[600]!, BlendMode.srcIn),
                            child: Image.asset(
                              'assets/ic_bathroom.png',
                              width: 16,
                            ),
                          ),
                          Expanded(
                              child: Html(
                                  data: Resources.getStringWithPlaceholder(
                                      'home__bathrooms', ['4']))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    mapElevation = 5;
                  });
                },
                onTapUp: (details) {
                  setState(() {
                    mapElevation = 2;
                  });
                },
                onTap: () => handleOnMapClicked(),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                        elevation: mapElevation,
                        child: Image.asset('assets/ic_show_on_map.png',
                            width: 60))),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              Resources.getStringWithPlaceholder(
                  'home__price_formatted', [getCurrencyFormat(3600000)]),
              style: Resources.getTitleStyle(),
            ),
          )
        ],
      ),
    );
  }

  _descriptionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Text(
            Resources.getString('home__description'),
            style: Resources.getTitleStyle(),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: ExpandText(
            '& English tekst below &\u000a\u000aZeer hoogwaardig gerenoveerd drie-laagse benedenwoning in half vrijstaande stadsvilla, met diepe tuin op het zuiden, entree aan voor -en zijkant, riant bijgebouw in de tuin (30m2), voortuin met prachtig hek en vele extra’s, gelegen aan een van de mooiste en meest chique straten van Amsterdam op circa 50m afstand van de ingang van het Vondelpark. \u000aTotale woonoppervlakte circa 290m2 en 30m2 tuinhuis. Deze laatste kan aangewend worden voor praktijk aan huis, atelier, werkplek, bergruimte, logeerplek, etc. Dit alles recent zeer hoogwaardig gerenoveerd met luxe materialen, inclusief funderingsherstel en uitbouw in 2019. \u000a\u000aDit oorspronkelijk door architect Van Arkel ontworpen huis uit 1899 heeft bij de grootschalige renovatie gelukkig nog heel veel originele stijlkenmerken behouden, zoals de oorspronkelijke paneeldeuren. Kosten noch moeite zijn gespaard gebleven om deze woning te realiseren. Zo zijn alle sanitaire ruimten en keuken met luxe materialen uitgevoerd, is er met een professioneel lichtplan en systeem gewerkt en zijn alle materialen en kleuren perfect op elkaar afgestemd. Er zijn twee luxe gashaarden in de woonkamers op de beletage en op de eerste verdieping in de studeerkamer is nog een derde gashaard. De beletage en 1e verdieping hebben een  eiken Hongaarse punt vloer. De souterrainverdieping, met keuken en appartement,  is met een gietvloer uitgerust. Dit huis (gemeentelijk monument) biedt een substantiële bijdrage aan de Amsterdamse Art-Nouveau architectuur, door onder meer haar bijzondere details in de voorgevel, balkon aan de straatzijde en de aanwezige erkers. De gemeenschappelijke buiten entree wordt omlijst door een zandstenen boog waarin de naam \"Johanna\" is opgenomen, vernoemd naar mevrouw Johanna Messschaert, een van de eerste bewoners. \u000a\u000aWELKOM\u000aVia een ruime voortuin aan de straatzijde,  hardstenen stoep en eigen entree naar de woning op de bel-etage wordt de woning betreden. In de entreegang is het oorspronkelijk aanwezige marmer gerestaureerd, vloerverwarming aanwezig en is de sierlijke trap voorzien van haar originele leuning naar de eerste verdieping. Er is een diepe bergingskast en garderobe onder de trap alsmede een gastentoilet. Aan de zijkant van het pand is een tweede entree; hiermee is de keuken aan de tuinzijde direct te betreden alsook het studio-appartement in het souterrain.\u000a\u000aWONEN\u000aDe overige deuren  in de gang op de bel-etage leiden naar het leefgedeelte, verdeeld over een voor -en achterkamer (ensuite) met beiden een gashaard alsmede een serre voorzien van een in 2019 geplaatste volledig geïsoleerde ruime raampartij welke een prachtig uitzicht geeft over de mooi aangelegde tuin en groen van andere tuinen. Openslaande deuren leiden naar een ruim terras op het zuiden. Dit terras staat via een stalen trap ook weer in verbinding met de tuin. Aan de voorzijde van de beneden verdieping is een aparte studio gerealiseerd, uitstekend geschikt als gastenverblijf, au-pair ruimte, slaapkamer, praktijk aan huis, etc. Deze studio beslaat circa 41m2 en omvat een eigen luxe keuken, eigen cv, badkamer en kan gebruik maken van de entree aan de zijkant van het huis.  \u000a\u000aKOKEN & TECHNIEK\u000aEr is een interne trap vanuit de bel-etage naar de leefkeuken in het souterrain. Deze is uitgebouwd en heeft onder het terras van de bel-etage een overdekt zitgedeelte met heaters. Er is een diepe gang met alle technische ruimten en bergingen, wijnklimaatkast en vrieskast, alsook een tweede gasten w.c. \u000aDe woonkeuken is tijdloos uitgevoerd in blauwstaal met marmer en een op maat gemaakt houten wandmeubel met diverse opbergruimtes en inbouwapparatuur zoals bijvoorbeeld stoomoven, ijskast etc. Het grote keukeneiland en werkblad met elektrische kookunit met afzuigsysteem bieden veel werkruimte, alsmede diverse ladeblokken en een Quooker. De apparatuur is o.a. van Gaggenau, Boretti, Miele en Liebherr. De keuken kan ook via de zijkant bereikt worden.\u000a\u000aSLAPEN & WERKKAMER\u000aDe eerste verdieping biedt een meer dan riante hoofdslaapkamer aan de achterzijde met wederom een serre met nieuwe glas pui voorzien van veel licht. Er is een inloopkast voor alle kleding en accessoires. Aan de voorzijde zijn nog twee kamers, waarvan de kleinere slaapkamer in verbinding staat met de grotere kamer. Deze wordt nu gebruikt als werkkamer en logeerkamer, maar kan uitstekend dienst doen als slaapkamer. De kleinere slaapkamer is ook aan de voorzijde gelegen. Beiden genieten een mooi uitzicht op de prachtige Vondelstraat.\u000a\u000aME-TIME\u000aAangrenzend aan de hoofdslaapkamer is de ruim bemeten badkamer voorzien van alle denkbare luxe. Een apart ligbad, inloopdouche, meubel en w.c. met kast. De vloer is als gietvloer uitgevoerd en de wanden zijn bekleed met luxe tegels. De twee slaapkamers aan de voorzijde hebben een eigen badkamer, compact maar heel compleet, met een douche en wastafel. Ook op deze verdieping is een aparte w.c. gesitueerd.\u000a\u000aNAAR BUITEN\u000aGenieten in de volste zin van het woord; de voortuin wordt sporadisch gebruikt als stalling voor de auto en geregeld voor de fietsen. Er is een laadpaal voor het opladen van de elektrische auto, maar er is geen vergunning voor het gebruik als zodanig.\u000aVia een eigen steeg en stalen hek wordt de achtertuin buitenom bereikt. Hier komt men in een oase van groen terecht, en vergeet je dat je in hartje Amsterdam woont. De brede tuin is prachtig aangelegd, met een onderhoudsvrij karakter en diverse zitjes. Doordat de zon vrij spel heeft wegens de zuidelijke ligging van de tuin, is er altijd wel een plekje om van de warmte te genieten, maar kan men ook beschut genieten in het verholen gedeelte grenzend aan de keuken.\u000a\u000aBIJGEBOUW\u000aDan nog het prachtige bijgebouw, compleet ingericht met keuken, natte cel, eigen CV en bergruimte voor tuinspullen en fietsen. De schuifpui die over de volle breedte open kan maakt het bijgebouw tot een prachtige buitenkeuken. Dit gebouw completeert de tuin door het sedum dak en maakt een ideale verbinding met het woongedeelte. In plaats van een begrenzing van het groen is er nu een extra gebruiksmogelijkheid van het huis en kan men volop genieten van deze strakke ruimte. \u000a\u000aVERENIGING VAN EIGENAREN \u000aDe Vereniging van Eigenaren omvat het pand Vondelstraat 51, verdeeld over 4 appartementsrechten. De servicekosten bedragen circa EUR 412,50 per maand. Het aandeel van deze woning is 660\/1000ste.\u000a\u000aGOED OM TE WETEN\u000aDit droomappartement is feitelijk zó te betreden. De gehele woning is voorzien van volledig nieuwe elektra, waterleidingen, riool, beveiliging en camera bewaking. Tussen de verdiepingen is geluidsisolerend materiaal aangebracht en voor zo ver mogelijk is tegen de buitenmuren isolerend materiaal aangebracht. \u000aHet geheel is voorzien van vloerverwarming onder een prachtige eiken parketvloer. Het gebouw is gelegen op eigen grond, dus geen erfpacht. Recent  is de fundering vernieuwd, zijn de goten vernieuwd, is het buitenschilderwerk verricht en zijn de buiten muren gerestaureerd en is de voor -en achtertuin aangelegd. Dat betekent dat de aankomende jaren er geen onderhoud verwacht wordt en alles in zeer goede staat verkeert. \u000a\u000aOMGEVING \u000aEigenlijk behoeft de locatie geen nadere duiding. Want de Vondelstraat spreekt een ieder tot de verbeelding en is ongetwijfeld een van de meest geliefde woonlocaties van Amsterdam. Hoe rustig en groen de straat zelf, de chique architectuur en daarmee de kapitaalkrachtige woningen die de straat rijk is, doet niet vermoeden dat er zoveel bruisends even verderop aanwezig is. Tal van winkels en eetgelegenheden, beiden enorm divers in hun soort en samenstelling,  zijn op loopafstand gelegen. Met uitstekende openbaar vervoersverbindingen en goede ontsluiting naar buiten via de nabijgelegen Overtoom. \u000a\u000aENGLISH TRANSLATION\u000a\u000aVery high standard renovated three-storey ground floorappartment in semi-detached town villa, with deep garden (south), entrance to front and side, spacious garden house in the garden (appr. 30m2), front garden with beautiful fence and many extras, located in one of the most beautiful and chic streets of Amsterdam about 50m away from the entrance to the Vondelpark. \u000aTotal living area approximately 290m2 and 30m2 garden house. The latter can be used for home practice, atelier, workplace, storage space, guest room, etc. All recently renovated to a very high quality with luxury materials, including new foundation glassdoors and extension in 2019. \u000aOriginally designed by architect Van Arkel in 1899, have fortunately been retained many original style features during the large-scale renovation, such as the original paneldoors. Costs nor efforts have been spared to realise this home. For example, all sanitary rooms and the kitchen were equipped with luxury materials, a professional lighting system was used and all materials and colours are matched perfectly. There are two luxury gas fireplaces in the living rooms on the bel-etage nd a third gas fire on the first floor in the study. The ground and first floor have an oak Hungarian point floor. The basement floor, with kitchen and flat, has a cast floor. This house (municipal monument) offers a substantial contribution to the Amsterdam Art-Nouveau architecture, through its special details in the front facade, balcony on the street side and the present bay windows. The communal exterior entrance is framed by a sandstone arch containing the name \"Johanna\", named after Mrs Johanna Messschaert, one of the first residents. \u000aWELCOME\u000aYou enter the house via a spacious front garden on the street side, stone pavement and private entrance to the residence on the ground floor. Here the original marble has been restored and the elegant staircase has its original banister to the first floor. There is a deep storage cupboard, cloakroom under the stairs and a guest toilet. A second entrance on the side of the property gives direct access to the kitchen on the garden side and to the studio in the basement.\u000aLIVING\u000aThe doors in the hallway on the entrance floor lead to the living area, divided into a front and back room (ensuite) both with a gas fireplace as well as a conservatory with a in 2019 installed fully insulated large window, which gives a beautiful view over the landscaped garden and greenery of other gardens. French doors lead to a spacious south-facing terrace. This terrace is also connected to the garden via a steel staircase. At the streetside of the ground floor a separate studio has been created, perfectly suitable as a guesthouse, au-pair room, bedroom, home practice, etc. This studio is approximately 41m2 and has its own luxury kitchen, own heating, bathroom and can use the entrance on the side of the house.  \u000aCOOKING & TECHNOLOGY\u000aThere is an internal staircase from the bel-etage to the kitchen in the souterrain. This has been extended and has a covered seating area with heaters underneath the terrace of the bel-etage. From this area you can also walk into the garden with small steps. A deep corridor offers all the technical rooms and storage areas, wine fridge and freezer, as well as a second guest toilet. \u000aThe kitchen is executed timelessly in blue steel with marble and a custom-made wooden wall unit with various storage spaces and built-in appliances such as steam oven, refrigerator etc. The large kitchen island and worktop with electric cooking unit with extractor system facilitates a lot of working space, as well as various drawer units and a Quooker. The appliances are from Gaggenau, Boretti, Miele and Liebherr, among others. The kitchen can also be reached from the side of the house.\u000aBEDROOM & STUDY\u000aThe first floor offers a more than spacious master bedroom at the rear with again a conservatory with new glass windows with lots of light and a spacious bathroom. There is a walk-in closet for all clothing and accessories. At the front are two more rooms, of which the smaller bedroom is connected to the larger room. This is now used as a study and guest room, but can perfectly serve as a bedroom. The smaller bedroom is also located at the front. Both enjoy a nice view of the beautiful Vondelstraat.\u000aME-TIME\u000aAdjacent to the master bedroom is the spacious bathroom equipped with every conceivable luxury. A separate bath, shower, washbasin with cupboard and toilet. The floor is a cast floor and the walls are covered with luxury tiles.\u000aThe two bedrooms at the front have their own bathroom, compact but very complete, with a shower and washbasin. Also on this floor is a separate toilet.\u000aLET’S GO OUTSIDE\u000aEnjoyment in the fullest sense of the word; the front garden is used sporadically as a parking place for the car and regularly for the bicycles. There is a charging station for electric car charging, but there is no permit for use as such.\u000aThrough an alley and steel gate, the back garden is accessed from the outside. Here one enters an oasis of green, and one forgets that you are living in the heart of Amsterdam. The wide garden is laid out under architecture, with a maintenance-free character and various seating areas. Because the sun has free reign on account of the southern location of the garden, there is always a place to enjoy the warmth, but one can also enjoy shelter in the concealed area adjacent to the kitchen.\u000aEXTERNAL BUILDING\u000aThen there is the beautiful annex, fully equipped with kitchen, bathroom, own CV and storage space for garden equipment and bicycles. The sliding doors that can be opened over the full width make the outbuilding a beautiful outdoor garden kitchen. This building completes the garden with its sedum roof and makes an ideal connection with the living area. \u000aASSOCIATION OF OWNERS \u000aThe Owners\' Association comprises the building Vondelstraat 51, divided into 4 apartment rights. The service costs are approximately EUR 412,50 per month. The share of this property is 660\/1000th .\u000aGOOD TO KNOW\u000aThis dream house is actually ready to move into. The whole property is equipped with completely new electrics, water pipes, sewerage, security and camera surveillance. Soundproofing material has been applied between the floors and insulating material has been applied to the outside walls as far as possible. \u000aThe whole property has underfloor heating under a beautiful oak parquet floor. The building is located on private land, so no leasehold. Recently, the foundation has been renewed, the gutters have been renewed, the exterior paintwork has been done and the exterior walls have been restored and the front and back gardens have been landscaped. This means that for the next few years no maintenance is expected and everything is in very good condition. \u000aSURROUNDINGS \u000aActually, the location needs no further explanation. Vondelstraat speaks to everyone\'s imagination and is undoubtedly one of the most popular residential locations in Amsterdam. How quiet and green the street itself, the chic architecture and thus the wealthy residences it contains, does not suggest that there is so much liveliness (shops and restaurants) and the Vondelpark so close.\",\"Voorzieningen":\"alarminstallatie en mechanische ventilatie',
          ),
        ),
      ],
    );
  }

  _specificationWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Text(
            Resources.getString('home__specification'),
            style: Resources.getTitleStyle(),
          ),
        ),
        Column(
          children: List.generate(2, (index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Spec', style: Resources.getMediumStyle()),
                  SizedBox(height: 8),
                  Divider(),
                  Column(
                    children: List.generate(3, (subIndex) {
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Text('Name',
                                        style: Resources.getNormalTextStyle())),
                                Expanded(
                                    flex: 2,
                                    child: Text('Value',
                                        style: Resources.getNormalTextStyle()))
                              ],
                            ),
                            SizedBox(height: 8),
                            Divider()
                          ],
                        ),
                      );
                    }),
                  )
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  handleOnMapClicked() {
    WebViewScreen.open(context, 'Vondelstraat 51 hs',
        'https://www.funda.nl/koop/amsterdam/appartement-42418369-vondelstraat-51-hs/#kaart');
  }

  handleOnCallClicked() async {
    launch('tel://' + '2523432523');
  }

  handleOnRedirectClicked() {
    WebViewScreen.open(context, 'Vondelstraat 51 hs',
        'https://www.funda.nl/koop/amsterdam/appartement-42418369-vondelstraat-51-hs/');
  }

  handleOnSlidePhotoClicked() {
    PhotoGalleryScreen.open(
        context,
        photos
            .map((e) => Media(
                    id: e.hashCode.toString(),
                    categorie: Media.MEDIA_IMAGE_CATEGORY,
                    mediaItems: [
                      MediaItem(
                          category: MediaItem.IMAGE_ITEM_SELECTED_CATEGORY,
                          url: e)
                    ]))
            .toList(),
        currentPhotoIndex,
        'photo');
  }
}
