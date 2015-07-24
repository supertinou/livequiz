![LiveQuiz](http://cl.ly/image/1a2f213b3a1x/livequizz-logo.png)

# LiveQuiz

__LiveQuiz is an app that allows you to create awesome real time quizzes. It is powered by [PubNub](https://www.pubnub.com/)__

- Create a quiz with questions and answers
- Create a quiz session and invite people
- Start the Quiz
- People can play the Quiz in realtime

## Built With
![LiveQuiz Technologies](http://cl.ly/image/2i260O0G1m1S/livequiz-tech.png)


- [Ruby on Rails](https://github.com/rails/rails) &mdash; The back end that allows to create quizzes is a Rails app.
- [PubNub](https://www.pubnub.com/) &mdash; The realtime communication layer that allows you to play the quizzes in realtime is PubNub. This app uses the [Javascript](https://github.com/pubnub/javascript) and [Ruby](https://github.com/pubnub/ruby) PubNub APIs. It uses PubNub [Access Manager](http://www.pubnub.com/products/access-manager/) and [Presence](http://www.pubnub.com/products/presence/) features to secure quizzes access and to allow to see the participants statuses.
- [ReactJS](https://github.com/facebook/react) &mdash; The quiz user interface is made with ReactJS and allows to display and refresh the realtime data received from the PubNub Network.
- [PostgreSQL](http://www.postgresql.org/) &mdash; The main data store is in Postgres.

Plus *lots* of Ruby Gems, a complete list of which is at [/develop/Gemfile](https://github.com/supertinou/livequiz/blob/master/Gemfile).



## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

### PubNub Account and API keys

- Create a PubNub account [here](https://www.pubnub.com/) and create an app.
- Activate __Access Manager__ and __Presence__ feature.
- Get your *SECRET_KEY*, *PUBLISH_KEY* and *SUBSCRIBE_KEY* and set them in the file __.env__. 

    *There is an example in the __.sample.env__ file :*
    ```
    PUBNUB_SECRET_KEY=XXXXXXXXXXXXX
    PUBNUB_PUBLISH_KEY=XXXXXXXXXXXX
    PUBNUB_SUBSCRIBE_KEY=XXXXXXXXXX
    ```

## Running the application

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

## Deploying

If you have previously run the `./bin/setup` script,
you can deploy to staging and production with:

    $ ./bin/deploy staging
    $ ./bin/deploy production
    
## Contributing

LiveQuiz is **100% free** and **open-source**. 
You can find some features in the [issues page](https://github.com/supertinou/livequiz/issues)

