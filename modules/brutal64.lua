gui.import("brutaldoom")
gui.import("brutalthemes")

local modversion = "bd64gamev2.pk3"

BRUTAL64 = { }

function BRUTAL64.gameinfo()

  local data =
  {
      '//ZDoom GAMEINFO lump for Brutal Oblige\n'
  }
        
  table.insert(data,'IWAD="' .. BRUTALDOOM.PARAMETERS.iwad .. '"\n')

  table.insert(data,'LOAD="' .. modversion .. '","bfriend1.pk3"')
--throws no error if not found so load it regardless of if that module's actually being used
  if BRUTALDOOM.PARAMETERS.starterpack == true then
      table.insert(data,',"hellonearthstarterpack.wad"')
  end
  if BRUTALDOOM.PARAMETERS.musicpreset == "doommetal" then
      table.insert(data,',"DoomMetalVol4.wad"')
  end
  if BRUTALDOOM.PARAMETERS.musicpreset == "idkfa" then
      table.insert(data,',"IDKFAv2.wad"')
  end
  
  table.insert(data,'\n')

  gui.wad_add_text_lump("GAMEINFO", data);
end

function BRUTAL64.monstersdecorate()

  local data =
	{
        'actor Oblige64NightmareImp : NightmareImp 325\n'
		'{\n'
                '//$Category "Monsters"\n'
                '//$EditorSprite "TRO2A1"\n'
                'Tag "Nightmare Imp"\n'
		'}\n'
		'actor Oblige64NightmareCaco : NightmareCacodemon 326\n'
		'{\n'
                '//$Category "Monsters"\n'
                '//$EditorSprite "HEA2A1"\n'
                'Tag "Nightmare Cacodemon"\n'
		'}\n'
		'actor NCacoBall : 64CacodemonBall {}\n' --not present in brutal64 V2
		'actor Oblige64Archvile : Archvile 327\n'
		'{\n'
                '//$Category "Monsters"\n'
                '//$EditorSprite "VILEA1"\n'
                'Tag "Archvile"\n'
		'}\n'
		'actor Oblige64ChaingunGuy : 64ChaingunGuy 328\n'
		'{\n'
                '//$Category "Monsters"\n'
                '//$EditorSprite "MPOSA1"\n'
                'Tag "Zombie Chaingunner"\n'
		'}\n'
		'actor Oblige64Zombiemarine : 64ZombieMarine 329\n'
		'{\n'
                '//$Category "Monsters"\n'
                '//$EditorSprite "CPOSA1"\n'
                'Tag "Zombie Marine"\n'
		'}\n'
	}
    gui.wad_add_text_lump("DECORATE", data);
end

function BRUTAL64.weaponsdecorate()

  local data =
	{
		'actor ObligeRifleSpawner : RifleSpawner 330 {}\n'
		'actor ObligeSoulAmmo : SoulAmmo 331 {}\n'
	}
    gui.wad_add_text_lump("DECORATE", data);
end

