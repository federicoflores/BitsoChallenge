# BitsoChallenge

## Architecture
The project was created in UIKIT as well as the Home Module. The architecture for this is VIPER with a builder that assembles it.
The SwIftUI architecture is MVVM as it responds very well to the reactive approach of the framework.
The selected architures responds to a simulation situation where an existing UIKIT app is introducing SwiftUI.

## Layout
All UI is done programatically in both UIKit and SwiftUI. CollectionView layout is set in order to dynamically calculate it's own dimensions according to the dynamic content coming from the API. 

## Network request:
Combine was used for Network Api calls. This was chosen as combine reactive approach works very well along with SwiftUI and UIKIT.

## Caching:
NSCache was used for caching the responses on memory. This helps the app performance to avoid unnecesary requests and give the user a best experience avoiding delays.
 

## Persistance:
UserDefaults is used for persistance. As no heavyweight persistance is needed I considered as an overkill to use combine or SwiftData.

## Error handling:
Errors are presented to the user through a customizable Errorview screen. Also persistance is used in some cases to show data to the user when the API call fails

## Pagination
Pagination was added with a preload of the next page and a delay of 0.3 seconds for user knowledge.  

## Navigation
Navigation is mostly using UINavigationController and a CustomHostingController.
This is thought as per SwiftUI Navigation still has some issues and lack of certain behaviours. Also in the end, the SwiftUI NavigationStack uses UINavigationController for handling the navigation.

## Conifg file
Config/Secrets file was added for protecting the sensible information of the app. In this case it only contains the host of the base URLs but it's thought for holding api keys or any other relevant information that should be secure.

## Unit testing:
Unit tests were added for both modules. Mocks and stubs were added for isolating the desire test.  
In case of the home, the presenter and the interactor logics were tested. 
In case of the Detail, the viewModel was tested.

## Snapshot testing:
Snapshot tests were added for both screens. SnapshotTesting third party dependency was added for this. Snapshot images were recorded on iPhone 15 Simulator. 

## Dependency manager:
SwiftPackageManager was chosen as a dependency manager. Nevertheless the only library used on this project was for snapshot testing. 
The idea of using only essential third partys responds to the objective of having as much control as possible over the whole application as well as avoiding the impacts that could happen if an error/security exploit happens on the third party integrated to the app. 

## Localizables
No localization was added on the project as the API only provides english responses.
