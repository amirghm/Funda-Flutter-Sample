# Funda-Sample-App
![Funda Sample App Icon](https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/funda.jpg)

This application aims to show a detail of apartment fetched from funda.nl apis. It was written by **Flutter** in Android Studio and created by **MVVM Architecture** and **Repository Pattern**.
It gets data from [Appartment Detail](https://partnerapi.funda.nl/feeds/Aanbod.svc/json/detail/ac1b0b1572524640a0ecc54de453ea9f/koop/4e8f2f68-442e-4014-9f99-339127f1dafe/) and shows it inside a detail screen and you can scroll and interact with information, see images and call to the real estate.


## Table of Contents

- [Structure](#structure)
- [Testing](#testing)
- [Libraries](#libraries)
- [Screenshots](#screenshots)

## Structure
The application has four main parts which responsible for managing applications.  
```data``` ```resources``` ```screen``` ```utils``` 

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/structure.png"/>

### Data
In this part we have our ```Models```, which distinct into two parts (at this code), **Simple Models** and **Response Models**. Another part is ```Repository``` which contains one  Repository class for getting information. we have also a local repository which handled by shared prefrences and used to store locale.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/data.png"/>

### Resources
This package handles all needed resources for the app including ```String```, ```App Colors```, ```Styles``` and some ```Placeholders```. With language auto changing feature, the application language is changes so simple by changing the app locale. We have also one constant file to store our hardcoded Key and Id which needed for fetching data.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/resources.png"/>

### Screens
The application is hosted by four main **Screens** , ```Home```, ```Gallery```, ```Splash``` and ```WebView```. For every application we need some setups and initialization, I use **Splash** page for initialize application and load necessary components. We have one internal **WebView** for loading urls inside the application. The **Gallery** page is used to Show appartment images, you can slide between them and zoom on them. the last and most important page is **Home**. This page responsible for representing the appartment details and fetch it.
We have also one **ViewModel** class for Home screen for getting data from server and manage application data and state.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screens.png"/>

### Utils

In this part we keep some useful utils to simplify some processes. The ```Network``` part which have some useful classes. it contains ```network_service``` and ```exception``` which are responsible for any api calls. The ```response_provider``` is a very good helper class which can represent responses from an api call, it can carry the data and error and you can set state to it and use it into the ui. we have a ```hidable_app_bar``` part which have one class for handling hiding app bar with a smooth animation. and the last class is ```utils``` which contains some function for handling time and currency format.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/utils.png"/>

## Testing

In this project we have 4 type of test, **Widget Test**, **Model Test**, **Repository Test** and **View Model Test**. We use ```Mockito``` to mock the http client and repository and write test for fetching success and failed case. and also some test are written to checking Screen Loading successfully. I write some Unit tests for HouseResponseModel.

We use same hierarchy for the tests like the **lib** folder.

The test instrumentation app uses modules that have been swapped with fakes for
the network module to run requests on localhost with mockwebserver, removes flakiness compared to relying on actual data from the real server aspects such as internet connection or network service might bring up issues.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/tests.png"/>

## Libraries

Libraries used in the whole application are:

- [shared_preferences](https://pub.dev/packages/shared_preferences) - With this library we handle locale storage for the application.
- [carousel_slider](https://pub.dev/packages/carousel_slider) - This library used for creating slides for the appartment photos.
- [photo_view](https://pub.dev/packages/photo_view) - This library used for handling fullscreen gallery.
- [cached_network_image](https://pub.dev/packages/cached_network_image) - Used for loading images and cache them.
- [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator) - With this library we show dots indicator for the slider.
- [dismissible_page](https://pub.dev/packages/dismissible_page) - We use this for handling dismiss function for the gallery by swiping.
- [okhttp-logging-interceptor](https://pub.dev/packages/logging) - logs HTTP request and response data.
- [share](https://pub.dev/packages/share) - With this library we share the images from the gallery.
- [flutter_cache_manager](https://pub.dev/packages/flutter_cache_manager) - With this library we can obtain cached image file and share it with **share** library.
- [flutter_html](https://pub.dev/packages/flutter_html) - Some of contents of api are in Html format, I use this library to support that contents.
- [expand_widget](https://pub.dev/packages/expand_widget) - With this library we handle Expandable description of apparments which can be a long text.
- [url_launcher](https://pub.dev/packages/url_launcher) - With this library we can request a Dial function of home owner.
- [provider](https://pub.dev/packages/provider) - With this library we handle states of app and use it as a dependancy injection tool too.
- [mockito](https://pub.dev/packages/mockito) - With this library we mock http client and repository for test purposes.
- [build_runner](https://pub.dev/packages/build_runner) - By Helping this library we can create mockito necessary.

## Screenshots

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot2.jpg" width=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot4.jpg" width=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot5.jpg" width=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot3.jpg" width=200>
<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot1.jpg" height=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot6.jpg" width=200> 
