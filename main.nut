/*  Hermes AI for OTTD
 *	Developed by Ryan Cook & Praveen Sanjay
 *	Main File */

/* Files writen by us to help our code */
require("Roads/roadconnecttown.nut");

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

	RoadConnectTown.BuildRoad(townid_a,townid_b);
    
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
