--Ultimate Snowball War 2.0 LUA 5
--
--by Mutor  10/08/05
--expanded by ProLoser 2006
--
--Requested by H€LL§Lí††L€ÅnG€L
--
-- Not unlike stab bot and similiar, show your love for other hubbers
-- with this nonsensical winter time sport of kings.
--
--		+Changes from 1.0
--			+Added user accuracy in score listing
--			+Added a few more responses
--
--		+Changes from 1.0b 11/08/05
--			+"Declaration of war statement" request by H€LL§Lí††L€ÅnG€L
--
--		+Changes from 1.0c 11/11/05
--			+Added WaitTime, user cannot throw again until time elapsed.
--			+User cannot score on themselves, a hit point weill be deducted for each offense
--
--		+Changes from 1.0d 12/06/05
--			+Bugfix in scoring, when user 'Hits' are equal or less than 0 [division by zero]
--			+Bugfix in scoring, hit/miss 12/12/05	--Thanks Ubikk for report
--			-Removed space from default botname, User & Bot names cannot contain a space [missed that]
--
--
--		+Changes from 1.0e 12/21/05
--			+Added WoW style rankings		Request by Ubikk / Syphrone-NL
--			+Added 'Liberty' toggle(hide)	Request by Ubikk
--			+Changed Scoring format/function
--
--
--		+Changes from 1.0f 12/21/05
--			+Added upgrade options							Request by Ubikk
--			+Changed scoring when score on higher rank		Request by Ubikk
--			+Changed hit/miss probability with upgrades		Request by Ubikk
--
--		+Changes to 2.0 2006
--			+Completely revamped hit calculations
--			+Completely revamped stats upgrades
--			+Enhanced 'liberty' mode
--			+Completely revamped scoring tables and ranks
--			+Added game visibility modes (Everyone, Active Duty players, and subroom)
--
--User Settings----------------------------------------------------------------------------------------------------------------
--
--//-- Botname pulled from the hub
SnowBot = "[Snowball-Fight]"
--//-- Command Prefix
Prefix = "!"
--//-- Throw a snowball
SnowCmd = "sb"
--//-- Take liberty [off active duty]
SnowLiberty = "sl"
--//-- Force liberty [off active duty]
ForceLiberty = "sfl"
--//-- Get scores
ScoresCmd = "ss"
--//-- Buy Upgrade(s)
UpgradeCmd = "su"
--//-- Display Upgrade(s)
ShowUpgrade = "ups"
--//-- Display Rules and Instructions
ShowRules = "srules"
--//-- Resets Scores file
ScoreReset = "sreset"
--//-- Change Game Visibility Mode
SnowMode = "smode"
--//-- Menu name pulled from hub, uses hub name for menu
SnowMenu = "•Snowball Fight•" 
--//-- Filename for user data
SnowFile="SnowTable3.dat"
--//-- Declaration of War message
WarCry = "\r\n\r\nLet the battle begin!"
--//-- Inactivity time (in minutes) to declare time of peace.
WarEndTime = 20
--//-- Minimum time (in seconds) a user must wait before be able to throw again.
WaitTime = 05
--//-- Maximum upgrade level (1 - 10 scale only, 1 being no purchased upgrades 10 being a less possible 10 to 1 odds to miss/hit. DO NOT PASS 10!!!!!)
MaxUpgrade = 10
--//-- Multiplyer of current upgrade level to decide next upgrade price (ie: AimLvl 2 x 10pts = 20pts cost to get AimLvl 3, etc.)
ShieldPrice = 20
PowerPrice = 20
AimPrice = 20
--//--Set your profiles permissions here.
--profile_idx, Commands/Menus enabled [0=no 1=yes], "Profile Name"
SnowProfiles = {
[-1] = {1,"Unregistered User"},
[0] = {1,"Master"},
[1] = {1,"Operator"},
[2] = {1,"Vip"},
[3] = {1,"Registered User"},
[4] = {1,"Moderator"},
[5] = {1,"NetFounder"},
}

--//Player Upgrades [idx] = {"Upgrade Name", point cost}
--Upgrades={
--[1] = {"Power Level 1",20},
--[2] = {"Power Level 2",45},
--[3] = {"Improved Aim 1",35},
--[4] = {"Improved Aim 2",45},
--[5] = {"Protective Shield",55},
--}

--//Player Ranking
TopRank = 1000 -- Enter highest rank's points here to force them to defend their title!!!

Rankings = {
[1] = {0, "Recruit","(Trainee)"},
[2] = {25, "Private","(Scout)"},
[3] = {50, "Corporal","(Grunt)"},
[4] = {100, "Seargent","(Sarge)"},
[5] = {150, "Master Sergeant","(Senior Sergeant)"},
[6] = {200, "Sergeant Major","(First Sergeant)"},
[7] = {275, "Knight","(Stone Guard)"},
[8] = {350, "Knight-Lieutenant","(Blood Guard)"},
[9] = {425, "Knight-Captain","(Legionnare)"},
[10] = {500, "Knight-Champion","(Centurion)"},
[11] = {600, "Lieutenant Commander","(Champion)"},
[12] = {700, "Commander","(Lieutenant General)"},
[13] = {800, "Marshal","(General)"},
[14] = {900, "Field Marshal","(Warlord)"},
[15] = {1000, "Grand Marshal","(High Warlord)"},
}

