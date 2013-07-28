class RoadRoute
{
	constructor();
	terminal_list = AIList();
	depot_list  = AIList();
	vehicle_list = AIList();
	cargo_type = null;
}

function RoadRoute::Init()
{
}

function RoadRoute::SetCargo(cargo)
{
	this.cargo_type = cargo;
}

function RoadRoute::AutoSetCargo()
{
	local cargo_list = AICargoList_StationAccepting(terminal_list.Begin());
	foreach (terminal in terminal_list)
	{
		cargo_list.KeepList(AICargoList_StationAccepting(terminal));
	}
	SetCargo(cargo_list.Begin());
}

function RoadRoute::AddTerminal(terminal)
{
	this.terminal_list.AddItem(terminal,0);
}

function RoadRoute::AddDepot(depot)
{
	this.depot_list.AddItem(depot,0);
}

function RoadRoute::AddVehicle(vehicle)
{
	this.vehicle_list.AddItem(vehicle,0);
}

function RoadRoute::RemoveTerminal(terminal)
{
	this.terminal_list.RemoveItem(terminal,0);
}

function RoadRoute::RemoveDepot(depot)
{
	this.depot_list.RemoveItem(depot,0);
}

function RoadRoute::RemoveVehicle(vehicle)
{
	this.vehicle_list.RemoveItem(vehicle,0);
}

function RoadRoute::BuildVehicle()
{
	local engine_list = AIEngineList(AIVehicle.VT_ROAD);
	local engine_choice;
	
	engine_list.Valuate(AIEngine.GetRoadType);
	engine_list.KeepValue(AIRoad.ROADTYPE_ROAD);
	
	local balance = AICompany.GetBankBalance(AICompany.COMPANY_SELF);
	engine_list.Valuate(AIEngine.GetPrice);
	engine_list.KeepBelowValue(balance);

	engine_list.Valuate(AIEngine.GetCargoType)
	engine_list.KeepValue(cargo_type); 

	engine_list.Valuate(AIEngine.GetCapacity)
	engine_list.KeepTop(1);
	
	engine_choice = engine_list.Begin();
	
	local Veh1=AIVehicle.BuildVehicle(depot_list.Begin(),engine_choice);
	if(!AIVehicle.IsValidVehicle(Veh1)) 
		AILog.Warning("Could not build a vehicle: " + AIError.GetLastErrorString());
	local ol=OrderList();
	foreach(terminal,v in terminal_list)
	{
		//ol.AddStop(AIStation.GetStationID(terminal), AIOrder.AIOF_NONE);
		AIOrder.InsertOrder(Veh1,0,terminal,AIOrder.AIOF_NONE);
	}
	AILog.Info(AIOrder.IsValidVehicleOrder(Veh1,0))
	//ol.ApplyToVehicle(Veh1);
	AIVehicle.StartStopVehicle(Veh1)
	AddVehicle(Veh1);
}