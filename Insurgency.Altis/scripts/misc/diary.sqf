/*
| Author: 
|
|	Quiksilver.
|_____
|
| Description: 
|	
|	Created: 26/11/2013.
|	Last modified:07/12/2015.
|	Coded for I&A and hosted on allfps.com.au servers.
|	You may use and edit the code.
|	You may not remove any entries from Credits without first removing the relevant author's contributions, 
|	or asking permission from the mission authors/contributors.
|	You may not remove the Credits tab, without consent of Ahoy World or allFPS.
| 	Feel free to re-format or make it look better.
|_____
|
| Usage: 
|	
|	Search below for the diary entries you would like to edit. 
|	DiarySubjects appear in descending order when player map is open.
|	DiaryRecords appear in ascending order when selected.
|_____
|
| Credit:
|
|	Invade & Annex 2.00 was developed by Rarek [ahoyworld.co.uk] with hundreds of hours of work 
|	The current version was developed by Quiksilver with hundreds more hours of work.
|	
|	Contributors: Razgriz33 [AW], Jester [AW], Kamaradski [AW], David [AW], chucky [allFPS].
|	
|	Please be respectful and do not remove credit.
|______________________________________________________________*/

if (!hasInterface) exitWith {};

waitUntil {!isNull player};

player createDiarySubject ["rules", "Rules"];
player createDiarySubject ["mods", "Mods"];
player createDiarySubject ["teamspeak", "Teamspeak"];
player createDiarySubject ["changelog", "Change Log"];
player createDiarySubject ["credits", "Credits"];

//-------------------------------------------------- Rules

player createDiaryRecord ["rules",
[
"Enforcement",
"
<br />The purpose of the above rules are to ensure a fun and relaxing environment for public players.
<br />
<br />Server rules are in place merely as a means to that end.
<br />
<br />Guideline for enforcement:
<br />
<br />-	Innocent rule violation and disruptive behavior: 
<br />
<br />		= Verbal / Written request to cease, or warning.
<br /> 
<br />-	Minor or first-time rule violation:
<br />
<br />		= Kick, or 0 - 3 day ban.
<br />
<br />-	Serious or repetitive rule violation: 
<br />
<br />		= 1 day ban.
<br />
<br />-	Administrative ban (hack/exploit/verbal abuse/serious offense):
<br />
<br />		= permanent ban.
<br />
<br />
<br />The above is subject to discretion.
"
]];

player createDiaryRecord ["rules",
[
"General English",
"
<br />1.  Hacking and mission exploitation will not be tolerated.
<br />2.  Intentional team-killing will not be tolerated.
<br />3.  Excessive, unintentional team-killing may result in a Kick/Temp ban.
<br />4.  Unnecessary destruction of BLUFOR vehicles will not be tolerated.
<br />5.  Verbal abuse and bullying will not be tolerated - respect other players. 
<br />6.  Firing a weapon on base--unless at an enemy--may result in a Kick/Temp ban.
<br />7.  Griefing and obstructive play will not be tolerated.
<br />8.  Excessive mic spamming, especially of Side and Global channels, will not be tolerated.
<br />9.  failure to observe the rules stated on the signs will not be tolerated.
<br />10. spam the Y key will be punished by ZEUS himself.
<br />11. A server moderator or admin's word is final.

<br />If you see a player in violation of the above, contact a moderator or admin (teamspeak).
"
]];

player createDiaryRecord ["rules",
[
"General Français",
"
<br />1.  Le hack et le détournement des fonctions (exploit) ne seront pas tolérés.
<br />2.  Le team kill n'est pas tolérés sur ce serveur.
<br />3.  Le team kill répété même non volontaire pourra être sanctionné par un ban.
<br />4.  La destruction non nécessaire de véhicule BLUEFOR pourra être sanctionné.
<br />5.  La violence verbale ne sera pas toléré - respectez les autres joueurs. 
<br />6.  Vous n'avez pas le droit de tirer a la base.
<br />7.  Le troll ne sera pas toléré et sanctionné par un ban.
<br />8.  le spamming n'est pas toléré et sanctionné par un ban.
<br />9.  Le non respect des règles énnoncées sur les panneaux ne seront pas tolérés.
<br />10. Spammer la touche Y vous vaudra les foudres de ZEUS.
<br />11. La décision d'un admin ou d'un modérateur n'est pas discutable ni négociable.

<br />Si vous voyez un joueur enfreinfre les règles, n'hésitez pas à nous contacter sur le TS.
"
]];