zRankings = {
[1] = {0, "Recruit","(Trainee)"},
[2] = {25, "Private","(Scout)"},
[3] = {50, "Corporal","(Grunt)"},
[4] = {100, "Seargent","(Sarge)"},
[5] = {150, "Master Sergeant","(Senior Sergeant)"},
[6] = {200, "Sergeant Major","(First Sergeant)"},
[7] = {275, "Knight","(Stone Guard)"},
[8] = {350, "Knight-Lieutenant","(Blood Guard)"},
[9] = {425, "Knight-Captain","(Legionnare)"},
[10] = {500, "Knight-Champion","(Centurion)"},
[11] = {600, "Lieutenant Commander","(Champion)"},
[12] = {700, "Commander","(Lieutenant General)"},
[13] = {800, "Marshal","(General)"},
[14] = {900, "Field Marshal","(Warlord)"},
[15] = {1000, "Grand Marshal","(High Warlord)"},
}

--//-- Set your hit/miss responses here
Hit = {
"Oh man, user1 just blasted user2 right in the mush.",
"user1 launches and.... Ouch, user2 thats gonna leave a mark!",
"user2 excalims 'HEY, user1 No iceballs! You'll put someone's eye out'.",
"user1 wings user2 , a mere flesh wound.",
"user1 bounces a hard packed one off user2's head. Oooooh, Thats gotta hurt.",
"Forgoing the whole 'throwing' technique, user1 walks right up and mashes one right in  user2's kisser.",
"For no apparent reason, user1 steps behind user2 and plants an icy one in the spine.",
"user1 AKA:'The Rifleman' nearly breaks user2's arm with a tremendous shot.",
"Recieving a humiliating shot in the ass from user1, user2 screams 'Oh its on!' and reaches for a round.",
"'Oh no you didn't', yells user1 and beans user2 in the eye!",
"user1 picks up an oversized snowball and drops it on user2's head.",
"'OK its not funny user1, I cant see' says user2.",
"Unable to move in the 20 layers of winter clothing, user2, is trapped like an upturned turtle. user1 moves in for the kill.",
"In a decidely vicious attack, user1 sends a line drive square into user2's er.. umm... 'nether region'.",
"New comer user2 takes a fastball to the chops from user1. Thats got to be dissapointing to the young upstart.",
"Fans cheer widly as user1 lands a deadly accurate slushball into the open collar of user2.",
"98 Mph., wow user1 turns on the heat and user2's hip will never heal fully after that shot.",
"Paramedics rush onto the playing field, user2 isn't moving, user2 just grins with indifference.",
"Posing as a snowcone vendor, user1 waltzes right up to user2 and scores another hit.  ...Brilliant.",
"A capacity crowd is on its feet as local hero and MVP candidate, user1 creams user2 and scores again.",
"user1, played strong all season and shows the fans post season play is no different and scores on user2",
"Team Captain user1 leads by example fires a real screamer into user2's midsection.",
"user1, undaunted by recent allegations of steroid use, scores again on user2",
"user1, rockets one to user2's genital area! Oddly, user2 seems unaffected  hmmm....",
}

Miss = {
"user2 asks 'Are you trowin ad me user1?, I said, 'Are you trowin ad me!?'",
"user1 fires and misses user2 and summarily blames the low quality French made snowballs",
"user1 tossing widly, misses user2 by a mile",
"user2 escapes a viscious head shot from user1 and seeks asylum in the igloo.",
"user2 runs like the wind and avoids the dreaded 'yellow snowball'.",
"All laugh as user1 throws a powder ball at user2 that never reaches its mark.",
"user2 is spared as user1's inexperience in the art of snowball making is displayed to all.",
"Blinded by an incoming round, user1 throws way long. user2 just giggles.",
"Although user1 launches a power shot right on its mark, user2's' fleet footedness affords a narrow escape.",
"user2 exclaims 'HAHA! You throw like a girl user1'",
"user2 dives behind an SUV and evades a barage launched by user1",
"user2 wisely escapes the hit from user1 by quickly dropping into a 'Snow Angel' defense posture.",
"user2 double pump fakes and spins left, user1 is livid with the display.",
"Moving as a divine mist, user2 disolves to nothingness just before user1's round impacts.",
"user1's myopia will cost him dearly in the ratings as user2 is missed entirely.",
"After 6 weeks on the DL, fan fav user1 fires a steamer. Broadly missing user2, fans wonder if "..
"the torn shoulder is truly healed.",
"Snowball War Veteran user2 takes the youngster to school and snatches user1's slowball and returns fire...",
"user2 shows textbook defense technique as he sidesteps user1's patented knuckleball.",
"First round draft pick user2 shows cause for owning 3 Snowbowl rings, user1 is denied.",
"user2 recently cleared of allegations of steroid use, shows user1 what reflexes are all about...",
"In a scene rivaling 'The Matrix' user2 does a slow-motion limbo and robs user1 of the score.",
"user2 displays textbook form and evades the heater launched by user1.",
"user2 dives and seeks refuge behind a mailbox from user1's attack.",
}
--
--End User Settings-------------------------------------------------------------------------------------------------------------

Players = {}
Throw = {1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0}

