//Resident Evil: Dead Aim IGT Timer & Room Autosplitter V1.0 07/09/2023
//Supports In Game Time & Autosplits on select doors

//emu-help tool created by jujstme - https://github.com/Jujstme
//script & ID's by TheDementedSalad

state("LiveSplit") {}

startup
{
	// Creates a persistent instance of the PS1 class (for PS1 emulators)
	vars.Helper = Assembly.Load(File.ReadAllBytes("Components/emu-help")).CreateInstance("PS2");

	// You can look up for known IDs on https://psxdatacenter.com/
	vars.Helper.Gamecodes = new Dictionary<string, string>
	{
		{"SLUS-20669", "NTSC-U"},
		{"SLPM-65245", "NTSC-J"},
		{"SLES-51448", "PAL"},
	};
	
	vars.Helper.Load = (Func<IntPtr, MemoryWatcherList>)(wram => new MemoryWatcherList{
		new StringWatcher(wram + 0x52E62, 10) {Name = "NTSC-U_Gamecode"},
		new StringWatcher(wram + 0x838E2, 10) {Name = "NTSC-J_Gamecode"},
		new StringWatcher(wram + 0x53D97, 10) {Name = "PAL_Gamecode"},
		
		new MemoryWatcher<int>(wram + 0x59054) {Name = "NTSC-U_IGT"},
		new MemoryWatcher<float>(wram + 0xD14F0) {Name = "NTSC-U_MS"},
		new MemoryWatcher<int>(wram + 0x2649C0) {Name = "NTSC-U_Map"},
		
		new MemoryWatcher<int>(wram + 0x17DBC) {Name = "NTSC-J_IGT"},
		new MemoryWatcher<float>(wram + 0xCF3B0) {Name = "NTSC-J_MS"},
		new MemoryWatcher<int>(wram + 0x14D6C0) {Name = "NTSC-J_Map"},
		
		new MemoryWatcher<int>(wram + 0x59A54) {Name = "PAL_IGT"},
		new MemoryWatcher<float>(wram + 0xD1FF8) {Name = "PAL_MS"},
		new MemoryWatcher<int>(wram + 0x2684C0) {Name = "PAL_Map"},
		
		{
			
		settings.Add("Area", false, "Area Splitter - Splits every area change");
	});
}

update
{
	if (!vars.Helper.Update()) return false;

	current.IGT = vars.Helper["IGT"].Current + vars.Helper["MS"].Current;
	old.IGT = vars.Helper["IGT"].Old + vars.Helper["MS"].Old;
	
	current.Map = vars.Helper["Map"].Current;
}

start
{
	return current.IGT != old.IGT && old.IGT < 1 && current.Map == 258;
}

split
{
	if(settings["Area"] && vars.Helper["Map"].Current != vars.Helper["Map"].Old){
		return true;
	}
}

gameTime
{
	return TimeSpan.FromSeconds(current.IGT);
}

isLoading
{
	return true;;
}

reset
{
	return current.IGT == 0 && current.Map == 258;
}


shutdown
{
	// Please don't remove this line from this block
	vars.Helper.Dispose();
}
