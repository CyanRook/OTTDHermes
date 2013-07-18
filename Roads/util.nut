// Add all the files for libraries here
import("util.superlib","SuperLib",13);
Road <- SuperLib.Road;
class Util
{
	constructor();
}

function Util::BuildDepot(town)
{

	local newDepot=Road.BuildNextToRoad(AITown.GetLocation(town),"DEPOT",-1,-1,50,155);


}

function Util::BuildBusStation(town)
{
	local newStation=Road.BuildNextToRoad(AITown.GetLocation(town), "BUS_STOP", -1, -1, 50, 150);

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