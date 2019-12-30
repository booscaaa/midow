# Midow

<img src="https://user-images.githubusercontent.com/25849775/71531064-c06c0c00-28cb-11ea-8b82-54fc121a31d2.gif" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="200" height="400" />


## About this Project

The idea of the App is:

_"An application that enables interaction between the urban community, allowing everyone who uses the solution to share medicine prices."._


## Why?

This project is part of my personal portfolio, so, I'll be happy if you could provide me any feedback about the project, code, structure or anything that you can report that could make me a better developer!

Email-me: boscardinvinicius@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/boscardinvinicius/).

Also, you can use this Project as you wish, be for study, be for make improvements or earn money with it!

It's free!

<!-- ## Some Observations about this App

1 - There's no functionality of Login/Register, the buttons and the forms in the Login Screen are only for UI matters.

2 - The only option that works at _Settings_ screen it's toggle the Dark/Light theme, all the others are just for UI matters too. -->

<!-- ## Installers

If you want to test the App in the Production mode, the installers are listed below:

[Android .apk installer](https://drive.google.com/file/d/1LKgdu1WDPo8eU2NVjoB92TPi4my8QP4D/view?usp=sharing) -->

<!-- iOS .ipa installer: Soon! -->

## Functionalities

- Choose the establishments of your choice and trust to compare prices and receive notifications

- Browse the map and see the best place to buy your medicine or product.

- Establishments
	- Create, edit and remove the establishments you have registered
	- Report incorrect information from other users anonymously.

## Getting Started

### Prerequisites

To run this project in the development mode, you'll need to have a basic environment to run: 
- A Flutter App, that can be found [here](https://flutter.dev/docs/get-started/install).

- A Adonis App, that can be found [here](https://adonisjs.com/docs/4.1/installation).

- A Postgres Database, that can be found [here](https://www.postgresql.org/download/).


### Installing

**Cloning the Repository**

```
$ git clone https://github.com/boscaa/midow

$ cd midow
```

**Installing dependencies**

- Navigate to packages - mobile - midow 
- Run a flutter command

```
$ cd packages/mobile/midow
$ flutter pub get
```

_and_

- Go back to project root folder
- Navigate to packages - apis - default-midow-api
- Run a node command

```
$ cd ../../../
$ cd packages/apis/default-midow-api
$ npm i 
```

### Connecting the App with the Server

<!-- 1 - Follow the instructions on the [mindcast-server](https://github.com/steniowagner/mindcast-server) to have the server up and running on your machine.

2 - With the server up and running, go to the [/.env.development](https://github.com/steniowagner/mindCast/blob/master/.env.development) file and edit the SERVER_URL value for the IP of your machine (you can have some issues with _localhost_ if you're running on an android physical device, but you can use localhost safely on iOS).

It should looks like this:

SERVER_URL=http://**_IP_OF_YOUR_MACHINE_**:3001/mind-cast/api/v1 -->
<!-- 
*or*

SERVER_URL=http://localhost:3001/mind-cast/api/v1 -->

### Running

With all dependencies installed and the environment properly configured, you can now run the app:

Android and iOS

```
$ flutter run
```

## Built With

- [Flutter](https://flutter.dev/) - Build the native app using Dart language
- [Google-Maps](https://pub.dev/packages/google_maps_flutter) - Maps SDK for flutter
- [Background-Location](https://pub.dev/packages/background_location) - Used to get location of user
- [Background-Fetch](https://pub.dev/packages/background_fetch) - Used to get location of user when application is closed

## Support tools

- [Gcloud Storage - GCS](https://cloud.google.com/storage/) - Storage Service

## Contributing

You can send how many PR's do you want, I'll be glad to analyse and accept them! And if you have any question about the project...

Email-me: boscardinvinicius@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/boscardinvinicius/)

Thank you!

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/boscaa/midow/blob/master/LICENSE) file for details