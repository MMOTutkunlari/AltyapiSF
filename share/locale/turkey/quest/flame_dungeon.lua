quest flame_dungeon begin
    state start begin   
        when 20394.click with pc.get_level() >= 90 begin
            pc.give_item2(71175, 1)
            set_state(run)
        end
    end
 
    state run begin
     
    function setting()
        return
        {
        ["bossroom_entry_pos"] = {8109,6867},
        ["boss_pos"] = {686,637},
        ["doors_pos"] = {
            {320,394},
            {293,359},
            {333,321},
            {378,320},
            {400,355},
            {394,401}
        },
        ["idoors_pos"] = {
            {268,447},
            {234,359},
            {300,264},
            {454,217},
            {470,355},
            {467,469}
        },
        ["doors_dir"] = {135,90,210,152,90,223},
        ["idoors_dir"] = {135,90,210,135,90,239},
        ["dungeon_entry_pos"] = {7766, 6719},-- ??? ?? ???? ?
        ["DUNGEON_MAN_bpos"] = {690,722},
        ["DUNGEON_MAN_pos"] = {354,362},
        ["LEVEL2_STONE_pos"] = {195,352},
        ["LEVEL4_TARGET_pos"] = {470,175},
        ["LEVEL5_STONE_pos"] = {
                {486, 345},
                {511, 336},
                {525, 349},
                {521, 365},
                {503, 372},
                {486, 365},
                {500, 354}
        },
        ["LEVEL6_TARGET_pos"] = {511,480},
        ["outside_entry_pos"] = {5980,7075}, --??????? ??? ?
         
        }
    end
    function is_flamed(idx) -- ???? ??? ?? 
        return idx >= 351 * 10000 and idx < (351 + 1) *10000
    end
    function make_dungeon() -- ?? ???
        local setting = flame_dungeon.setting()
        d.new_jump_party(351, setting.dungeon_entry_pos[1], setting.dungeon_entry_pos[2])
        d.regen_file("data/dungeon/flame_dungeon/npc.txt")
        d.setf("level",0)
        for i=1,6 do
            d.set_unique("door"..i, d.spawn_mob_ac_dir(20387, setting.doors_pos[i][1], setting.doors_pos[i][2],setting.doors_dir[i]))
        end
        for i=1,6 do
            d.set_unique("idoor"..i, d.spawn_mob_ac_dir(20388, setting.idoors_pos[i][1], setting.idoors_pos[i][2],setting.idoors_dir[i]))
        end
        d.setf("clear_count",0)
        d.setf("started",0)
        d.setf("dungeon_enter",0) -- ????? ?????? // ??? : 0 ?? : 1 // ??? ??????? ?? ??
        d.setf("counter_11", 180)
        d.setf("counter_13", 180)
    end
    function go_boss() -- ??? ?? 
        local setting = flame_dungeon.setting()
        if pc.get_level() < 104 then --????
            say("Sizin seviyeniz devam etmek için yeterli deðil.[ENTER]104.Seviyeye ulaþtýðýnýz zaman tekrar gelin.")
            return
        else
            --if pc.getf("main_quest_flame_lv103", "__status")==main_quest_flame_lv103.__COMPLETE__ then -- ????? ??
                say("Será que você quer avançar[ENTER]para conhecer o seu destino?")
                local warp = select("Avançar","Talvez mais tarde")
                if warp == 1 then
                    d.setf("level",17)
                    d.jump_all(setting.bossroom_entry_pos[1],setting.bossroom_entry_pos[2])
                    d.set_regen_file ("data/dungeon/flame_dungeon/".."fd_fild_boss.txt")
                    d.spawn_mob(6091,setting.boss_pos[1],setting.boss_pos[2])
                end
            --else
            --    say("Pode apenas avançar quando tiver[ENTER]concluído a missão de nível 103.")
            --    return
            --end
        end
    end
    function level_clear() -- ?? ???, ?????, ?????
        d.setf("level",0)
        d.clear_regen()
        d.purge_area(750000,620000,817400,689400) -- ??? -- d.purge() ????
    end
    function clear_timer(inx) -- ??? ????
        clear_server_timer ("flame_dungeon_0m_left_timer", inx)
        clear_server_timer ("flame_dungeon_1m_left_timer", inx)
        clear_server_timer ("flame_dungeon_5m_left_timer", inx)
        clear_server_timer ("flame_dungeon_10m_left_timer", inx)
        clear_server_timer ("flame_dungeon_15m_left_timer", inx)
        clear_server_timer ("flame_dungeon_30m_left_timer", inx)
        clear_server_timer ("flame_dungeon_45m_left_timer", inx)
        clear_server_timer ("flame_dungeon_ticket_remove", inx) 
    end
     
        when login begin
            local idx = pc.get_map_index()
            local setting = flame_dungeon.setting()
            if idx == 351 then
                --pc.warp(setting.outside_entry_pos[1]*100, setting.outside_entry_pos[2] * 100, 62)
            elseif flame_dungeon.is_flamed(idx) then -- ?? ??, ??? ?? ??
            ------------------------------------------------------------------------------------------------------------------------------------------------------
            --??? ??? ???? ???? ???? ?????? ?? ?? ??? ????. ???? ??? ?? ???? ???? ?? ?? ??? ??? ??.
            --???? ???? ?? ?? ?? ??? ??? ??, ???? ??? ??? ????? ?? ??? ????? ???? ??? ??? ??? ??.
            ------------------------------------------------------------------------------------------------------------------------------------------------------
                --pc.set_warp_location(62, setting.outside_entry_pos[1] , setting.outside_entry_pos[2]) -- ?? ??? ? ??? ????
                local ticketGroup = {71175, 1}
                if d.getf("dungeon_enter") == 0 then -- ???? ???
                    local canPass = false
                    for i=1, table.getn(ticketGroup),2 do
                        if pc.count_item(ticketGroup[i]) >= ticketGroup[i+1] then
                            canPass = true
                            break
                        end
                    end
 
                    if get_global_time() - pc.getf("flame_dungeon","exit_time") < 30 * 60 then -- ??????? ????
                        notice_multiline(" Ýçeriye giriþ yapabilmek için henüz süreniz dolmamýþ.[ENTER]Lütfen sürenizin dolmasýný bekleyiniz.",d.notice)
                        say(" Ýçeriye giriþ yapabilmek için henüz süreniz dolmamýþ.[ENTER]Lütfen sürenizin dolmasýný bekleyiniz.")
                        timer("flame_dungeon_warp_timer", 5)
                    elseif not canPass then
                        notice_multiline("Bir grup ile Kýzýl Ejder Kalesi'ne girebilirsiniz.[ENTER]Ve buna ek olarak, giriþ için izin olmalýdýr.",d.notice)
                        say("Eu posso deixar você entrar se[ENTER]você tiver em posse de um passe.")
                        timer("flame_dungeon_warp_timer", 5)
                    elseif pc.get_level() < 100 then
                        notice_multiline("Grubun tüm üyelerinin 100.seviyede[ENTER]olmasý gereklidir.Aksi takdirde[ENTER]devam edemezsiniz.",d.notice)
                        say("Devam edebilmek için tüm grup üyelerinin,[ENTER]100.Seviye'ye ulaþmýþ olmasý gerekli.")
                        timer("flame_dungeon_warp_timer", 5)
                    end
                elseif pc.getf("flame_dungeon","ticket_delete") == 0 then -- ????? ??? ???????
                     
                    for i=1, table.getn(ticketGroup),2 do
                        if pc.count_item(ticketGroup[i]) >= ticketGroup[i+1] then
                            pc.remove_item(ticketGroup[i], ticketGroup[i+1])
                            break
                        end
                    end
                    pc.setf("flame_dungeon","ticket_delete",1)
                end
            else
                pc.setf("flame_dungeon","ticket_delete",0)
            end
        end
        when flame_dungeon_warp_timer.timer begin
            local setting = flame_dungeon.setting()
            pc.warp(setting.outside_entry_pos[1]*100, setting.outside_entry_pos[2] * 100, 62)
        end
        when logout begin
            local idx = pc.get_map_index()
            if flame_dungeon.is_flamed(idx) then 
                if d.getf("dungeon_enter") == 1 then -- ???? ?? ?? ? ????
                    pc.setf("flame_dungeon","exit_time",get_global_time()) -- ???? ???? ??? ??? ??, ?? ???? ??? or ?? ???? ???
                end
                 
 
            end
        end
        when 20394.chat."Kýrmýzý Ejderha Kulesi" begin
         
            local setting = flame_dungeon.setting()
            if party.is_party() then
                local party_check = 0
                if d.find(party.getf("dungeon_index")) then
                    party_check = (d.getf_from_map_index("party_leader_pid", party.getf("dungeon_index")) == party.get_leader_pid())
                end
                 
                if d.find(party.getf("dungeon_index")) and party_check then
                    if get_global_time() - pc.getf("flame_dungeon","exit_time") < 5 * 60 then -- ?? ?? 5? ??
                        local dungeon_level = d.getf_from_map_index("level", party.getf("dungeon_index"))
                        if dungeon_level == 17 then -- ??
                            pc.warp(setting.bossroom_entry_pos[1] * 100, setting.bossroom_entry_pos[2] * 100, party.getf("dungeon_index"))
                        else
                            pc.warp(setting.dungeon_entry_pos[1] * 100, setting.dungeon_entry_pos[2] * 100, party.getf("dungeon_index"))
                        end
                    else -- 5? ???? ? ?? ??
                        say_title(mob_name(20394))
                        say(" Kýrmýzý Ejderha Kulesi'nin dýþarýsýnda[ENTER]5 dakikadan uzun süredir duruyorsunuz.[ENTER]Þimdi içeriye giremezsiniz.")
                    end
                else
                    local pids = {party.get_member_pids()}
                    local noTicketMembers = {}
                    local notEnoughLevelMembers = {}
                    local ticketCheck = true
                    local levelCheck = true
                    local ticketGroup = {71175, 1}
                    for i, pid in next, pids, nil do
                        q.begin_other_pc_block(pid)
                        local canPass = false
                        for idx=1, table.getn(ticketGroup),2 do
                            if pc.count_item(ticketGroup[idx]) >= ticketGroup[idx+1] then
                                canPass = true
                                break
                            end
                        end
                         
                        if not canPass then
                            table.insert(noTicketMembers, pc.get_name())
                            ticketCheck = false
                        end
                        if pc.level < 100 then
                            table.insert(notEnoughLevelMembers, pc.get_name())
                            levelCheck = false
                        end
                        q.end_other_pc_block()
                    end
 
                    if not ticketCheck then
                        say_title(mob_name(20394))
                        say("Uyarý! Kýrmýzý Ejderha Kulesi'ne girebilmek için,[ENTER]bütün grup üyelerinin[ENTER]geçiþ biletine sahip olmasý gereklidir.[ENTER]Geçiþ kartý olmayan üyeler:")
                        for i, name in next, noTicketMembers, nil do
                            say(color(1,1,0), "    "..name)
                        end
                        if levelCheck then
                            return
                        else
                            wait()
                        end
                    end
 
                    if not levelCheck then
                        say_title(mob_name(20394))
                        say("Uyarý! Kýrmýzý Ejderha Kulesi'ne girebilmek için,[ENTER]bütün grup üyelerinin[ENTER]100.Seviye'ye ulaþmýþ olmasý gereklidir.[ENTER]Gerekli seviyede olmayan üyeler:")
                        for i, name in next, notEnoughLevelMembers, nil do
                            say(color(1,1,0), "    "..name)
                        end
                        return
                    end
 
                    if party.is_leader() then
                        say("Kýrmýzý Ejderha Kulesi'ne girmek için emin misin?")
                        local warp = select("Evet.","Belki daha sonra...")
                        if warp == 1 then
                            if party.is_map_member_flag_lt("exit_time", get_global_time() - 30 * 60 ) then
                                flame_dungeon.make_dungeon()
                            else
                                say("Kýrmýzý Ejderha Kulesi'ne giriþ yapabilmek için[ENTER]henüz süreniz dolmamýþ.")
                            end
                        end
                         
                        party.setf("flame_dungeon_boss_kill_count", 0)
                         
                    else
                        say("Sadece grup liderleri giriþ izninde bulunabilir.")
                    end
                end
            else
                say("Cesaretini takdir ediyorum.[ENTER]Fakat, Kýrmýzý Ejderha Kulesi'ne tek baþýna giremezsin.[ENTER]Güçlü bir grup kur ve daha sonra tekrar gel.")
            end
        end
        when 20394.chat."Test : Iþýnla " with pc.is_gm() begin -- ????
            local setting = flame_dungeon.setting()
            pc.setf("flame_dungeon","fdRtest",1)
            pc.warp( setting.dungeon_entry_pos[1]*100, setting.dungeon_entry_pos[2]*100, 351)
        end
         
         
        when 20394.chat."TEST : Süreyi deðiþtir " with pc.is_gm() begin -- ????
            pc.setf("flame_dungeon","exit_time",get_global_time()-1800)
            say("Geri")
        end
        when 20385.chat."Test : Bilgi" with pc.is_gm() begin -- ????
            say("canavarlar_11 : "..d.getf("counter_11"))
            say("canavarlar_13 : "..d.getf("counter_13"))
            say("server saati : "..get_server_timer_arg())
            say("toplam canavar sayýsý : "..d.count_monster())
            say("level : "..d.getf("level"))
            say("Dmap index : "..d.get_map_index())
            say("Pmap index : "..pc.get_map_index())
            say("eriþim süresi : "..pc.getf("flame_dungeon","exit_time"))
            say("gerçek zaman : "..get_global_time())
            if flame_dungeon.is_flamed(d.get_map_index()) then
                say("in dungeon") -- is_flamed ?? ??
            end
            if d.is_unique_dead("stone1") then
                say("taþ 1 öldü ")
            else
                say("taþ 1 yaþýyor")
            end
        end
        when 20385.chat." Örnegi etkinleþtir " with pc.is_gm() begin -- ????
            say("??? ???")
            flame_dungeon.clear_timer(d.get_map_index())
            flame_dungeon.make_dungeon()
        end
        when 20385.chat."Test : Patron odasý " with pc.is_gm() begin -- ????
            flame_dungeon.go_boss()
        end
         
        when 20385.chat."Test et" with pc.is_gm() begin -- ???? ??? ?? ? ?? ???
            local setting = flame_dungeon.setting()
            say("??? ????????")
            local warp = select("Evet","Hayýr")
            if warp == 1 then
                pc.warp(setting.outside_entry_pos[1]*100, setting.outside_entry_pos[2] * 100, 62)
            end
        end
        when flame_dungeon_45m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 45),d.notice)
            notice_multiline("Süre bitince grup olarak kale'nin dýþýna atýlacaksýnýz.",d.notice)
            timer("flame_dungeon_30m_left_timer", 15*60)
        end
        when flame_dungeon_30m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 30),d.notice)
            notice_multiline("Süre bitince grup olarak kale'nin dýþýna atýlacaksýnýz.",d.notice)
            timer("flame_dungeon_15m_left_timer", 15*60)
        end
        when flame_dungeon_15m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 15),d.notice)
             notice_multiline("Süre bitince grup olarak kale'nin dýþýna atýlacaksýnýz.",d.notice)
            timer("flame_dungeon_5m_left_timer", 10*60)
        end
        when flame_dungeon_5m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 5),d.notice)
            notice_multiline("Süre bitince grup olarak kale'nin dýþýna atýlacaksýnýz.",d.notice)
            timer("flame_dungeon_1m_left_timer", 4*60)
        end
        when flame_dungeon_1m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 1),d.notice)
            notice_multiline("Süre bitince grup olarak kale'nin dýþýna atýlacaksýnýz.",d.notice)
            timer("flame_dungeon_0m_left_timer", 60)
        end
        when flame_dungeon_0m_left_timer.timer begin
            local setting = flame_dungeon.setting()
            notice_multiline("Size ayýrýlan süre doldu.10 Saniye[ENTER]içinde kale'nin kapýlarý sizin için açýlacak.",d.notice)
            notice_multiline("10 Saniye içinde herkes ýþýnlanacak.",d.notice)
            timer("exit_dungeon",10)    
        end
 
 
        when 20385.chat." Am-heh Uyanýþ " with npc.lock() begin -- '0x'? x?? ?? ??? ?? ? ?? ?? , '1x'? x?? ?? ??? ???
            local setting = flame_dungeon.setting()
            if d.getf("started") == 0 then
                say("Am-heh Uyandý!")
                say("Kýzýl Ejderha Kale'si bir saat boyunca[ENTER]baþkalarýna kapatýldý.")
                wait()
                d.setf("started",1)
                timer("flame_dungeon_45m_left_timer",15*60)
                notice_multiline("Kalan zaman: 60 Dakika(lar) ",d.notice)
                notice_multiline("Süre dolduðunda bütün grup üyeleri dýþarýya atýlýr.",d.notice)
                 
                local pids = {party.get_member_pids()}
                local ticketGroup = {71175, 1}
                for i, pid in next, pids, nil do
                    q.begin_other_pc_block(pid)
                    local canPass = false
                    for idx=1, table.getn(ticketGroup),2 do
                        if pc.count_item(ticketGroup[idx]) >= ticketGroup[idx+1] then
                            canPass = true
                            pc.remove_item(ticketGroup[idx], ticketGroup[idx+1])
                            break
                        end
                    end
                     
                    if not canPass then
                        pc.warp(setting.outside_entry_pos[1]*100, setting.outside_entry_pos[2] * 100, 62)
                    end
                    q.end_other_pc_block()
                end
                d.setqf2("flame_dungeon","ticket_delete",1)
                d.setf("dungeon_enter",1)
                 
                party.setf("dungeon_index", d.get_map_index())
                d.setf("party_leader_pid", party.get_leader_pid())
            end
            if d.getf("level") < 7 then --???? ???
                if d.getf("clear_count") == 6 then -- ? ??? ??? ???
                    d.setf("level",7)
                else
                    local rand = number(1,6)--???? ????? ?? ???? ?? ?? ?????? ???
                    local setlev = 0
                    d.setf("level",7) -- ?? ?? ??? ?? ??? ?????? ??? ????? ????
                    for i=1,50 do
                        setlev = setlev + 1
                        if setlev > 6 then
                            setlev = 1
                        end
                        if not d.is_unique_dead("door"..setlev) then
                            rand = rand - 1
                            if rand == 0 then
                                d.setf("level",setlev)
                                d.setf("clear_count",d.getf("clear_count")+1)
                                break
                            end
                        end
                    end
                end
            end
                if d.getf("level") == 1 then
                    say("Missão: Aventure-se no anel de demônios[ENTER]e surja como vencedor.")
                    notice_multiline("Bilgilendirme: Savaþçýlar ve Ejderha kral arasýndaki ayaklanma birazdan baþlayacak.",d.notice)
                    d.kill_unique("door1")
                    d.kill_unique("idoor1")
                    d.setf("level",11)
                    local counter_11 = 180
                    d.regen_file ("data/dungeon/flame_dungeon/".."fd_a.txt")
                elseif d.getf("level") == 11 then
                    say("Bütün þeytanlar yenilmedi.")
                    say_title("Kalan: ", counter_11)
                elseif d.getf("level") == 2 then
                        say("Tarefa: Encontre a engrenagem de ouro,[ENTER]substituindo o mecanismo oculto[ENTER]na estela de Isfet.")
                        notice_multiline("Tarefa: Encontre a engrenagem de ouro, substituindo [ENTER] o mecanismo oculto na estela de Isfet.",d.notice)
                        d.spawn_mob(20386, setting.LEVEL2_STONE_pos[1], setting.LEVEL2_STONE_pos[2]) -- ??? ??
                        d.kill_unique("door2")
                        d.kill_unique("idoor2")
                        d.set_regen_file ("data/dungeon/flame_dungeon/".."fd_b.txt")
                        d.setf("level",12)
                elseif d.getf("level") == 12 then
                    say("O mecanismo na estela de Isfet só pode ser[ENTER]acionado com a roda de engrenagem de ouro.[ENTER]Volta quando a tarefa foi cumprida.")
                elseif d.getf("level") == 3 then
                    say("Missão: Aventure-se no anel de demônios e[ENTER]surja como vencedor.")
                    notice_multiline("Missão: Aventure-se no anel de demônios e[ENTER]surja como vencedor.",d.notice)
                    d.kill_unique("door3")
                    d.kill_unique("idoor3")
                    d.setf("level",13)
                    local counter_13 = 180
                    d.regen_file ("data/dungeon/flame_dungeon/".."fd_c.txt")
                elseif d.getf("level") == 13 then
                    say("Não foram derrotados todos os demônios.")
                    say_title("Restantes: ", counter_13)
                elseif d.getf("level") == 4 then -- 474 178
                    say("Tarefa: Derrote Ignator, guarda das brasas.")
                    notice_multiline("Tarefa: Derrote Ignator, guarda das brasas.",d.notice)
                    d.setf("level",14)
                    d.kill_unique("door4")
                    d.kill_unique("idoor4")
                    d.set_regen_file ("data/dungeon/flame_dungeon/".."fd_d.txt")
                    d.spawn_mob(6051,setting.LEVEL4_TARGET_pos[1],setting.LEVEL4_TARGET_pos[2] ) -- ????? ??
                elseif d.getf("level") == 14 then
                    say("Ignator ainda não foi derrotado.[ENTER]Fortaleça-se ou receberá a condenação eterna.[ENTER]Volte se a tarefa for cumprida.")
                elseif d.getf("level") == 5 then -- 510 355
                    say("Missão: Procurar as Pedras de Maat e coloca-as[ENTER]na ordem correta nas 7 estelas de Isfet.")
                    say("Se usares a Pedra de Maat na estela errada,[ENTER]a pedra irá partir-se.")
                    notice_multiline("Missão: Procurar as Pedras de Maat e coloca-as[ENTER]na ordem correta nas 7 estelas de Isfet.",d.notice)
                    notice_multiline("Se usares a Pedra de Maat na estela errada,[ENTER]a pedra irá partir-se.",d.notice)
                    d.kill_unique("door5")
                    d.kill_unique("idoor5")
                    d.setf("level",15)
                    d.set_regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    local vis = { 0,0,0,0,0,0,0}
                    for i=1,7 do
                        vis[i] = 0
                    end
                    for i = 1, 7 do -- ???? ???
                        local ran = number(1,7)
                        local st = 0
                        for j = 1, 50 do
                            st = st + 1
                            if st > 7 then
                                st = 1
                            end
                            if vis[st] == 0 then
                                ran = ran - 1
                                if ran == 0 then
                                    vis[st] = 1
                                    d.set_unique("stone5_"..st, d.spawn_mob(20386, setting.LEVEL5_STONE_pos[i][1], setting.LEVEL5_STONE_pos[i][2]))
                                    break
                                end
                            end
                        end
                    end 
                elseif d.getf("level") == 15 then
                    say("Errar é humano! Portanto, escolha com sabedoria[ENTER]para resolver o mistério. Volte se a tarefa[ENTER]for cumprida.")
                elseif d.getf("level") == 6 then -- 507 490
                    say("Tarefa: Só quem não tem medo do calor abrasador,[ENTER]irá destruir a Metin do purgatório.")
                    notice_multiline("Tarefa: Só quem não tem medo do calor abrasador,[ENTER]irá destruir a Metin do purgatório.",d.notice)
                    d.setf("level",16)
                    d.kill_unique("door6")
                    d.kill_unique("idoor6")
                    d.set_regen_file ("data/dungeon/flame_dungeon/".."fd_f.txt")
                    d.spawn_mob(8057, setting.LEVEL6_TARGET_pos[1],setting.LEVEL6_TARGET_pos[2]) -- ?????? ??
                elseif d.getf("level") == 16 then
                    say(" ")
                    say("Vamos colocar a Metin do purgatório em cinzas.[ENTER]Volta se a tarefa for cumprida.")
                elseif d.getf("level") == 7 then
                    flame_dungeon.go_boss()
                else
                    say(" ")
                end
            npc.unlock()        
        end
     
        when kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 11 begin -- 2?? ??? ?? ??
            if d.getf("counter_11") == 0 then -- 1?? ??? ???
                notice_multiline("Bütün þeytanlarý yendiniz,",d.notice)
                notice_multiline("Yeni görev için Am-heh ile görüþün...",d.notice)
                flame_dungeon.level_clear()
            else
                d.setf("counter_11",d.getf("counter_11")-1)
            end
        end
 
        when kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 13 begin -- 2?? ??? ?? ??
            if d.getf("counter_13") == 0 then -- 1?? ??? ???
                notice_multiline("Bütün þeytanlarý yendiniz,",d.notice)
                notice_multiline("Yeni görev için Am-heh ile görüþün...",d.notice)
                flame_dungeon.level_clear()
            else
                d.setf("counter_13",d.getf("counter_13")-1)
            end
        end
 
        when kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 12 begin -- 2?? ??? ?? ??
            local i = number(1, 100) -- 100?? 1 ??? ????
            if i == 1 then
                game.drop_item (30329, 1)
            end
        end
        when 20386.take with flame_dungeon.is_flamed(pc.get_map_index()) and item.vnum == 30329 and d.getf("level") == 12 begin -- 2?? ?? ????
            local i = number(1, 5) -- 5?? 1 ??? ?? ??
            if i == 1 then
                npc.purge()
                item.remove()
                notice_multiline("Bütün þeytanlarý yendiniz,",d.notice)
                notice_multiline("Yeni görev için Am-heh ile görüþün...",d.notice)
                flame_dungeon.level_clear()
            else
                item.remove()
                say("Esta peça é falsa e foi destruida.[ENTER]Procura a original.")
            end
        end
 
        when 6051.kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 14 begin
                notice_multiline("Bütün þeytanlarý yendiniz,",d.notice)
                notice_multiline("Yeni görev için Am-heh ile görüþün...",d.notice)
            flame_dungeon.level_clear()
        end
 
        when kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 15 begin -- 5?? ??? ?? ??
            local i = number(1, 30) -- 30?? 1 ??? ????
            if i == 1 then
                game.drop_item (30330, 1)
            end
        end
        when 20386.take with flame_dungeon.is_flamed(d.get_map_index()) and item.vnum == 30330 and d.getf("level") == 15 begin -- 5?? ???? ????
            local setting = flame_dungeon.setting()
            if npc.get_vid() == d.get_unique_vid("stone5_1") then -- ??? ?? ????? ? ?? ????? ???? ????
                npc.purge()
                item.remove()
                say("Essa foi uma escolha sábia.[ENTER]Destrua agora a próxima estela.")
                d.setf("stonekill",2) -- 2? ?? ???
                if d.count_monster() < 100 then
                    d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_2") then 
                if d.getf("stonekill") == 2 then -- 2??? ?? ??? 2???? ??? ??? ?
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha sábia.[ENTER]Destrua agora a próxima estela.")
                    d.setf("stonekill",3)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destruída.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_3") then
                if d.getf("stonekill") == 3 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha sábia.[ENTER]Destrua agora a próxima estela.")
                    d.setf("stonekill",4)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destruída.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_4") then
                if d.getf("stonekill") == 4 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha sábia.[ENTER]Destrua agora a próxima estela.")
                    d.setf("stonekill",5)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destruída.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_5") then
                if d.getf("stonekill") == 5 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha sábia.[ENTER]Destrua agora a próxima estela.")
                    d.setf("stonekill",6)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destruída.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_6") then
                if d.getf("stonekill") == 6 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha sábia. Destrua agora a última[ENTER]estela e Maat triunfará sobre Isfet.")
                    d.setf("stonekill",7)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destruída.")
                end
            else
                if d.getf("stonekill") == 7 then
                    npc.purge()
                    item.remove()
                    notice_multiline("A estela de Isfet foi destruída.",d.notice)
                    notice_multiline("Fala com Am-heh para abrir um novo destino.",d.notice)
                    flame_dungeon.level_clear()
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destruída.")
                end
            end
        end
 
        when 8057.kill with flame_dungeon.is_flamed(d.get_map_index()) and d.getf("level") ==16 begin -- ??? ???? ?
            notice_multiline("A Metin do purgatório foi destruída.",d.notice)
            notice_multiline("Fala com Am-heh para abrir um novo destino.",d.notice)
            flame_dungeon.level_clear()
        end
 
        when 6091.kill with flame_dungeon.is_flamed(d.get_map_index()) and d.getf("level") ==17 begin -- ?? ????
            notice_multiline("Razador foi destruído.",d.notice)
            notice_multiline("Todos os lutadores seram teleportados[ENTER]em um minuto do Templo do Dragão.",d.notice)
            timer("exit_dungeon", 60)
            flame_dungeon.level_clear()
             
            if party.is_party() then
                party.setf("flame_dungeon_boss_kill_count", 1)
            end
             
        end
         
        when exit_dungeon.timer begin
            local setting = flame_dungeon.setting()
            flame_dungeon.clear_timer(d.get_map_index())
            d.set_warp_location(62, setting.outside_entry_pos[1] , setting.outside_entry_pos[2])
            d.exit_all()
            d.setf("party_leader_pid", 0)
        end
         
    end
end