Main = function()
	--//-- Choose who views the snowfight (1:All, 2:Those involved with the throw, 3: Those on Active Duty, 4: Those on Active Duty in PM) on script startup
	PlayMode = "1"
	if SnowBot ~= frmHub:GetHubBotName() then
		frmHub:RegBot(SnowBot, 1, "Winter Fun", "")
	end
	if loadfile(SnowFile) ~= nil then
		dofile(SnowFile)
	else
		local startdate,starttime =os.date("%B %d %Y"),os.date("%X")
		SnowTable ={}
		SnowTable["start"]={startdate,starttime}
		Save_File(SnowFile,SnowTable,"SnowTable")
	end
GameOn = 0
WarEndTime = WarEndTime * 60
GetRank()
end

OnExit = function()
Save_File(SnowFile,SnowTable,"SnowTable")
	if SnowBot ~= frmHub:GetHubBotName() then
		frmHub:UnregBot(SnowBot)
	end
end

NewUserConnected = function(user, data)
	if SnowProfiles[user.iProfile][1] == 1 then
		Commands(user)
		--user:SendData(SnowBot, SnowProfiles[user.iProfile][2].."'s Snowball fight commands enabled. Right click hub tab or user list for command menu.")-----REMOVED TO MAKE ROOM FOR MOTD
	end
end

OpConnected = NewUserConnected

ChatArrival = function(user, data)

local s,e,pre,cmd = string.find(data, "^%b<>%s+(%p)(%w+)")
local s,e,nick = string.find(data, "^%b<>%s+%p%w+%s(%S+)|$")
	if pre and pre==Prefix then
		if cmd and cmd==ScoresCmd then
			if not SnowTable[user.sName] then
				SnowTable[user.sName]={0,0,0,Rankings[1][2],1,1,1,0}
			end
			if SnowProfiles[user.iProfile] and SnowProfiles[user.iProfile][1] == 1 then
				local Scores = "\r\n\r\n\t•Snowball Fight Scores•\r\n\r\n"..string.rep("¯",105).."\r\n"
				for i,v in SnowTable do
					if i ~= "start" then
						local rank = ""
						GetRank()
						local pct = ""
						if v[1] <= 0 then
							pct = "<0.00 %"
						else
							pct = 100 - (v[2] / (v[1] + v[2])) * (100 / 1 )
							pct = string.format("%.2f %%",pct)
						end
						local usr,hit,miss,rank,away,pwr,aim,shield = i,v[1],v[2],v[4],v[3],v[5],v[6],v[7]
						if hit ~= 0 or miss ~= 0 or away ~= 1 or pwr ~= 1 or aim ~= 1 or shield ~= 1 then--Custom Code: Hides unchanged users from the scores display
							if away == 0 then--Custom Code: Displays away status in scores
								Scores = Scores.." • "
							else
								Scores = Scores.." o "
							end
							Scores = Scores..string.format("%-40.30s",usr).."\tHits: "..string.format("%-5.4d",hit).."  Misses: "..
							string.format("%-5.4d",miss).."  Accuracy: "..string.format("%-4s",pct).."  Power: "..string.format("%2d",pwr)..
							"  Aim: "..string.format("%2d",aim).."  Shield: "..string.format("%2d",shield).."   Rank: ["..GetRank(usr).."] "..string.format("%-25s",rank).."\r\n"--Custom Code: Added rank number to display
						end
					end
				end
				if PlayMode == "4" then
					user:SendPM(SnowBot, Scores.."\r\n"..string.rep("¯",105).."\r\n\t•End of Scores Listing•\r\n\r\n")
				else
					user:SendData(SnowBot, Scores.."\r\n"..string.rep("¯",105).."\r\n\t•End of Scores Listing•\r\n\r\n")
				end
				return 1
			else
				if PlayMode == "4"  then
					user:SendData("\r\n\r\n\tSorry "..user.sName.." the command ' "..Prefix..ScoresCmd..
					" ' is disabled for "..SnowProfiles[user.iProfile][2].."'s\r\n")
				else
					user:SendData("\r\n\r\n\tSorry "..user.sName.." the command ' "..Prefix..ScoresCmd..
					" ' is disabled for "..SnowProfiles[user.iProfile][2].."'s\r\n")
				end
				return 1
			end
		elseif cmd and cmd==UpgradeCmd then
			if not SnowTable[user.sName] then
				SnowTable[user.sName]={0,0,0,Rankings[1][2],1,1,1,0}
			end