//-------------------------------------------------- Mods

player createDiaryRecord ["mods",
[
"Serverside",
"
<br /> Mods currently running on server (subject to change without notice):<br /><br />

<br />- Addons package for this server.
		https://mega.nz/#!ockTGTbb!5eP96blQ1EaIKnzc7LoFMgTXxD1O4tkM5GZHdQEJyh8<br /><br />	
		
<br />- MF Uniforms.
		https://mega.nz/#!udcnRBha!sbWLxoF4hA0O06BsUbHV6IaTBUIxOwy4O0DtV1GtLGI<br /><br />	
		
<br />- Retextured of BLUEFOR vehicles.
		https://mega.nz/#!8AcmRABA!p1NKLwMkoupzGETj6SI-us432NQmPWkMfnsODCftB1g<br /><br />	

"
]];

player createDiaryRecord ["mods",
[
"Mods Allowed or recommended",
"
<br /> Mods currently allowed (subject to change without notice):<br /><br />

<br /> None at this time. <br />

"
]];


//-------------------------------------------------- Teamspeak

player createDiaryRecord ["teamspeak",
[
"TS3",
"
<br /> Teamspeak:<br /><br />
<br /> http://www.teamspeak.com/?page=downloads
"
]];

player createDiaryRecord ["teamspeak",
[
"Mercenaires Francais",
"
<br /> Address: 94.247.28.17
<br />
<br /> Visitors and guests welcome!
"
]];

//-------------------------------------------------- Change Log

player createDiaryRecord ["changelog",
[
"2.70.2",
"
<br />- [UPDATED]=BTC= Revive.
<br />- [UPDATED] Realistic airlift system.
<br />- [ADDED] SCUBA missions.
<br />- [ADDED] Defend AO.
<br />- [ADDED] AO Air Reinforcements.
<br />- [ADDED] Greater variety of enemy soldiers and vehicles at the AO and side missions.
<br />- [ADDED] FFIS mod.
<br />- [ADDED] Easter eggs!
<br />- [ADDED] A-143 Buzzard spawn at base (CAS).
<br />- [ADDED] UH-80 Ghost Hawk door animation added.
<br />- [ADDED] Recon Team added to role assignments.
<br />- [ADDED] Clear Inventory script added to vehicles, for easy clearing of stock inventory to facilitate custom loading.
<br />- [CHANGED] Spawn area and base layout adjusted to increase frame rate performance and mitigate griefing.
<br />- [CHANGED] HEMTT Mobile Ammo Box (VAS) Truck now respawns.
<br />- [CHANGED] Lots of subtle adjustments to AI strengths, weaknesses, and actions.
<br />- [CHANGED] UAVs adjusted to mitigate spontaneous explosion.
<br />- [FIXED] Fire-related frame-drop and crash-to-desktop bug fixed.
<br />- [FIXED] Plenty of behind-the-scenes scripts and code adjustments for performance, realism and fun!
"
]];

player createDiaryRecord ["changelog",
[
"2.70.3",
"
<br />- [UPDATED] EOS v1.95
<br />- [ADDED] New Side Missions.
<br />- [ADDED] OPFOR Static weapons.
<br />- [ADDED] UAV Connection instructions added to map Diary entry.
<br />- [CHANGED] Improved AI garrison scripts.
<br />- [CHANGED] Modified FFIS.
<br />- [CHANGED] OPFOR Artillery range reduced.
<br />- [CHANGED] AI vehicle crew behavior.
<br />- [CHANGED] Refined AO locations.
<br />- [CHANGED] Refined OPFOR behavior and waypoints.
"
]];

