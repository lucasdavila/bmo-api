### bmo-api
bmo-api provides a simple web api to interact with your arduino.

#### setup
* clone this repo
* `$ bundle install`
* `$ RACK_ENV=production bundle exec ruby api.rb`

### API

#### leds
* `/leds/on/:pin`, eg:  
  `$ curl 0.0.0.0:4567/leds/on/13`

* `/leds/off/:pin`, eg:  
  `$ curl 0.0.0.0:4567/leds/off/13`

### Contribute
Want to help? Just send a pull request :D
