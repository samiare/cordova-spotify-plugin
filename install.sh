#!/bin/sh

#if [ "$PLUGIN_ENV" == "test" ]; then
#  exit
#fi

#if [ "$CORDOVA_SPOTIFY_URL_SCHEME" == "" ]
#then
#    DEFAULT_SCHEME="spotify-cordova"

#    echo "The Spotify SDK Plugin needs a URL scheme for authentication."
#    echo "See http://bit.ly/1u11ZUz for more information"
#    printf "Specify your URL scheme [$DEFAULT_SCHEME]: "

#    read CORDOVA_SPOTIFY_URL_SCHEME
#    if [ "$CORDOVA_SPOTIFY_URL_SCHEME" == "" ]
#    then
#      CORDOVA_SPOTIFY_URL_SCHEME="$DEFAULT_SCHEME"
#    fi
#fi

#echo "Writing URL scheme to plugin.xml"

mv plugins/cordova-spotify-plugin/plugin.xml plugins/cordova-spotify-plugin/plugin.bak.xml
sed "s/{{URL_SCHEME}}/$CORDOVA_SPOTIFY_URL_SCHEME/g" plugins/cordova-spotify-plugin/plugin.bak.xml > plugins/cordova-spotify-plugin/plugin.xml
rm plugins/cordova-spotify-plugin/plugin.bak.xml

echo "Removing placeholder"
rm -rf plugins/cordova-spotify-plugin/src/ios/Spotify.framework

echo "Downloading Spotify Framework"
mkdir plugins/cordova-spotify-plugin/src/ios/tmp
cd plugins/cordova-spotify-plugin/src/ios/tmp
curl -OL "https://github.com/spotify/ios-sdk/archive/beta-6.tar.gz"

echo "Extracting"
tar xzvf beta-6.tar.gz
cd ..
mv tmp/ios-sdk-beta-6/Spotify.framework .
rm -rf tmp

echo "Finished!"