player createDiaryRecord ["changelog",
[
"2.70.4",
"
<br />- [UPDATED] EOS v1.96.
<br />- [UPDATED] FFIS v1.25.
<br />- [ADDED] Urban missions.
<br />- [ADDED] Medic markers and Revive tweaks.
<br />- [ADDED] UGV Stomper added.
<br />- [REMOVED] AH-9 Pawnee removed from CAS spawn.
<br />- [FIXED] Behind-the-scenes bug fixes, code adjustments and performance-related tweaks.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.0",
"
<br />- [UPDATED] EOS v1.97.
<br />- [UPDATED] TAW View Distance v1.2
<br />- [UPDATED] VAS v2.3
<br />- [CHANGED] Refined urban missions and AO counterattack.
<br />- [REMOVED] Old code.
<br />- [REMOVED] Skip Time parameter.
<br />- [FIXED] De-sync associated with Skip Time.
<br />- [FIXED] Bug fixes and code adjustments aimed at improving performance and frame rate.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.1",
"
<br />- [UPDATED] Map Markers.
<br />- [UPDATED] Admin tools.
<br />- [ADDED] MBT-52 Kuma to vehicle spawn.
<br />- [ADDED] VAS to unarmed UGV Stomper.
<br />- [CHANGED] Fast-Rope.
<br />- [CHANGED] Map marker color to grey, to improve clarity.
<br />- [REMOVED] Duplicate group manager (assigned to 'T' key).
<br />- [REMOVED] Global chat.
<br />- [FIXED] UI errors associated with last patch.
<br />- [FIXED] UAV spawn. Maybe. Ok, not quite.
<br />- [FIXED] Players couldn't be dragged or revived.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.2",
"
<br />- [UPDATED] EOS v1.97.2. (Defend sequence).
<br />- [UPDATED] Vehicle hud (tweaked by QS).
<br />- [ADDED] FOB Gori, FOB Kali, FOB Delfinaki. Currently unmarked and not operational.
<br />- [ADDED] 
<br />- [CHANGED] AO Defend sequence, slightly. Attempt at increasing enemy aggression.
<br />- [REMOVED] Most easter eggs.
<br />- [REMOVED] Some aircraft service locations.
<br />- [REMOVED] A couple vehicles from base. Outsourced to under-construction FOBs.
<br />- [REMOVED] Personal UAV.
<br />- [FIXED] All UI errors.
<br />- [FIXED] 
"
]];

player createDiaryRecord ["changelog",
[
"2.71.3",
"
<br />- [UPDATED] 
<br />- [ADDED] T-100 to side mission rewards.
<br />- [ADDED] Radio tower minefield.
<br />- [ADDED] AA Buzzard instead of CAS (reduced respawn time!).
<br />- [CHANGED] OPFOR patrol logic, to increase performance and realism. 
<br />- [CHANGED] OPFOR skill refined, based on unit type and location.
<br />- [REMOVED] More old and inefficient code.
<br />- [FIXED] Some side mission errors.
<br />- [FIXED] AO unit spawn problems.
<br />- [FIXED] Enemy snipers smarter.
"
]];

player createDiaryRecord ["changelog",
[
"2.71.35",
"
<br />- [UPDATED]
<br />- [ADDED] Enemy UAV [currently disabled].
<br />- [ADDED] Airbase AA.
<br />- [ADDED] Weather script test.
<br />- [CHANGED] OPFOR patrol logic. They like the high ground too!
<br />- [REMOVED] More old code.
<br />- [FIXED] Enemy CAS spawn limit.
<br />- [FIXED]
"
]];

