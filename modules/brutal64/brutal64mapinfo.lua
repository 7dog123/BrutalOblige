local castcall =
[[
Intermission Brutal64_FinalIntermission
    {
    	Image
    	{
    		// This is only here to initialize the background and the music
    		Background = "$bgcastcall"
    		Time = -1
    		Music = "$MUSIC_EVIL"
    	}
    	Link = Brutal64Cast
    }
Intermission Brutal64Cast
    {
    	Cast
    	{
    		CastClass = "64ZombieMan"
    		CastName = "$CC_ZOMBIE"
    		AttackSound = "Missile", 1, "grunt/attack"
    	}
    	Cast
    	{
    		CastClass = "64ShotgunGuy"
    		CastName = "$CC_SHOTGUN"
    		AttackSound = "Missile", 1, "shotguy/attack"
    	}
		Cast
    	{
    		CastClass = "64ZombieMarine"
    		CastName = "Zombie Marine"
    		AttackSound = "Missile", 1, "grunt/attack"
    	}
    	Cast
    	{
    		CastClass = "64ChaingunGuy"
    		CastName = "$CC_HEAVY"
    		AttackSound = "Missile", 1, "chainguy/attack"
    		AttackSound = "Missile", 2, "chainguy/attack"
    		AttackSound = "Missile", 3, "chainguy/attack"
    	}
    	Cast
    	{
    		CastClass = "64DoomImp"
    		CastName = "$CC_IMP"
    		AttackSound = "Missile", 2, "imp/attack"
    	}
    	Cast
    	{
    		CastClass = "NightmareImp"
    		CastName = "Nightmare Imp"
    		AttackSound = "Missile", 2, "imp/attack"
    	}
    	Cast
    	{
    		CastClass = "64Demon"
    		CastName = "$CC_DEMON"
    		AttackSound = "Melee", 1, "demon/melee"
    	}
		Cast
    	{
    		CastClass = "64Spectre"
    		CastName = "Nightmare Spectre"
    		AttackSound = "Melee", 1, "demon/melee"
    	}
    	Cast
    	{
    		CastClass = "64LostSoul"
    		CastName = "$CC_LOST"
    		AttackSound = "Missile", 1, "skull/melee"
    	}
    	Cast
    	{
    		CastClass = "64Cacodemon"
    		CastName = "$CC_CACO"
    		AttackSound = "Missile", 1, "caco/attack"
    	}
		Cast
    	{
    		CastClass = "NightmareCacodemon"
    		CastName = "Nightmare Cacodemon"
    		AttackSound = "Missile", 1, "caco/attack"
    	}
    	Cast
    	{
    		CastClass = "64HellKnight"
    		CastName = "$CC_HELL"
    		AttackSound = "Missile", 1, "baron/attack"
    	}
    	Cast
    	{
    		CastClass = "64BaronOfHell"
    		CastName = "$CC_BARON"
    		AttackSound = "Missile", 1, "baron/attack"
    	}
    	Cast
    	{
    		CastClass = "64Arachnotron"
    		CastName = "$CC_ARACH"
    		AttackSound = "Missile", 1, "baby/attack"
    	}
    	Cast
    	{
    		CastClass = "64PainElemental"
    		CastName = "$CC_PAIN"
    		AttackSound = "Missile", 2, "skull/melee"
    	}
    	Cast
    	{
    		CastClass = "64Revenant"
    		CastName = "$CC_REVEN"
    		AttackSound = "Missile", 1, "skeleton/attack"
    		AttackSound = "Melee", 1, "skeleton/swing"
    		AttackSound = "Melee", 3, "skeleton/melee"
    	}
    	Cast
    	{
    		CastClass = "64Fatso"
    		CastName = "$CC_MANCU"
    		AttackSound = "Missile", 1, "fatso/attack"
    		AttackSound = "Missile", 4, "fatso/attack"
    		AttackSound = "Missile", 7, "fatso/attack"
    	}
		Cast
    	{
    		CastClass = "64HellHound"
    		CastName = "Hell Hound"
    		AttackSound = "Missile", 1, "demon/melee"
    	}
    	Cast
    	{
    		CastClass = "Archvile"
    		CastName = "$CC_ARCH"
    		AttackSound = "Missile", 1, "vile/start"
    	}
    	Cast
    	{
    		CastClass = "64SpiderMastermind"
    		CastName = "$CC_SPIDER"
    		AttackSound = "Missile", 1, "spider/attack"
    		AttackSound = "Missile", 2, "spider/attack"
    	}
        Cast
    	{
    		CastClass = "64Cyberdemon"
    		CastName = "$CC_CYBER"
    		AttackSound = "Missile", 1, "weapons/rocklf"
    		AttackSound = "Missile", 3, "weapons/rocklf"
    		AttackSound = "Missile", 5, "weapons/rocklf"
    	}
    	Cast
    	{
    		CastClass = "64DoomPlayer"
    		CastName = "$CC_HERO"
    		AttackSound = "Missile", 0, "weapons/sshotf"
    	}
    	Link = Brutal64Cast	// restart cast call
    }
]]

