# ZenMenu

A customizable menu that displays menu items in various circle patterns around the menu button.

## Requirements

* ios 10.0+
* XCode 9.0+
* Swift 4.0+

## Examples

To view and download our example project, follow this link: [ZenMenu Example](https://github.com/ZenBanana/ZenMenu-Example)

This gif demonstrates a ZenMenu with custom ZenMenuItems displayed in a Full circle

![Full Example](/Assets/ReadMe-Videos/Full.gif)

This gif demonstrates a ZenMenu with UIImage ZenMenuItems displayed in a Half circle

![Half Example](/Assets/ReadMe-Videos/Half.gif)

This gif demonstrates a ZenMenu with String ZenMenuItems displayed in a Quarter circle

![Quarter Example](/Assets/ReadMe-Videos/Quarter.gif)



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
	
A) Using a Simple String

   One type of ZenMenuItem is just created from a string. When you initialize it, you just have to set the title, itemSize, background color, and text color. Here is an example: 

```swift
// Size that I want the ZenMenuItem to be
let itemSize = CGSize(width: 100, height: 100)

// Initialize first ZenMenuItem using a String
let item1 = ZenMenuItem(title: "Item 1", withSize: itemSize, backgroundColor: UIColor.white, titleColor: UIColor.black)
```
   
	
B) Using a UIImage

   Another type of ZenMenuItem can be created from an image. When you initialize it, you just have to set the image and the itemSize. Here is an example:

```swift
// Size that I want the ZenMenuItem to be
let itemSize = CGSize(width: 100, height: 100)

// Initialize first ZenMenuItem using an image
let item2 = ZenMenuItem(icon: UIImage(named: "Item 2")!, withSize: itemSize)
```
	
	
C) Using a Custom View from a .xib

   If a simple string with a background or an image does not suite your needs, you also have the ability to create your own custom view and initialize a ZenMenuItem with that. I prefer designing my custom UIView through a .xib file and creating an instance from a nib, but which ever method you prefer will due. Here is an example of how I initialize ZenMenuItems with a custom view:

```swift
// Size that I want the ZenMenuItem to be
let itemSize = CGSize(width: 100, height: 100)

// Initialize custom view (MenuButtonItem) to be used for the first ZenMenuItem
let item1View = MenuButtonItem.instanceFromNib(title: "Quarter", icon: UIImage(named: "Quarter")!, mainColor: UIColor.clear)
item1View.titleLabel.textColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
// Initialize first ZenMenuItem using the first custom view
let item1 = ZenMenuItem(customItemView: item1View, withSize: itemSize)
```
   
   Here, MenuButtonItem is the class associated with my custom .xib file. MenuButtonItem is designed with a UIImage with a UILabel below. Here is the source code for that file:

```swift
open class MenuButtonItem: UIView {

    // MARK: - Class Variables
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var iconButton: UIButton!

    let backgroundView = UIView()
    var isBackgroundReady = false
    var isPresented = false

    // MARK: - Class Initializer

    class func instanceFromNib(title: String, icon: UIImage, mainColor: UIColor) -> MenuButtonItem {

	let view = UINib(nibName: "MenuButtonItem", bundle: nil).instantiate(withOwner: MenuButtonItem(), options: nil)[0] as! MenuButtonItem
		view.titleLabel.text = title
	view.iconButton.setImage(icon, for: .normal)
	view.iconButton.contentMode = .scaleAspectFit
	view.iconButton.isUserInteractionEnabled = false

	view.autoresizesSubviews = false

	return view
    }
}
```

	

##### 6) Assign ZenMenu's programmable attributes

Now we need to finish setting up some of the ZenMenu attributes. We need to set these attributes:
    
* parentView: This needs set for displaying a background view over the view controllers main view for when the menu is open. Always set this as the view controllers view
* items: This is an array of the ZenMenuItems you want in the menu
* direction: When the ZenMenu calculates the positioning of the ZenMenuItems, it calculates them in a clockwise rotation around the ZenMenu. The direction is where the first ZenMenu item will be calculated from. There are 4 options (north, south, east, and west)
* type: The type is the way you want the ZenMenuItems to be displayed around the ZenMenu. There are 3 options: 
	- **.fullCircle:**
		The fullCircle ZenMenu will display the ZenMenuItems all the way around the ZenMenu button in a complete circle. The fullCirlce is capable of displaying a **max of 16 items**
	
	- **.halfCircle**
		The halfCircle ZenMenu will display the ZenMenuItems around the ZenMenu button covering one half of a complete circle. The halfCirlce is capable of displaying a **max of 8 items**
	
	- **.quarterCircle**
		The quarterCircle ZenMenu will display the ZenMenuItems around the ZenMenu button covering a quarter of a complete circle. The quarterCirlce is capable of displaying a **max of 4 items**

