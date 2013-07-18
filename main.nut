/*  Hermes AI for OTTD
 *	Developed by Ryan Cook & Praveen Sanjay
 *	Main File */

 // Add all the files for libraries here
import("util.superlib","SuperLib",13);
/* Files writen by us to help our code */
require("Roads/roadconnecttown.nut");
require("Roads/util.nut");
Road <- SuperLib.Road;
RoadBuilder <- SuperLib.RoadBuilder;
Engine <- SuperLib.Engine;
OrderList <- SuperLib.OrderList;

/* External Libraries Imported From OTTD Online Resources */
import("pathfinder.road", "RoadPathFinder", 3);

class HermesAI extends AIController
{
    function Start();
    constructor()
    {
    } 
}
 
 /* Main Function Call
	Called by OTTD */
function HermesAI::Start()
{
    AILog.Info("HermesAI Started.");
    SetCompanyName();
    /* Get a list of all towns on the map. */
    local townlist = AITownList();
	


    /* Sort the list by population, highest population first. */
    townlist.Valuate(AITown.GetPopulation);
    townlist.Sort(AIAbstractList.SORT_BY_VALUE, false);

    /* Pick the two towns with the highest population. */
    local townid_a = townlist.Begin();
    local townid_b = townlist.Next();
	AIRoad.SetCurrentRoadType(AIRoad.ROADTYPE_ROAD);
	
	local rb=RoadBuilder();

	local Depot1 = Util.BuildDepot(townid_a);
	local Station1 = Util.BuildBusStation(townid_a);
	Util.BuildDepot(townid_b);
	local Station2 = Util.BuildBusStation(townid_b);
	rb.Init(Station1,Station2);
//	rb.ConnectTiles();
	RoadConnectTown.BuildRoad(townid_a, townid_b);
	local engine_list = AIEngineList(AIVehicle.VT_ROAD);
	local Correct_Cargo = AICargoList_StationAccepting(Station1);
	local engine_choice;
	foreach(engine in engine_list)
	{
		if(AIEngine.CanPullCargo(engine,Correct_Cargo.Begin()))
		{
			engine_choice = engine;
		}
	}
	//local myEngine=Engine.GetEngine_PAXLink(10, AIVehicle.VT_ROAD);
	local Veh1=AIVehicle.BuildVehicle(Depot1,engine_choice);
	local ol=OrderList();
	ol.AddStop(AIStation.GetStationID(Station1), AIOrder.AIOF_NONE);
	ol.AddStop(AIStation.GetStationID(Station2), AIOrder.AIOF_NONE);
	ol.ApplyToVehicle(Veh1);
	AIVehicle.StartStopVehicle(Veh1)
	AILog.Info("Made it past util stuff");
	/*
	local VehID = AIVehicle.BuildVehicle(AIDepotList(1).Begin(), engine_choice);
	local StList = AIStationList(2);
	local TList = AITileList_StationType(StList.Begin(), 2);
	AIOrder.InsertOrder(VehID,0,TList.Begin(),0);
	AIOrder.InsertOrder(VehID,0,TList.Next(),0);
	*/
	
	AILog.Info("Made it past util stuff");
    
    AILog.Info("Done");
}
 
function HermesAI::Save()
{
    local table = {};	
    //TODO: Add your save data to the table.
    return table;
}

function HermesAI::Load(version, data)
{
    AILog.Info(" Loaded");
    //TODO: Add your loading routines.
}
 
 
function HermesAI::SetCompanyName()
{
    if(!AICompany.SetName("HermesAI"))
    {
        local i = 2;
        while(!AICompany.SetName("HermesAI #" + i))
        {
            i = i + 1;
            if(i > 255) break;
        }
    }
    AICompany.SetPresidentName("Hermes");
}
