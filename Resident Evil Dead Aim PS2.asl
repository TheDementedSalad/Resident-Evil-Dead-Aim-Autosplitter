//Resident Evil: Dead Aim IGT Timer & Room Autosplitter V1.0 07/09/2023
//Supports In Game Time & Autosplits on select doors

//emu-help tool created by jujstme - https://github.com/Jujstme
//script & ID's by TheDementedSalad

state("LiveSplit") {}

startup
{
	//Creates a persistent instance of the PS2 class (for PS2 emulators)
	//If you want to change it to another emulator type, change the "PS2" to say "PS1" if the splitter is for a PS1 Emu game
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS2");

	// You can look up for known IDs on https://psxdatacenter.com/
	vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
		//Address of Gamecode
		emu.MakeString("U_Gamecode", 10, 0x307397);		//SLUS-20669
		emu.MakeString("J_Gamecode", 10, 0x2CEE17);		//SLPM-65245
		emu.MakeString("P_Gamecode", 10, 0x3082CC);		//SLES-51448
		//-------------------------------------------------------------------------------------------------------------
		//General Game Info
		emu.Make<int>("J_IGT", 0x262DBC);
        emu.Make<float>("J_MS", 0x31A3B0);
		emu.Make<int>("J_Map", 0x3986C0);
		emu.Make<int>("J_Results", 0x254144);
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
		
		/*
        emu.Make<int>("U_IGT", 0x30D054);
        emu.Make<float>("U_MS", 0x3854F0);
		emu.Make<int>("U_Map", 0x5189C0);
		emu.Make<int>("U_Results", 0x2A4054);
		//Key Items
		emu.Make<byte>("U_FirstC", 0x2A3E1C);
		emu.Make<byte>("U_GuestK", 0x2A3E00);
		emu.Make<byte>("U_IDCard", 0x2A3E04);
		emu.Make<byte>("U_MaintK", 0x2A3E08);
		emu.Make<byte>("U_Handle", 0x2A3E0C);
		emu.Make<byte>("U_Crowbar", 0x2A3E10);
		emu.Make<byte>("U_CrewK", 0x2A3E14);
		emu.Make<byte>("U_RecR", 0x2A3E18);
		emu.Make<byte>("U_SecK", 0x2A3EDC);
		emu.Make<byte>("U_ElevL", 0x2A3E24);
		emu.Make<byte>("U_PodB", 0x2A3E28);
		emu.Make<byte>("U_DigiR", 0x2A3E2C);
		emu.Make<byte>("U_DigiRF", 0x2A3E30);
		emu.Make<byte>("U_BackK", 0x2A3E34);
	
	
        emu.Make<int>("P_IGT", 0x2A4A54);
        emu.Make<float>("P_MS", 0x31CFF8);
		emu.Make<int>("P_Map", 0x4B34C0);
		emu.Make<int>("P_Results", 0x2DE164);
		//Key Items
		emu.Make<byte>("P_FirstC", 0x2A481C);
		emu.Make<byte>("P_GuestK", 0x2A4800);
		emu.Make<byte>("P_IDCard", 0x2A4804);
		emu.Make<byte>("P_MaintK", 0x2A4808);
		emu.Make<byte>("P_Handle", 0x2A480C);
		emu.Make<byte>("P_Crowbar", 0x2A4810);
		emu.Make<byte>("P_CrewK", 0x2A4814);
		emu.Make<byte>("P_RecR", 0x2A4818);
		emu.Make<byte>("P_SecK", 0x2A48DC);
		emu.Make<byte>("P_ElevL", 0x2A4824);
		emu.Make<byte>("P_PodB", 0x2A4828);
		emu.Make<byte>("P_DigiR", 0x2A482C);
		emu.Make<byte>("P_DigiRF", 0x2A4830);
		emu.Make<byte>("P_BackK", 0x2A4834);
		*/
        return true;
    });
	
	settings.Add("Note", true, "Please Restart Game Ever Run So IGT Correctly Resets");
	
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
	settings.Add("FirstC_1", false, "Pick Up 1st Class Key");
	settings.Add("FirstC_100", false, "Use 1st Class Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("GuestK", false, "Guest Keycard");
	settings.CurrentDefaultParent = "GuestK";
	settings.Add("GuestK_1", false, "Pick Up Guest Keycard");
	settings.Add("GuestK_2", false, "Used Card to Unlock Door");
	settings.Add("GuestK_100", false, "Used Card On Panel Control");
	settings.CurrentDefaultParent = "Item";
	settings.Add("IDCard", false, "ID Card");
	settings.CurrentDefaultParent = "IDCard";
	settings.Add("IDCard_1", false, "Pick Up ID Card");
	settings.Add("IDCard_100", false, "Use ID Card");
	settings.CurrentDefaultParent = "Item";
	settings.Add("MaintK", false, "Maintenance Key");
	settings.CurrentDefaultParent = "MaintK";
	settings.Add("MaintK_1", false, "Pick Up Maintenance Key");
	settings.Add("MaintK_100", false, "Use Maintenance Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("Handle", false, "Handle");
	settings.CurrentDefaultParent = "Handle";
	settings.Add("Handle_1", false, "Pick Up Handle");
	settings.Add("Handle_100", false, "Use Handle");
	settings.CurrentDefaultParent = "Item";
	settings.Add("Crowbar", false, "Crowbar");
	settings.CurrentDefaultParent = "Crowbar";
	settings.Add("Crowbar_1", false, "Pick Up Crowbar");
	settings.CurrentDefaultParent = "Item";
	settings.Add("CrewK", false, "Crewman's Keycard");
	settings.CurrentDefaultParent = "CrewK";
	settings.Add("CrewK_1", false, "Pick Up Crewman's Keycard");
	settings.Add("CrewK_100", false, "Use Crewman's Keycard");
	settings.CurrentDefaultParent = "Item";
	settings.Add("RecR", false, "Recreation Room Key");
	settings.CurrentDefaultParent = "RecR";
	settings.Add("RecR_1", false, "Pick Up Recreation Room Key");
	settings.Add("RecR_100", false, "Use Recreation Room Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("SecK", false, "Sector Admin Key");
	settings.CurrentDefaultParent = "SecK";
	settings.Add("SecK_1", false, "Pick Up Sector Admin Key");
	settings.Add("SecK_100", false, "Use Sector Admin Key");
	settings.CurrentDefaultParent = "Item";
	settings.Add("ElevL", false, "Elevator Keycard");
	settings.CurrentDefaultParent = "ElevL";
	settings.Add("ElevL_1", false, "Pick Up Elevator Keycard");
	settings.Add("ElevL_100", false, "Use Elevator Keycard");
	settings.CurrentDefaultParent = "Item";
	settings.Add("PodB", false, "Pod Bay Keycard");
	settings.CurrentDefaultParent = "PodB";
	settings.Add("PodB_1", false, "Pick Up Pod Bay Keycard");
	settings.Add("PodB_100", false, "Use Pod Bay Keycard");
	settings.CurrentDefaultParent = "Item";
	settings.Add("DigiR", false, "Digital Recorder");
	settings.CurrentDefaultParent = "DigiR";
	settings.Add("DigiR_1", false, "Pick Up Digital Recorder");
	settings.Add("DigiRF_1", false, "Record Morpheus' Voice");
	settings.Add("DigiRF_100", false, "Use Digital Recorder (Full)");
	settings.CurrentDefaultParent = "Item";
	settings.Add("BackK", false, "Backyard Key");
	settings.CurrentDefaultParent = "BackK";
	settings.Add("BackK_1", false, "Pick Up Backyard Key");
	settings.Add("BackK_100", false, "Use Backyard Key");
	settings.CurrentDefaultParent = null;
	
	settings.Add("Final", true, "Final Split - Splits On Results Screen (Always Active)");
}

init
{
	//Create a list that can hold our completed split strings
	vars.completedSplits = new HashSet<string>();
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
	//Start condition
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
