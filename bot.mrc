on *:start:{
  mnick Eco
  server irc.irchighway.net
  server -m irc.brasnet.org
}

on *:nick:{
  if ( $nick != $me && $newnick != $me ) {
    var %Lond.x 0
    var %Lond.cid = $cid
    var %Lond.tam = $scon(0)
    while ( %Lond.x < %Lond.tam ) {
      inc %Lond.x
      if ( $scon(%Lond.x).cid != %Lond.cid ) {
        scon %Lond.x
        /*
        var %Lond.y 0
        while ( %lond.y < $nick($chan,0) ) {
          inc %Lond.y
          var %Lond.addr = $nick($chan,%Lond.y)
          var %Lond.addr = $address(%Lond.addr,0)
          if ( $ialchan(%lond.addr,$chan,1) ) {
            var %Lond.hasmatch 1
            echo buh! $nick
          }
        }
        if ( $nick !ison $chan && %Lond.hasmatch == $null ) {
          */
          var %Lond.y 0
          while ( %Lond.y < $chan(0) ) {
            inc %Lond.y
            msg $chan(%Lond.y) $nick is now known as $newnick @  $+ %cor. [ $+ [ $scid(%Lond.cid).network ] ] $+ $scid(%Lond.cid).network
          }
          ;    }
        }
      }
    }
  }

  on *:kick:#:{
    var %Lond.x 0
    var %Lond.cid = $cid
    var %Lond.tam = $scon(0)
    if ( $knick != $me ) {
      while ( %Lond.x < %Lond.tam ) {
        inc %Lond.x
        if ( $scon(%Lond.x).cid != %Lond.cid ) {
          scon %Lond.x
          /*
          var %Lond.y 0
          while ( %lond.y < $nick($chan,0) ) {
            inc %Lond.y
            var %Lond.addr = $nick($chan,%Lond.y)
            var %Lond.addr = $address(%Lond.addr,0)
            if ( $ialchan(%lond.addr,$chan,1) ) {
              var %Lond.hasmatch 1
              echo buh! $nick
            }
          }
          if ( $nick !ison $chan && %Lond.hasmatch == $null ) {
            */
            msg $chan $knick was kicked from $chan by $nick @  $+ %cor. [ $+ [ $scid(%Lond.cid).network ] ] $+ $scid(%Lond.cid).network ( $+ $1- $+ )
            ;    }
          }
        }
      }
    }

    on *:join:#:{
      var %Lond.x 0
      var %Lond.cid = $cid
      var %Lond.tam = $scon(0)
      if ( $nick != $me ) {
        while ( %Lond.x < %Lond.tam ) {
          inc %Lond.x
          if ( $scon(%Lond.x).cid != %Lond.cid ) {
            scon %Lond.x
            /*
            var %Lond.y 0
            while ( %lond.y < $nick($chan,0) ) {
              inc %Lond.y
              var %Lond.addr = $nick($chan,%Lond.y)
              var %Lond.addr = $address(%Lond.addr,0)
              if ( $ialchan(%lond.addr,$chan,1) ) {
                var %Lond.hasmatch 1
                echo buh! $nick
              }
            }
            if ( $nick !ison $chan && %Lond.hasmatch == $null ) {
              */
              msg $chan $nick has joined $chan @  $+ %cor. [ $+ [ $scid(%Lond.cid).network ] ] $+ $scid(%Lond.cid).network
              ;    }
            }
          }
        }
      }

      on *:part:#:{
        var %Lond.x 0
        var %Lond.cid = $cid
        var %Lond.tam = $scon(0)
        if ( $nick != $me ) {
          while ( %Lond.x < %Lond.tam ) {
            inc %Lond.x
            if ( $scon(%Lond.x).cid != %Lond.cid ) {
              scon %Lond.x
              /*
              var %Lond.y 0
              while ( %lond.y < $nick($chan,0) ) {
                inc %Lond.y
                var %Lond.addr = $nick($chan,%Lond.y)
                var %Lond.addr = $address(%Lond.addr,0)
                if ( $ialchan(%lond.addr,$chan,1) ) {
                  var %Lond.hasmatch 1
                  echo buh! $nick
                }
              }
              if ( $nick !ison $chan && %Lond.hasmatch == $null ) {
                */
                msg $chan $nick has left $chan @  $+ %cor. [ $+ [ $scid(%Lond.cid).network ] ] $+ $scid(%Lond.cid).network $iif($1!=$null,( $+ $1- $+ ))
                ;    }
              }
            }
          }
        }

        on *:quit:{
          if ( $nick != $me && $newnick != $me ) {
            var %Lond.x 0
            var %Lond.cid = $cid
            var %Lond.tam = $scon(0)
            while ( %Lond.x < %Lond.tam ) {
              inc %Lond.x
              if ( $scon(%Lond.x).cid != %Lond.cid ) {
                scon %Lond.x
                /*
                var %Lond.y 0
                while ( %lond.y < $nick($chan,0) ) {
                  inc %Lond.y
                  var %Lond.addr = $nick($chan,%Lond.y)
                  var %Lond.addr = $address(%Lond.addr,0)
                  if ( $ialchan(%lond.addr,$chan,1) ) {
                    var %Lond.hasmatch 1
                    echo buh! $nick
                  }
                }
                if ( $nick !ison $chan && %Lond.hasmatch == $null ) {
                  */
                  var %Lond.y 0
                  while ( %Lond.y < $chan(0) ) {
                    inc %Lond.y
                    msg $chan(%Lond.y) $nick has quit  $+ %cor. [ $+ [ $scid(%Lond.cid).network ] ] $+ $scid(%Lond.cid).network ( $+ $1- $+ )
                  }
                  ;    }
                }
              }
            }
          }

          on *:TEXT:*:#:{
            var %Lond.x 0
            var %Lond.cid = $cid
            var %Lond.tam = $scon(0)
            if ( $strip($1) == sussurra || $strip($1) == sussurro || $strip($1) == !sussurra || $strip($1) == !sussurro || $left($strip($1),1) == $chr(252) || ($left($strip($1),1) == $chr(195) && $mid($strip($1),2,1) == $chr(188))) {
              halt
            }
            if ( $strip($1) == !whois || $strip($1) == !ajuda ) {
              halt
            }
            if ( $strip($1) == !who ) {
              var %Lond.who 1
            }
            if ( $strip($1) == !pvt ) {
              var %Lond.pvt 1
            }
            if ( $strip($1) == !kick ) {
              if ( $nick isop $chan ) {
                var %Lond.kick 1
              }
              else {
                msg $chan $nick $+ , você não é um op e portanto não tem permissão para fazer isto.
              }
            }
            if ( $strip($1) == !voice ) {
              if ( $nick isop $chan ) {
                var %Lond.voice 1
              }
              else {
                msg $chan $nick $+ , você não é um op e portanto não tem permissão para fazer isto.
              }
            }
            ;if ( ( $1- != %Lond.lastmsg || $nick != %Lond.lastnick ) && ( $1- != %Lond.lastmsg1 || $nick != %Lond.lastnick1 ) && ( $1- != %Lond.lastmsg2 || $nick != %Lond.lastnick2 ) ) {
            var %Lond.symbol $left($nick(#,$nick).pnick,1)
            var %Lond.symbols = !@%+
            if ( %Lond.symbol isin %Lond.symbols ) {
              %Lond.symbol = 15 $+ %Lond.symbol $+ 
            }
            else {
              %Lond.symbol = $null
            }
            ;}
            ;  var %Lond.ident = $+(*!*,$remove($gettok($address,1,64),$chr(126)),*@*)
            while ( %Lond.x < %Lond.tam ) {
              inc %Lond.x
              if ( $scon(%Lond.x).cid != %Lond.cid ) {
                scon %Lond.x
                if ( %Lond.who == 1 ) {
                  var %Lond.z 0
                  var %Lond.who = $null
                  while ( %Lond.z < $nick($chan,0) ) {
                    inc %Lond.z
                    if ( $nick($chan,%Lond.z) != $me ) {
                      var %Lond.who = $addtok(%Lond.who, $chr(32) $nick($chan,%Lond.z),44)
                    }
                  }
                  var %Lond.who = Who is @  $+ %cor. [ $+ [ $scon(%Lond.x).network ] ] $+ $scid(%Lond.x).network $+ : %Lond.who
                  scon %Lond.cid
                  .msg $nick %Lond.who
                  continue
                }
                if ( %Lond.pvt == 1 ) {
                  .msg $strip($2) < $+ [ $nick ] $+ > $3-
                  continue
                }
                /*
                var %Lond.y 0
                while ( %lond.y < $nick($chan,0) ) {
                  inc %Lond.y
                  var %Lond.addr = $nick($chan,%Lond.y)
                  var %Lond.addr = $address(%Lond.addr,0)
                  if ( $ialchan(%lond.addr,$chan,1) ) {
                    var %Lond.hasmatch 1
                    echo buh! $nick
                  }
                }
                if ( $nick !ison $chan && %Lond.hasmatch == $null ) {
                  */
                  ;if ( ( $1- != %Lond.lastmsg || $nick != %Lond.lastnick ) && ( $1- != %Lond.lastmsg1 || $nick != %Lond.lastnick1 ) && ( $1- != %Lond.lastmsg2 || $nick != %Lond.lastnick2 ) ) {
                  var %Lond.frasetmp = $1-
                  set %Lond.nc.canal $chan
                  ;Se o ultimo caracter da primeira palavra for : ,
                  if ( $right($strip($gettok(%Lond.frasetmp,1,32),burc),1) == $chr(58) || $right($strip($gettok(%Lond.frasetmp,1,32),burc),1) == $chr(44) ) {
                    ;se o primeiro caracter NÃO for §
                    if ( $left($strip($gettok(%Lond.frasetmp,1,32),burc),1) != $chr(167) ) {
                      ;Copia o resto da frase pra outra variável, e chama o nick completion com a primeira palavra.
                      var %Lond.frasetmp2 $deltok(%Lond.frasetmp,1,32)
                      var %Lond.nicktmp $Lond.nickcompletion($strip($left($strip($gettok(%Lond.frasetmp,1,32),burc),-1),burc))

                      if ( %Lond.nicktmp == $left($strip($gettok(%Lond.frasetmp,1,32),burc),-1) ) {
                        unset %Lond.nicktmp
                      }
                      else {
                        var %Lond.frasetmp = $instok(%Lond.frasetmp2,$replace($gettok(%Lond.frasetmp,1,32),$left($strip($gettok(%Lond.frasetmp,1,32)),-1),%Lond.nicktmp),1,32)
                      }
                    }
                    else {
                      var %Lond.frasetmp2 $deltok(%Lond.frasetmp,1-2,32)
                      var %Lond.nicktmp $lond.nickcompletion($left($gettok(%Lond.frasetmp,1-2,32),-1))
                      var %Lond.frasetmp %Lond.nicktmp $+ $right($gettok(%Lond.frasetmp,1-2,32),1) %Lond.frasetmp2
                      unset %Lond.nicktmp
                    }
                    if ( %Lond.nc.tmp != $null ) {
                      unset %Lond.nc.depois
                    }
                  }
                  if ( $right($strip($gettok(%Lond.frasetmp,2,32),burc),1) == $chr(58) || $right($strip($gettok(%Lond.frasetmp,2,32),burc),1) == $chr(44) ) {
                    if ( %Lond.nicktmp == $null ) {
                      if ( $left($strip($gettok(%Lond.frasetmp,1,32),burc),1) != $chr(167) ) {
                        var %Lond.frasetmp2 $deltok(%Lond.frasetmp,2,32)
                        var %Lond.nicktmp $Lond.nickcompletion($strip($left($strip($gettok(%Lond.frasetmp,2,32),burc),-1),burc))

                        if ( %Lond.nicktmp == $left($strip($gettok(%Lond.frasetmp,2,32),burc),-1) ) {
                          unset %Lond.nicktmp
                        }
                        else {
                          var %Lond.frasetmp = $instok(%Lond.frasetmp2,$replace($gettok(%Lond.frasetmp,2,32),$left($strip($gettok(%Lond.frasetmp,2,32)),-1),%Lond.nicktmp),2,32)
                        }
                      }
                      else {
                        var %Lond.frasetmp2 $deltok(%Lond.frasetmp,1-2,32)
                        var %Lond.nicktmp $lond.nickcompletion($left($gettok(%Lond.frasetmp,1-2,32),-1))
                        var %Lond.frasetmp %Lond.nicktmp $+ $right($gettok(%Lond.frasetmp,1-2,32),1) %Lond.frasetmp2
                        unset %Lond.nicktmp
                      }

                    }
                  }
                  msg $chan < $+ %Lond.symbol $+ $nick @  $+ %cor. [ $+ [ $scid(%Lond.cid).network ] ] $+ $scid(%Lond.cid).network $+ > %Lond.frasetmp
                  ;}
                  ;else {
                  ;  break
                  ;}
                  if ( %Lond.kick == 1 ) {
                    k $strip($2) Kick a pedido de $nick $+ . $iif(($3 != $null),Motivo: $3-)
                    continue
                  }
                  if ( %Lond.voice == 1 ) {
                    mode # +vvv $strip($2) $strip($3) $strip($4)
                  }
                  ;    }
                }
              }
              ;if ( ( $1- != %Lond.lastmsg || $nick != %Lond.lastnick ) && ( $1- != %Lond.lastmsg1 || $nick != %Lond.lastnick1 ) && ( $1- != %Lond.lastmsg2 || $nick != %Lond.lastnick2 ) ) {
              ;  %Lond.lastmsg2 = %Lond.lastmsg1
              ;  %Lond.lastnick2 = %Lond.lastnick1
              ;  %Lond.lastmsg1 = %Lond.lastmsg
              ;  %Lond.lastnick1 = %Lond.lastnick
              ;  %Lond.lastmsg = $1-
              ;  %Lond.lastnick = $nick
              ;}
            }

            on *:ACTION:*:#:{
              var %Lond.x 0
              var %Lond.cid = $cid
              var %Lond.tam = $scon(0)
              if ( $strip($1) == sussurra || $strip($1) == sussurro || $strip($1) == !sussurra || $strip($1) == !sussurro || $left($strip($1),1) == $chr(252) ) {
                halt
              }
              ;  var %Lond.ident = $+(*!*,$remove($gettok($address,1,64),$chr(126)),*@*)
              while ( %Lond.x < %Lond.tam ) {
                inc %Lond.x
                if ( $scon(%Lond.x).cid != %Lond.cid ) {
                  scon %Lond.x
                  /*
                  var %Lond.y 0
                  while ( %lond.y < $nick($chan,0) ) {
                    inc %Lond.y
                    var %Lond.addr = $nick($chan,%Lond.y)
                    var %Lond.addr = $address(%Lond.addr,0)
                    if ( $ialchan(%lond.addr,$chan,1) ) {
                      var %Lond.hasmatch 1
                      echo buh! $nick
                    }
                  }
                  if ( $nick !ison $chan && %Lond.hasmatch == $null ) {
                    */
                    if ( ( $1- != %Lond.lastact || $nick != %Lond.lastnicka ) && ( $1- != %Lond.lastact1 || $nick != %Lond.lastnicka1 ) && ( $1- != %Lond.lastact2 || $nick != %Lond.lastnicka2 ) ) {
                      msg $chan 6* $nick @  $+ %cor. [ $+ [ $scid(%Lond.cid).network ] ] $+ $scid(%Lond.cid).network 6 $+ $1-
                    }
                    else {
                      break
                    }
                    ;    }
                  }
                }
                if ( ( $1- != %Lond.lastmsg || $nick != %Lond.lastnick ) && ( $1- != %Lond.lastmsg1 || $nick != %Lond.lastnick1 ) && ( $1- != %Lond.lastmsg2 || $nick != %Lond.lastnick2 ) ) {
                  %Lond.lastact2 = %Lond.lastact1
                  %Lond.lastnicka2 = %Lond.lastnicka1
                  %Lond.lastact1 = %Lond.lastact
                  %Lond.lastnicka1 = %Lond.lastnicka
                  %Lond.lastact = $1-
                  %Lond.lastnicka = $nick
                }
              }
