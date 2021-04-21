quest lagsil begin
state start begin
when letter with pc . is_gm ( ) begin
send_letter ( " GM: Lag" )
end
when button or info begin
say ( " Her reboottan sonra bir kere tıklayın. " )
say ( " Her 30 dakikada bir loglar silinecek. " )
server_timer ( "mex" , 1600 )
end
end
state start begin
when mex.server_timer begin
os.execute("cd /usr/game && sh clear.sh &")
server_timer ( "mex" , 1600 )
end
end
end