--//Player Upgrades [idx] = {"Upgrade Name", point cost}
			Upgrades={
			[1] = {"Power Upgrade",SnowTable[user.sName][5] * PowerPrice},
			[2] = {"Aim Upgrade",SnowTable[user.sName][6] * AimPrice},
			[3] = {"Shield Upgrade",SnowTable[user.sName][7] * ShieldPrice},
			}
			if SnowProfiles[user.iProfile] and SnowProfiles[user.iProfile][1] == 1 then
				if SnowTable[user.sName] then
					local s,e,buy = string.find(data, "^%b<>%s+%p%w+%s(%d)|$")
					if buy then
						buy = tonumber(buy)
						if Upgrades[buy] then
							local upgrade,cost = Upgrades[buy][1],Upgrades[buy][2]
							if SnowTable[user.sName][buy + 4] < MaxUpgrade then
								if SnowTable[user.sName][8] >= cost then		
									SnowTable[user.sName][buy + 4] = SnowTable[user.sName][buy + 4] + 1
								else
									if PlayMode == "4"  then
										user:SendPM(SnowBot,"\r\n\tSorry "..SnowTable[user.sName][4].." "..
										user.sName..", you cant afford "..upgrade..".\r\n\tThat upgrade costs "..
										cost.." points, you only have "..SnowTable[user.sName][8].." points.")
									else
										user:SendData(SnowBot,"\r\n\tSorry "..SnowTable[user.sName][4].." "..
										user.sName..", you cant afford "..upgrade..".\r\n\tThat upgrade costs "..
										cost.." points, you only have "..SnowTable[user.sName][8].." points.")
									end
									return 1
								end
							else
								if PlayMode == "4"  then
									user:SendPM(SnowBot,"\r\n\t"..SnowTable[user.sName][4].." "..user.sName.." you already"..
									" have the Max "..upgrade..".")
								else
									user:SendData(SnowBot,"\r\n\t"..SnowTable[user.sName][4].." "..user.sName.." you already"..
									" have the Max "..upgrade..".")
								end
								return 1
							end
								SnowTable[user.sName][8] = SnowTable[user.sName][8] - cost
								if PlayMode == "4"  then
									user:SendPM(SnowBot,"\r\n\t"..SnowTable[user.sName][4].." "..user.sName.." you have "..
									"purchased "..upgrade..".\r\n\t"..cost.." points have been deducted from your score.")
								else
									user:SendData(SnowBot,"\r\n\t"..SnowTable[user.sName][4].." "..user.sName.." you have "..
									"purchased "..upgrade..".\r\n\t"..cost.." points have been deducted from your score.")
								end
								GetRank()
								return 1
						else
							if PlayMode == "4"  then
								user:SendPM(SnowBot,"***Syntax = "..Prefix..UpgradeCmd.." <#>\t"..
								"Where '#' is a number between 1 and 3")
							else
								user:SendData(SnowBot,"***Syntax = "..Prefix..UpgradeCmd.." <#>\t"..
								"Where '#' is a number between 1 and 3")
							end
							return 1
						end
					else
						if PlayMode == "4"  then
							user:SendPM(SnowBot,"***Syntax = "..Prefix..UpgradeCmd.." <#>\t"..
							"Where '#' is a number between 1 and 3")
						else
							user:SendData(SnowBot,"***Syntax = "..Prefix..UpgradeCmd.." <#>\t"..
							"Where '#' is a number between 1 and 3")
						end
						return 1
					end
				else
					if PlayMode == "4"  then
						user:SendPM(SnowBot,"\r\n\r\n\tSorry "..user.sName..", upgrades are purchased "..
						"with points. You'll need to play to get points.\r\n")
					else
						user:SendData(SnowBot,"\r\n\r\n\tSorry "..user.sName..", upgrades are purchased "..
						"with points. You'll need to play to get points.\r\n")
					end
					return 1
				end
			else
				if PlayMode == "4"  then
					user:SendPM(SnowBot,"\r\n\r\n\tSorry "..user.sName.." the command ' "..Prefix..UpgradeCmd..
					" ' is disabled for "..SnowProfiles[user.iProfile][2].."'s\r\n")
				else
					user:SendData(SnowBot,"\r\n\r\n\tSorry "..user.sName.." the command ' "..Prefix..UpgradeCmd..
					" ' is disabled for "..SnowProfiles[user.iProfile][2].."'s\r\n")
				end
				return 1
			end
		elseif cmd and cmd==SnowCmd then
			if SnowProfiles[user.iProfile] and SnowProfiles[user.iProfile][1] == 1 then
				if SnowTable[user.sName] and SnowTable[user.sName][3] == 1 then
					local reply = user.sName.." you can't join the battle while on liberty. "..
					"Request active duty with the command ' "..Prefix..SnowLiberty.." '"
					if PlayMode == "4" then
						user:SendPM(SnowBot,reply)
					else
						user:SendData(SnowBot,reply)
					end
					return 1
				end
				local start = os.clock()
				if Players[user.sName] then
					local interval = Players[user.sName]
					if os.difftime(os.clock(), interval) < WaitTime then
						local reply = "Take it easy rookie. You must wait "..WaitTime.." seconds between shots in regulation play."
						if PlayMode == "4" then
							user:SendPM(SnowBot,reply)
						else
							user:SendData(SnowBot,reply)
						end
						return 1
					end
				end
				if nick then
					local usrnick = GetItemByName(nick)
					if not usrnick then
						local reply = "User "..nick.." Not found. Best to set your sights on one who is online."
						if PlayMode == "4" then
							user:SendPM(SnowBot,reply)
						else
							user:SendData(SnowBot,reply)
						end
						return 1
					elseif SnowTable[usrnick.sName] then
						if SnowTable[usrnick.sName][3] == 1 then
							local reply = "User "..nick.." is on liberty, choose another target soldier."
							if PlayMode == "4" then
								user:SendPM(SnowBot,reply)
							else
								user:SendData(SnowBot,reply)
							end
							return 1
						end
					elseif not SnowTable[usrnick.sName] then
						local reply = "User "..nick.." is on liberty, choose another target soldier."
						if PlayMode == "4" then
							user:SendPM(SnowBot,reply)
						else
							user:SendData(SnowBot,reply)
						end
						return 1
					end
					if not SnowTable[user.sName] then
							SnowTable[user.sName]={0,0,0,Rankings[1][2],1,1,1,0}
					end
					if nick == user.sName then
						if SnowTable[user.sName][1] > 1000 then--Custom Code: If they pass the top rank they cannot go on liberty
							if PlayMode == "4" then
								user:SendPM(SnowBot,"Sorry "..SnowTable[user.sName][4].." "..user.sName.." but at the highest rank you cannot self-inflict damage, you CHICKEN!")--Custom Code: Top rank is not allowed on liberty to prevent secluded domination and must defend their title)
							else
								user:SendData(SnowBot,"Sorry "..SnowTable[user.sName][4].." "..user.sName.." but at the highest rank you cannot self-inflict damage, you CHICKEN!")--Custom Code: Top rank is not allowed on liberty to prevent secluded domination and must defend their title)
							end
							return 1
						end
						SnowTable[user.sName][1] = SnowTable[user.sName][1] - GetRank(user.sName)
						SnowTable[user.sName][8] = SnowTable[user.sName][8] - GetRank(user.sName)--Custom Code: Spending points are reduced too
						if SnowTable[user.sName][1] < 0 then--Custom Code: Prevents score from going negative
							SnowTable[user.sName][1] = 0
						end
						if SnowTable[user.sName][8] < 0 then
							SnowTable[user.sName][8] = 0
						end
						Save_File(SnowFile,SnowTable,"SnowTable")