player createDiaryRecord ["changelog",
[
"2.74.3",
"
<br />- [UPDATED] =BTC= Revive v0.97 [reverted to 0.95 temporarily]
<br />- [UPDATED] EOS v1.98
<br />- [UPDATED] VAS v2.40
<br />- [ADDED] A-164 Wipeout and To-199 Neophron jets.
<br />- [ADDED] FOB Gori
<br />- [ADDED] Jet spawn at base.
<br />- [ADDED] Easier selection of VAS box (no scroll needed).
<br />- [CHANGED] Code refinement for FPS increase.
<br />- [CHANGED] Testing performance capacity, for future content expansion. 
<br />- [CHANGED] UH-80 door animation parameters (speed instead of altitude).
<br />- [CHANGED] Airlift speed increased slightly.
<br />- [REMOVED] Enemy AAF Buzzard.
<br />- [FIXED] VAS scroll menu bug
<br />- [FIXED] Clear Inventory only clears Ammo and Items. Backpacks/weapons will remain.
<br />- [Coming soon] Zeus module integration.
<br />- [Coming soon] More side missions.
<br />- [Coming soon] Enemy CAS and JTAC cooperation.
<br />- [Coming soon] More cool stuff and adjustments.
"
]];

player createDiaryRecord ["changelog",
[
"2.75.0",
"
<br />- [UPDATED] VAS v2.5
<br />- [ADDED] Integrated easter eggs.
<br />- [ADDED] Regional AOs = less travel time.
<br />- [ADDED] New side missions.
<br />- [ADDED] Zeus (not all servers).
<br />- [CHANGED] AO initialization (faster mission load times).
<br />- [CHANGED] Radio tower marker now rough location instead of exact.
<br />- [CHANGED] Can fail side missions.
<br />- [CHANGED] Access side missions from briefing room in Terminal building.
<br />- [CHANGED] Must now activate base air defense. Also, it only has 1 rocket, and then only autocannon.
<br />- [REMOVED] FOBs, until FOB integration is complete.
<br />- [FIXED] Binoculars being removed when killed. [attempted fix, may cause other issues]. WIP.
<br />- [FIXED] Enemy artillery.
<br />- [FIXED] Enemy CAS, slightly more effective now.
<br />- [Behind the scenes] The mission has been significantly re-coded, allowing for more rapid mission development.
"
]];

player createDiaryRecord ["changelog",
[
"2.75.27",
"
<br />- [UPDATED] Reverted to VAS 2.4 due to alphabetical sorting implemented in 2.5. Hard to find stuff.
<br />- [ADDED]
<br />- [CHANGED] Closed VAS loophole, whereby UAV Operator could access VAS remotely with a UAV.
<br />- [CHANGED] Reduced AI accuracy, due to increased skill from better mission/code performance.
<br />- [CHANGED] Air vehicle re-arm, in response to BIS bug of planes sinking into ground on refuel.
<br />- [REMOVED]
<br />- [FIXED]
<br />- [FIXED] Some sling script issues.
<br />- [Behind the scenes]
"
]];

player createDiaryRecord ["changelog",
[
"2.75.28",
"
<br />- [UPDATED]
<br />- [ADDED]
<br />- [CHANGED]
<br />- [REMOVED]
<br />- [FIXED] Revive instability. Temporary revert to older, more stable (but less performance-friendly) code.
<br />- [FIXED] OPFOR CAS spawn frequency.
<br />- [Behind the scenes]
"
]];

player createDiaryRecord ["changelog",
[
"2.75.29",
"
<br />- [UPDATED]
<br />- [ADDED] UAV Operator maintenance action to terminal in control tower.
<br />- [CHANGED] CAS spawn frequency.
<br />- [CHANGED] UAV spawn location.
<br />- [REMOVED]
<br />- [FIXED] Attempt to mitigate UAV spawning 'dead'.
<br />- [FIXED] Get Intel (unit) mission, removed weapon from target.
<br />- [Behind the scenes]
"
]];