```swift
// MARK: Assign ZenMenu's programmable attributes

// set the View Controller view as the menuButton's parent view
menuButton.parentView = self.view

// set the menuButton's items
menuButton.items = [item1, item2, item3]

// set the direction of where the first ZenMenuItem will be displayed in reference to the ZenMenu
menuButton.direction = .north

// Set the type of ZenMenu that will be used
menuButton.type = .fullCircle
```


##### 7) Assign ZenMenu Delegate

Assign the ZenMenu delegate as the current view controller in order to handle different events during interaction with the ZenMenu and its items. 

```swift
// Set the delegate for the menuButton
menuButton.delegate = self
```
	
	
##### 8) Finalize the ZenMenu by calling commonInit()

When this function is called, it finalizes the set up of the ZenMenu. Mainly, it calculates the center points of the ZenMenuItems for when the ZenMenu is open. This function must be called in order to have menu items displayed as desired.

```swift
// MARK: Finish initialization of ZenMenu
menuButton.commonInit()
```


*Extending the View Controller Class for ZenMenuDelegate*

##### 9) Add ZenMenuDelegate Source to View Controller

Since you set the ZenMenu delegate as self (view controller), the ZenMenuDelegate class will need to extend the View Controller you are working on. This is where you can handle different events such as *didSelectZenMenuItem*, *willPresentZenMenuItem*, *willDismissZenMenuItem*, *etc.* 

```swift
extension MyViewController: ZenMenuDelegate {

}
```


*move to ZenMenuDelegate Source*

##### 10) Handling when user selects ZenMenuItem

When a user clicks on a ZenMenuItem, usually something should happen. You can handle this by using the *didSelectZenMenuItem* protocol. This protocol is called whenever a user selects a ZenMenuItem, and should be used to trigger an event on the ViewController depending on the ZenMenuItem. For this example, my menu items are used for navigation to other view controllers, so depending on which ZenMenuItem was chosen, I navigate to a different view controller.

```swift
// Navigate to view controller represented by selected ZenMenuItem
func zenMenu(_ zenMenu: ZenMenu, didSelectZenMenuItem zenMenuItem: ZenMenuItem, index: Int) {

	switch index {
	case 0:
	    // Navigate to the quarter circle view controller
	    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
	    let vc = storyboard.instantiateViewController(withIdentifier: "QuarterCircle") as! QuarterCircleViewController
	    navigationController?.pushViewController(vc, animated: true)

	case 1:
	    // Navigate to the half circle view controller
	    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
	    let vc = storyboard.instantiateViewController(withIdentifier: "HalfCircle") as! HalfCircleViewController
	    navigationController?.pushViewController(vc, animated: true)

	default:
	    // Already on the full circle view controller, simply close the menu
	    zenMenu.close()

	}
}
```


##### In the end, your ViewDidLoad should match something similar to this:

