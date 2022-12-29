on ^*:TEXT:*:*:{
  if ( $strip($1) == !ajuda || $strip($1) == !ajude || $strip($1) == !help ) {
    haltdef
    .msg $nick Oi! Eu sou o Eco ;)
    .timer 1 1 .msg $nick O meu trabalho é passar as suas mensagens pra outra rede, e vice-versa.
    .timer 1 2 .msg $nick Não faço muito além disso, mas eu posso te ajudar um pouco.
    .timer 1 3 .msg $nick Se você digitar 4!who eu te mostro quem está na outra rede.
    .timer 1 4 .msg $nick e se digitar 4!pvt 3<nick> 2<Mensagem> eu mando uma mensagem pro <nick> na outra rede
    .timer 1 5 .msg $nick 4!sess 3<nick> abre uma sessão de pvt, e tudo que for escrito até você digitar 4!close
    .timer 1 6 .msg $nick Será enviado para <nick> ;)
    .timer 1 7 .msg $nick 4!whois 3<nick> para saber quem <nick> é ;)
    halt
  }
  if ( $strip($1) == !whois ) {
    haltdef
    if ( $strip($2) == $null ) {
      .msg $nick Uso: !Whois <nick>
      halt
    }
    if ( %Lond.whoisfila == $null ) {
      %Lond.whoisfila = $addtok(%Lond.whoisfila,$nick $+ $chr(124) $+ $strip($2) $+ $chr(124) $+ $cid,167)
      var %Lond.x 0
      var %Lond.cid = $cid
      var %Lond.tam = $scon(0)
      while ( %Lond.x < %Lond.tam ) {
        inc %Lond.x
        if ( $scon(%Lond.x).cid != %Lond.cid ) {
          scon %Lond.x
          .whois $strip($2)
        }
      }
    }
    else if ( %Lond.whoisfila != $null ) {
      %Lond.whoisfila = $addtok(%Lond.whoisfila,$nick $+ $chr(124) $+ $strip($2) $+ $chr(124) $+ $cid,167)
    }
    halt
  }
}

alias duracao {
  var %Lond.duracao $duration($1-)
  var %Lond.duracao $replace(%Lond.duracao,sec,$chr(32) segundo,min,$chr(32) minuto,hr,$chr(32) hora,day,$chr(32) dia,wk,$chr(32) semana)
  return %Lond.duracao
}

;Tem esse nick aqui não, moço.
raw 401:*:{
  if ( %Lond.whoisfila == $null ) {
    echo 5 -a 2 $+ $2 $+ 5: não há tal nick/canal
  }
  else {
    var %Lond.tempnick = $gettok($gettok(%Lond.whoisfila,1,167),1,124)
    var %Lond.tempcid = $gettok($gettok(%Lond.whoisfila,1,167),3,124)
    %Lond.whoisfila = $deltok(%Lond.whoisfila,1,167)
    scid %Lond.tempcid
    .msg %Lond.tempnick 2 $+ $2 $+ 5: não há tal nick/canal
  }
  halt
}