player createDiaryRecord ["changelog",
[
"2.77.1",
"
<br />- [UPDATED]
<br />- [ADDED] Soldier Tracker v1.0.1 (Map and GPS Icons)
<br />- [ADDED] Base Air Defense (manual activation)
<br />- [ADDED] Medical HEMTT - Any player can revive if near medical truck (must have FAK)
<br />- [ADDED] CAS Jet as AO Reward.
<br />- [CHANGED] Pilot respawn.
<br />- [CHANGED] Enemy vehicle mission fidelity.
<br />- [CHANGED] Gear specialisations.
<br />- [CHANGED] Fatigue.
<br />- [REMOVED]
<br />- [FIXED] BTC Revive bugs
<br />- [FIXED] Secure Chopper side mission
<br />- [Behind the scenes]
"
]];

player createDiaryRecord ["changelog",
[
"2.77.2",
"
<br />- [UPDATED] 
<br />- [ADDED] New action for UAV Operator on UAVs.
<br />- [ADDED] Pilots can lock UH-80 Turrets.
<br />- [ADDED] AO - enemies in buildings.
<br />- [ADDED] Enemy CAS coordination with enemy JTAC. [temp disabled]
<br />- [ADDED]
<br />- [ADDED] Potentially more Defend Mission difficulty.
<br />- [CHANGED] Vehicle respawn system.
<br />- [CHANGED] Safe-zone system, for performance increase.
<br />- [CHANGED] Upgraded lethality of Anti-Air priority target.
<br />- [CHANGED] Clear Inventory action, now for driver of vehicle only.
<br />- [CHANGED] View Distance control at Ammo boxes instead of on soldier action menu.
<br />- [CHANGED] First few AOs always somewhat close to base.
<br />- [REMOVED]
<br />- [FIXED] BTC Revive stuff.
<br />- [FIXED] Sling.
<br />- [FIXED] Side mission markers.
<br />- [FIXED] Supply drop should no longer be lethal when approached.
<br />- [FIXED] NATO vehicles de-spawning even when players near.
<br />- [FIXED] Some ZEUS functionality.
<br />- [Behind the scenes] Newer vehicle respawn system will improve performance slightly.
<br />- [HOTFIX] UH-80 Turret control functionality, Zeus, opfor CAS.
"
]];

player createDiaryRecord ["changelog",
[
"2.79",
"
<br />- [CHANGED] Hummingbird texture.
<br />- [CHANGED] 1 Ghosthawk changed to a helcat.
<br />- [CHANGED] Pawnee should now have a different texture.
<br />- [CHANGED] Changelog.
<br />- [TWEAKED] Pawnee side mission spawn rate increased.
<br />- [TWEAKED] Wipeout and Neophron now have 60 flares.
<br />- [TWEAKED] Some minor things added at spawn.
<br />- [ADDED] Minigun Dispersion.
<br />- [ADDED] Mortar to side mission reward.
<br />- [ADDED] LaForte to Zeus.
<br />- [ADDED] Spartan program.
<br />- [ADDED] New AO's.
<br />- [ADDED] Speed of sound to accepted mods.
<br />- [ADDED] Tao Folding Map to accepted mods.
<br />- [ADDED] Helmet Mounted Displays Mod to accepted mods.
<br />- [ADDED] Midrange Terrain Texture to accepted mods.
<br />- [ADDED] Rule against landing helicopters in the main spawn.
<br />- [FIXED] Exploit where jet could bypass 5 minutes repair timer.
"
]];

player createDiaryRecord ["changelog",
[
"2.79A",
"
<br />- [ADDED] AH-9 Pawnee GAU - 19 variant to side missions rewards.
<br />- [ADDED] Rabbit to side missions rewards (used to spawn GAU-19).
<br />- [FIXED] Mortar side mission reward should no longer be restricted.
<br />- [FIXED] Secure Chopper side missions should now work.
<br />- [FIXED] Minigun dispersion to Ghosthawk turrets.
"
]];

player createDiaryRecord ["changelog",
[
"2.79B",
"
<br />- [CHANGED] Now Use Quiksilver's player markers.
<br />- [CHANGED] Rifleman (AT) is now a Missile Spec. (AT).
<br />- [ADDED] All players may now revive when within 5 meters of a Medical HEMTT.
<br />- [ADDED] New Medivac LZ.
<br />- [ADDED] Combat Life Saviour Team.
<br />- [ADDED] Arsenal is back on the VASman.
"
]];

