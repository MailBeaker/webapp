## MailBeaker Client ##

The MailBeaker client uses a single-page application design and requires
some tools to assist in dependency management, compilation, and minification.
This README will guide you through getting the development environment setup.

### 1. Required Programs & Software ###
If you do not already have the following package managers and task runners installed
from developing other projects, install them now.

1. nodejs (`brew install nodejs`)
2. gulp (`npm install -g gulp`)

### 2. Download Dependencies & Libraries ###
Whenever you are working on the client, you should be in the `webapp/client` directory.

`cd ~/workspace/MailBeaker/webapp/client`

1. `npm install`


### 3. Build the Application ###
Building the application is simple:

1. `gulp`


That's it!


## Developing ##
In order to avoid having to run `gulp` every time you make a change, we utilize
a gulp-watch that will rebuild the app whenever a file changes. To use this, run:

1. `gulp dev`