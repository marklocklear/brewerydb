#Saving and Retrieving Data in Firebase

In this tutorial I will show you how to retrieve data from an API,  and then save and retrieve that data from a [Firebase](https://www.firebase.com/) database. Now, we could come up with some contrived premise for creating data to store in our database, and boring old Lorem Ipsum simply will not do. Everyone loves beer, so we will search our favoriate breweries using [BreweryDB](http://www.brewerydb.com/) and write that data to our database. We will be using Ruby 1.9.3 or greater to write this script.

We will be using the [brewery_db](https://github.com/tylerhunt/brewery_db) and [firebase](https://github.com/oscardelben/firebase-ruby) gems in this tutorial. The first thing we'll need to do is install the gems locally.
<pre>
    ruby-1.9.3-p551$ <b>gem install firebase</b>
    Fetching: firebase-0.2.6.gem (100%)
    Successfully installed firebase-0.2.6
    Installing ri documentation for firebase-0.2.6
    1 gem installed
    ruby-1.9.3-p551$ <b>gem install brewery_db</b>
    Fetching: brewery_db-0.2.4.gem (100%)
    Successfully installed brewery_db-0.2.4
    Installing ri documentation for brewery_db-0.2.4
    1 gem installed
<pre>

Now let's create a new ruby script. The first thing we will want to do in the script is require these gems at the top.
```ruby
require 'brewery_db'
require 'firebase'
```
Next lets set up connections to both Firebase and BreweryDB.
```ruby
require 'brewery_db'
require 'firebase'

#connect to Firebase
firebase_uri = 'https://locklear.firebaseio.com/'
@firebase = Firebase::Client.new(firebase_uri)

#connect to BreweryDB
@brewery_db = BreweryDB::Client.new do |config|
    config.api_key = '<your BreweryDB key here>'
end
```

Be sure to enter your private API key in the `config.api_key...` line above. Its quick and easy to [sign up here](http://www.brewerydb.com/developers).

Now might be a good time to sanity check the script. If you run the script now you should not get any errors.

OK, so far so good! Now let's search the BreweryDB database for a particular Brewery. Based on the brewery_db gem [documentation](https://github.com/tylerhunt/brewery_db#usage) we can do something like `name = brewery_db.search.breweries(q: 'urban')` to search all brewerys with the name "wicked" in them. Lets give that a try along with a simple loop to display any results we find.

```ruby
require 'brewery_db'
require 'firebase'

#connect to Firebase
firebase_uri = 'https://locklear.firebaseio.com/'
@firebase = Firebase::Client.new(firebase_uri)

#connect to BreweryDB
@brewery_db = BreweryDB::Client.new do |config|
    config.api_key = '<your BreweryDB key here>'
end

breweries = @brewery_db.search.breweries(q: 'urban')

breweries.each do |b|
	puts b.name
end
```

Go ahead and try the names of some of your favorite craft breweries around the country. The database is pretty comprehensive. When I run the script above I get:

```
ruby-1.9.3-p551$ ruby brewery.rb
Hopworks Urban Brewery
Urban Artifact
Urban Legend Brewing Company
Urban Family Brewing
Urban Farm Fermentory
Urban Growler Brewing Company
Big Rock Urban Brewery
Urban Chestnut Brewing Company
```
You should see something similar. Also, when quering data in ruby like this I like using `inspect` to look at the entire object being returned. You can do this by using `puts b.inspect` in your loop rather than `puts b.name`.




> Written with [StackEdit](https://stackedit.io/).
