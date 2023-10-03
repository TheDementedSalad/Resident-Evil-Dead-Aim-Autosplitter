//Resident Evil: Dead Aim IGT Timer & Autosplitter V1.0.5 4/10/2023
//Supports In Game Time & Autosplits

//emu-help tool created by jujstme - https://github.com/Jujstme
//script & ID's by TheDementedSalad

state("LiveSplit") {}

startup
{
	// Creates a persistent instance of the PS1 class (for PS1 emulators)
	Assembly.Load(File.ReadAllBytes("Components/emu-help-v2")).CreateInstance("PS2");
	
	vars.bitCheck = new Func<byte, int, bool>((byte val, int b) => (val & (1 << b)) != 0);

	// You can look up for known IDs on https://psxdatacenter.com/
	vars.Helper.Load = (Func<dynamic, bool>)(emu => 
    {
		emu.MakeString("NTSCU_Gamecode", 10, 0x307397);		//SLUS-20669
        emu.Make<int>("NTSCU_IGT", 0x30D054);
        emu.Make<float>("NTSCU_MS", 0x3854F0);
		emu.Make<int>("NTSCU_Map", 0x5189C0);
		emu.Make<int>("NTSCU_Results", 0x2A4054);
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
		
		
		
		emu.MakeString("PAL_Gamecode", 10, 0x3082CC);		//SLES-51448
        emu.Make<int>("PAL_IGT", 0x30DA54);
        emu.Make<float>("PAL_MS", 0x385FF8);
		emu.Make<int>("PAL_Map", 0x51C4C0);
		emu.Make<int>("PAL_Results", 0x2DE164);
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
        return true;
    });
	
	settings.Add("Note", true, "Please Restart Game Every Run So IGT Correctly Resets");
	
	settings.Add("Boss", false, "Boss Splits");
	settings.CurrentDefaultParent = "Boss";
	settings.Add("490", false, "Defeat Hunters");
	settings.Add("100", false, "Defeat Tyrant");
	settings.Add("910", false, "Defeat Pluto");
	settings.Add("350", false, "Defeat Halbert");
	settings.Add("430", false, "Defeat Morpheus 1");
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
	if (!vars.Helper.Update()) return false;
	
	if(timer.CurrentPhase == TimerPhase.NotRunning)
	{
		vars.completedSplits = new bool[50];
	}
	
	if(current.NTSCU_Gamecode == "SLUS-20669"){
		current.Time = current.NTSCU_IGT + current.NTSCU_MS;
		current.Map = current.NTSCU_Map;
		current.Results = current.NTSCU_Results;
		//Items
		current.FirstC = current.U_FirstC;
		current.GuestK = current.U_GuestK;
		current.IDCard = current.U_IDCard;
		current.MaintK = current.U_MaintK;
		current.Handle = current.U_Handle;
		current.Crowbar = current.U_Crowbar;
		current.CrewK = current.U_CrewK;
		current.RecR = current.U_RecR;
		current.SecK = current.U_SecK;
		current.ElevL = current.U_ElevL;
		current.PodB = current.U_PodB;
		current.DigiR = current.U_DigiR;
		current.DigiRF = current.U_DigiRF;
		current.BackK = current.U_BackK;
	}
	else if(current.NTSCJ_Gamecode == "SLPM-65245"){
		current.Time = current.NTSCJ_IGT + current.NTSCJ_MS;
		current.Map = current.NTSCJ_Map;
		current.Results = current.NTSCJ_Results;
		//Items
		current.FirstC = current.J_FirstC;
		current.GuestK = current.J_GuestK;
		current.IDCard = current.J_IDCard;
		current.MaintK = current.J_MaintK;
		current.Handle = current.J_Handle;
		current.Crowbar = current.J_Crowbar;
		current.CrewK = current.J_CrewK;
		current.RecR = current.J_RecR;
		current.SecK = current.J_SecK;
		current.ElevL = current.J_ElevL;
		current.PodB = current.J_PodB;
		current.DigiR = current.J_DigiR;
		current.DigiRF = current.J_DigiRF;
		current.BackK = current.J_BackK;
	}
	else{
		current.Time = current.PAL_IGT + current.PAL_MS;
		current.Map = current.PAL_Map;
		current.Results = current.PAL_Results;
		//Items
		current.FirstC = current.P_FirstC;
		current.GuestK = current.P_GuestK;
		current.IDCard = current.P_IDCard;
		current.MaintK = current.P_MaintK;
		current.Handle = current.P_Handle;
		current.Crowbar = current.P_Crowbar;
		current.CrewK = current.P_CrewK;
		current.RecR = current.P_RecR;
		current.SecK = current.P_SecK;
		current.ElevL = current.P_ElevL;
		current.PodB = current.P_PodB;
		current.DigiR = current.P_DigiR;
		current.DigiRF = current.P_DigiRF;
		current.BackK = current.P_BackK;
	}
}

