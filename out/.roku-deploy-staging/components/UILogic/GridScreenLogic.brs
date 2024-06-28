

sub ShowGridScreen()
    m.GridScreen = CreateObject("roSGNode", "GridScreen")
    m.GridScreen.ObserveField("rowItemSelected", "OnGridScreenItemSelected")
    ShowScreen(m.GridScreen) ' show GridScreen
    
end sub



sub OnGridScreenItemSelected(event as Object) ' invoked when GridScreen item is selected

    ring = m.top.FindNode("ring")
    label = m.top.FindNode("counter")
    calories = m.top.FindNode("titleLabel")
    notification = m.top.FindNode("goalLabel")

    caloriesBurned = label.text.ToInt()
    calorieGoal = 5000


    caloriesBurned = caloriesBurned + calories.text.ToInt()

    barPercent = (caloriesBurned * 100) / calorieGoal

   if barPercent >= 100 then
        ringString = "100"
        notification.text = "Daily Goal Met"
        notification.color = "0x77eb34ff"
    else
      ringString = barPercent.ToStr()
    end if

    
    ring.iconUri = "pkg:/images/ring/" + ringString + ".png"

    label.text = caloriesBurned

    grid = event.GetRoSGNode()
    ' extract the row and column indexes of the item the user selected
    m.selectedIndex = event.GetData()
    ' the entire row from the RowList will be used by the Video node
    rowContent = grid.content.GetChild(m.selectedIndex[0])
    itemIndex = m.selectedIndex[1]
    ShowVideoScreen(rowContent, itemIndex)
end sub