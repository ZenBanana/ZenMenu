# ZenMenu
______________________________________________________________________________________________________________________________________________________________

A customizable menu that displays menu items in various circle patterns around the menu button.

## Requirements
______________________________________________________________________________________________________________________________________________________________

* ios 10.0+
* XCode 9.0+
* Swift 4.0+

## Installation
______________________________________________________________________________________________________________________________________________________________

1) via Github
	Download Repo and add to your project

2) via Cocoapods with Podfile
	
	pod 'ZenMenu'
	

## Usage
______________________________________________________________________________________________________________________________________________________________


### Set Up Using Storyboard


Open Storyboard 

Step 1) Add UIButton inheiriting from ZenMenu for the ViewController ZenMenu will be used in

Step 2) Set Attributes for UIButton via Storyboard IBInspectables
	
	a) Set Radius (default is 100)
	b) Set Animation Duration (default is 0.3)
	c) Set Open Menu Icon
	d) Set Closed Menu Icon

Open ViewController Source File

Step 3) Set ZenMenu button as an @IBOutlet

*In viewDidLoad()*

Step 4) Create ZenMenuItems. 
    
  There are three different types of ZenMenuItems you can initialize
	
  * Using a Simple String
	
	
  * Using a UIImage
	
	
  * Using a Custom View from a .xib

		// Size that will be used for the different menu items
		let customSize = CGSize(width: 80, height: 80)

		// Initialize the UIView that will be used as the view for the first ZenMenuItem
		let item1 = CustomMenuButtonItem.instanceFromNib(title: "Full Circle", icon: UIImage(named: "Full")!, mainColor: UIColor.green)
		item1.titleLabel.textColor = UIColor.white
		// Initialize the first ZenMenuItem using a UIImage
		let item1Button = ZenMenuItem(customItemView: item1, withSize: customSize)


### Set Up Programatically


## Additional Features
______________________________________________________________________________________________________________________________________________________________


## Authors
______________________________________________________________________________________________________________________________________________________________

* **Tanner Juby** - *Initial work* - [ZenBanana](https://github.com/ZenBanana)


## License
______________________________________________________________________________________________________________________________________________________________

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details


## Acknowledgments
______________________________________________________________________________________________________________________________________________________________

* Hat tip to anyone who's code was used
* Inspiration
* etc