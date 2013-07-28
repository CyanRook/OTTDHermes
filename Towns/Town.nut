class Town
{
	constructor();
	town_id = null;
	terminal_list = AIList();
	depot_list  = AIList();
	route_list = [];
}

function Town::AddTerminal(terminal)
{
	this.terminal_list.AddItem(terminal,0);
}

function Town::AddDepot(depot)
{
	this.depot_list.AddItem(depot,0);
}

function Town::AddRoute(Route)
{
	this.route_list.AddItem(Route,0);
}

function Town::RemoveRoute(Route)
{
	this.route_list.RemoveItem(Route,0);
}

function Town::RemoveTerminal(terminal)
{
	this.terminal_list.RemoveItem(terminal,0);
}

function Town::RemoveDepot(depot)
{
	this.depot_list.RemoveItem(depot,0);
}