```swift
// MARK: - Class Initializers

override func viewDidLoad() {
super.viewDidLoad()

	// MARK: Create ZenMenuItems

	// Size that I want the ZenMenuItem to be
	let itemSize = CGSize(width: 100, height: 100)

	// Initialize custom view (MenuButtonItem) to be used for the first ZenMenuItem
	let item1View = MenuButtonItem.instanceFromNib(title: "Quarter", icon: UIImage(named: "Quarter")!, mainColor: UIColor.clear)
	item1View.titleLabel.textColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)
	// Initialize first ZenMenuItem using the first custom view
	let item1 = ZenMenuItem(customItemView: item1View, withSize: itemSize)

	// Initialize custom view (MenuButtonItem) to be used for the second ZenMenuItem
	let item2View = MenuButtonItem.instanceFromNib(title: "Half", icon: UIImage(named: "Half")!, mainColor: UIColor.clear)
	item2View.titleLabel.textColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)

	// Initialize second ZenMenuItem using the second custom view
	let item2 = ZenMenuItem(customItemView: item2View, withSize: itemSize)

	// Initialize custom view (MenuButtonItem) to be used for the third ZenMenuItem
	let item3View = MenuButtonItem.instanceFromNib(title: "Full", icon: UIImage(named: "Full")!, mainColor: UIColor.clear)
	item3View.titleLabel.textColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1.0)

	// Initialize third ZenMenuItem using the third custom view
	let item3 = ZenMenuItem(customItemView: item3View, withSize: itemSize)


	// MARK: Assign ZenMenu's programmable attributes

	// set the View Controller view as the menuButton's parent view
	menuButton.parentView = self.view

	// set the menuButton's items
	menuButton.items = [item1, item2, item3]

	// set the direction of where the first ZenMenuItem will be displayed in reference to the ZenMenu
	menuButton.direction = .north

	// Set the type of ZenMenu that will be used
	menuButton.type = .fullCircle

	// Set the delegate for the menuButton
	menuButton.delegate = self


	// MARK: Finish initialization of ZenMenu
	menuButton.commonInit()

}
```


##### And your ZenMenuDelegate should match something similar to this:

```swift
extension MyViewController: ZenMenuDelegate {

    // Navigate to view controller represented by selected ZenMenuItem
    func zenMenu(_ zenMenu: ZenMenu, didSelectZenMenuItem zenMenuItem: ZenMenuItem, index: Int) {

	switch index {
	case 0:
	    // Navigate to the quarter circle view controller
	    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
	    let vc = storyboard.instantiateViewController(withIdentifier: "My2ndViewController") as! My2ndViewController
	    navigationController?.pushViewController(vc, animated: true)

	case 1:
	    // Navigate to the half circle view controller
	    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
	    let vc = storyboard.instantiateViewController(withIdentifier: "My3rdViewController") as! My3rdViewController
	    navigationController?.pushViewController(vc, animated: true)

	default:
	    // Already on the MyViewCntroller, simply close the menu
	    zenMenu.close()

	}
    }
}
```


##### The set up is now complete and your ZenMenu is fully functional.


## Additional Features


### ZenMenuHelper.swift

This is a file included with the pod that includes some functions for the UIView class. This class is meant to provide you, the programmer, with some easy to use modification to your UIViews. For example, there is one function in there that will spin the view around in a clockwise circle, and one that will spin it in a counterclockwise. These are handy to add some effects to your ZenMenu button and the ZenMenuItems when the menu is opening and closing. Feel free to utilize in your ZenMenu implementation. 


### ZenMenu Protocol Functions

There are a number of protocol functions you can utilize to customize your ZenMenu. For example, if you wanted to add an animation to the ZenMenu as it opens and closes, you could do so using the *willOpen(_ zenMenu: ZenMenu)* and *willClose(_ zenMenu: ZenMenu)* protocols, respectively. 

In the example above, you can see that each ZenMenuItem spins clockwise when being displayed, and spins counter-clockwise when being dismissed. In order for that to happen, I utilized the *zenMenuSpinClockwise()* and *zenMenuSpinCounterClockwise()* functions in the *ZenMenuHelper.swift* file and applied them to the ZenMenuItem being displayed using the *willPresentZenMenuItem* and *willDismissZenMenuItem* protocol functions, respectively. Here is the code added to the ZenMenuDelegate source:

```swift
// Add animation to the ZenMenuItems as they open
func zenMenu(_ zenMenu: ZenMenu, willPresentZenMenuItem zenMenuItem: ZenMenuItem, index: Int) {
	zenMenuItem.zenMenuSpinClockwise(duration: 0.3)
}

// Add animation to the ZenMenuItems as they close
func zenMenu(_ zenMenu: ZenMenu, willDismissZenMenuItem zenMenuItem: ZenMenuItem, index: Int) {
	zenMenuItem.zenMenuSpinCounterClockwise(duration: 0.3)
}
```

All protocol functions are optional. Make sure to view the ZenMenuDelegate protocol fucntions in ZenMenu.swift to explore the endless ways you can customize your ZenMenu.


## Authors

* **Tanner Juby** - *Initial work* - [ZenBanana](https://github.com/ZenBanana)


## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details