--						local reply = "The officials have taken a point from "..user.sName.." for a self-inflicted score."
						local reply = "The officials have deducted "..GetRank(user.sName).." point(s) from "..user.sName.." for a self-inflicted score."
						if PlayMode == "1" then	--Custom Code: Everyone views all snowfight messages
							SendToAll(SnowBot,reply)
						elseif PlayMode == "2" then	--Custom Code: Only those involved view snowfight messages
							user:SendData(SnowBot,reply)
							usrnick:SendData(SnowBot,reply)
						elseif PlayMode == "3" then	--Custom Code: Only active players view snowfight messages
							for i,v in SnowTable do
								if v[3] == 0 then
									SendToNick(i, SnowBot,reply)
								end
							end
						else
							for i,v in SnowTable do
								if v[3] == 0 then
									SendPmToNick(i, SnowBot,reply)
								end
							end
						end
						return 1
					end
					if GameOn == 0 then
						GameOn = 1
						WarStopTime = WarStartTime
						WarCry = WarCry.." When they ask who started this War remember to tell them it was "..user.sName..".\r\n\r\n"
					else
						WarStopTime = math.floor(os.clock())
						WarCry = ""
							if (WarStopTime - WarStartTime) > WarEndTime then
								GameOn = 1
								WarCry = "\r\n\r\nAfter more than "..(WarEndTime / 60).." minutes of peace "..
								user.sName.." fans the flames of War yet again.\r\n\r\n"
							end
					end
					Players[user.sName]=start
					WarStartTime = os.clock()
					local toss = ""
--					if SnowTable[user.sName][6] == 1 then
--						if SnowTable[usrnick.sName] then
--							if SnowTable[usrnick.sName][7] == 0 then
--								toss =  Throw[math.random(1,4)]
--							else
--								toss =  Throw[math.random(5,10)]
--							end
--						else
--							toss =  Throw[math.random(2,3)]
--						end
--					elseif SnowTable[user.sName][6] == 2 then
--						if SnowTable[usrnick.sName] then
--							if SnowTable[usrnick.sName][7] == 0 then
--								toss =  Throw[math.random(4,6)]
--							else
--								toss =  Throw[math.random(6,10)]
--							end
--						else
--							toss =  Throw[math.random(1,3)]
--						end
--					end
--					if SnowTable[user.sName][6] == 0 and SnowTable[user.sName][7] == 0 then
--						toss =  Throw[math.random(1,6)]
--					end
					toss =  Throw[math.random(11 - SnowTable[user.sName][6],10 + SnowTable[usrnick.sName][7])]--Custom Code: calculates random slots using your aim and their shield
					if toss == 0 then
						SnowTable[user.sName][2] = SnowTable[user.sName][2] + 1
						local result = Miss[math.random(1, table.getn(Miss))]
						result = string.gsub(result,"user1", user.sName)
						result = string.gsub(result,"user2", usrnick.sName)
						if PlayMode == "1" then	--Custom Code: Everyone views all snowfight messages
							SendToAll(SnowBot,WarCry..result)
						elseif PlayMode == "2" then	--Custom Code: Only those involved view snowfight messages
							user:SendData(SnowBot,WarCry..result)
							usrnick:SendData(SnowBot,WarCry..result)
						elseif PlayMode == "3" then	--Custom Code: Only active players view snowfight messages
							for i,v in SnowTable do
								if v[3] == 0 then
									SendToNick(i, WarCry..result)
								end
							end
						else
							for i,v in SnowTable do
								if v[3] == 0 then
									SendPmToNick(i, SnowBot, WarCry..result)
								end
							end
						end
					else
						SnowTable[user.sName][1] = SnowTable[user.sName][1] + SnowTable[user.sName][5]--Custom Code: adds your power level to your points for a hit
						SnowTable[user.sName][8] = SnowTable[user.sName][8] + SnowTable[user.sName][5]--Custom Code: adds your power level to your points for a hit
						SnowTable[usrnick.sName][1] = SnowTable[usrnick.sName][1] - GetRank(usrnick.sName)--Custom Code: person hit loses points equal to rank
						SnowTable[usrnick.sName][8] = SnowTable[usrnick.sName][8] - GetRank(usrnick.sName)--Custom Code: person hit loses points equal to rank
						if SnowTable[usrnick.sName][1] < 0 then--Custom Code: Prevents score from going negative
							SnowTable[usrnick.sName][1] = 0
						end
						if SnowTable[usrnick.sName][8] < 0 then
							SnowTable[usrnick.sName][8] = 0
						end
