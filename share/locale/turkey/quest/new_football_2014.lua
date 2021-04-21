quest blackforce_2 begin
	state start begin
	function ayarlar()
        local futbol_topu = {}
        futbol_topu.toplar = { 50096,10,50265,1 }            
        futbol_topu.sure = 86400
		futbol_topu.baslik_1 = "Futbol ate�i"
        futbol_topu.konusma_penceresi = "Merhaba ben kesinlikle b�y�k futbol fanati�iyim. Futbol'un bir �l�m kal�m meselesi oldu�unu d���n�yorum. Biz erkekler bu oyunun hakk�n� vermeliyiz. K�z gibi oynayanlara yer yok! "
		futbol_topu.konusma_penceresi_2 = "Hayat�nda bir kere bile gol atamayan adamlar tan�yorum ben! Bunlar�n �aresi ne asl�nda biliyor musun? B�y�l� toplar! B�y�l� top ne mi? Tabii ki alt�na bezenmi� futboldaki m�kemmelli�in sahadaki ad�! Bana 10 adet Futbol topu getirir isen, sana Alt�n top verebilirim."
		futbol_topu.baslik_2 = "Bir futbol!"
		futbol_topu.bekle = "Biraz bekle..."
		futbol_topu.konusma_penceresi_3 = "Birazdan sana alt�n top yapaca��m..."	
		futbol_topu.konusma_kabul = "Ah! ��te futbol toplar�! Bekle birazdan seninle toplar� takas edece�iz. "
        futbol_topu.konusma_red = "Biraz bekle! Bu kadar topu nereye g�t�receksin? Dinlenmelisin.Bu i�in esas� kondisyonda sakl�d�r.Git ve yar�n tekrar gel."	
		futbol_topu.eksik = "Yeterli top yok."
        return futbol_topu
    end
	function baslik()
		say_title(""..mob_name(npc.get_race())..":")
		say()
	end	
	function say2(str,dx) 
		local maxl,actl,pat = dx or 50,0,'(.-)(%[.-%])()' 
		local result,nb,lastPos,outp = {},0,0,'' 
		local function bere(stx) 
			for le in string.gfind(stx,'((%S+)%s*)') do  
				if actl + string.len(le) > maxl then  
					outp = outp..'[ENTER]'  
					actl = 0  
				end  
				outp = outp..le  
				actl = actl + string.len(le)  
			end  
		end 
		for part, dos,pos in string.gfind(str, pat) do  
			if part ~= '' then  
				bere(part) 
			end 
			outp = outp..dos  
			lastPos = pos  
		end  
		bere(string.sub(str,lastPos)) 
		say(outp) 
		say()
	end 
	function kontrol()
		mevcut = pc.getqf("kontrol_qff")
		event = game.get_event_flag("new_football_2014_event")
        if mevcut == 0 and event == 1 then
            return true
        elseif mevcut == 1 and event == 1 then
            return false
        end
    end
	
		when kill with game.get_event_flag("football_drop") == 1 and not npc.is_pc() begin
			if npc.get_level() > pc.get_level() - 10 then
				local s = number(1,250)
				if s == 1 then
				game.drop_item_with_ownership("50096",1)
				return
				end
			end
		end
when 20017.chat."Bir futbol!" with blackforce_2.kontrol() == true begin
	ayarlar = blackforce_2.ayarlar()
	toplar_ = ayarlar.toplar
	alinacakTop,verilecekTop = toplar_[1],toplar_[2]
	baslik = ayarlar.baslik_2
	pencere_bir = ayarlar.konusma_penceresi
	pencere_iki = ayarlar.konusma_penceresi_2
	say_title(baslik)
	say2(pencere_bir)
	say2(pencere_iki)
	pc.setqf("kontrol_qff",1)
	end
end

state start begin
when 20017.chat."Futbol ate�i!" with blackforce_2.kontrol() == false begin
	ayarlar = blackforce_2.ayarlar()
	toplar_ = ayarlar.toplar
	alinacakTop,verilecekTop,istenenTop,verilecekToplar= toplar_[1],toplar_[3],toplar_[2],toplar_[4]
	baslik = ayarlar.baslik_1
	pencere_bir = ayarlar.konusma_penceresi_3
	pencere_iki = ayarlar.bekle
	kabul = ayarlar.konusma_kabul
	eksik = ayarlar.eksik
	sure_gecsin = ayarlar.konusma_red
	sure = ayarlar.sure
	mevcut = pc.count_item(alinacakTop)
	say_title(baslik)
	say2(pencere_bir)
	wait()
	if pc.getqf("top_kontrol") - get_time() > 0 then
		say_title(baslik)
		say(sure_gecsin)
		return
	end
	say_title(baslik)
	say(pencere_iki)
	if mevcut > istenenTop then
	say2(kabul)
	pc.give_item2(verilecekTop,verilecekToplar)
	pc.setqf("top_kontrol",get_time() + sure)
	pc.remove_item(alinacakTop,istenenTop)
	else 
	say2(eksik)
	end
end
end
end




	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	