BRUTAL64.MONSTERS =
{
 NightmareCaco =
  {
    id = 326
    r = 31
    h = 56 
    level = 4
    prob = 50
    health = 700
    damage = 5
    attack = "missile"
    density = 0.5
    min_weapon = 1
    float = true
    room_size = "large"
  }
  NightmareImp =
  {
    id = 325
    r = 20
    h = 56 
    level = 2
    prob = 130
    health = 60
    damage = 1.5
    attack = "missile"
    density = 1.0
    room_size = "small"
    trap_factor = 0.3
    infight_damage = 4.0
  }
  --BD64 replaces the archvile with the HellHound. The next 3 entries correct oblige for this
  vile = REMOVE_ME --clear and use a seperate hellhound definition so probability can be controlled seperately
  HellHound =
  {
    id = 64
    r = 20
    h = 56 
    level = 6
    prob = 10
    crazy_prob = 20
    health = 800
    damage = 20
    attack = "Missile"
    density = 0.15
    room_size = "medium"
    min_weapon = 4
    infight_damage = 18
  }
  ReplacementVile = --same as Archvile in regular Oblige
  {
    id = 327
    r = 20
    h = 56 
    level = 6.5
    boss_type = "nasty"
    boss_prob = 50
    prob = 5
    crazy_prob = 15
    health = 700
    damage = 25
    attack = "hitscan"
    density = 0.15
    room_size = "medium"
    min_weapon = 4
    nasty = true
    infight_damage = 18
  }
  --seperate the zombie chaingunner and zombie marine
  gunner = REMOVE_ME
  Chaingunner64 =
  {
    id = 328
    r = 20
    h = 56 
    level = 3
    prob = 60
    health = 70
    damage = 5.5
    attack = "hitscan"
    give = { {weapon="chain"}, {ammo="bullet",count=10} }
    min_weapon = 1
    density = 0.75
    species = "zombie"
    room_size = "large"
    disloyal = true
    trap_factor = 2.4
    infight_damage = 25
  }
  ZombieMarine =
  {
    id = 329
    r = 20
    h = 56 
    level = 3
    prob = 60
    health = 70
    damage = 5.5
    attack = "hitscan"
    give = { {weapon="AssaultRifle"}, {ammo="bullet",count=10} }
    min_weapon = 1
    density = 0.75
    species = "zombie"
    room_size = "large"
    disloyal = true
    trap_factor = 2.4
    infight_damage = 25
  }
}

BRUTAL64.WEAPONS =
{
	AssaultRifle = --roughly the same as the chaingun
	{
	    id=330
	    level = 2
		pref = 70
		upgrades = "pistol"
		add_prob = 40
		attack = "hitscan"
		rate = 8.5
		accuracy = 85
		damage = 10
		ammo = "bullet"
		per = 1
		give = { {ammo="bullet",count=0} } --yes really
		bonus_ammo = 50
	}
	Unmaker = --roughly the same as the rocket launcher
    {
		id = 9901
		level = 5
		pref = 30
		add_prob = 65
		hide_prob = 10
		attack = "missile"
		rate = 1.7
		accuracy = 80
		damage = 170
		splash = { 65,20,5 }
		ammo = "SoulAmmo"
		per = 1
		give = { {ammo="SoulAmmo",count=40} }
		bonus_ammo = 5
    }
	AlphaUnmaker =
    {
		id = 9351
		level = 5
		pref = 30
		add_prob = 65
		hide_prob = 10
		attack = "missile"
		rate = 1.7
		accuracy = 80
		damage = 170
		splash = { 65,20,5 }
		ammo = "Cell"
		per = 1
		give = { {ammo="Cell",count=40} }
		bonus_ammo = 5
    }
}

BRUTAL64.PICKUPS =
{
  -- AMMO --
  SoulAmmo =
  {
    id = 331
    kind = "ammo"
    add_prob = 10
    give = { {ammo="SoulAmmo",count=3} }
  }
}

function BRUTAL64.all_done()
	DOOM.all_done();
	BRUTALDOOM.texturesetup();
	BRUTAL64.gameinfo();
	BRUTAL64.monstersdecorate();
	BRUTAL64.weaponsdecorate();
end

OB_GAMES["brutal64"] =
{
  label = "Brutal Doom 64"

  extends = "doom2"

  format = "doom"

  engine = { boom=0, gzdoom=1, zandronum=0 }

  tables =
  {
	BRUTAL64
	BRUTALDOOM.PARAMETERS
	BRUTALDOOM.MATERIALS
	BRUTALDOOM.LIQUIDS
	BRUTALDOOM.ENTITIES
	BRUTALDOOM.THEMES
	BRUTALDOOM.ROOM_THEMES
  }

  hooks =
  {
    get_levels = DOOM.get_levels
    end_level  = DOOM.end_level
    all_done   = BRUTAL64.all_done
  }
}