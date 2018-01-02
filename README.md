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

![Set Attributes](/Assets/ReadMe-Images/Set-ZenMenu-Attributes-SB.png)


*Open ViewController Source File*


##### 4) Link the ZenMenu button to source file

![Link to source file](/Assets/ReadMe-Images/set-ZenMenu-As-UIOutlet.png)


*In viewDidLoad()*


##### 5) Create ZenMenuItems. 
    
There are three different types of ZenMenuItems you can initialize
	
  * Using a Simple String
  
	![Simple String Item](/Assets/ReadMe-Images/Init-ZenMenuItem-As-String.png)	
	
	
* Using a UIImage

	![UImage Item](/Assets/ReadMe-Images/Init-ZenMenuItem-As-Image.png)
	
	
  * Using a Custom View from a .xib

	![Custom View Item](/Assets/ReadMe-Images/Init-ZenMenuItem-As-Custom.png)
	

##### 6) Assign ZenMenu's programmable attributes

	![Programatical Attributes](/Assets/ReadMe-Images/Set-ZenMenu-Attributes.png)
	
	
##### 7) Finalize the ZenMenu by calling commonInit()

	![Common Init](/Assets/ReadMe-Images/Common-Init.png)


##### 8) Add Delegate Resource to View Controller
	
	![Delegate](/Assets/ReadMe-Images/Delegate-Source.png)


### Set Up Programatically


## Additional Features


## Authors

* **Tanner Juby** - *Initial work* - [ZenBanana](https://github.com/ZenBanana)


## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details


## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc
