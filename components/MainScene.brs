' Entry point of MainScene
sub Init()
    ' set background color for scene. Applied only if backgroundUri has empty value
    m.goalAchievedShown = false
    m.top.backgroundColor = "0x662D91"
    m.top.backgroundUri = "pkg:/images/background.jpeg"
    m.splashText = m.top.FindNode("splashText")
    m.splashText.text = "Terms of service" ' Set your desired text content here
    ' Optional: Adjust other properties of m.splashText if needed (e.g., m.splashText.scrollSpeed = 30)
    ' Add other initialization code as necessary
    ' set initial visibility

    m.loadingIndicator = m.top.FindNode("loadingIndicator")
    
    m.overhang = m.top.FindNode("overhang")
    m.goalLabel = m.top.FindNode("goalLabel")
    
    m.counter = m.top.FindNode("counter")
    
    m.ring = m.top.FindNode("ring")

    ' Initialize and start the timer
    m.splashTimer = m.top.FindNode("splashTimer")
    m.splashTimer.ObserveField("fire", "OnSplashTimerFire")
    m.splashTimer.control = "start"
    
end sub

' Timer event handler
sub OnSplashTimerFire()
    InitScreenStack()
    ShowGridScreen()
    RunContentTask() ' retrieving content
    ' hide the splash text
    m.splashText.visible = false
    
    ' show other UI elements
    m.overhang.visible = true
    m.goalLabel.visible = true
    m.counter.visible = true
    m.ring.visible = true

    ' You can add additional initialization code here if needed
end sub

function CreateGoalAchievedScreen() as Object
    ' Create a new screen node (assuming it's a rectangle node for example)
    screenNode = CreateObject("roSGNode", "Rectangle")
    screenNode.width = "1920" ' Set appropriate width
    screenNode.height = "1080" ' Set appropriate height
    screenNode.color = "0x000000" ' Set background color

    ' Add text node for displaying goal achievement message
    textNode = CreateObject("roSGNode", "Label")
    textNode.text = "Congratulations! Goal Achieved!"
    textNode.translation = [960, 540] ' Position at the center of the screen
    textNode.font.size = 36
    textNode.font.color = "0xFFFFFF"

    ' Add the text node as a child of the screen node
    screenNode.appendChild(textNode)

    ' You can add more UI elements or logic here as needed

    return screenNode
end function

function OnKeyEvent(key as String, press as Boolean) as Boolean
    result = false
    label = m.top.FindNode("counter")
    caloriesBurned = label.text.ToInt()
    calorieGoal = 5000
    barPercent = (caloriesBurned * 100) / calorieGoal
    if press
        ' handle "back" key press
        if key = "back"
            print "close Screen!!"
            print caloriesBurned.ToStr()
            numberOfScreens = m.screenStack.Count()
            ' close top screen if there are two or more screens in the screen stack
            if numberOfScreens > 1
                CloseScreen(invalid)
                result = true

                if barPercent >= 100 and not m.goalAchievedShown
                    ' Create a new screen for goal achievement
                    newNode = CreateGoalAchievedScreen()
                    ShowScreen(newNode) ' Show the goal achieved screen
                    m.goalAchievedShown = true ' Set the toggle variable to true
                end if
            end if
        end if
    end if
    ' The OnKeyEvent() function must return true if the component handled the event,
    ' or false if it did not handle the event.
    return result
end function