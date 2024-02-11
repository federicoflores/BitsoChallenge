# BitsoChallenge

## Architecture
The App has UIKit and SwiftUI frameworks coexisting.
The project was created in UIKIT as well as the Home Module. The architecture for this is VIPER with a builder to assemble all it's components.
The Detailview is done in SwIftUI and the architecture chosen is MVVM as it responds very well to the reactive approach of the framework.
The selected architectures responds to a simulation situation where an existing UIKIT app is introducing SwiftUI.

## Layout
All UI is done programatically in both UIKit and SwiftUI. CollectionView layout is set in order to dynamically calculate it's own dimensions according to the dynamic content coming from the API. 

## Network request:
Combine was used for Network Api calls. This was chosen as combine reactive approach works very well along with SwiftUI and UIKIT.

## Caching:
NSCache was used for caching the responses on memory. This helps the app performance to avoid unnecesary requests and give the user a best experience avoiding delays.
 

## Persistance:
UserDefaults is used for persistance. As no heavyweight persistance is needed I considered as an overkill to use CoreData or SwiftData.

## Error handling:
Errors are presented to the user through a customizable Errorview screen. Also persistance is used in some cases to show data to the user when the API call fails

## Pagination
Pagination was added with a preload of the next page to have smoother outcomes when scrolling.  

## Navigation
Navigation is done using UINavigationController and a CustomHostingController to synchronize SwiftUI views.
This is thought as per SwiftUI Navigation still has some issues and lack of certain behaviours. Also because in the end, the SwiftUI NavigationStack uses UINavigationController for handling the navigation.

## Config file
Config/Secrets file was added for protecting the sensible information of the app. In this case it only contains the host of the base URLs but it's open for holding api keys or any other relevant information that should be secure.

## Unit testing:
Unit tests were added for both modules. Mocks and stubs were added for isolating the desire test.  
In the Home module the presenter and the interactor logics were tested. 
In the Detail module the viewModel was tested.

## Snapshot testing:
Snapshot tests were added for both screens. swift-snapshot-testing third party dependency was added for this. Snapshot images were recorded on iPhone 15 Simulator. 

## Dependency manager:
SwiftPackageManager was chosen as a dependency manager. Nevertheless the only library used on this project was for snapshot testing. 
The approach of using only essential third partys responds to the objective of having as much control as possible over the whole application as well as avoiding the impacts that could happen if an error/security exploit happens on the third party integrated to the app. 

## Localizables
No localization was added on the project as the API only provides english responses.
