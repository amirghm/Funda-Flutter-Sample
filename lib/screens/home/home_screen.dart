import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:funda_sample/resources/resources.dart';
import 'package:funda_sample/screens/gallery/photo_gallery_screen.dart';
import 'package:funda_sample/screens/home/home_viewmodel.dart';
import 'package:funda_sample/utils/utils.dart';
import 'package:funda_sample/screens/webview/webview_screen.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const HOME_ROUTE = '/Home';

  @override
  _HomeScreenState createState() => _HomeScreenState();

  static void open(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), ModalRoute.withName(HOME_ROUTE));
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin<HomeScreen> {

  AnimationController? _hideFabAnimation;
  late HomeViewModel viewModel;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
              _hideFabAnimation?.forward();
            }
            break;
          case ScrollDirection.reverse:
            if (userScroll.metrics.maxScrollExtent != userScroll.metrics.minScrollExtent) {
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

    initViewModel();
    fetchHouseDetails();
    initFabAnimation();
  }

  initViewModel() {
    viewModel = Provider.of<HomeViewModel>(context, listen: false);
  }

  initFabAnimation() {
    _hideFabAnimation = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  fetchHouseDetails() async {
    await viewModel.fetchHouseDetails();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(backgroundColor: Colors.white, appBar: _appBarWidget(), body: _bodyWidget(), floatingActionButton: _fabWidget()),
    );
  }

  _appBarWidget() {
    return AppBar(
      backgroundColor: Resources.APP_PRIMARY_COLOR,
      title: Hero(tag: 'logo', child: Image.asset('assets/ic_splash_logo.png', height: 24)),
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
                child: ColorFiltered(colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn), child: Image.asset('assets/ic_redirect.png')),
              )),
        ),
      ],
      brightness: Brightness.dark,
    );
  }

  _bodyWidget() {
    return Consumer<HomeViewModel>(
      builder: (_, __, ___) =>
          Container(
            color: Colors.grey[100],
            child: viewModel.houseDetails.isCompleted()
                ? Scrollbar(
              isAlwaysShown: false,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    _imageSliderWidget(),
                    _detailsWidget(),
                  ],
                ),
              ),
            )
                : viewModel.houseDetails.isLoading()
                ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: new AlwaysStoppedAnimation<Color>(Resources.APP_ACCENT_COLOR),
              ),
            )
                : Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorFiltered(
                          colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
                          child: Image.asset(
                            'assets/ic_no_signal.png',
                            width: 80,
                          )),
                      Text(
                        Resources.getString(
                          'general__network_error',
                        ),
                        style: Resources.getNormalTextStyle(),
                      ),
                      SizedBox(height: 12),
                      MaterialButton(
                        child: Text(
                          Resources.getString('home__try_again'),
                          style: Resources.getNormalLightTextStyle(),
                        ),
                        onPressed: () => fetchHouseDetails(),
                        color: Resources.APP_PRIMARY_COLOR,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
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
    return (viewModel.houseDetails.data?.isPhotoAvailable ?? false)
        ? Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              viewModel.currentPhotoIndex.value = index;
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
          items: viewModel.houseDetails.data?.photos?.map((media) {
            return Builder(
              builder: (BuildContext context) {
                return Hero(
                  tag: 'photo-' + (media.id ?? ''),
                  child: GestureDetector(
                    onTap: () => handleOnSlidePhotoClicked(),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: (media.imageUrl == null)
                          ? Container(
                        color: Colors.grey,
                        height: 200,
                      )
                          : CachedNetworkImage(
                        imageUrl: media.imageUrl!,
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
            maxWidth: MediaQuery
                .of(context)
                .size
                .width, // minimum width
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
        (viewModel.houseDetails.data?.isPhotoAvailable ?? false)
            ? ValueListenableBuilder(
          valueListenable: viewModel.currentPhotoIndex,
          builder: (_, __, ___) =>
              Container(
                padding: EdgeInsets.only(bottom: 4),
                alignment: Alignment.bottomCenter,
                child: AnimatedSmoothIndicator(
                  activeIndex: viewModel.currentPhotoIndex.value,
                  count: viewModel.houseDetails.data!.photos!.length,
                  effect: ScrollingDotsEffect(
                    dotColor: Colors.white54,
                    activeDotColor: Resources.APP_PRIMARY_COLOR,
                    dotWidth: 8,
                    dotHeight: 8,
                  ),
                ),
              ),
        )
            : Container(),
        (viewModel.houseDetails.data?.isPhotoAvailable ?? false)
            ? ValueListenableBuilder(
          valueListenable: viewModel.currentPhotoIndex,
          builder: (_, __, ___) =>
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                alignment: Alignment.bottomRight,
                child: Text(
                  Resources.getStringWithPlaceholder('photo_gallery__count_indicator',
                      [(viewModel.currentPhotoIndex.value + 1).toString(), viewModel.houseDetails.data?.photos?.length.toString()]),
                  style: Resources.getNormalLightTextStyle(),
                ),
              ),
        )
            : Container()
      ],
    )
        : Container(
      height: 200,
      width: MediaQuery
          .of(context)
          .size
          .width,
      color: Colors.grey[300],
      child: Center(
        child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
            child: Image.asset(
              'assets/ic_home.png',
              width: 60,
              fit: BoxFit.contain,
            )),
      ),
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
    if (viewModel.houseDetails.data == null) return Container();
    late var houseModel = viewModel.houseDetails.data!;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          houseModel.adres != null && houseModel.adres!.isNotEmpty
              ? Container(
              padding: EdgeInsets.only(left: 16, bottom: 8), child: Text(viewModel.houseDetails.data!.adres!, style: Resources.getTitleStyle()))
              : Container(),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(children: [
                        houseModel.woonOppervlakte != null
                            ? _featuresWidget(
                            'assets/ic_meter.png', Resources.getStringWithPlaceholder('home__mm', [houseModel.woonOppervlakte!.toString()]))
                            : Container(),
                        SizedBox(width: 8),
                        houseModel.aantalKamers != null
                            ? _featuresWidget(
                            'assets/ic_bed.png', Resources.getStringWithPlaceholder('home__rooms', [houseModel.aantalKamers!.toString()]))
                            : Container(),
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Row(
                        children: [
                          houseModel.aantalBadkamers != null
                              ? _featuresWidget('assets/ic_bathroom.png',
                              Resources.getStringWithPlaceholder('home__bathrooms', [houseModel.aantalBadkamers!.toString()]))
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => handleOnMapClicked(),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Card(elevation: 2, child: Image.asset('assets/ic_show_on_map.png', width: 60))),
              )
            ],
          ),
          houseModel.koopPrijs != null
              ? Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text(
              Resources.getStringWithPlaceholder('home__price_formatted', [getCurrencyFormat(houseModel.koopPrijs)]),
              style: Resources.getTitleStyle(),
            ),
          )
              : Container()
        ],
      ),
    );
  }

  _featuresWidget(String asset, String value) {
    return Row(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
          child: Image.asset(
            asset,
            width: 16,
          ),
        ),
        Html(
          shrinkWrap: true,
          data: value,
          style: {'body': Style(color: Colors.grey[700]), 'b': Style(color: Colors.black)},
        )
      ],
    );
  }

  _descriptionWidget() {
    return viewModel.houseDetails.data?.volledigeOmschrijving != null && viewModel.houseDetails.data!.volledigeOmschrijving!.isNotEmpty
        ? Column(
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
            viewModel.houseDetails.data!.volledigeOmschrijving ?? '',
          ),
        ),
      ],
    )
        : Container();
  }

  _specificationWidget() {
    return viewModel.houseDetails.data?.kenmerken != null
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 8),
          child: Text(
            Resources.getString('home__specification'),
            style: Resources.getTitleStyle(),
          ),
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.houseDetails.data!.kenmerken!.length,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(viewModel.houseDetails.data!.kenmerken![index].titel ?? '-', style: Resources.getMediumStyle()),
                    SizedBox(height: 8),
                    Divider(),
                    viewModel.houseDetails.data!.kenmerken![index].kenmerken != null
                        ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.houseDetails.data!.kenmerken![index].kenmerken!.length,
                        itemBuilder: (context, subIndex) {
                          return Container(
                            child: Column(
                              children: [
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Text(viewModel.houseDetails.data!.kenmerken![index].kenmerken![subIndex].naam ?? '',
                                            style: Resources.getNormalTextStyle())),
                                    Expanded(
                                        flex: 3,
                                        child: Html(
                                            data: viewModel.houseDetails.data!.kenmerken![index].kenmerken![subIndex].waarde ?? '',
                                            style: {"body": Style(color: Resources.APP_BODY_COLOR)}))
                                  ],
                                ),
                                SizedBox(height: 8),
                                Divider()
                              ],
                            ),
                          );
                        })
                        : Container()
                  ],
                ),
              );
            }),
      ],
    )
        : Container();
  }

  handleOnMapClicked() {
    if (viewModel.houseDetails.data == null || viewModel.houseDetails.data!.makelaarTelefoon == null) return;
    WebViewScreen.open(context, viewModel.houseDetails.data!.adres ?? '', viewModel.houseDetails.data!.url! + '#kaart');
  }

  handleOnCallClicked() async {
    if (viewModel.houseDetails.data == null || viewModel.houseDetails.data!.makelaarTelefoon == null) return;
    launch('tel://' + viewModel.houseDetails.data!.makelaarTelefoon!);
  }

  handleOnRedirectClicked() {
    if (viewModel.houseDetails.data == null || viewModel.houseDetails.data!.url == null) return;
    WebViewScreen.open(context, viewModel.houseDetails.data!.adres ?? '', viewModel.houseDetails.data!.url!);
  }

  handleOnSlidePhotoClicked() {
    if (viewModel.houseDetails.data == null || viewModel.houseDetails.data!.photos == null) return;
    PhotoGalleryScreen.open(context, viewModel.houseDetails.data!.photos!, viewModel.currentPhotoIndex.value, 'photo');
  }
}
