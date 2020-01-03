# Midow

<img src="https://user-images.githubusercontent.com/25849775/71724544-63161480-2e0f-11ea-89ad-cc30d4e2ba8c.gif" data-canonical-src="https://gyazo.com/eb5c5741b6a9a16c692170a41a49c858.png" width="200" height="400" />


## About this Project

The idea of the App is:

_"An application that enables interaction between the urban community, allowing everyone who uses the solution to share medicine prices."._

<br>

## Why?

This project is part of my personal portfolio, so, I'll be happy if you could provide me any feedback about the project, code, structure or anything that you can report that could make me a better developer!

Email-me: boscardinvinicius@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/boscardinvinicius/).

Also, you can use this Project as you wish, be for study, be for make improvements or earn money with it!

It's free!

<br>

## Functionalities

- Choose the establishments of your choice and trust to compare prices and receive notifications

- Browse the map and see the best place to buy your medicine or product.

- Establishments
	- Create, edit and remove the establishments you have registered
	- Report incorrect information from other users anonymously.

<br>

## Getting Started

### Prerequisites

To run this project in the development mode, you'll need to have a basic environment to run: 
- A Flutter App, that can be found [here](https://flutter.dev/docs/get-started/install).

- A Docker App, that con be found [here](https://docs.docker.com/install/)

_or_

- A Adonis CLI App, that can be found [here](https://adonisjs.com/docs/4.1/installation).

- A Vue CLI App, that can be found [here](https://cli.vuejs.org/guide/installation.html).

- A Postgres Database, that can be found [here](https://www.postgresql.org/download/).


<br>

### Installing


**Cloning the Repository**

```
$ git clone https://github.com/boscaa/midow

$ cd midow
```

# Installing with Docker !!!!!!!


**Installing dependencies**

- Navigate to packages - docker
- Run a docker command

```
$ cd packages/docker
$ docker-compose up -d
```

### Running

The docker compose already installed all the dependencies, just run a flutter app into your emulator.

Android and iOS

```
$ cd packages/mobile/midow
$ flutter pub get
$ flutter run
```

<br>
<br>
<br>

#### Installing without Docker !?   :(


**Installing dependencies**

- Navigate to packages - mobile - midow 
- Run a flutter command

```
$ cd packages/mobile/midow
$ flutter pub get
```

_and_

- Go back to project root folder
- Navigate to packages - api - default-midow-api
- Run a node command

```
$ cd ../../../
$ cd packages/api/default-midow-api
$ npm i
```

_and_

- Go back to project root folder
- Navigate to packages - web - midow
- Run a node command

```
$ cd ../../../
$ cd packages/web/midow
$ npm i
```

<br>

### Running (if you not using docker :()

With all dependencies installed and the environment properly configured, you can now run the app:

Android and iOS

```
$ cd packages/mobile/midow
$ flutter run
```


Adonis API

```
$ cd packages/api/default-midow-api
$ adonis serve --dev
```

Vue Frontend

```
$ cd packages/web/midow
$ npm run serve
```

<br>

### URLs to show the aplications

- API = http://YOUR_MACHINE_IP:3333
- FRONTEND = http://YOUR_MACHINE_IP:8080

<br>
<br>
<br>

## Mobile application built With

- [Flutter](https://flutter.dev/) - Build the native app using Dart language
- [Google-Maps](https://pub.dev/packages/google_maps_flutter) - Maps SDK for flutter
- [Location](https://pub.dev/packages/location) - Used to get location of user
- [Background-Fetch](https://pub.dev/packages/background_fetch) - Used to get location of user when application is closed
- [Permission_Handler](https://pub.dev/packages/permission_handler) - Used to get permissions of device services
- [Dio](https://pub.dev/packages/dio) - Http cliente to make requests
- [Bloc_Pattern](https://pub.dev/packages/bloc_pattern) - BR library to state management - Thanks [Flutterando](https://flutterando.com.br)
- [Bloc](https://pub.dev/packages/bloc) - State management library
- [Google-Maps-Util](https://pub.dev/packages/google_maps_util) - Directions and routes from google maps API


## Web application built With

- [Vue](https://vuejs.org/) - Build the web app using JS language
- [Vuetify](https://vuetifyjs.com/) - Material Design library for Vuejs
- [Google-Maps](https://developers.google.com/maps/documentation/javascript/tutorial) - Maps SDK for JS

## Support tools

- [Gcloud Storage - GCS](https://cloud.google.com/storage/) - Storage Service

## Contributing

You can send how many PR's do you want, I'll be glad to analyse and accept them! And if you have any question about the project...

Email-me: boscardinvinicius@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/boscardinvinicius/)

Thank you!

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/boscaa/midow/blob/master/LICENSE) file for details
