```
git clone https://github.com/JanC/MBChallenge.git
cd MBChallenge/
pod install
open MBChallenge.xcodeproj/
```


###MVMM
This app uses the MVVM design pattern. I'm not so familiar with it but I find it cool so I used it here ;)

###AutoLayout

The app uses the auto layout feature to support landscape and portrait mode all screen sizes ;)


##MBNotesClient
Responsible for fetching the data from the API. Here it just returns the dummy array asynchronously to simulate a network call

###MBNotesManager
Processes the remote data into local CoreData model.

###MBNoteListViewModel
Business logic responsible for preparing the the data for the dislay. 

###Style
I did some styling to match the mbrace iphone app ;)

###TODO
The table view should have the links clickable. I was kind of struggeling for making the UITextView heigt dynamic so I desided to use just a UILabel with a dynamic height for the MBTableViewCell

### Resources
Here are the thing that I used as resources for this app

[MVVM](http://www.teehanlax.com/blog/model-view-viewmodel-for-ios/)

[MVVM Open Source App](https://github.com/AshFurrow/C-41)





