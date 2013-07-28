/*  Hermes AI for OTTD
 *	Developed by Ryan Cook & Praveen Sanjay
 *	Main File
 *  Test comment 
 */

 // Add all the files for libraries here
import("util.superlib","SuperLib",13);
/* Files writen by us to help our code */
require("Roads/roadconnecttown.nut");
require("Roads/util.nut");
require("Roads/roadroute.nut")

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
	local connectedList = AIList();


    /* Sort the list by population, highest population first. */
    townlist.Valuate(AITown.GetPopulation);
    townlist.Sort(AIAbstractList.SORT_BY_VALUE, false);

    /* Pick the two towns with the highest population. */
    local townid_a = townlist.Begin();
    local townid_b = townlist.Next();
	connectedList.AddItem(townid_a,0)
	AIRoad.SetCurrentRoadType(AIRoad.ROADTYPE_ROAD);
	local Route_1 = RoadRoute();
	Route_1.Init();
	Route_1.AddTerminal(Util.BuildBusStation(townid_a));
	Route_1.AddDepot(Util.BuildDepot(townid_a));
	for(local i=0;i<3;i+=1)
	{
		local closeTown = Util.ClosestTown(townid_a,townlist,connectedList);
		connectedList.AddItem(closeTown,0);
		Route_1.AddTerminal(Util.BuildBusStation(closeTown));
		Route_1.AddDepot(Util.BuildDepot(closeTown));
		RoadConnectTown.BuildRoad(townid_a, closeTown);
	}
	Route_1.AutoSetCargo();
	Route_1.BuildVehicle();

	
	//RoadConnectTown.BuildRoad(townid_a, townid_b);



	

	
	
/*	local Route_1 = RoadRoute();
	Route_1.Init();
	Route_1.AddTerminal(Util.BuildBusStation(townid_a));
	Route_1.AddTerminal(Util.BuildBusStation(townid_b));
	Route_1.AddDepot(Util.BuildDepot(townid_a));
	Route_1.AddDepot(Util.BuildDepot(townid_b));
	Route_1.AutoSetCargo();
	Route_1.BuildVehicle();*/
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