--						if GetRank(user.sName) ~= nil and GetRank(usrnick.sName) ~= nil
--						and GetRank(user.sName) > GetRank(usrnick.sName) then
--							if SnowTable[user.sName][5] == 1 then
--								SnowTable[user.sName][1] = SnowTable[user.sName][1] + 3
--							elseif SnowTable[user.sName][5] == 2 then
--								SnowTable[user.sName][1] = SnowTable[user.sName][1] + 4
--							else
--								SnowTable[user.sName][1] = SnowTable[user.sName][1] + 2
--							end
--						else
--							SnowTable[user.sName][1] = SnowTable[user.sName][1] + 1
--						end
						local result = Hit[math.random(1, table.getn(Hit))]
						result = string.gsub(result,"user1", user.sName)
						result = string.gsub(result,"user2", usrnick.sName)
						if PlayMode == "1" then	--Custom Code: Everyone views all snowfight messages
							SendToAll(SnowBot,WarCry..result)
						elseif PlayMode == "2" then	--Custom Code: Only those involved view snowfight messages
							user:SendData(SnowBot,WarCry..result)
							usrnick:SendData(SnowBot,WarCry..result)
						elseif PlayMode == "3" then	--Custom Code: Only active players view snowfight messages
							for i,v in SnowTable do
								if v[3] == 0 then
									SendToNick(i, WarCry..result)
								end
							end
						else
							for i,v in SnowTable do
								if v[3] == 0 then
									SendPmToNick(i, SnowBot, WarCry..result)
								end
							end
						end
					end
					Save_File(SnowFile,SnowTable,"SnowTable")
					return 1
				else
					user:SendData("\r\n\r\n\tSyntax Error, Syntax = "..Prefix..SnowCmd.." <Nick>\r\n")
					return 1
				end
			else
				user:SendData("\r\n\r\n\tSorry "..user.sName.." the command ' "..Prefix..SnowCmd..
				" ' is disabled for "..SnowProfiles[user.iProfile][2].."'s\r\n")
				return 1
			end
		elseif cmd and cmd == SnowLiberty then
			if Players[user.sName] then
				local interval = Players[user.sName]
				if os.difftime(os.clock(), interval) < WaitTime then
					local reply = "Chicken! You must wait "..WaitTime.." seconds before going into hiding."
					if PlayMode == "4" then
						user:SendPM(SnowBot,reply)
					else
						user:SendData(SnowBot,reply)
					end
					return 1
				end
			end
			if SnowTable[user.sName] then
				if SnowTable[user.sName][1] > TopRank then--Custom Code: If they pass the top rank they cannot go on liberty
					if PlayMode == "4" then
						user:SendPM(SnowBot,"Sorry "..SnowTable[user.sName][4].." "..user.sName.." but at the highest rank you cannot go on liberty and must defend your title.")--Custom Code: Top rank is not allowed on liberty to prevent secluded domination and must defend their title)
					else
						user:SendData(SnowBot,"Sorry "..SnowTable[user.sName][4].." "..user.sName.." but at the highest rank you cannot go on liberty and must defend your title.")--Custom Code: Top rank is not allowed on liberty to prevent secluded domination and must defend their title)
					end
					return 1
				elseif SnowTable[user.sName][3] == 0 then
					SnowTable[user.sName][3] = 1
					if PlayMode == "4" then
						user:SendPM(SnowBot,"OK "..SnowTable[user.sName][4].." "..user.sName.." you've been cleared for liberty.")
					else
						user:SendData(SnowBot,"OK "..SnowTable[user.sName][4].." "..user.sName.." you've been cleared for liberty.")
					end
					Save_File(SnowFile,SnowTable,"SnowTable")
					return 1
				elseif SnowTable[user.sName][3] == 1 then
					SnowTable[user.sName][3] = 0
					if PlayMode == "4" then
						user:SendPM(SnowBot,"OK "..SnowTable[user.sName][4].." "..user.sName.." you've been placed back on active duty.")
					else
						user:SendData(SnowBot,"OK "..SnowTable[user.sName][4].." "..user.sName.." you've been placed back on active duty.")
					end
					Save_File(SnowFile,SnowTable,"SnowTable")
					return 1
				end
			else
				SnowTable[user.sName]={0,0,0,Rankings[1][2],1,1,1,0}
				if PlayMode == "4" then
					user:SendPM(SnowBot,"OK "..SnowTable[user.sName][4].." "..user.sName.." you're now ready to fight!")
				else
					user:SendData(SnowBot,"OK "..SnowTable[user.sName][4].." "..user.sName.." you're now ready to fight!")
				end
				Save_File(SnowFile,SnowTable,"SnowTable")
				return 1
			end
		elseif cmd and cmd == ForceLiberty and user.iProfile <= 1 then
			local usrnick = GetItemByName(nick)--Custom Code: Testing to see if this allows toggling of offline users
			if usrnick then
				if SnowTable[usrnick.sName][1] > TopRank then--Custom Code: If they pass the top rank they cannot go on liberty
					if PlayMode == "4" then
						user:SendPM(SnowBot,SnowTable[usrnick.sName][4].." "..usrnick.sName.." is at the highest rank and cannot go on liberty and must defend their title.")--Custom Code: Top rank is not allowed on liberty to prevent secluded domination and must defend their title)
					else
						user:SendData(SnowBot,SnowTable[usrnick.sName][4].." "..usrnick.sName.." is at the highest rank and cannot go on liberty and must defend their title.")--Custom Code: Top rank is not allowed on liberty to prevent secluded domination and must defend their title)
					end
					return 1
				elseif SnowTable[usrnick.sName][3] == 0 then
					SnowTable[usrnick.sName][3] = 1
					if PlayMode == "4" then
						user:SendPM(SnowBot,SnowTable[usrnick.sName][4].." "..usrnick.sName.." has been placed on liberty.")
					else
						user:SendData(SnowBot,SnowTable[usrnick.sName][4].." "..usrnick.sName.." has been placed on liberty.")
					end
					Save_File(SnowFile,SnowTable,"SnowTable")
					return 1
				elseif SnowTable[usrnick.sName][3] == 1 then
					SnowTable[usrnick.sName][3] = 0
					if PlayMode == "4" then
						user:SendPM(SnowBot,SnowTable[usrnick.sName][4].." "..usrnick.sName.." has been placed on active duty.")
					else
						user:SendData(SnowBot,SnowTable[usrnick.sName][4].." "..usrnick.sName.." has been placed on active duty.")
					end
					Save_File(SnowFile,SnowTable,"SnowTable")
					return 1
				end
			else
				local reply = "User "..nick.." not found / is offline."
				if PlayMode == "4" then
					user:SendPM(SnowBot,reply)
				else
					user:SendData(SnowBot,reply)
				end
				return 1
			end
		elseif cmd and cmd == ShowUpgrade then
			if not SnowTable[user.sName] then
				SnowTable[user.sName]={0,0,0,Rankings[1][2],1,1,1,0}
			end
