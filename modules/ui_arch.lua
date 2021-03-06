------------------------------------------------------------------------
--  PANEL: Architecture
------------------------------------------------------------------------
--
--  Copyright (C) 2016-2017 Andrew Apted
--
--  This program is free software; you can redistribute it and/or
--  modify it under the terms of the GNU General Public License
--  as published by the Free Software Foundation; either version 2
--  of the License, or (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
------------------------------------------------------------------------

UI_ARCH = { }

UI_ARCH.SIZES =
{
  "epi",     _("Episodic"),
  "prog",    _("Progressive"),
  "mixed",   _("Mix It Up"),

  -- this is a separator (not a usable choice)
  "_",       "_",

  "micro",   _("Micro"),
  "tiny",    _("Tiny"),  
  "small",   _("Small"),
  "regular", _("Regular"),
  "large",   _("Large"),
  "colossal",_("Colossal"),  
  "extreme", _("Extreme"),
}


UI_ARCH.PROC_GOTCHA_CHOICES =
{
  "none",  _("NONE"),
  "final", _("Final Map Only (if not prebuilt)"),
  "epi",   _("Episodic (MAP06, MAP16, MAP26)"),
  "2epi",   _("2 per ep (4,8,14,18,24,28)"),
  "3epi",   _("3 per ep (3,7,10,14,16,18,24,26,28)"),
  "_",     _("_"),
  "5p",    _("05% Chance, Any Map After MAP04"),
  "10p",   _("10% Chance, Any Map After MAP04"),
  "15p",   _("15% Chance, Any Map After MAP04"),
  "20p",   _("20% Chance, Any Map After MAP04"),
  "all",   _("Everything o_O"),
}
	
UI_ARCH.LEVEL_PERCENTAGE_CHOICES =
{
  "all",  _("All Levels"),
  "75",   _("75% of All Levels"),
  "50",   _("50% of All Levels"),
  "25",   _("25% of All Levels"),
  "10",   _("10% of All Levels"),
  "5",    _("5% of All Levels"),
  "none", _("NONE"),
}

UI_ARCH.ABSURDITY_CHOICES =
{
  "none", _("NONE"),
  "all",  _("Every Level"),
  "75",   _("75% of Levels"),
  "50",   _("50% of Levels"),
  "25",   _("25% of Levels"),
}

OB_MODULES["ui_arch"] =
{
  label = _("Architecture")

  side = "left"
  priority = 104

  options =
  {
    { name="size",         label=_("Level Size"), choices=UI_ARCH.SIZES,  default="epi",  gap=1 }
     
    { name="outdoors",     label=_("Outdoors"),   choices=STYLE_CHOICES }
    { name="caves",        label=_("Caves"),      choices=STYLE_CHOICES }
    { name="liquids",      label=_("Liquids"),    choices=STYLE_CHOICES,  gap=1 }

    { name="hallways",     label=_("Hallways"),   choices=STYLE_CHOICES }
    { name="teleporters",  label=_("Teleports"),  choices=STYLE_CHOICES }
    { name="steepness",    label=_("Steepness"),  choices=STYLE_CHOICES, gap=1 }
    {
      name = "layout_absurdity"
      label = _("Layout Absurdity")
      choices=UI_ARCH.ABSURDITY_CHOICES
      default="none"
      tooltip = "The layout absurdifier attempts to cause levels to overprefer specific shape " ..
      "rules from the ruleset in order to create odd and possibly broken but interesting combinations. " ..
      "Use at your own risk. These options will affect the amount of levels have the absurdity module activated on. " ..
      "Selecting ALL will not necessarily make all levels absurd as it is all still based on chance."
      gap=1
    }
    {
      name="procedural_gotchas"
      label=_("Procedural Gotcha")
      choices=UI_ARCH.PROC_GOTCHA_CHOICES
      default="none"
      tooltip = "Procedural Gotchas are two room maps, where the second is an immediate " ..
      "but immensely-sized exit room with gratitiously intensified monster strength. " ..
      "Essentially an arena - prepare for a tough, tough fight!\n\nNotes:\n\n" ..
      "5% of levels may create at least 1 or 2 gotcha maps in a standard full game."
    }
    {
      name = "linear_mode"
      label = _("Call of Duty Mode")
      choices = UI_ARCH.LEVEL_PERCENTAGE_CHOICES
      default = "none"
      tooltip = "Creates linear levels, where rooms are connected along a " ..
      "linear layout from start to exit."
    }
  }
}