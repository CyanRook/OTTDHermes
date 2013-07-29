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
require("Roads/roadroute.nut");

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
	Route_List = [];
	Start_Date = null;
	Evaluate_Return = false;
}
 
 /* Main Function Call
	Called by OTTD */
function HermesAI::Start()
{
    AILog.Info("HermesAI Started.");
    SetCompanyName();
	Start_Date = AIDate.GetCurrentDate();
	
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
	local New_Route = RoadRoute();
	New_Route.Init();
	New_Route.AddTerminal(Util.BuildBusStation(townid_a));
	New_Route.AddDepot(Util.BuildDepot(townid_a));
	for(local i=0;i<3;i+=1)
	{
		local closeTown = Util.ClosestTown(townid_a,townlist,connectedList);
		connectedList.AddItem(closeTown,0);
		New_Route.AddTerminal(Util.BuildBusStation(closeTown));
		New_Route.AddDepot(Util.BuildDepot(closeTown));
		RoadConnectTown.BuildRoad(townid_a, closeTown);
	}
	New_Route.AutoSetCargo();
	New_Route.BuildVehicle();
	New_Route.BuildVehicle();
	
	Route_List.append(New_Route);

	AILog.Info("Made it past util stuff");
	
	ActionLoop();
	
	AILog.Info("Made it past util stuff");
    
    AILog.Info("Done");
}
 
 function HermesAI::ActionLoop()
 {
	AILog.Info("Entered Action Loop");
	while (true)
	{
		EvaluateRoadRoutes();
		ImproveRoadRoutes();
		RepayLoans();
		BuildNewRoutes();
	}
}

function HermesAI::EvaluateRoadRoutes()
{
	Evaluate_Return = false;
	foreach(route in Route_List)
	{
		Evaluate_Return = Evaluate_Return || route.EvaluateRoute();
	}
}

function HermesAI::ImproveRoadRoutes()
{
	foreach(route in Route_List)
	{
		route.ImproveRoute();
	}
}

function HermesAI::RepayLoans()
{
	if((AICompany.GetLoanAmount() > 0) && (AICompany.GetBankBalance(AICompany.COMPANY_SELF) > 40000) && ((AIDate.GetYear(AIDate.GetCurrentDate())-AIDate.GetYear(Start_Date))>5))
	{
		AICompany.SetLoanAmount(AICompany.GetLoanAmount() - 20000);
	}
}

function HermesAI::BuildNewRoutes()
{
	if(Evaluate_Return == false)
	{
		//Code to build a new route set
	}
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