--//Player Upgrades [idx] = {"Upgrade Name", point cost}
--			Upgrades={
--			[1] = {"Lvl ["..SnowTable[user.sName][5]+'1'.."] Power Upgrade",SnowTable[user.sName][5] * 10},--Custom Code: Added Rank level to upgrade display
--			[2] = {"Lvl ["..SnowTable[user.sName][6]+'1'.."] Aim Upgrade",SnowTable[user.sName][6] * 10},--Custom Code: Added Rank level to upgrade display
--			[3] = {"Lvl ["..SnowTable[user.sName][7]+'1'.."] Shield Upgrade",SnowTable[user.sName][7] * 10},--Custom Code: Added Rank level to upgrade display
--			}
			local ups = "\r\n\r\n\tThese are the upgrades available to you.\r\n"..
			"\t"..string.rep("¯",32).."\r\n"
			if SnowTable[user.sName][5] == MaxUpgrade then
				ups = ups.."\t1. Max Power Upgrade Reached\r\n"
			else
				ups = ups.."\t1. Lvl ["..SnowTable[user.sName][5]+'1'.."] Power Upgrade\t"..SnowTable[user.sName][5] * PowerPrice.."  Points\r\n"
			end
			if SnowTable[user.sName][6] == MaxUpgrade then
				ups = ups.."\t2. Max Aim Upgrade Reached\r\n"
			else
				ups = ups.."\t2. Lvl ["..SnowTable[user.sName][6]+'1'.."] Aim Upgrade\t"..SnowTable[user.sName][6] * AimPrice.."  Points\r\n"
			end
			if SnowTable[user.sName][7] == MaxUpgrade then
				ups = ups.."\t3. Max Shield Upgrade Reached\r\n"
			else
				ups = ups.."\t3. Lvl ["..SnowTable[user.sName][7]+'1'.."] Shield Upgrade\t"..SnowTable[user.sName][7] * ShieldPrice.."  Points\r\n"
			end
