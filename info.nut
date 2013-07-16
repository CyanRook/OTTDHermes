class HermesAI extends AIInfo 
 {
   function GetAuthor()      { return "Ryan Cook/Praveen Sanjay"; }
   function GetName()        { return "HermesAI"; }
   function GetDescription() { return "OTTD AI built for VG AI at Georgia Tech"; }
   function GetVersion()     { return 1; }
   function GetDate()        { return "2013-07-15"; }
   function CreateInstance() { return "HermesAI"; }
   function GetShortName()   { return "Hermes"; }
   
   function GetSettings() 
   {
     AddSetting({name = "bool_setting",
                 description = "a bool setting, default off", 
                 easy_value = 0, 
                 medium_value = 0, 
                 hard_value = 0, 
                 custom_value = 0, 
                 flags = AICONFIG_BOOLEAN});
                 
     AddSetting({name = "bool2_setting", 
                description = "a bool setting, default on", 
                easy_value = 1, 
                medium_value = 1, 
                hard_value = 1, 
                custom_value = 1, 
                flags = AICONFIG_BOOLEAN});
                
     AddSetting({name = "int_setting", 
                 description = "an int setting", 
                 easy_value = 30, 
                 medium_value = 20, 
                 hard_value = 10, 
                 custom_value = 20, 
                 flags = 0, 
                 min_value = 1, 
                 max_value = 100});    	
   }
 }
 
 RegisterAI(HermesAI());