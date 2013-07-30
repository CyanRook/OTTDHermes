// Add all the files for libraries here
import("util.superlib","SuperLib",13);
Road <- SuperLib.Road;
require("roadroute.nut");
class Util
{
	constructor();
}

function Util::BuildDepot(town)
{

	local newDepot=Road.BuildNextToRoad(AITown.GetLocation(town),"DEPOT",-1,-1,50,155);
	return newDepot;
}

function Util::BuildBusStation(town)
{
	local newStation=Road.BuildNextToRoad(AITown.GetLocation(town), "BUS_STOP", -1, -1, 50, 150);
	return newStation;
}

function Util::ClosestTown(townStart,townlist,connectedList)
{
	local minDist = 2137483647;
	local closeTown = 0;
	local maxTile = AITown.GetLocation(townStart);
	foreach(town,v in townlist)
	{
		//AILog.Info(AITown.GetName(town))
		//AILog.Info(AITown.IsValidTown(town))
		if(AITown.IsValidTown(town) && !connectedList.HasItem(town))
		{
			AILog.Info(AITown.GetName(town))
			local distance = AITown.GetDistanceManhattanToTile(town,maxTile);
			AILog.Info(distance);
			
			if(distance < minDist)
				if(distance > 0)
				{
					closeTown = town;
					minDist = distance;
				}
		}
	}
	return closeTown

} 
function Util::BuildTownRoute(town,countryRoute)
{
	local City_Route = RoadRoute();
	City_Route.Init();
	local cityStation = Util.BuildBusStation(town);
	City_Route.AddTerminal(cityStation);
	countryRoute.AddTerminal(cityStation)
	local stations = AITown.GetPopulation(town)/500;
	for(local i=0;i<stations;i+=1)
		City_Route.AddTerminal(Util.BuildBusStation(town));
	local cityDepot = Util.BuildDepot(town);
	City_Route.AddDepot(cityDepot);
	City_Route.AutoSetCargo();
	City_Route.BuildVehicle(cityDepot);

	return City_Route

}

/*
	local tile = AITown.GetLocation(town_id);
	local xOffSet = 0;
	local yOffSet = 0;
	local inc = 1;
	local direction = 0;
	local isValid = false;
	while (!isValid)
	{
		if (AIRoad.IsRoadTile(tile + AIMap.GetTileIndex(0, 1)) || AIRoad.IsRoadTile(tile + AIMap.GetTileIndex(0, -1))) 
		{
			if (AIRoad.BuildDriveThroughRoadStation(tile, tile + AIMap.GetTileIndex(0, 1), AIRoad.ROADVEHTYPE_BUS, AIStation.STATION_NEW)) 
				return tile + AIMap.GetTileIndex(0, 1);
		} else if (AIRoad.IsRoadTile(tile + AIMap.GetTileIndex(1, 0)) || AIRoad.IsRoadTile(tile + AIMap.GetTileIndex(-1, 0))) 
		{
			if (AIRoad.BuildDriveThroughRoadStation(tile, tile + AIMap.GetTileIndex(1, 0), AIRoad.ROADVEHTYPE_BUS, AIStation.STATION_NEW)) 
				return tile + AIMap.GetTileIndex(1, 0);
		}
	}
	return 0;
*/