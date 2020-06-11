# Coffee_Foursquare
Using the Foursquare API to make an app displaying the top 15 coffee shops in an area in an interesting way.

The challenge was to make an app that pulled the top 15 coffee shops from a specific location and display the information for those coffee shops in a table view. My first thought was to have a tableview and a map within the same view but I wanted to do something a bit different that I could have fun with. After becomming aquainted with the data, I decided to make those 15 results look like instagram posts and display the "tips" associated with the results as the message under the "post". The GIF below shows this better than I can in words. 

<p align="center">
	<a href="https://github.com/StevenWorrall/Coffee_Foursquare/blob/master/Coffee_Example.gif"><img src="https://github.com/StevenWorrall/Coffee_Foursquare/blob/master/Coffee_Example.gif" height=400px width=auto ></a>
</p>

I didn't manage to get to UnitTests within the time I was willing to spend on the app however I might go about making some tests to ensure proper instantiation of views by both feeding in correct and incorrect data via the FoursquareInteractorDelegate dataSuccess function. 

Another point I should make is that if I were to do it over again, I'd add another layer coming off of the Interactor in order to process the data down into a usable form. Currently this is done in a "didSet" inside of the ResultCell but it would be cleaner and more testable to do this elsewhere. While in the ResultCell, I'd probably mess with the data for the coffee shop some more. I'd like it to either be moved or to be put into one label with multiple lines like I did for the tip.

The idea is either something you love or hate. I think the most important thing is that I turned it into a project that I throughly enjoyed working on. 

If you'd like to see more examples of my Swift code click [here](https://github.com/StevenWorrall/Swift_Practice)

If you'd like to see more examples of some complex views in Swift click [here](https://github.com/StevenWorrall/Netflix_Clone)

My resume is [here](https://github.com/StevenWorrall/Resume/blob/master/Steven_Worrall.pdf)

Thanks!
