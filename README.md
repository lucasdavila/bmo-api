![left](http://24.media.tumblr.com/tumblr_lxb4dnHoSu1qfr9vzo1_400.gif)

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

* `/leds/fade_in/:pin`, eg:  
  `$ curl 0.0.0.0:4567/leds/fade_in/11 -X PUT -d ''`  
  `$ curl 0.0.0.0:4567/leds/fade_in/11 -X PUT -d sleep=0.5`

* `/leds/fade_out/:pin`, eg:  
  `$ curl 0.0.0.0:4567/leds/fade_out/11 -X PUT -d ''`  
  `$ curl 0.0.0.0:4567/leds/fade_out/11 -X PUT -d sleep=0.5`

* `/leds/fade/:pin?to=100`, eg:  
  `$ curl 0.0.0.0:4567/leds/fade/11 -X PUT -d to=100`

### Contribute
Want to help? Just send a pull request :D
