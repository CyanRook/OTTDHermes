class RoadRoute
{
	constructor();
}

function RoadRoute::Init()
{
	local terminal_list;
	local depot_list;
	local vehicle_list;
}

function RoadRoute::AddTerminal(terminal)
{
	terminal_list.AddItem(terminal,0);
}

function RoadRoute::AddDepot(depot)
{
	depot_list.AddItem(depot,0);
}

function RoadRoute::AddVehicle(vehicle)
{
	vehicle_list.AddItem(vehicle,0);
}

function RoadRoute::RemoveTerminal(terminal)
{
	terminal_list.RemoveItem(terminal,0);
}

function RoadRoute::RemoveDepot(depot)
{
	depot_list.RemoveItem(depot,0);
}

function RoadRoute::RemoveVehicle(vehicle)
{
	vehicle_list.RemoveItem(vehicle,0);
}