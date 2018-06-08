# NonStopApp
Outsmarting airports, together. NonStop is the worlds first all-in-one airport navigator. With premium features designed to make your life easier, Nonstop takes the stress out of flying.

Landing page for the app!
  https://alexandrakl.github.io/nonstop/ 

Features:
  Comprehensive travel time calculator broken down into individual segments
    Time to airport (Uber/Lyft integration)
    Time in ticketing & check-in
    Time in security 
    Time to gate 
  Airport Information (Restaurants, Shops, Traveler Services, etc.) 
  Restaurant menus and reviews

In order to estimate the drive time, I used the Core Location API and MapKit to display the maps.

A web scraper and a parser was implemented in Java in order to gather flight data from LAX departures @ http://www.airport-la.com/lax/departures. 

An algorithm that gives an estimate of the time that takes to travel is based on the volume of flights departing from specific terminal and specific airline within one hour of the flight time.

For each terminal I am querying dining options for the Food Finder feature from the Yelp Developer API by setting GeoFence Locations in each terminal and pulling the data from a 100m radius to gather all nearby food locations. 




