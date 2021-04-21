quest pvp_manager begin 
    state start begin 
        when login with game.get_event_flag("budokan_open") > 0 and pc.get_map_index() != 112 begin 
            send_letter("D�ello turnuvas�na kat�l") 
        end 
        when button or info begin 
                ----"123456789012345678901234567890123456789012345678901234567890"| 
            say_title("D�ello Turnuvas� ") 
            say("") 
            if game.get_event_flag("budokan_open") == 2 then 
                say("Turnuva eventi aktif!") 
                say("") 
                say2("D�rt kategoriden olu�an (Level 15-39, 40-64,65-84 ve 85+) ac�mas�z sava���lar ile sava� ve zenginlik ve ��hret i�in nam sal! ") 
                say("") 
                local s = select("Beni hemen oraya g�t�r!","Hay�r, te�ekk�r ederim.") 
                if s == 1 then 
                   pc.warp(857400,2500) 
                end 
            else 
                say("") 
                say2("D�rt kategoriden olu�an (Level 15-39, 40-64,65-84 ve 85+) ac�mas�z sava���lar ile sava�; zenginlik ve ��hret i�in nam sal! ") 
                say2("Giri�ler a��ld��� zaman buradan giri� yapabilirsiniz Yak�nda turnuva ger�ekle�ecek, silahlar�n�z� haz�r tutun!") 
                say("") 
            end 
        end 
		
		when login with pc.get_map_index() == 112 and (pvp_attenders == nil or pvp_attenders[pvp_manager.get_my_attender_id()] == nil or (pvp_attenders[pvp_manager.get_my_attender_id()].fight_mode != 1 and pvp_attenders[pvp_manager.get_my_attender_id()].fight_mode != 2)) begin
			if pvp_attenders == nil then
				pvp_manager.guard_check_position()
				timer("pvp_guard_1", 20)
				return
			end
			if pvp_attenders[pvp_manager.get_my_attender_id()] == nil then
				pvp_manager.guard_check_position()
				timer("pvp_guard_1", 20)
				return
			end
			if pvp_attenders[pvp_manager.get_my_attender_id()].fight_mode != 1 and pvp_attenders[pvp_manager.get_my_attender_id()].fight_mode != 2 then
				pvp_manager.guard_check_position()
				timer("pvp_guard_1", 20)
			end
		end
		when pvp_guard_1.timer begin
			if pc.get_map_index() != 112 then
				return
			end
			pvp_manager.guard_check_position()
			timer("pvp_guard_2", 20)
		end
		when pvp_guard_2.timer begin
			if pc.get_map_index() != 112 then
				return
			end
			pvp_manager.guard_check_position()
			timer("pvp_guard_1", 20)
		end
        function guard_check_position() 
			syschat("Kontrol ediliyor... .")
			---	pc.remove_item(27003, pc.count_item(27003))
			---	pc.remove_item(27001, pc.count_item(27001))
			---	pc.remove_item(27118, pc.count_item(27118))
			if pc.is_polymorphed() then
			syschat("D�n���m�n�z silindi, d�ello har�tas�nda d�n��mek yasak.")
			pc.remove_polymorph()
            end 
        end 
        
        when 20011.chat."Haritay� kapat" with pc.is_gm() begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            say_title("Budokan:") 
            say("Haritay� kapatmak istiyor musun?") 
            say("Herkes �ehre ���nland�...") 
            say("") 
            warp_all_to_village( pc.get_map_index() , 1 ) 
            game.set_event_flag("budokan_open", 0) 
        end 
         
        when 20011.chat."�ehire d�n" with pc.get_map_index() == 112 begin 
            say_title("Sava� sorumlusu") 
            say("") 
            say("Ger�ekten �ehire gitmek istiyor musun?") 
            say("") 
            local s = select("Evet", "Hay�r") 
            if s == 1 then 
                warp_to_village() 
            end 
        end 

        when 20011.chat."GM: Turnuvay� iptal et" with pc.is_gm() and game.get_event_flag("pvp") != 0 begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            say_title("Turnuvay� iptal et") 
            say("Turnuva iptal olsun mu?") 
            local s = select("Evet", "Hay�r") 
            if s == 1 then 
                game.set_event_flag("pvp", 0) 
                pvp_attenders = nil 
                notice_all("<Boot> Turnuva iptal edildi.") 
                say_title("Turnuva iptal.") 
                say("Turnuvayi iptal ettiniz.") 
                say("") 
            end 
        end 

        when 20011.chat."GM: Turnuvay� ba�lat" with pc.is_gm() and game.get_event_flag("pvp") == 0 begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            say_title("Turnuvay� ba�lat") 
            say("Turnuvay� ba�latmak i�in l�tfen level[ENTER]limitlendirmesi yap�n�z.") 
            say("") 
            say_reward("En az Level (minumum 15):") 
            local str_az_level = input() 
            say_title("Turnuvay� ba�lat") 
            local az_level = tonumber(str_az_level) 
            if az_level == nil then 
                say("Yanl�� numara girildi.") 
                say("") 
                return 
            end 
            if tonumber(str_az_level) < 15 then 
                az_level = 15 
            end 
            say("En az level olarak "..tostring(az_level).." se�ildi.") 
            say("�imdi l�tfen en fazla leveli giriniz:") 
            local str_cok_level = input() 
            say_title("Turnuvay� ba�lat") 
            local cok_level = tonumber(str_cok_level) 
            if cok_level == nil then 
                say("Yanl�� numara girildi.") 
                say("") 
                return 
            end 
            if tonumber(str_cok_level) < az_level then 
                say2("En fazla level en d���k levelden k���k olamaz.") 
                say("") 
                return 
            end 
             
            game.set_event_flag("en_az_level", az_level) 
            game.set_event_flag("en_fazla_level", cok_level) 
             
            say("En az level : "..tostring(az_level)..".") 
            say("En fazla level "..tostring(cok_level)..".") 
            say("Devam edelim mi?")
            say("")			
            local s = select("Ba�lat", "�ptal") 
            if s == 2 then 
                return 
            end 
             
            say_title("Turnuvay� ba�lat") 
            say("Turnuva ba�lat�ld�...") 
            say("Leveli yeten herkes kay�t olabilir.") 
            say_reward("Level limiti: "..game.get_event_flag("en_az_level").." - "..game.get_event_flag("en_fazla_level")) 
            game.set_event_flag("pvp", 1) 
            attender_count = 0 
            game.set_event_flag("duello_turnuvasi", get_global_time()) 
            pvp_attenders = nil 
            pvp_attenders = { } 
             
            arena = { 
                        -- arena 1 
                        { 
                            { 167, 152 }, 
                            { 137, 152 }, 
                            0, 
                            "SLEEPING", 
                            0, 
                        }, 
                        -- arena 2 
                        { 
                            { 114, 152 }, 
                            { 85, 152 }, -- 166 103
                            0, 
                            "SLEEPING", 
                            0, 
                        }, 
                        -- arena 3 
                        { 
                            { 115, 98 }, 
                            { 85, 98 }, 
                            0, 
                            "SLEEPING", 
                            0, 
                        }, 
                        -- arena 4 
                        { 
                            { 167, 100 }, 
                            { 137, 100 }, 
                            0, 
                            "SLEEPING", 
                            0, 
                        }, 
                    } 
             
            notice_all("<Boot> Turnuva i�in kay�tlar a��lm��t�r!") 
            notice_all("<Boot> Level limitleri: "..game.get_event_flag("en_az_level").." - "..game.get_event_flag("en_fazla_level")) 
        end 
		
        when 20011.chat."Turnuva'ya kay�t ol" with game.get_event_flag("pvp") == 1 begin 
            say_title(mob_name(20078)..":") 
            say("") 
            if game.get_event_flag("duello_turnuvasi") == pc.getqf("duello_turnuvasi") then 
                say("Turnuvaya zaten kay�tl�s�n.") 
                say("") 
                return 
            end 
            if pc.get_level() < 15 then 
                say("Seviyeniz �ok d���k.") 
                say("") 
                return 
            end 
            if pc.get_level() < game.get_event_flag("en_az_level") or pc.get_level() > game.get_event_flag("en_fazla_level") then 
                say("Seviyeniz "..game.get_event_flag("en_az_level").." ile "..game.get_event_flag("en_fazla_level").." aral���nda olmal�d�r. ") 
                say("") 
                return 
            end 
            ----"123456789012345678901234567890123456789012345678901234567890"| 

            say2("Ho� geldiniz.Sizinle benzer d�zeyde olan oyuncular ile m�cadele edecekiniz.Rakibinizi yenmek ve b�y�k �d�llerin sahibi olmak ister misiniz?") 
            say2("M�cadele i�in haz�r m�s�n�z?") 
            local s = select("Kat�lmak istiyorum.", "�ans�m yok.") 
            say_title(mob_name(20078)..":") 
            say("") 
            if s == 1 then 
                say("S�ran�z geldi�inde �a��r�lacaks�n�z.D�ello[ENTER]bitene kadar oyunda ve ayn� haritada olmak[ENTER]zorundas�n�z aksi halde elenirsiniz.") 
                say("") 
                 
                pvp_attenders[attender_count+1] = {name = pc.getname(), level = pc.get_level(), partner = nil, winner = true, fight_mode = 0, arena = 0} 
                pc.setqf("attender_id", attender_count+1) 
                pc.setqf("duello_turnuvasi", game.get_event_flag("duello_turnuvasi")) 
                attender_count = attender_count + 1 
            elseif s == 2 then 
                say("Yaz�k... Ger�ek bir korkaks�n!") 
                say2("Kat�lsayd�n zaten oradan anca cesedin ��kard�!") 
                say("") 
            end 
        end 
        when 20011.chat."Kay�tlar� kapat" with pc.is_gm() and game.get_event_flag("pvp") == 1 begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            say_title("D�ello turnuvas� ") 
            say("�uanda "..tostring(attender_count).." oyuncu kay�tl�.") 
            say("Kay�tlar� kapatmak ister misiniz?") 
            say("") 
            local s = select("Kay�tlar� kapat", "Devam etsin") 
            if s == 1 then 
                say_title("Kay�tlar� kapat:") 
                say("Kay�tlar kapat�ld�.") 
                say("Ba�latmak i�in l�tfen Turnuvalar�[ENTER]ba�lata t�klay�n�z...") 
                say("") 
                game.set_event_flag("pvp", 2) 
                betting_list = {} 
                betting_state = {} 
            end 
        end 
         
        when 20011.chat."Turnuvalar� ba�lat" with pc.is_gm() and game.get_event_flag("pvp") == 2 begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            say_title("Turnuva") 
            say("Turnuvay� ba�latmak ister misin?") 
            say("") 
            local s = select("Turnuvay� ba�lat", "Hen�z de�il") 
            if s == 1 then 
                say_title("Zaman doldu:") 
                say("Kay�tlar kapat�ld� ve turnuva ba�lat�lacak..") 
                say("") 
                game.set_event_flag("pvp", 3) 
                pvp_manager.make_duel_list() 
                duel_list_index = 0 
                playerless_mode = false 
                notice_all("<Boot> Turnuva i�in kay�tlar kapat�lm��t�r!") 
                notice_all("<Boot> K�l�c�n haz�r olsun sava���, birazdan meydana �a��r�lacaks�n!") 
                pvp_round_num = 1 
                pvp_manager.refresh_arenas() 
            end 
        end 
         
        when 20011.chat."Bahis oyna" with pc.is_gm() and pc.get_map_index() == 112 and game.get_event_flag("pvp") == 2 and betting_state != nil and betting_state[pc.get_player_id()] == nil begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end 
			say_title("Bahis oyna:") 
            say("Hangi oyuncuya bahsini veriyorsun?") 
            say("") 
            local player = input() 
            say_title("Bahis oyna:") 
            say("") 
            if pvp_manager.get_attender_id_by_name(player) == 0 then 
                say("Bu oyuncu kay�tl� de�il.") 
                say("") 
                return 
            end 
            say("Ne kadar para veriyorsun?") 
            say("") 
            local bet_amount = tonumber(input()) 
            if bet_amount < 1 then 
                say_title("Hata:") 
                say("Bu ge�erli bir miktar de�il...") 
                say("") 
                return 
            end 
            say_title("Onaylay�n l�tfen:") 
            say(""..bet_amount.." �zerine bahse giriyor musunuz?") 
            say(player.."?") 
            say("") 
            if select("Evet", "Hay�r") == 2 then 
                return 
            end 
             
            betting_state[pc.get_player_id()] = 1 
            table.insert(betting_list, {pc.get_name(), bet_amount, player}) 
             
            say_title("Bahis:") 
            say("Bahsiniz kay�t edildi.") 
            say("�yi �anslar ve iyi oyunlar dileriz!") 
            say("") 
        end 
         
        when 20011.chat."Kimler turnuvaya kat�ld�?" with game.get_event_flag("pvp") == 2 begin 
            setskin(NOWINDOW) 
            chat("A�a��daki ki�iler d�ello turnuvas�na kat�ld�:") 
            for i = 1, attender_count, 4 do 
                local chatline = "" 
                for j = i, 4, 1 do 
                    if pvp_attenders[j] != nil then 
                        chatline = chatline..pvp_attenders[j].name.."    " 
                    end 
                end 
                syschat(chatline) 
            end 
            syschat("Toplam "..attender_count.." sava��� m�cadele ediyor.") 
        end 
         
        when 20011.chat."Rakibim kim?" with game.get_event_flag("pvp") == 3 and game.get_event_flag("duello_turnuvasi") == pc.getqf("duello_turnuvasi") begin 
            say_title(mob_name(20078)..":") 
            say("") 
            if pvp_manager.get_duel_partner() == nil then 
                say("�uanda hi� bir rakibiniz yok.") 
                say("") 
                say("Hi� bir rakip bulamaz iseniz,") 
                say2("Varsay�lan olarak otomatikman sonraki tura devam edeceksiniz.") 
                say("") 
                return 
            end 
            say("Mevcut plana g�re sizinle sava�acak olan:") 
            say("") 
            say_reward(""..pvp_manager.get_duel_partner().."") 
            say("") 
        end          

        function make_duel_list() 
            duel_list = { } 
            local i = 0 
            for ai = 1, attender_count, 1 do 
                if pvp_attenders[ai] != nil and pvp_attenders[ai].partner == nil and pvp_attenders[ai].winner == true then 
                    local partner_id = pvp_manager.findpartner(tostring(pvp_attenders[ai].name), pvp_attenders[ai].level) 
                    if partner_id != nil then 
                        pvp_attenders[ai].partner = tostring(pvp_attenders[partner_id].name) 
                        pvp_attenders[partner_id].partner = tostring(pvp_attenders[ai].name) 
                        duel_list[i] = {fighter_id1 = ai, fighter_id2 = partner_id} 
                        i = i + 1 
                    end 
                end 
            end 
             
            for ai = 1, attender_count, 1 do 
                if pvp_attenders[ai] != nil and pvp_attenders[ai].partner == nil and pvp_attenders[ai].winner == true then 
                    local partner_id = pvp_manager.findpartner_for_partnerless(tostring(pvp_attenders[ai].name), pvp_attenders[ai].level) 
                    if partner_id != nil then 
                        pvp_attenders[ai].partner = tostring(pvp_attenders[partner_id].name) 
                        pvp_attenders[partner_id].partner = tostring(pvp_attenders[ai].name) 
                        duel_list[i] = {fighter_id1 = ai, fighter_id2 = partner_id} 
                        i = i + 1 
                    end 
                end 
            end 
        end 
         
         
        function findpartner(name, level) 
            local closest_level = nil 
            local partner_id = nil 
            for ai = 1, attender_count, 1 do 
                if pvp_attenders[ai] != nil and pvp_attenders[ai].winner == true and tonumber(pvp_attenders[ai].level) <= level + 30 and tonumber(pvp_attenders[ai].level) >= level - 30 and tostring(pvp_attenders[ai].name) != name and pvp_attenders[ai].partner == nil and pvp_manager.is_player_in_map(tostring(pvp_attenders[ai].name)) == true then 
                    if closest_level == nil then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    elseif tonumber(pvp_attenders[ai].level) == tonumber(level) then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    elseif tonumber(level) < tonumber(closest_level) and tonumber(pvp_attenders[ai].level) < tonumber(closest_level) then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    elseif tonumber(level) > tonumber(closest_level) and tonumber(pvp_attenders[ai].level) > tonumber(closest_level) then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    end 
                end 
            end 
            return tonumber(partner_id) 
        end 
         
        function findpartner_for_partnerless(name, level) 
            local closest_level = nil 
            local partner_id = nil 
            for ai = 1, attender_count, 1 do 
                if pvp_attenders[ai] != nil and pvp_attenders[ai].winner == true and tostring(pvp_attenders[ai].name) != name and pvp_attenders[ai].partner == nil and pvp_manager.is_player_in_map(tostring(pvp_attenders[ai].name)) == true then 
                    if closest_level == nil then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    elseif pvp_attenders[ai].level == level then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    elseif tonumber(level) < tonumber(closest_level) and pvp_attenders[ai].level < closest_level then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    elseif tonumber(level) > tonumber(closest_level) and pvp_attenders[ai].level > closest_level then 
                        closest_level = pvp_attenders[ai].level 
                        partner_id = ai 
                    end 
                end 
            end 
            return partner_id 
        end 
         
        function is_player_in_map(name) 
            if pc.getname() == name then 
                return true 
            end 
            local myname = pc.getname() 
            local target = find_pc_by_name(name) 
            local t = pc.select(target) 
            if pc.getname() == myname then 
                pc.select(t) 
                return false 
            end 
            pc.select(t) 
            return true 
        end 
         
         
        when 20011.chat."GM: Turnuvay� yenile" with pc.is_gm() and game.get_event_flag("pvp") == 3 begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            for aArena = 1, 4, 1 do 
                arena[aArena][3] = 0 
                arena[aArena][4] = "SLEEPING" 
            end 
            pvp_manager.refresh_arenas() 
        end 



        when 20011.chat."GM: Turnuva �d�l� " with pc.is_gm() begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            say_title("�d�l:") 
            say("�u an �d�l: "..game.get_event_flag("pvp_price_count").."x "..item_name(game.get_event_flag("pvp_price_vnum")).." (kod: "..game.get_event_flag("pvp_price_vnum")..")") 
            say("") 
            local s = select("�d�l� de�i�tir", "Kapat") 
            if s == 2 then 
                return 
            end 
            say_title("�d�l de�i�tirme:") 
            say("Yeni �d�l kodunu giriniz:") 
            say("") 
            local vnum = input() 
            say_title("�d�l de�i�tirme:") 
            say("Yeni �d�l adetini yaz�n�z:") 
            say("") 
            local count = input() 
            game.set_event_flag("pvp_price_count", count) 
            game.set_event_flag("pvp_price_vnum", vnum) 
            say_title("�d�l de�i�tirme:")  
            say("�d�l de�i�tirild.") 
            say("Yeni �d�l: "..count.."x "..item_name(vnum).." (kod: "..vnum..")") 
            say("") 
        end 

        when 20011.chat."GM: Turnuva �d�l� : Yang" with pc.is_gm() begin 
		if pc.get_name() != "[TEC]BlackForce" and pc.get_name() != "Maxmi" then
		say_title("Eri�im engeli")
		say()
		say("Serverde yetkili de�ilsiniz.")
		return
		end
            say_title("Turnuva �d�l� yang :") 
            say("�uan ki yang miktar�: "..game.get_event_flag("pvp_round_gold")) 
            say("") 
            local s = select("De�i�tir", "Kapat") 
            if s == 2 then 
                return 
            end 
            say_title("Yang �d�l�n� de�i�tir:") 
            say("L�tfen ne kadar yang verilece�ini yaz�n�z.") 
            say("") 
            local gold = input() 
            game.set_event_flag("pvp_round_gold", gold) 
            say_title("Yang �d�l�:") 
            say("Yang �d�l� de�i�tirildi.") 
            say("Yeni �d�l: "..gold.." yang") 
            say("") 
        end 
         
        function refresh_arenas() 
            for aArena = 1, 4, 1 do 
                if duel_list[duel_list_index] == nil then 
                    if playerless_mode == true then 
                        pvp_manager.init_next_round() 
                    else 
                        pvp_manager.fight_playerless() 
                    end 
                    return 
                end 
                if arena[aArena][3] == 0 then 
                    arena[aArena][3] = 1 
                    pvp_manager.fight_init(duel_list[duel_list_index].fighter_id1, duel_list[duel_list_index].fighter_id2, aArena) 
                end 
            end 
        end 
         

        function fight_init(pid1, pid2, arena_id) 
            duel_list_index = duel_list_index + 1 
            if pvp_manager.is_player_in_map(tostring(pvp_attenders[pid1].name)) == false then 
                notice_all("<Boot> "..tostring(pvp_attenders[pid1].name).." online de�il yada turnuvadan elendi.") 
                pvp_attenders[pid1].winner = false 
                pvp_attenders[pid2].partner = nil 
                arena[arena_id][3] = 0 
                pvp_manager.refresh_arenas() 
                return 
            end 
            if pvp_manager.is_player_in_map(tostring(pvp_attenders[pid2].name)) == false then 
                notice_all("<Boot> "..tostring(pvp_attenders[pid2].name).." online de�il yada turnuvadan elendi.") 
                pvp_attenders[pid2].winner = false 
                pvp_attenders[pid1].partner = nil 
                arena[arena_id][3] = 0 
                pvp_manager.refresh_arenas() 
                return 
            end 
             
            notice_all("<Boot> "..tostring(pvp_attenders[pid1].name).." ve "..tostring(pvp_attenders[pid2].name).." haz�r olun l�tfen!") 
             
            pvp_attenders[pid1].fight_mode = 1 
            pvp_attenders[pid2].fight_mode = 1 
            pvp_attenders[pid1].arena = arena_id 
            pvp_attenders[pid2].arena = arena_id 
             
            pvp_manager.local_pc_warp(tostring(pvp_attenders[pid1].name), arena[arena_id][1][1], arena[arena_id][1][2]) 
            pvp_manager.local_pc_warp(tostring(pvp_attenders[pid2].name), arena[arena_id][2][1], arena[arena_id][2][2]) 

        end 
         
        when login with pc.get_map_index() == 112 and game.get_event_flag("pvp") == 3 and pvp_manager.get_fight_mode() == 1 begin 
            affect.add(apply.MOV_SPEED, -10000, 2) 
            affect.add_collect(apply.HP_REGEN, 5000, 30) 
            affect.add_collect(apply.SP_REGEN, 5000, 30) 
            pvp_manager.set_fight_mode(2) 
            if arena[pvp_manager.get_arena()][3] == 2 then 
                arena[pvp_manager.get_arena()][5] = 30 
                loop_timer("fight_start_countdown", 1) 
            else 
                timer("partner_timeout", 60) 
            end 
            arena[pvp_manager.get_arena()][3] = 2 
        end         
         
        when partner_timeout.timer begin 
            if pvp_manager.is_player_in_map(pvp_manager.get_duel_partner()) == true or game.get_event_flag("pvp") != 2 or pvp_manager.get_fight_mode() != 2 then 
                return 
            end 
            pvp_manager.set_fight_mode(3) 
            if arena[pvp_manager.get_arena()][3] == 3 then 
                return 
            end 
            arena[pvp_manager.get_arena()][3] = 3 
            notice_in_map("<Boot> "..pc.getname()..", "..pvp_manager.get_duel_partner().." kar�� h�kmen kazand�.", pc.get_map_index()) 
            pvp_attenders[pvp_manager.get_attender_id_by_name(pvp_manager.get_duel_partner())].fight_mode = 3 
            pvp_attenders[pvp_manager.get_my_attender_id()].winner = true 
            pvp_attenders[pvp_manager.get_attender_id_by_name(pvp_manager.get_duel_partner())].winner = false 
			pc.warp_local(pc.get_map_index(), 12600, 23400)
        end 

        when fight_start_countdown.timer begin 
            if arena[pvp_manager.get_arena()][5] == -1 then 
                return 
            end 
            local partner_vid = find_pc_by_name(pvp_manager.get_duel_partner()) 
            local my_vid = pc.get_vid() 
            if arena[pvp_manager.get_arena()][5] == 0 then 
                arena[pvp_manager.get_arena()][5] = -1 
                pc.select(partner_vid) 
				--affect.add_collect(10, 32000, 4)
				--pc.remove_item(27003, pc.count_item(27003))
				--pc.remove_item(27001, pc.count_item(27001))
				--pc.remove_item(27118, pc.count_item(27118))
				--syschat("Rakibinin ve senin potlar�n silindi.Can�n fullendi.")
				--syschat("Envanterine pot al�r isen otomatikman eleneceksin.")
                command("pvp "..my_vid) 
                pc.select(my_vid) 
				--affect.add_collect(10, 32000, 4)
				--pc.remove_item(27003, pc.count_item(27003))
				--pc.remove_item(27001, pc.count_item(27001))
				--pc.remove_item(27118, pc.count_item(27118))
				--syschat("Rakibinin ve senin potlar�n silindi.Can�n fullendi.")
				--syschat("Envanterine pot al�r isen otomatikman eleneceksin.")
                command("pvp "..partner_vid) 
                notice_all("<Boot> "..pvp_manager.get_duel_partner().." ve "..pc.get_name().." aras�ndaki m�cadele ba�lad�!") 
                timer("fight_start_countdown_shutdown", 1) 
            else 
                pc.select(partner_vid) 
                if math.mod(arena[pvp_manager.get_arena()][5], 5) == 0 then 
                    syschat("M�cadelen "..tostring(arena[pvp_manager.get_arena()][5]).." saniye sonra ba�layacak.") 
                end 
                affect.add(apply.MOV_SPEED, -10000, 2) 
                pc.select(my_vid) 
                if math.mod(arena[pvp_manager.get_arena()][5], 5) == 0 then 
                    syschat("M�cadelen "..tostring(arena[pvp_manager.get_arena()][5]).." saniye sonra ba�layacak.") 
                end 
                affect.add(apply.MOV_SPEED, -10000, 2) 
                arena[pvp_manager.get_arena()][5] = arena[pvp_manager.get_arena()][5] - 1 
            end 
        end 
         
        when fight_start_countdown_shutdown.timer begin 
            cleartimer("fight_start_countdown") 
        end 
         
        when logout with game.get_event_flag("pvp") == 3 and pc.get_map_index() == 112 and pvp_manager.get_fight_mode() == 2 begin 
            pvp_manager.set_fight_mode(3) 
            arena[pvp_manager.get_arena()][3] = 3 
            notice_all("<Boot> "..pvp_manager.get_duel_partner()..", "..pc.getname().." ile olan m�cadelesini h�kmen kazand�!") 
            pvp_attenders[pvp_manager.get_attender_id_by_name(pvp_manager.get_duel_partner())].fight_mode = 3 
            pvp_attenders[pvp_manager.get_my_attender_id()].winner = false 
            pvp_attenders[pvp_manager.get_attender_id_by_name(pvp_manager.get_duel_partner())].winner = true 
             
            local target = find_pc_by_name(pvp_manager.get_duel_partner()) 
            local t = pc.select(target) 
            pc.change_gold(game.get_event_flag("pvp_round_gold")*pvp_round_num) 
            pc.select(t) 
             
			pvp_manager.local_pc_warp(pvp_manager.get_duel_partner(), 126, 24)
        end 
		
        when login with pc.get_map_index() == 112 begin 
			if pc.is_polymorphed() then
			say_title("Bu har�tada d�n���m yasak.")
			say2("Bu d�ello haritas� oldu�u i�in d�n��emezsiniz.")
			say("[DELAY value;66666]D�n���m siliniyor...[/DELAY]")
			pc.remove_polymorph()
			return
        end 			
		if pc.is_riding() then
	    say_title("Bu haritaya at ile giremezsiniz.")
		say()
		---
		say2("Bu harita d�ello haritas� oldu�u i�in at ile giri� yapamazs�n�z.")
		say("[DELAY value;66666]At g�nderiliyor...[/DELAY]")
		horse.unride()
		horse.unsummon()
			return
		end
		end
		
        when 70104.use with pc.get_map_index() == 112 begin 
			say_title("Bu har�tada d�n���m yasak.")
			say2("Bu d�ello haritas� oldu�u i�in d�n��emezsiniz.")
        end 
		
        when 50053.use with pc.get_map_index() == 112 begin 
			say_title("Bu har�tada at �a��rmak yasak")
			say2("Bu d�ello haritas� oldu�u i�in at �a��ramazs�n�z.")
        end 
		
		 when login with pc.get_map_index() == 112 begin 
			chat("D�ello b�l�m�nde at �a��r�lamaz ve at ile sava�a girilemez.")
			horse.unride()
			horse.unsummon()
		end
		
        when kill with game.get_event_flag("pvp") == 3 and pc.get_map_index() == 112 and npc.is_pc() and pvp_manager.get_fight_mode() == 2 begin 
            pvp_manager.set_fight_mode(3) 
            if arena[pvp_manager.get_arena()][3] == 3 then 
                return 
            end 
            arena[pvp_manager.get_arena()][3] = 3 
            notice_all("<Boot> "..pc.getname()..", "..pvp_manager.get_duel_partner().." ile olan m�cadelesini kazand�!") 
            pvp_attenders[pvp_manager.get_attender_id_by_name(pvp_manager.get_duel_partner())].fight_mode = 3 
            pvp_attenders[pvp_manager.get_my_attender_id()].winner = true 
            pvp_attenders[pvp_manager.get_attender_id_by_name(pvp_manager.get_duel_partner())].winner = false 
             
            pc.change_gold(game.get_event_flag("pvp_round_gold")*pvp_round_num) 
             
            timer("fight_end", 5) 
        end 
         
        when fight_end.timer begin 
			pc.warp_local(pc.get_map_index(), 12600, 23400)
			pvp_manager.local_pc_warp(pvp_manager.get_duel_partner(), 126, 24)
        end 
         
        when letter with pc.get_map_index() == 112 and game.get_event_flag("pvp") == 3 and pvp_manager.get_fight_mode() == 3 begin 
            pvp_manager.set_fight_mode(0) 
             
            if pvp_attenders[pvp_manager.get_my_attender_id()].winner == true then 
                arena[pvp_manager.get_arena()][3] = 0 
                pvp_manager.refresh_arenas() 
            end 
        end 
         
        function fight_playerless() 
            for aArena = 1, 4, 1 do 
                if arena[aArena][3] != 0 then 
                    return 
                end 
            end 
            playerless_mode = true 

             
            pvp_manager.make_duel_list() 
            pvp_manager.refresh_arenas() 
        end 
         
        function init_next_round() 
            for aArena = 1, 4, 1 do 
                if arena[aArena][3] != 0 then 
                    return 
                end 
            end 
            playerless_mode = false 
             
            local winner_count = 0 
            local winner_id = 0 
            for ai = 1, attender_count, 1 do 
                pvp_attenders[ai].partner = nil 
                pvp_attenders[ai].fight_mode = 0 
                if pvp_attenders[ai] != nil and pvp_attenders[ai].winner == true then 
                    winner_count = winner_count + 1 
                    winner_id = ai 
                end 
            end 
             
            if winner_count == 1 then 
                notice_all("<Boot> "..pvp_attenders[winner_id].name.." turnuvay� kazand�!") 
                notice_all("<Boot> "..pvp_attenders[winner_id].name.." �d�l olarak "..game.get_event_flag("pvp_price_count").."x "..item_name(game.get_event_flag("pvp_price_vnum")).." kazand�!") 
                local target = find_pc_by_name(pvp_attenders[winner_id].name) 
                local t = pc.select(target) 
                pc.give_item2(game.get_event_flag("pvp_price_vnum"), game.get_event_flag("pvp_price_count")) 
                pc.select(t) 
                notice_all("<Boot> D�ello turnuvas� bitmi�tir... �yi oyunlar, iyi e�lenceler...") 
                game.set_event_flag("pvp", 0) 
				say_title("Sava���lar�n en onurlusu "..pvp_attenders[winner_id].name.."! ")
				say("")
				---
				say2("Seni tebrik ederiz sava���! Az �nceki g�sterdi�in performans ile serverin yeni lideri sen oldun! G�revliye giderek ticaret duyurusu yapabilirsin, haftadan haftaya yang alabilirsin g�revliden.")
				say("�yi oyunlar!")
				kazanan_guncelle(pvp_attenders[winner_id].name)
                return 
            end 
             
            pvp_manager.make_duel_list() 
            duel_list_index = 0 
            if winner_count == 2 then 
                notice_all("<Boot> Turnuvan�n son turu �imdi ba�l�yor!") 
            elseif winner_count <= 4 then 
                notice_all("<Boot> Turnuvan�n yar� final turu �imdi ba�l�yor!") 
            else 
                notice_all("<Boot> Turnuva bir sonraki tura ge�iyor!") 
            end 
            pvp_round_num = pvp_round_num + 1 
            pvp_manager.refresh_arenas() 
        end 
         
        function distribute_bets(winner_name) 
            table.insert(betting_list, {pc.get_name(), bet_amount, player}) 
            local jackpot = 0 
            local jackpot_winner_only = 0 
            local winners = 0 
            for i = 1, table.getn(betting_list), 1 do 
                if betting_list[i][3] == winner_name then 
                    jackpot_winner_only = jackpot_winner_only + betting_list[i][2] 
                end 
                jackpot = jackpot + betting_list[i][2] 
                winners = winners + 1 
            end 
             
            for i = 1, table.getn(betting_list), 1 do 
                if betting_list[i][3] == winner_name then 
                    pvp_manager.give_jackpot_gold(betting_list[i][1], math.ceil( (betting_list[i][2] / jackpot_winner_only)*jackpot )) 
                end 
            end 
             
        end 
         
        function give_jackpot_gold(name, amount) 
            local target = find_pc_by_name(name) 
            if target == 0 then 
                return 
            end 
            local t = pc.select(target) 
            pc.change_money(amount) 
            pc.select(t) 
        end 
		
        function hediye_ver_bitir(name, item, adet) 
            local target = find_pc_by_name(name) 
            if target == 0 then 
                return 
            end 
            local t = pc.select(target) 
               pc.give_item2(item, adet) 
               notice_all("<Boot> Turnuva tamamland�.") 
               game.set_event_flag("pvp", 0) 
               pvp_attenders = nil 
            pc.select(t) 
        end 
		         
		function local_pc_warp(name, x, y)
			local target = find_pc_by_name(name)
			local t = pc.select(target)
			pc.warp_local(pc.get_map_index(), x*100, y*100)
			pc.select(t)
		end

        function disari_at(name) 
            local target = find_pc_by_name(name) 
            local t = pc.select(target) 
            pc.warp(960100, 268700) 
            pc.select(t) 
        end 
		
        function hediye_son_ver(name, item, adet) 
            local target = find_pc_by_name(name) 
            local t = pc.select(target) 
               pc.give_item2(item, adet) 
               notice_all("<Boot> Turnuva tamamland�.") 
               game.set_event_flag("pvp", 0) 
            pc.select(t) 
        end 
		
		function bitir_turnuvayi(name) 
            local target = find_pc_by_name(name) 
            local t = pc.select(target) 
            pc.warp(960100, 268700) 
            pc.select(t) 
        end 
         
        function setqf_by_name(name, flag, value) 
            local target = find_pc_by_name(name) 
            local t = pc.select(target) 
            pc.setqf(flag, value) 
            pc.select(t) 
        end 
         
        function getqf_by_name(name, flag) 
            local target = find_pc_by_name(name) 
            local t = pc.select(target) 
            local rflag = pc.getqf(flag) 
            pc.select(t) 
            return rflag 
        end 
         
        function get_attender_id_by_name(name) 
            for ai = 1, attender_count, 1 do 
                if tostring(pvp_attenders[ai].name) == name then 
                    return ai 
                end 
            end 
            return 0 
        end 
         
        function get_my_attender_id() 
            return pvp_manager.get_attender_id_by_name(pc.get_name()) 
        end 
         
        function get_duel_partner() 
            if pvp_attenders[pvp_manager.get_my_attender_id()] != nil and pvp_attenders[pvp_manager.get_my_attender_id()].partner != nil then 
                return pvp_attenders[pvp_manager.get_my_attender_id()].partner 
            else 
                return nil 
            end 
        end 
         
        function get_fight_mode() 
            if pvp_attenders != nil and pvp_manager.get_my_attender_id() != 0 and pvp_attenders[pvp_manager.get_my_attender_id()] != nil and pvp_attenders[pvp_manager.get_my_attender_id()].fight_mode != nil then 
                return pvp_attenders[pvp_manager.get_my_attender_id()].fight_mode 
            else 
                return 0 
            end 
        end 
         
        function set_fight_mode(fmode) 
            pvp_attenders[pvp_manager.get_my_attender_id()].fight_mode = fmode 
        end 
         
        function get_arena() 
            return pvp_attenders[pvp_manager.get_my_attender_id()].arena 
        end 
         
        function set_arena(id) 
            pvp_attenders[pvp_manager.get_my_attender_id()].arena = id 
        end 
         
        function ask_fight(asker, target) 
            return confirm(find_pc_by_name(target), " kar�� m�cadele etmek istiyormusun "..asker.. "?", 15) 
        end 
         
    end 
end  