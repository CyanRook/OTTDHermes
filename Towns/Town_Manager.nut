class Town_Manager
{
	constructor();
	town_list = AIList();
}

function Town_Manager::Update()
{
	local tl = AITownList();
	foreach(twn in town_list)
	{
		tl.RemoveItem(twn.town_id)
	}
	foreach(twn in tl)
	{
		local NewTown = Town();
		NewTown.town_id = twn;
		town_list.AddItem(NewTown, twn);
	}
}