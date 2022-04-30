# AdsApp
Application to show Ads

Short description of my decisions:
- I've used Swift 5 as a main language
- Project is built on top of MVVM pattern with binding between ViewModel and ViewController
- I've choose simplified Coordinator pattern for app navigation with coordinator for every module and callbacks on blocks
- API is designed on top of URLSession with help of Generics, Request has Response as associatedtype
- All models is Codable
- I've choose UserDefaults as a simplest storage, but it could be easily replaced by more elegant solution using Storable protocol
- Custom LoadableImageView has it's own Cache. It is simplified version of 3rd party sd_webimage

What exactly I feel proud of?
- Simple understandable MVVM + Coordinators pattern, one of the best solution for small projects like this. Bindable could be easily replaced with delegates, blocks or even RX
- API design on top of Generics with Codable is very extendable and could be use even in commercial projects
- Following SOLID principles 

What could be done better?
- API requests with pagination by 20-25 items
- CollectionView UI/UX experience
- Cell UI with better performance. Also, cell heigh could be dynamically expandable depends on content (title length or image height) 
- Add Unit Tests for coordinator, viewModel and API
- For storing favourites UserDefaults is not the best solution. Better will be to update isFavourite on backend for specific user and refresh cell


