//Resident Evil: Dead Aim IGT Timer & Autosplitter V1.0.5 4/10/2023
//Supports In Game Time & Autosplits

//emu-help tool created by jujstme - https://github.com/Jujstme
//script & ID's by TheDementedSalad

state("LiveSplit") {}

startup
{
	// Creates a persistent instance of the PS2 class (for PS2 emulators)
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS2");
	
	vars.bitCheck = new Func<byte, int, bool>((byte val, int b) => (val & (1 << b)) != 0);

	// You can look up for known IDs on https://psxdatacenter.com/
	vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
		emu.MakeString("NTSCJ_Gamecode", 10, 0x2CEE17);		//SLPM-65245
        	emu.Make<int>("NTSCJ_IGT", 0x262DBC);
        	emu.Make<float>("NTSCJ_MS", 0x31A3B0);
		emu.Make<int>("NTSCJ_Map", 0x3986C0);
		emu.Make<int>("NTSCJ_Results", 0x254144);
		//Key Items
		emu.Make<byte>("J_FirstC", 0x262B8C);
		emu.Make<byte>("J_GuestK", 0x262B70);
		emu.Make<byte>("J_IDCard", 0x262B74);
		emu.Make<byte>("J_MaintK", 0x262B78);
		emu.Make<byte>("J_Handle", 0x262B7C);
		emu.Make<byte>("J_Crowbar", 0x262B80);
		emu.Make<byte>("J_CrewK", 0x262B84);
		emu.Make<byte>("J_RecR", 0x262B88);
		emu.Make<byte>("J_SecK", 0x262C4C);
		emu.Make<byte>("J_ElevL", 0x262B94);
		emu.Make<byte>("J_PodB", 0x262B98);
		emu.Make<byte>("J_DigiR", 0x262B9C);
		emu.Make<byte>("J_DigiRF", 0x262BA0);
		emu.Make<byte>("J_BackK", 0x262BA4);
        return true;
    });
	
	settings.Add("Note", true, "Please Restart Game Every Run So IGT Correctly Resets");
	
	settings.Add("Boss", false, "Boss Splits");
	settings.CurrentDefaultParent = "Boss";
	settings.Add("Hunters", false, "Defeat Hunters");
	settings.Add("100_110", false, "Defeat Tyrant");
	settings.Add("910_560", false, "Defeat Pluto");
	settings.Add("350_340", false, "Defeat Halbert");
	settings.Add("Morpheus1", false, "Defeat Morpheus 1");
	settings.CurrentDefaultParent = null;
	
	
	settings.Add("Item", false, "Item Splitter");
	settings.CurrentDefaultParent = "Item";
	settings.Add("FirstC", false, "1st Class Key");
	settings.CurrentDefaultParent = "FirstC";
	settings.Add("FirstCP", false, "Pick Up 1st Class Key");
	settings.Add("FirstCU", false, "Use 1st Class Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("GuestK", false, "Guest Keycard");
	settings.CurrentDefaultParent = "GuestK";
	settings.Add("GuestKP", false, "Pick Up Guest Keycard");
	settings.Add("GuestKD", false, "Used Card to Unlock Door");
	settings.Add("GuestKU", false, "Used Card On Panel Control");
	settings.CurrentDefaultParent = "Item";
	settings.Add("IDCard", false, "ID Card");
	settings.CurrentDefaultParent = "IDCard";
	settings.Add("IDCardP", false, "Pick Up ID Card");
	settings.Add("IDCardU", false, "Use ID Card");
	settings.CurrentDefaultParent = "Item";
	settings.Add("MaintK", false, "Maintenance Key");
	settings.CurrentDefaultParent = "MaintK";
	settings.Add("MaintKP", false, "Pick Up Maintenance Key");
	settings.Add("MaintKU", false, "Use Maintenance Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("Handle", false, "Handle");
	settings.CurrentDefaultParent = "Handle";
	settings.Add("HandleP", false, "Pick Up Handle");
	settings.Add("HandleU", false, "Use Handle");
	settings.CurrentDefaultParent = "Item";
	settings.Add("Crowbar", false, "Crowbar");
	settings.CurrentDefaultParent = "Crowbar";
	settings.Add("CrowbarP", false, "Pick Up Crowbar");
	settings.CurrentDefaultParent = "Item";
	settings.Add("CrewK", false, "Crewman's Keycard");
	settings.CurrentDefaultParent = "CrewK";
	settings.Add("CrewKP", false, "Pick Up Crewman's Keycard");
	settings.Add("CrewKU", false, "Use Crewman's Keycard");
	settings.CurrentDefaultParent = "Item";
	settings.Add("RecR", false, "Recreation Room Key");
	settings.CurrentDefaultParent = "RecR";
	settings.Add("RecRP", false, "Pick Up Recreation Room Key");
	settings.Add("RecRU", false, "Use Recreation Room Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("SecK", false, "Sector Admin Key");
	settings.CurrentDefaultParent = "SecK";
	settings.Add("SecKP", false, "Pick Up Sector Admin Key");
	settings.Add("SecKU", false, "Use Sector Admin Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("ElevL", false, "Elevator Keycard");
	settings.CurrentDefaultParent = "ElevL";
	settings.Add("ElevLP", false, "Pick Up Elevator Keycard");
	settings.Add("ElevLU", false, "Use Elevator Keycard");
	settings.CurrentDefaultParent = "Item";
	settings.Add("PodB", false, "Pod Bay Keycard");
	settings.CurrentDefaultParent = "PodB";
	settings.Add("PodBP", false, "Pick Up Pod Bay Keycard");
	settings.Add("PodBU", false, "Use Pod Bay Keycard");
	settings.CurrentDefaultParent = "Item";
	settings.Add("DigiR", false, "Digital Recorder");
	settings.CurrentDefaultParent = "DigiR";
	settings.Add("DigiRP", false, "Pick Up Digital Recorder");
	settings.Add("DigiRFP", false, "Record Morpheus' Voice");
	settings.Add("DigiRFU", false, "Use Digital Recorder (Full)");
	settings.CurrentDefaultParent = "Item";
	settings.Add("BackK", false, "Backyard Key");
	settings.CurrentDefaultParent = "BackK";
	settings.Add("BackKP", false, "Pick Up Backyard Key");
	settings.Add("BackKU", false, "Use Backyard Key");
	settings.CurrentDefaultParent = null;
	
	settings.Add("Final", true, "Final Split - Splits On Results Screen (Always Active)");
}

init
{
	vars.completedSplits = new bool[50];
}

update
{
	// get a casted (to dictionary) reference to current
	// so we can manipulate it using dynamic keynames
	var cur = current as IDictionary<string, object>;

	// list of pc address names to be recreated when on emu
	var names = new List<string>() { 
		"IGT",
		"MS",
		"Map",
		"Results",
		"FirstC",
		"GuestK",
		"IDCard",
		"MaintK",
		"Handle",
		"Crowbar",
		"CrewK",
		"RecR",
		"SecK",
		"ElevL",
		"PodB",
		"DigiR",
		"DigiRF",
		"BackK",
	};

	// (placeholder) have some logic to work out the version and create the prefix
	string ver = null;

	// assign version based on gamecode
	if (current.J_Gamecode == "SLPM-65245") ver = "J_";

	// if in a supported version of the game...
	if (ver == null) return false;
	// loop through each desired address...
	foreach(string name in names) {
		// set e.g. current.GameTime to the value at e.g. current.US_GameTime
		cur[name] = cur[ver + name];
	}
	
	//GameTime
	current.Time = current.IGT + current.MS;
}

onStart
{
	//Clear the variable on start
	vars.completedSplits.Clear();
}

start
{
	return current.Time != old.Time && old.Time < 1 && current.Map == 258;
}

split
{
	//Create an empty setting
	string setting = "";
	
	//Whenever the value of something here changes, it assigns the setting info. E.g if FirstC changes
	//from 0 to 1 when you pick it up then it will pass FirstC_1 which we can then use as the split ID
	if(current.FirstC != old.FirstC){
		setting = "FirstC_" + current.FirstC;
	}
	if(current.GuestK != old.GuestK){
		setting = "GuestK_" + current.GuestK;
	}
	if(current.IDCard != old.IDCard){
		setting = "IDCard_" + current.IDCard;
	}
	if(current.MaintK != old.MaintK){
		setting = "MaintK_" + current.MaintK;
	}
	if(current.Handle != old.Handle){
		setting = "Handle_" + current.Handle;
	}
	if(current.Crowbar != old.Crowbar){
		setting = "Crowbar_" + current.Crowbar;
	}
	if(current.CrewK != old.CrewK){
		setting = "CrewK_" + current.CrewK;
	}
	if(current.RecR != old.RecR){
		setting = "RecR_" + current.RecR;
	}
	if(current.SecK != old.SecK){
		setting = "SecK_" + current.SecK;
	}
	if(current.ElevL != old.ElevL){
		setting = "ElevL_" + current.ElevL;
	}
	if(current.PodB != old.PodB){
		setting = "PodB_" + current.PodB;
	}
	if(current.DigiR != old.DigiR){
		setting = "DigiR_" + current.DigiR;
	}
	if(current.DigiRF != old.DigiRF){
		setting = "DigiRF_" + current.DigiRF;
	}
	if(current.BackK!= old.BackK){
		setting = "BackK_" + current.BackK;
	}
	
	//Same for current map
	if(current.Map != old.Map){
		setting = current.Map + "_" + old.Map;
	}
	
	if(setting == "490_391" || setting == "490_392" || setting == "490_393"){
		setting = "Hunters";
	}
	
	if(setting == "430_410" || setting == "430_411" || setting == "430_412" || setting == "430_413" || setting == "430_414" ||
		setting == "430_414" || setting == "430_415" || setting == "430_416" || setting == "430_417" || setting == "430_418"){
			setting = "Morpheus1";
	}
	
	//final split - always active
	if(current.Results > 0 && old.Results == 0 && current.Map == 470){
		setting = "Final";
	}
	
	// Debug. Comment out before release (prints the setting to a debugger)
    if (!string.IsNullOrEmpty(setting)){
		print(setting);
	}
	
	//Adds the split to completedSplits if our settings is enabled and contains the correct ID
	if (settings.ContainsKey(setting) && settings[setting] && vars.completedSplits.Add(setting)) {
		return true;
	}
}

gameTime
{
	return TimeSpan.FromSeconds(current.Time);
}

isLoading
{
	return true;
}

reset
{
	return current.Time == 0 && current.Map == 0;
}

shutdown
{
	// Please don't remove this line from this block
	vars.Helper.Dispose();
}
