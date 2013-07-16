class HermesAI extends AIInfo 
{
    function GetAuthor()      { return "Ryan Cook/Praveen Sanjay"; }
    function GetName()        { return "HermesAI"; }
    function GetDescription() { return "OTTD AI built for VG AI at Georgia Tech"; }
    function GetVersion()     { return 1; }
    function GetDate()        { return "2013-07-15"; }
    function CreateInstance() { return "HermesAI"; }
    function GetShortName()   { return "Herm"; }
}
 
RegisterAI(HermesAI());
