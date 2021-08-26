# Funda-Sample-App
![Funda Sample App Icon](https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/funda.jpg)

This application aims to show a detail of the apartment fetched from funda.nl APIs. It was written by **Flutter** in Android Studio and created by **MVVM Architecture** and **Repository Pattern**.
It gets data from [Appartment Detail](https://partnerapi.funda.nl/feeds/Aanbod.svc/json/detail/ac1b0b1572524640a0ecc54de453ea9f/koop/4e8f2f68-442e-4014-9f99-339127f1dafe/) and shows it inside a detailed screen and you can scroll and interact with information, see images, and call to the real estate.


## Table of Contents

- [Structure](#structure)
- [Testing](#testing)
- [Libraries](#libraries)
- [Screenshots](#screenshots)

## Structure
The application has four main parts which are responsible for managing applications.  
```data``` ```resources``` ```screen``` ```utils``` 

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/structure.png"/>

### Data
In this part we have our ```Models```, which are distinct into two parts (at this code), **Simple Models** and **Response Models**. Another part is ```Repository``` which contains one  Repository class for getting information. we have also a local repository that is handled by shared preferences and used to store locale.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/data.png"/>

### Resources
This package handles all needed resources for the app including ```String```, ```App Colors```, ```Styles``` and some ```Placeholders```. With the language auto changing feature, the application language is changing so simply by changing the app locale. We have also one constant file to store our hardcoded Key and Id which is needed for fetching data.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/resources.png"/>

### Screens
The application is hosted by four main **Screens**, ```Home```, ```Gallery```, ```Splash``` and ```WebView```. For every application we need some setups and initialization, I use the **Splash** page to initialize the application and load necessary components. We have one internal **WebView** for loading URLs inside the application. The **Gallery** page is used to Show apartment images, you can slide between them and zoom on them. the last and most important page is **Home**. This page is responsible for representing the apartment details and fetches them.
We have also one **ViewModel** class for the Home screen for getting data from the server and manage application data and state.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screens.png"/>

### Utils

In this part, we keep some useful utils to simplify some processes. The ```Network``` part has some useful classes. it contains ```network_service``` and ```exception``` which are responsible for any API calls. The ```response_provider``` is a very good helper class that can represent responses from an API call, it can carry the data and error and you can setState to it and use it into the UI. we have a ```hidable_app_bar``` part which has one class for handling hiding app bar with a smooth animation. and the last class is ```utils``` which contains some functions for handling time and currency format.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/utils.png"/>

## Testing

In this project, we have 4 types of tests, **Widget Test**, **Model Test**, **Repository Test**, and **View Model Test**. We use ```Mockito``` to mock the HTTP client and repository and write some tests for fetching success and failed cases. and also some tests are written to checking Screen Loading successfully. I write some Unit tests for HouseResponseModel.

We use the same hierarchy for the tests like the **lib** folder.

The test instrumentation app uses modules that have been swapped with fakes for
the network module to run requests on localhost with mockwebserver removes flakiness compared to relying on actual data from the real server aspects such as internet connection or network service might bring up issues.

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/tests.png"/>

## Libraries

Libraries used in the whole application are:

- [shared_preferences](https://pub.dev/packages/shared_preferences) - With this library, we handle locale storage for the application.
- [carousel_slider](https://pub.dev/packages/carousel_slider) - This library used for creating slides for the apartment photos.
- [photo_view](https://pub.dev/packages/photo_view) - This library is used for handling fullscreen galleries.
- [cached_network_image](https://pub.dev/packages/cached_network_image) - Used for loading images and cache them.
- [smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator) - With this library, we show dots indicator for the slider.
- [dismissible_page](https://pub.dev/packages/dismissible_page) - We use this for handling dismiss function for the gallery by swiping.
- [share](https://pub.dev/packages/share) - With this library, we share the images from the gallery.
- [flutter_cache_manager](https://pub.dev/packages/flutter_cache_manager) - With this library, we can obtain cached image file and share it with the **share** library.
- [flutter_html](https://pub.dev/packages/flutter_html) - Some of the contents of API are in Html format, I use this library to support that contents.
- [expand_widget](https://pub.dev/packages/expand_widget) - With this library, we handle Expandable descriptions of apartments which can be a long text.
- [url_launcher](https://pub.dev/packages/url_launcher) - With this library, we can request a Dial function of the homeowner.
- [provider](https://pub.dev/packages/provider) - With this library, we handle states of the app and use it as a dependency injection tool too.
- [mockito](https://pub.dev/packages/mockito) - With this library, we mock the HTTP client and repository for test purposes.
- [build_runner](https://pub.dev/packages/build_runner) - By Helping this library we can create mockito necessary.

## Screenshots

<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot2.jpg" width=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot4.jpg" width=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot5.jpg" width=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot3.jpg" width=200>
<img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot6.jpg" width=200><img src="https://raw.githubusercontent.com/amirghm/Funda-Sample/develop/screenshots/screenshot1.jpg" width=200> 