--			for i,v in Upgrades do
--				if v[2] == MaxUpgrade * 10 - 10 then
--					ups = ups.."\t"..i..".  "..string.format("%-18s",v[1]).."\tMax Reached\r\n"
--				else
--					ups = ups.."\t"..i..".  "..string.format("%-18s",v[1]).."\t"..v[2].."  Points\r\n"
--				end if
--			end
			ups = ups.."\r\n\t"..string.rep("¯",32).."\r\n"
			ups = ups.."\r\n\tYou have "..SnowTable[user.sName][8].." points.\r\n"
			if PlayMode == "4" then
				user:SendPM(SnowBot,ups)
			else
				user:SendData(SnowBot,ups)
			end
			return 1
		elseif cmd and cmd == ShowRules then
			local ups = "\r\n\r\n\t\tRules and Instructions\r\n"..
			"\t"..string.rep("¯",32).."\r\n"
			ups = ups.."\tThere are new rules and calculations that have been added to Snowball.\r\n"
			ups = ups.."\tSnowball is a simple amusing game of throwing snowballs at other people in the room for points.\r\n"
			ups = ups.."\tThe new features of snowball is whenever you hit someone you gain points and rank up.\r\n"
			ups = ups.."\tYou can now go into hiding by going on 'Liberty' which prevents others from hitting you.\r\n"
			ups = ups.."\tYou will be on liberty if you've never played before and someone attacks you, just remember to always go back to liberty when your done fighting.\r\n"
			ups = ups.."\tIn addition you can now purchase upgrades to your player with the points you earned. Misses and spendable points are now seperate so check available upgrades for how much money to spend you have.\r\n"
			ups = ups.."\tEvery player is equipped with 3 stats: Power, Aim and Shield. All players start at lvl 1 stats and can get up to lvl 10 in all stats!\r\n"
			ups = ups.."\tPower is equal to the number of points you get when you hit someone.\r\n"
			ups = ups.."\tAim increases your accuracy chance and can get above 90 percent!\r\n"
			ups = ups.."\tShield decreases other's accuracy chance of hitting you and can get below 10 percent!\r\n"
			ups = ups.."\tShields are now more important because if you are hit you lose points equal to your rank (check your scores and rank number for that value).\r\n"
			ups = ups.."\tIf you reach the maximum rank (15) you are no longer allowed on liberty and must defend your title.\r\n"
			ups = ups.."\r\n\tHave fun playing! Oh ya and if you look carefully there's a way to see who's not on liberty in via scores.\r\n"
			ups = ups.."\r\n\t"..string.rep("¯",32).."\r\n"
			if PlayMode == "4" then
				user:SendPM(SnowBot,ups)
			else
				user:SendData(SnowBot,ups)
			end
			return 1
		elseif cmd and cmd == SnowMode then
			local s,e,mode = string.find(data, "^%b<>%s+%p%w+%s(%d)|$")
			PlayMode = mode
			SendToAll(SnowBot,"Game Play changed to Mode "..PlayMode)
			return 1
--		elseif cmd and cmd== ScoreReset then
--			user:SendData(SnowBot,"Scores Reset")
--			Save_File(SnowFile,SnowTable,"SnowTable")
--			return 1
		end
	end
end

function Commands(user)
	user:SendData("$UserCommand 1 1 "..SnowMenu.."\\Toss a snowball at... $<%[mynick]> "..Prefix..SnowCmd.." %[line:Nick]&#124;")
	user:SendData("$UserCommand 1 2 "..SnowMenu.."\\Toss a snowball at... $<%[mynick]> "..Prefix..SnowCmd.." %[nick]&#124;")
	user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Get scores $<%[mynick]> "..Prefix..ScoresCmd.."&#124;")
	user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Toggle Liberty $<%[mynick]> "..Prefix..SnowLiberty.."&#124;")
	if user.iProfile == 0 or user.iProfile == 1 or user.iProfile == 4 or user.iProfile == 5 then
		user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Force Liberty $<%[mynick]> !sfl %[userNI]&#124;|")
--		user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Reset Scores $<%[mynick]> !sreset &#124;|")
		user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Change Play Mode $<%[mynick]> !smode %[line:1=All, 2=Involved, 3=Active, 4=ActivePM]&#124;")
	end
	user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Purchase Upgrades $<%[mynick]> "..Prefix..UpgradeCmd.." %[line:1=Power, 2=Aim, 3=Shield]&#124;")
	user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Available Upgrades $<%[mynick]> "..Prefix..ShowUpgrade.."&#124;")
	user:SendData("$UserCommand 1 3 "..SnowMenu.."\\Rules and Instructions $<%[mynick]> "..Prefix..ShowRules.."&#124;")
end

GetRank = function(nick)
	if nick then
		for a,b in Rankings do
			if SnowTable[nick] then
				if SnowTable[nick][4] == b[2] then
					return a
				end
			else
				return nil
			end
		end
	else
		for i,v in SnowTable do
			if i ~= "start" then
				for a,b in Rankings do
					if v[1] > b[1] and v[1] <= b[1] then
						v[4] = b[2]
					elseif v[1] > b[1] then
						v[4] = b[2]
					end
				end
			end
		end
		Save_File(SnowFile,SnowTable,"SnowTable")
	end
end

Save_Serialize = function(tTable, sTableName, hFile, sTab)
	sTab = sTab or "";
	hFile:write(sTab..sTableName.." = {\n" );
	for key, value in tTable do
		local sKey = (type(key) == "string") and string.format("[%q]",key) or string.format("[%d]",key);
		if(type(value) == "table") then
			Save_Serialize(value, sKey, hFile, sTab.."\t");
		else
			local sValue = (type(value) == "string") and string.format("%q",value) or tostring(value);
			hFile:write( sTab.."\t"..sKey.." = "..sValue);
		end
		hFile:write( ",\n");
	end
	hFile:write( sTab.."}");
end

Save_File = function(file,table , tablename )
	local hFile = io.open (file , "w")
	Save_Serialize(table, tablename, hFile);
	hFile:close()
end