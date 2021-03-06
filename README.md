This is a prototype to get Dropbox login working on tvOS.  tvOS does not support webkit and so OAuth is not so much an option.  

This rails app follows the suggestion made by [Dropbox](https://www.dropboxforum.com/hc/en-us/community/posts/204784269-Authentication-to-dropbox-on-tvOS). A tvOS app user can authenticate on a browser on phone or computer and then tvOS can send a request after this login to get Dropbox access token. This rails app helps facilitate that login for the user.

To do this a tvOS app can hit the following endpoint: 

`/tv`

and get back the following JSON response: 

`{tv_token:"cda5a09", url:"http(s)://<host>/addtv/cda5a09"}`


The tvOS app can use the code or the url to show to the user.  User can then hit that URL on a phone or browser of some sort and do the Dropbox OAuth login to get an access token.  Once the access token is saved by the rails app, the tvOS app can hit  

`/tv/:tv_token`  

`{db_access_token : "<Dropbox access token>", user_id : "<user id>"}`

to get the Dropbox access_token and proceed to with interacting with Dropbox API.


#### TL;DR Steps: ####

- 1 TV app makes request to rails app endpoint `/tv` to get tv token
- 2 TV app shows user on screen the url to visit with phone or other browser ( [Example](https://www.dropboxforum.com/hc/user_images/rxHsYVjTe_VSFwCzdMF6KQ.jpeg) )
- 3 User enters the url and is redirected to Dropbox login
- 4 Dropbox redirects back to rails app with access token
- 5 Rails app saves access token
- 6 TV app should have some sort of button or retry to request access token from `/tv/:tv_token` once user has finished logging in to Dropbox on phone or computer




#### Dropbox Setup ####
Visit [Dropbox apps](https://www.dropbox.com/developers/apps) to setup the callback URL or your rails app.
	( My Apps > Select app > Settings > OAuth2 Redirect URIs )