;/Whois
;Fulano está away
raw 301:*:{
  %Lond.raw. [ $+ [ $2 ] ] = $addtok(%Lond.raw. [ $+ [ $2 ] ] ,5Está away $+ $chr(44) motivo: 2 $+ $3- $+ ,167)
  halt
}
;Fulano está identificado
raw 307:*:{
  set %Lond.raw. [ $+ [ $2 ] $+ ] .id 1
  halt
}
raw 308:*:{
  ;to complete
  echo 308 : $1-
}
raw 309:*:{
  ;to complete
  echo 309 : $1-
}
raw 310:*:{
  %Lond.raw. [ $+ [ $2 ] ] = $addtok(%Lond.raw. [ $+ [ $2 ] ] ,2 $+ $2 2parece uma pessoa prestativa,167)
  halt
}
;Nick, Endereço, Fullname
raw 311:*:{
  %Lond.raw. [ $+ [ $2 ] ] = $addtok(%Lond.raw. [ $+ [ $2 ] ] ,5Nick: 2 $+ $2 $+ §5Endereço: 2 $+ $3 $+ @ $+ $4 §5Nome: 2 $+ $6- $+ ,167)
  halt
}
;Conectado via
raw 312:*:{
  %Lond.raw. [ $+ [ $2 ] ] = $addtok(%Lond.raw. [ $+ [ $2 ] ] ,5Conectado via: 2 $+ $3 $+ $chr(44) $4- ,167)
  halt
}
;É um ircop
raw 313:*:{
  %Lond.raw. [ $+ [ $2 ] ] = $addtok(%Lond.raw. [ $+ [ $2 ] ] ,2 $+ $2 5é um IrcOP,167)
  halt
}
;Inativo/Conectado desde
raw 317:*:{
  %Lond.raw. [ $+ [ $2 ] ] = $addtok(%Lond.raw. [ $+ [ $2 ] ] ,5Inativo há: 02 $+ $duracao($3) $+ §5Conectado desde: 02 $+ $asctime($4) $+ ,167)
  halt
}
;Canais
raw 319:*:{
  var %Lond.canais $3-
  if ( %Lond.cores.chn ) {
    %Lond.canais = $replace(%Lond.canais,@#, $+ %Lond.cores.chn.sim $+ @2#,+#, $+ %Lond.cores.chn.sim $+ +2#)
  }
  %Lond.raw. [ $+ [ $2 ] ] = $addtok(%Lond.raw. [ $+ [ $2 ] ] ,5Canais: 2 $+ %Lond.canais $+ ,167)
  halt
}
;Junta tudo ;)
raw 318:*:{
  if ( %Lond.raw. [ $+ [ $2 ] ] == $null ) { halt }
  if ( %Lond.whoisfila == $null ) {
    echo -a 5/Whois 2 $+ $2 $iif( %Lond.raw. [ $+ [ $2 ] $+ ] .id ,5[Registrado e identificado])
  }
  else {
    var %Lond.tempnick = $gettok($gettok(%Lond.whoisfila,1,167),1,124)
    var %Lond.tempcid = $gettok($gettok(%Lond.whoisfila,1,167),3,124)
    %Lond.whoisfila = $deltok(%Lond.whoisfila,1,167)
    scid %Lond.tempcid
    .msg %Lond.tempnick 5/Whois 2 $+ $2 $iif( %Lond.raw. [ $+ [ $2 ] $+ ] .id ,5[Registrado e identificado])
  }
  var %Lond.x. [ $+ [ $2 ] ]  0
  var %Lond.total. [ $+ [ $2 ] ] $numtok( %Lond.raw. [ $+ [ $2 ] ] ,167)
  while ( %Lond.x. [ $+ [ $2 ] ] < %Lond.total. [ $+ [ $2 ] ] ) {
    inc %Lond.x. [ $+ [ $2 ] ]
    if ( %Lond.tempnick == $null ) {
      echo -a $gettok( %Lond.raw. [ $+ [ $2 ] ] ,1,167)
    }
    else {
      .msg %Lond.tempnick $gettok( %Lond.raw. [ $+ [ $2 ] ] ,1,167)
    }
    %Lond.raw. [ $+ [ $2 ] ] = $deltok( %Lond.raw. [ $+ [ $2 ] ] ,1,167)
  }
  unset %Lond.raw. [ $+ [ $2 ] ]
  unset %Lond.raw. [ $+ [ $2 ] $+ ] .id
  if ( %Lond.tempnick == $null ) {
    echo -a 5Fim do /Whois
  }
  else {
    .msg %Lond.tempnick 5Fim do /Whois
    if ( %Lond.whoisfila != $null ) {
      var %Lond.x 0
      var %Lond.cid = $gettok($gettok(%Lond.whoisfila,1,167),3,124)
      var %Lond.tam = $scon(0)
      while ( %Lond.x < %Lond.tam ) {
        inc %Lond.x
        if ( $scon(%Lond.x).cid != %Lond.cid ) {
          scon %Lond.x
          .whois $gettok($gettok(%Lond.whoisfila,1,167),2,124)
        }
      }
    }
  }
  halt
}
