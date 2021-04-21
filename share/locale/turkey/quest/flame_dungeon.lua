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
            say("Sizin seviyeniz devam etmek i�in yeterli de�il.[ENTER]104.Seviyeye ula�t���n�z zaman tekrar gelin.")
            return
        else
            --if pc.getf("main_quest_flame_lv103", "__status")==main_quest_flame_lv103.__COMPLETE__ then -- ????? ??
                say("Ser� que voc� quer avan�ar[ENTER]para conhecer o seu destino?")
                local warp = select("Avan�ar","Talvez mais tarde")
                if warp == 1 then
                    d.setf("level",17)
                    d.jump_all(setting.bossroom_entry_pos[1],setting.bossroom_entry_pos[2])
                    d.set_regen_file ("data/dungeon/flame_dungeon/".."fd_fild_boss.txt")
                    d.spawn_mob(6091,setting.boss_pos[1],setting.boss_pos[2])
                end
            --else
            --    say("Pode apenas avan�ar quando tiver[ENTER]conclu�do a miss�o de n�vel 103.")
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
                        notice_multiline(" ��eriye giri� yapabilmek i�in hen�z s�reniz dolmam��.[ENTER]L�tfen s�renizin dolmas�n� bekleyiniz.",d.notice)
                        say(" ��eriye giri� yapabilmek i�in hen�z s�reniz dolmam��.[ENTER]L�tfen s�renizin dolmas�n� bekleyiniz.")
                        timer("flame_dungeon_warp_timer", 5)
                    elseif not canPass then
                        notice_multiline("Bir grup ile K�z�l Ejder Kalesi'ne girebilirsiniz.[ENTER]Ve buna ek olarak, giri� i�in izin olmal�d�r.",d.notice)
                        say("Eu posso deixar voc� entrar se[ENTER]voc� tiver em posse de um passe.")
                        timer("flame_dungeon_warp_timer", 5)
                    elseif pc.get_level() < 100 then
                        notice_multiline("Grubun t�m �yelerinin 100.seviyede[ENTER]olmas� gereklidir.Aksi takdirde[ENTER]devam edemezsiniz.",d.notice)
                        say("Devam edebilmek i�in t�m grup �yelerinin,[ENTER]100.Seviye'ye ula�m�� olmas� gerekli.")
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
        when 20394.chat."K�rm�z� Ejderha Kulesi" begin
         
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
                        say(" K�rm�z� Ejderha Kulesi'nin d��ar�s�nda[ENTER]5 dakikadan uzun s�redir duruyorsunuz.[ENTER]�imdi i�eriye giremezsiniz.")
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
                        say("Uyar�! K�rm�z� Ejderha Kulesi'ne girebilmek i�in,[ENTER]b�t�n grup �yelerinin[ENTER]ge�i� biletine sahip olmas� gereklidir.[ENTER]Ge�i� kart� olmayan �yeler:")
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
                        say("Uyar�! K�rm�z� Ejderha Kulesi'ne girebilmek i�in,[ENTER]b�t�n grup �yelerinin[ENTER]100.Seviye'ye ula�m�� olmas� gereklidir.[ENTER]Gerekli seviyede olmayan �yeler:")
                        for i, name in next, notEnoughLevelMembers, nil do
                            say(color(1,1,0), "    "..name)
                        end
                        return
                    end
 
                    if party.is_leader() then
                        say("K�rm�z� Ejderha Kulesi'ne girmek i�in emin misin?")
                        local warp = select("Evet.","Belki daha sonra...")
                        if warp == 1 then
                            if party.is_map_member_flag_lt("exit_time", get_global_time() - 30 * 60 ) then
                                flame_dungeon.make_dungeon()
                            else
                                say("K�rm�z� Ejderha Kulesi'ne giri� yapabilmek i�in[ENTER]hen�z s�reniz dolmam��.")
                            end
                        end
                         
                        party.setf("flame_dungeon_boss_kill_count", 0)
                         
                    else
                        say("Sadece grup liderleri giri� izninde bulunabilir.")
                    end
                end
            else
                say("Cesaretini takdir ediyorum.[ENTER]Fakat, K�rm�z� Ejderha Kulesi'ne tek ba��na giremezsin.[ENTER]G��l� bir grup kur ve daha sonra tekrar gel.")
            end
        end
        when 20394.chat."Test : I��nla " with pc.is_gm() begin -- ????
            local setting = flame_dungeon.setting()
            pc.setf("flame_dungeon","fdRtest",1)
            pc.warp( setting.dungeon_entry_pos[1]*100, setting.dungeon_entry_pos[2]*100, 351)
        end
         
         
        when 20394.chat."TEST : S�reyi de�i�tir " with pc.is_gm() begin -- ????
            pc.setf("flame_dungeon","exit_time",get_global_time()-1800)
            say("Geri")
        end
        when 20385.chat."Test : Bilgi" with pc.is_gm() begin -- ????
            say("canavarlar_11 : "..d.getf("counter_11"))
            say("canavarlar_13 : "..d.getf("counter_13"))
            say("server saati : "..get_server_timer_arg())
            say("toplam canavar say�s� : "..d.count_monster())
            say("level : "..d.getf("level"))
            say("Dmap index : "..d.get_map_index())
            say("Pmap index : "..pc.get_map_index())
            say("eri�im s�resi : "..pc.getf("flame_dungeon","exit_time"))
            say("ger�ek zaman : "..get_global_time())
            if flame_dungeon.is_flamed(d.get_map_index()) then
                say("in dungeon") -- is_flamed ?? ??
            end
            if d.is_unique_dead("stone1") then
                say("ta� 1 �ld� ")
            else
                say("ta� 1 ya��yor")
            end
        end
        when 20385.chat." �rnegi etkinle�tir " with pc.is_gm() begin -- ????
            say("??? ???")
            flame_dungeon.clear_timer(d.get_map_index())
            flame_dungeon.make_dungeon()
        end
        when 20385.chat."Test : Patron odas� " with pc.is_gm() begin -- ????
            flame_dungeon.go_boss()
        end
         
        when 20385.chat."Test et" with pc.is_gm() begin -- ???? ??? ?? ? ?? ???
            local setting = flame_dungeon.setting()
            say("??? ????????")
            local warp = select("Evet","Hay�r")
            if warp == 1 then
                pc.warp(setting.outside_entry_pos[1]*100, setting.outside_entry_pos[2] * 100, 62)
            end
        end
        when flame_dungeon_45m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 45),d.notice)
            notice_multiline("S�re bitince grup olarak kale'nin d���na at�lacaks�n�z.",d.notice)
            timer("flame_dungeon_30m_left_timer", 15*60)
        end
        when flame_dungeon_30m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 30),d.notice)
            notice_multiline("S�re bitince grup olarak kale'nin d���na at�lacaks�n�z.",d.notice)
            timer("flame_dungeon_15m_left_timer", 15*60)
        end
        when flame_dungeon_15m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 15),d.notice)
             notice_multiline("S�re bitince grup olarak kale'nin d���na at�lacaks�n�z.",d.notice)
            timer("flame_dungeon_5m_left_timer", 10*60)
        end
        when flame_dungeon_5m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 5),d.notice)
            notice_multiline("S�re bitince grup olarak kale'nin d���na at�lacaks�n�z.",d.notice)
            timer("flame_dungeon_1m_left_timer", 4*60)
        end
        when flame_dungeon_1m_left_timer.timer begin
            notice_multiline(string.format("Kalan zaman: %d dakika(lar)", 1),d.notice)
            notice_multiline("S�re bitince grup olarak kale'nin d���na at�lacaks�n�z.",d.notice)
            timer("flame_dungeon_0m_left_timer", 60)
        end
        when flame_dungeon_0m_left_timer.timer begin
            local setting = flame_dungeon.setting()
            notice_multiline("Size ay�r�lan s�re doldu.10 Saniye[ENTER]i�inde kale'nin kap�lar� sizin i�in a��lacak.",d.notice)
            notice_multiline("10 Saniye i�inde herkes ���nlanacak.",d.notice)
            timer("exit_dungeon",10)    
        end
 
 
        when 20385.chat." Am-heh Uyan�� " with npc.lock() begin -- '0x'? x?? ?? ??? ?? ? ?? ?? , '1x'? x?? ?? ??? ???
            local setting = flame_dungeon.setting()
            if d.getf("started") == 0 then
                say("Am-heh Uyand�!")
                say("K�z�l Ejderha Kale'si bir saat boyunca[ENTER]ba�kalar�na kapat�ld�.")
                wait()
                d.setf("started",1)
                timer("flame_dungeon_45m_left_timer",15*60)
                notice_multiline("Kalan zaman: 60 Dakika(lar) ",d.notice)
                notice_multiline("S�re doldu�unda b�t�n grup �yeleri d��ar�ya at�l�r.",d.notice)
                 
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
                    say("Miss�o: Aventure-se no anel de dem�nios[ENTER]e surja como vencedor.")
                    notice_multiline("Bilgilendirme: Sava���lar ve Ejderha kral aras�ndaki ayaklanma birazdan ba�layacak.",d.notice)
                    d.kill_unique("door1")
                    d.kill_unique("idoor1")
                    d.setf("level",11)
                    local counter_11 = 180
                    d.regen_file ("data/dungeon/flame_dungeon/".."fd_a.txt")
                elseif d.getf("level") == 11 then
                    say("B�t�n �eytanlar yenilmedi.")
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
                    say("O mecanismo na estela de Isfet s� pode ser[ENTER]acionado com a roda de engrenagem de ouro.[ENTER]Volta quando a tarefa foi cumprida.")
                elseif d.getf("level") == 3 then
                    say("Miss�o: Aventure-se no anel de dem�nios e[ENTER]surja como vencedor.")
                    notice_multiline("Miss�o: Aventure-se no anel de dem�nios e[ENTER]surja como vencedor.",d.notice)
                    d.kill_unique("door3")
                    d.kill_unique("idoor3")
                    d.setf("level",13)
                    local counter_13 = 180
                    d.regen_file ("data/dungeon/flame_dungeon/".."fd_c.txt")
                elseif d.getf("level") == 13 then
                    say("N�o foram derrotados todos os dem�nios.")
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
                    say("Ignator ainda n�o foi derrotado.[ENTER]Fortale�a-se ou receber� a condena��o eterna.[ENTER]Volte se a tarefa for cumprida.")
                elseif d.getf("level") == 5 then -- 510 355
                    say("Miss�o: Procurar as Pedras de Maat e coloca-as[ENTER]na ordem correta nas 7 estelas de Isfet.")
                    say("Se usares a Pedra de Maat na estela errada,[ENTER]a pedra ir� partir-se.")
                    notice_multiline("Miss�o: Procurar as Pedras de Maat e coloca-as[ENTER]na ordem correta nas 7 estelas de Isfet.",d.notice)
                    notice_multiline("Se usares a Pedra de Maat na estela errada,[ENTER]a pedra ir� partir-se.",d.notice)
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
                    say("Errar � humano! Portanto, escolha com sabedoria[ENTER]para resolver o mist�rio. Volte se a tarefa[ENTER]for cumprida.")
                elseif d.getf("level") == 6 then -- 507 490
                    say("Tarefa: S� quem n�o tem medo do calor abrasador,[ENTER]ir� destruir a Metin do purgat�rio.")
                    notice_multiline("Tarefa: S� quem n�o tem medo do calor abrasador,[ENTER]ir� destruir a Metin do purgat�rio.",d.notice)
                    d.setf("level",16)
                    d.kill_unique("door6")
                    d.kill_unique("idoor6")
                    d.set_regen_file ("data/dungeon/flame_dungeon/".."fd_f.txt")
                    d.spawn_mob(8057, setting.LEVEL6_TARGET_pos[1],setting.LEVEL6_TARGET_pos[2]) -- ?????? ??
                elseif d.getf("level") == 16 then
                    say(" ")
                    say("Vamos colocar a Metin do purgat�rio em cinzas.[ENTER]Volta se a tarefa for cumprida.")
                elseif d.getf("level") == 7 then
                    flame_dungeon.go_boss()
                else
                    say(" ")
                end
            npc.unlock()        
        end
     
        when kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 11 begin -- 2?? ??? ?? ??
            if d.getf("counter_11") == 0 then -- 1?? ??? ???
                notice_multiline("B�t�n �eytanlar� yendiniz,",d.notice)
                notice_multiline("Yeni g�rev i�in Am-heh ile g�r���n...",d.notice)
                flame_dungeon.level_clear()
            else
                d.setf("counter_11",d.getf("counter_11")-1)
            end
        end
 
        when kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 13 begin -- 2?? ??? ?? ??
            if d.getf("counter_13") == 0 then -- 1?? ??? ???
                notice_multiline("B�t�n �eytanlar� yendiniz,",d.notice)
                notice_multiline("Yeni g�rev i�in Am-heh ile g�r���n...",d.notice)
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
                notice_multiline("B�t�n �eytanlar� yendiniz,",d.notice)
                notice_multiline("Yeni g�rev i�in Am-heh ile g�r���n...",d.notice)
                flame_dungeon.level_clear()
            else
                item.remove()
                say("Esta pe�a � falsa e foi destruida.[ENTER]Procura a original.")
            end
        end
 
        when 6051.kill with flame_dungeon.is_flamed(pc.get_map_index()) and d.getf("level") == 14 begin
                notice_multiline("B�t�n �eytanlar� yendiniz,",d.notice)
                notice_multiline("Yeni g�rev i�in Am-heh ile g�r���n...",d.notice)
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
                say("Essa foi uma escolha s�bia.[ENTER]Destrua agora a pr�xima estela.")
                d.setf("stonekill",2) -- 2? ?? ???
                if d.count_monster() < 100 then
                    d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_2") then 
                if d.getf("stonekill") == 2 then -- 2??? ?? ??? 2???? ??? ??? ?
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha s�bia.[ENTER]Destrua agora a pr�xima estela.")
                    d.setf("stonekill",3)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destru�da.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_3") then
                if d.getf("stonekill") == 3 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha s�bia.[ENTER]Destrua agora a pr�xima estela.")
                    d.setf("stonekill",4)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destru�da.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_4") then
                if d.getf("stonekill") == 4 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha s�bia.[ENTER]Destrua agora a pr�xima estela.")
                    d.setf("stonekill",5)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destru�da.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_5") then
                if d.getf("stonekill") == 5 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha s�bia.[ENTER]Destrua agora a pr�xima estela.")
                    d.setf("stonekill",6)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destru�da.")
                end
            elseif npc.get_vid() == d.get_unique_vid("stone5_6") then
                if d.getf("stonekill") == 6 then
                    npc.purge()
                    item.remove()
                    say("Essa foi uma escolha s�bia. Destrua agora a �ltima[ENTER]estela e Maat triunfar� sobre Isfet.")
                    d.setf("stonekill",7)
                    if d.count_monster() < 100 then
                        d.regen_file ("data/dungeon/flame_dungeon/".."fd_e.txt")
                    end
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destru�da.")
                end
            else
                if d.getf("stonekill") == 7 then
                    npc.purge()
                    item.remove()
                    notice_multiline("A estela de Isfet foi destru�da.",d.notice)
                    notice_multiline("Fala com Am-heh para abrir um novo destino.",d.notice)
                    flame_dungeon.level_clear()
                else
                    item.remove()
                    say("Ordem errada. A Pedra de Maat foi destru�da.")
                end
            end
        end
 
        when 8057.kill with flame_dungeon.is_flamed(d.get_map_index()) and d.getf("level") ==16 begin -- ??? ???? ?
            notice_multiline("A Metin do purgat�rio foi destru�da.",d.notice)
            notice_multiline("Fala com Am-heh para abrir um novo destino.",d.notice)
            flame_dungeon.level_clear()
        end
 
        when 6091.kill with flame_dungeon.is_flamed(d.get_map_index()) and d.getf("level") ==17 begin -- ?? ????
            notice_multiline("Razador foi destru�do.",d.notice)
            notice_multiline("Todos os lutadores seram teleportados[ENTER]em um minuto do Templo do Drag�o.",d.notice)
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