-- Dragon Setting


BlueDragonSetting = {
    
    DragonStone = {{effect_type = 1,vnum = 8031, val = 1,enemy_val =3,enemy = 1},
                    {effect_type = 2,vnum = 8031, val = 2,enemy_val =4,enemy = 2},
                    {effect_type = 3,vnum = 8032, val = 3,enemy_val =5,enemy = 3},
                    {effect_type = 4,vnum = 8033, val = 4,enemy_val =6,enemy = 4},
                    {effect_type = 5,vnum = 8034, val = 5,enemy_val =7,enemy = 5}},
        
    hp_regen = {
        ['min'] = 10,
        ['max'] = 15,
        ['pct'] = 35
    },
    hp_period = {
        ['min'] = 3,
        ['max'] = 7,
        ['pct'] = 25
    },
    hp_damage = {
        ['min'] = 1000,
        ['max'] = 1400,
        ['pct'] = 35
    },
    
    Skill0 = {
        ['damage'] = {musa={min=13,max=38},muda={min=12,max=30},assa={min=10,max=24},sura={min=18,max=29}},
        ['damage_area'] = 4000,
        ['default_damage'] = {min=2000,max=4000},
        ['period'] = {min=19,max=27},
        ['gender']  = {female={min=5,max=10},male={min=8,max=17}},
    },
    Skill1 = {
        ['damage_area'] = 3000,
        ['default_damage'] = {min=3000,max=5000},
        ['period'] = {min=29,max=39},
    },
    
    Skill2 = {
        ['damage_area'] = 10000,
        ['period'] = {min=30,max=56},
        ['default_damage'] = {min=4000,max=7000},
        ['stun_time'] = {default={min=5,max=6}},
        ['gender']  = {female={min=5,max=10},male={min=8,max=17}},
    },
}
-- Skill0 = Breath
-- Skill1 = Wirbel
-- Skill2 = Earthquake aka Stampfer  