player createDiaryRecord ["changelog",
[
"2.79D",
"
<br />- [FIXED] Rifleman(AT) should now be fixed again.
<br />- [FIXED] Artillery should now fire.
<br />- [TWEAKED] Player Icons should now display further away.
<br />- [TWEAKED] Players now need a FAK to revive at a Medical HEMTT.
<br />- [TWEAKED] Tweaked some aspects of BTC to improve performance.
<br />- [CHANGED] All playable units should now be attached to Zues.
<br />- [ADDED] 5th pilot slot and helicopter.
<br />- [ADDED] Bobcat is now at spawn.
<br />- [ADDED] Quick save option for gear.
"
]];

player createDiaryRecord ["changelog",
[
"2.79F",
"
<br />- [TWEAKED] Some behind the scenes stuff.
<br />- [ADDED] Some parameters for better before mission customization.
"
]];

player createDiaryRecord ["changelog",
[
"2.780",
"
<br />- [ADDED] CH-47 Huron to helicopters.
<br />- [ADDED] Mi-290 Taru to Side mission rewards.
<br />- [ADDED] Huron crate spawner.
"
]];

player createDiaryRecord ["changelog",
[
"MF4.A0.17",
"
<br />- [CHANGED] TAW View Distance Script v1.5.
<br />- [ADDED] Fast rop.
<br />- [REMOVED] MF.
"
]];

player createDiaryRecord ["changelog",
[
"MF4.A0.18",
"
<br />- [CHANGED] Fast-Rope test.
<br />- [CHANGED] Operateur Drone slot.
<br />- [CHANGED] Ammo suply test.
<br />- [CHANGED] Pilot avion slot.
<br />- [REMOVED] MF.
"
]];

player createDiaryRecord ["changelog",
[
"MF4.A0.21",
"
<br />- [ADDED] Jump by Double Tapped C. (Saut par appui d'un double C rapide).
<br />- [ADDED] Mag Repack by Ctrl+ R.   (Repacking des munitions par CTRL + R).
<br />- [REMOVED] MF.
"
]];


player createDiaryRecord ["changelog",
[
"MF4.A0.22",
"
<br />- minor changes.
"
]];


player createDiaryRecord ["changelog",
[
"MF4.A0.23",
"
<br />- [ADDED] ZEUS Permissions for xGORx.
"
]];

//-------------------------------------------------- Credits

player createDiaryRecord ["credits",
[
"I & A",
"
<br />Mission authors:<br /><br />

		- <font size='16'>Rarek</font> - Ahoy World (ahoyworld.co.uk)<br /><br />
		- <font size='16'>Quiksilver</font><br />
		
<br />Contributors:<br /><br />
		- Jester - Ahoy World (ahoyworld.co.uk)<br />
		- Razgriz33 - Ahoy World (ahoyworld.co.uk)<br />
		- Kamaradski - Ahoy World (ahoyworld.co.uk)<br />
		- BACONMOP - Ahoy World (ahoyworld.co.uk)<br />
		- chucky - All FPS (allfps.com.au)<br /><br />
		
<br />Other:<br /><br />
		VAS<br />
		- Kronzky<br />
		- Sa-Matra<br />
		- Dslyecxi<br /><br />
		=BTC= Revive<br />
		- Giallustio<br />
		- Edited by Quiksilver<br/><br />
		EOS<br />
		- BangaBob<br /><br />
		Squad Manager<br />
		- aeroson<br /> <br />
		TAW View Distance<br />
		- Tonic<br /> <br />
		aw_fnc<br />
		- Alex Wise<br /><br />
		SHK Taskmaster<br />
		- Shuko<br /><br />
		Fast rope<br />
		- Zealot<br /><br />
		Map and GPS Icons (Soldier Tracker)<br />
		- Quiksilver<br /><br />
		Jump<br />
		- ProGamer<br /><br />
		Safe zone<br />
		- Bake<br />
"
]];