start
{
	return current.Time != old.Time && old.Time < 1 && current.Map == 258;
}

split
{
	if (settings["FirstCP"] && current.FirstC == 1 && !vars.completedSplits[0])		{return vars.completedSplits[0]  = true;}
	if (settings["FirstCU"] && current.FirstC == 100 && !vars.completedSplits[1])		{return vars.completedSplits[1]  = true;}
	if (settings["GuestKP"] && current.GuestK == 1 && !vars.completedSplits[2])		{return vars.completedSplits[2]  = true;}
	if (settings["GuestKD"] && current.GuestK == 2 && !vars.completedSplits[3])		{return vars.completedSplits[3]  = true;}
	if (settings["GuestKU"] && current.GuestK == 100 && !vars.completedSplits[4])		{return vars.completedSplits[4]  = true;}
	if (settings["IDCardP"] && current.IDCard == 1 && !vars.completedSplits[5])		{return vars.completedSplits[5]  = true;}
	if (settings["IDCardU"] && current.IDCard == 100 && !vars.completedSplits[6])		{return vars.completedSplits[6]  = true;}
	if (settings["MaintKP"] && current.MaintK == 1 && !vars.completedSplits[7])		{return vars.completedSplits[7] = true;}
	if (settings["MaintKU"] && current.MaintK == 100 && !vars.completedSplits[8])		{return vars.completedSplits[8]  = true;}
	if (settings["HandleP"] && current.Handle == 1 && !vars.completedSplits[9])		{return vars.completedSplits[9]  = true;}
	if (settings["HandleU"] && current.Handle == 100 && !vars.completedSplits[10])		{return vars.completedSplits[10]  = true;}
	if (settings["CrowbarP"] && current.Crowbar == 1 && !vars.completedSplits[11])		{return vars.completedSplits[11]  = true;}
	if (settings["CrewKP"] && current.CrewK == 1 && !vars.completedSplits[12])		{return vars.completedSplits[12]  = true;}
	if (settings["CrewKU"] && current.CrewK == 100 && !vars.completedSplits[13])		{return vars.completedSplits[13]  = true;}
	if (settings["RecRP"] && current.RecR == 1 && !vars.completedSplits[14])		{return vars.completedSplits[14]  = true;}
	if (settings["RecRU"] && current.RecR == 100 && !vars.completedSplits[15])		{return vars.completedSplits[15]  = true;}
	if (settings["SecKP"] && current.SecK == 1 && !vars.completedSplits[16])		{return vars.completedSplits[16]  = true;}
	if (settings["SecKU"] && current.SecK == 100 && !vars.completedSplits[17])		{return vars.completedSplits[17]  = true;}
	if (settings["ElevLP"] && current.ElevL == 1 && !vars.completedSplits[18])		{return vars.completedSplits[18]  = true;}
	if (settings["ElevLU"] && current.ElevL == 100 && !vars.completedSplits[19])		{return vars.completedSplits[19]  = true;}
	if (settings["PodBP"] && current.PodB == 1 && !vars.completedSplits[20])		{return vars.completedSplits[20]  = true;}
	if (settings["PodBU"] && current.PodB == 100 && !vars.completedSplits[21])		{return vars.completedSplits[21]  = true;}
	if (settings["DigiRP"] && current.DigiR == 1 && !vars.completedSplits[22])		{return vars.completedSplits[22]  = true;}
	if (settings["DigiRFP"] && current.DigiRF == 1 && !vars.completedSplits[23])		{return vars.completedSplits[23]  = true;}
	if (settings["DigiRFU"] && current.DigiRF == 100 && !vars.completedSplits[24])		{return vars.completedSplits[24]  = true;}
	if (settings["BackKP"] && current.BackK == 1 && !vars.completedSplits[25])		{return vars.completedSplits[25]  = true;}
	if (settings["BackKU"] && current.BackK == 100 && !vars.completedSplits[26])		{return vars.completedSplits[26]  = true;}
	
	if (settings["490"] && current.Map == 490 && !vars.completedSplits[27])		{return vars.completedSplits[27]  = true;}
	if (settings["100"] && current.Map == 100 && !vars.completedSplits[28])		{return vars.completedSplits[28]  = true;}
	if (settings["910"] && current.Map == 910 && !vars.completedSplits[29])		{return vars.completedSplits[29]  = true;}
	if (settings["350"] && current.Map == 350 && !vars.completedSplits[30])		{return vars.completedSplits[30]  = true;}
	if (settings["430"] && current.Map == 430 && !vars.completedSplits[31])		{return vars.completedSplits[31]  = true;}
	
	if(current.Results > 0 && old.Results == 0 && current.Map == 470){
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
