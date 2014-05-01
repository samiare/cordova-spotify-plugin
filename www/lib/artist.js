var exec = require('cordova/exec');

var defaultProps = {
  name: null,
  uri: null,
  sharingURL: null,
  genres: null,
  images: null,
  smallestImage: null,
  largestImage: null,
  popularity: null
};

function ArtistData() {}
function Artist(uri, callback) {
  var callback = callback || null
    , props = {}
    , artist = new ArtistData();
  
  Object.keys(defaultProps).forEach(function(prop, index) {
    Object.defineProperty(artist, prop, {
      get: function() { return props[prop] || defaultProps[prop]; },
      enumerable: true
    });
  });

  function onSuccess(data) {
    props = data;
    
    if (callback) 
      return callback(null, track);
  }

  function onError(error) {
    if (callback)
      return callback(error);
  }
  
  spotify.exec( 'artistFromURI',
                [ uri ],
                callback );
  
  return track;
}

Artist.prototype = {};
ArtistData.prototype = Object.create(Artist.prototype);
ArtistData.prototype.constructor = TrackData;

module.exports = Artist;