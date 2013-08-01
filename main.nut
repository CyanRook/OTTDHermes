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
	connectedList = AIList();
	Main_Route = null;
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


    /* Sort the list by population, highest population first. */
    townlist.Valuate(AITown.GetPopulation);
    townlist.Sort(AIAbstractList.SORT_BY_VALUE, false);

    /* Pick the two towns with the highest population. */
    local townid_a = townlist.Begin();
    local townid_b = townlist.Next();
	connectedList.AddItem(townid_a,0);
	AIRoad.SetCurrentRoadType(AIRoad.ROADTYPE_ROAD);
	Main_Route = Util.BuildRoadNetwork(townid_a,townlist,connectedList);
	foreach(town,v in townlist)
	{
		if(!connectedList.HasItem(town))
		{
			local Town_Route = Util.BuildRoadNetwork(town,townlist,connectedList);
			Route_List.append(Town_Route);
			break;
		}
	}

	

	AILog.Info("Made it past util stuff");
	
	ActionLoop();
	
	AILog.Info("Made it past util stuff");
    
    AILog.Info("Done");
}

 function HermesAI::Init()
 {

 
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
		local townlist = AITownList();
		foreach(town,v in townlist)
		{
			if(!connectedList.HasItem(town))
			{
				local Town_Route = Util.BuildTownRoute(town,Main_Route);
				Route_List.append(Town_Route);
			
				break;
			}
		}
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
