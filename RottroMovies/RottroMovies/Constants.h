//
//  Contants.h
//  RottroMovies
//
//  Created by Vitor Navarro on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#define RT_KEY @"svbq8zvh527r2pemyfkfz37j"
#define RT_TOPTEN_URL @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=svbq8zvh527r2pemyfkfz37j&limit=10"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//TWITTER
#define TWITTER_KEY @"5LlbtfBDPtpjZiathLylzw"
#define TWITTER_SECRET @"uEsjcEyvPF3RZJoMjDC3rHbjo7NbwX1HUwKrrdhFk"
#define TWITTER_REQUEST_TOKEN_URL @"https://api.twitter.com/oauth/request_token"
#define TWITTER_AUTHORIZE_URL @"https://api.twitter.com/oauth/authorize?oauth_token=%@&oauth_callback=%@"
#define TWITTER_ACCESS_TOKEN_URL @"https://api.twitter.com/oauth/access_token"
#define TWITTER_UPDATE_URL @"https://api.twitter.com/1/statuses/update.json"
#define TWITTER_DEFAULTS @"TT"
#define TT_CALLBACK_URL @"http://www.vnavarro.com.br"


//FACEBOOK
#define FACEBOOK_KEY @"323963917664166"
#define FACEBOOK_SECRET @"1a13502d4c18adb6c92767b25ecc9a79"
#define FACEBOOK_ACESS_TOKEN_KEY_USER @"FBAccessTokenKey"
#define FACEBOOK_EXPIRE_DATE_KEY_USER @"FBExpirationDateKey"