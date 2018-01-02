# ZenMenu

A customizable menu that displays menu items in various circle patterns around the menu button.

## Requirements

* ios 10.0+
* XCode 9.0+
* Swift 4.0+

## Installation

1) *via* Github
	Download Repo and add to your project

2) *via* Cocoapods with Podfile
	
	pod 'ZenMenu'
	

## Usage


### Set Up Using Storyboard


Open Storyboard 

##### 1) Add UIButton to Storyboard

![Add UIButton](/Assets/ReadMe-Images/Add-UIButton-To-SB.png)


##### 2) Set UIButton custom class as ZenMenu

![Set as ZenMenu](/Assets/ReadMe-Images/Set-Button-As-ZenMenu.png)


##### 3) Set up ZenMenu attributes

You can do these all programatically in the View Controller viewDidLoad(), or you can edit them in storyboard

![Set Attributes](/Assets/ReadMe-Images/Set-ZenMenu-Attributes-SB.png)


*Open ViewController Source File*


##### 4) Link the ZenMenu button to source file

![Link to source file](/Assets/ReadMe-Images/Set-ZenMenu-As-UIOutlet.png)


*In viewDidLoad()*


##### 5) Create ZenMenuItems. 

In order to have a functioning ZenMenu, we need ZenMenuItems to display when the menu is open. There are three different types of ZenMenuItems, and here is how you initialze them:
	
   *) Using a Simple String

   If you want to just display simple strings for the menu items, here is how you would initialize them:
  
   ![Simple String Item](/Assets/ReadMe-Images/Init-ZenMenuItem-As-String.png)	
	
	
   * Using a UIImage

   If you have images for the menu items, here is how to initialize them as ZenMenuItems:

   ![UImage Item](/Assets/ReadMe-Images/Init-ZenMenuItem-As-Image.png)
	
	
   * Using a Custom View from a .xib

   If you have a custom view for your menu items, here is how to initialize them as ZenMenuItems:

   ![Custom View Item](/Assets/ReadMe-Images/Init-ZenMenuItem-As-Custom.png)
	

##### 6) Assign ZenMenu's programmable attributes

Now we need to finish setting up some of the ZenMenu attributes. We need to set these attributes:
    * parentView: This needs set for displaying a background view over the view controllers main view for when the menu is open. Always set this as the view controllers view
    * items: This is an array of the ZenMenuItems you want in the menu
    * direction: When the ZenMenu calculates the positioning of the ZenMenuItems, it calculates them in a clockwise rotation around the ZenMenu. The direction is where the first ZenMenu item will be calculated from. There are 4 options (north, south, east, and west)
    * type: The type is the way you want the ZenMenuItems to be displayed around the ZenMenu. There are 3 options (fullCircle, halfCircle, quarterCircle)

![Programatical Attributes](/Assets/ReadMe-Images/Set-ZenMenu-Attributes.png)
	
	
##### 7) Finalize the ZenMenu by calling commonInit()

When this function is called, it finalizes the set up of the ZenMenu. Mainly, it calculates the center points of the ZenMenuItems for when the ZenMenu is open. This function must be called in order to have menu items displayed as desired.

![Common Init](/Assets/ReadMe-Images/Common-Init.png)


##### 8) Assign ZenMenu Delegate

Assign the ZenMenu delegate as the current view controller in order to handle different events during interaction with the ZenMenu and its items. 

![Delegate](/Assets/ReadMe-Images/Delegate.png)


*Extending the View Controller Class for ZenMenuDelegate*

##### 9) Add Delegate Resource to View Controller

Since you set the ZenMenu delegate as self (view controller), the view controller will need to extend the ZenMenuDelegate class. This is where you can handle different events such as *didSelectZenMenuItem*, *willPresentZenMenuItem*, *willDismissZenMenuItem*, *etc.* 

![Delegate](/Assets/ReadMe-Images/Delegate-Source.png)


*move to ZenMenuDelegate Source*

##### 10) Handling when user selects ZenMenuItem

When a user clicks on a ZenMenuItem, usually something should happen. You can handle this by using the *didSelectZenMenuItem* protocol. This protocol is called whenever a user selects a ZenMenuItem, and should be used to trigger an event on the ViewController depending on the ZenMenuItem. For this example, my menu items are used for navigation to other view controllers, so depending on which ZenMenuItem was chosen, I navigate to a different view controller.

![DidSelectZenMenuItem](/Assets/ReadMe-Images/Did-Select-ZenMenuItem.png)


### Set Up Programatically


## Additional Features


## Authors

* **Tanner Juby** - *Initial work* - [ZenBanana](https://github.com/ZenBanana)


## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details