function BRUTAL64.create_mapinfo()
  gui.printf("Brutal 64 Mapinfo code is starting\n");
  local data =
  {
    "//\n"
    "// MAPINFO LUMP created by OBLIGE\n"
    "//\n"
    "//Secret exits are in maps " .. tostring(secretexit1) .. ', ' .. tostring(secretexit2) .. ' and ' .. tostring(secretexit3) .. '\n'
    "clearepisodes\n\n"
    'episode bom01\n'
    '{\n'
    'name = "Brutal Oblige"\n'
    '}\n\n'
  }

  --- music ---
  local epi_list = BRUTAL64.music
  local dest = { }

  each _,src in epi_list do
    dest = table.copy(src)
    
    -- this shuffle algorithm ensures first entry is never the same
    --once again I can't quite work out the code so I have left this even though I only need half of it
    for i = 1, (#dest) do
      local k = rand.irange(i + 1, #dest)
      dest[i], dest[k] = dest[k], dest[i]
    end
  end
    --after this dest[1-#src] are the music tracks
    dest[31] = "d_evil" --map 31 always wolf themed

  local firstmap = 1
  local mapnum = 1

  --- level names ---
  --L.name is MAP01 etc, L.descritption is the nice name
  --L.theme_name gives the theme
  each L in GAME.levels do
    local prefix = PARAM.bex_map_prefix

    if L.description and prefix then --keep the prefix stuff from the bex incase something else relies on it
      local id

      if string.sub(L.name, 1, 1) == 'E' then
        -- Doom I : ExMy
        id = "bom" .. L.name

      else
        local pos = 4
        if string.sub(L.name, pos, pos) == '0' then
          pos = pos + 1
        end

        -- Doom II / Final Doom : HUSTR_%d
        id = "bom" .. string.sub(L.name, pos)
      end

      local nextmap = 'next = "' .. L.name ..'"\n'

      local sky1 = 'sky1 = "RSKY1' --default sky. Final " deliberately ommitted so a B can be added before it, see the roll for extra sky bit.
      local enterpic = '"INTERPIC"' --default intermissionpic
      if L.theme_name == "hell" then
        sky1 = 'sky1 = "RSKY3'
      elseif L.theme_name == "urban" then
        sky1 = 'sky1 = "RSKY2'
      elseif L.theme_name == "satanshankerchief" then --may need to be removed
	local n = rand.irange(1,3)
        sky1 = 'sky1 = "CHEXSKY' .. n
        enterpic = '"CHEXINT"'
      end
      
      --roll for extra sky --may not work
      --if BRUTALDOOM.PARAMETERS.skygenerator == true and rand.irange(1,2) == 2 and L.theme_name != "satanshankerchief" then
      --    sky1 = sky1 .. 'B'
      --end

      sky1 = sky1 .. '"\n' --put in the newline here for convinience
      enterpic = enterpic .. '\n'

      local text = L.name .. ' "' .. L.description ..'"'; --the mapinfo key

      --say that this map comes after the last map
      if firstmap == 0 then
	if mapnum != 31 and mapnum != 32 and mapnum != 33 then --yes I could just do <31 but it might be possible to make Oblige do more than 32 maps in which case this will still work. Number is 1 higher because this is inserted at the start of the next map.
          table.insert(data, nextmap)
        else
	  if mapnum != 32 and mapnum != 33 then
            table.insert(data, 'next = "EndGame3"\n')
	  end
	end
        if mapnum >=11 and mapnum < 21 then--mapnum == 17 then --map 16 has the secret exit to wolf levels. Number is 1 higher because this is inserted at the start of the next map.
          table.insert(data, 'secretnext = "BOM31"\n')
        end
        if mapnum == 32 then --first secret level (wolf)
          table.insert(data, 'next = "BOM' .. tostring(secretexit2 + 1) .. '"\n')
          table.insert(data, 'secretnext = "BOM32"\n')
        end
        table.insert(data, '\n}\n') --close last map's definition
      else
        firstmap = 0
      end

      --open definition for map
      table.insert(data, string.format("%s %s\n{\n", "map", text))
      --enter map information
      table.insert(data, sky1)
      table.insert(data, 'EnterPic = ' .. enterpic)
      table.insert(data, 'ExitPic = ' .. enterpic)
      table.insert(data, 'cluster = 10\n')
      table.insert(data, 'music = "' .. dest[mapnum] .. '"\n')
      mapnum = mapnum + 1
    end
  end -- for L

  if mapnum == 33 then --second secret level (chex)
    table.insert(data, 'next = "BOM' .. tostring(secretexit2 + 1) .. '"\n')
  else
    table.insert(data, 'next = EndSequence, "Brutal64_FinalIntermission"\n') --last map ends the game unless it is a secret level (ie anything more or less than full game)
  end
  table.insert(data, "}\n"); --close final map definition
  
  --insert final intermission
  table.insert(data, castcall)

--make sure there are no 0s in stupid places
for i = 1, (#data) do --for every value in data
  data[i] = string.gsub(data[i], '"BOM010"','"BOM10"')
  data[i] = string.gsub(data[i], '"BOM011"','"BOM11"')
  data[i] = string.gsub(data[i], '"BOM012"','"BOM12"')
  data[i] = string.gsub(data[i], '"BOM013"','"BOM13"')
  data[i] = string.gsub(data[i], '"BOM014"','"BOM14"')
  data[i] = string.gsub(data[i], '"BOM015"','"BOM15"')
  data[i] = string.gsub(data[i], '"BOM016"','"BOM16"')
  data[i] = string.gsub(data[i], '"BOM017"','"BOM17"')
  data[i] = string.gsub(data[i], '"BOM018"','"BOM18"')
  data[i] = string.gsub(data[i], '"BOM019"','"BOM19"')
  data[i] = string.gsub(data[i], '"BOM020"','"BOM20"')
  data[i] = string.gsub(data[i], '"BOM021"','"BOM21"')
  data[i] = string.gsub(data[i], '"BOM022"','"BOM22"')
  data[i] = string.gsub(data[i], '"BOM023"','"BOM23"')
  data[i] = string.gsub(data[i], '"BOM024"','"BOM24"')
  data[i] = string.gsub(data[i], '"BOM025"','"BOM25"')
  data[i] = string.gsub(data[i], '"BOM026"','"BOM26"')
  data[i] = string.gsub(data[i], '"BOM027"','"BOM27"')
  data[i] = string.gsub(data[i], '"BOM028"','"BOM28"')
  data[i] = string.gsub(data[i], '"BOM029"','"BOM29"')
  data[i] = string.gsub(data[i], '"BOM030"','"BOM30"')
  data[i] = string.gsub(data[i], '"BOM031"','"BOM31"')
  data[i] = string.gsub(data[i], '"BOM032"','"BOM32"')
  data[i] = string.gsub(data[i], '"BOM1"','"BOM01"')
  data[i] = string.gsub(data[i], '"BOM2"','"BOM02"')
  data[i] = string.gsub(data[i], '"BOM3"','"BOM03"')
  data[i] = string.gsub(data[i], '"BOM4"','"BOM04"')
  data[i] = string.gsub(data[i], '"BOM5"','"BOM05"')
  data[i] = string.gsub(data[i], '"BOM6"','"BOM06"')
  data[i] = string.gsub(data[i], '"BOM7"','"BOM07"')
  data[i] = string.gsub(data[i], '"BOM8"','"BOM08"')
  data[i] = string.gsub(data[i], '"BOM9"','"BOM09"')
end

gui.wad_add_text_lump("MAPINFO", data);

end