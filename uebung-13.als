open util/ordering[Haus]

enum Haustier { Hund, Schnecken, Fuchs, Pferd, Zebra }
enum Zigaretten { OldGold, Kools, Chesterfields, LuckyStrike, Parliaments }
enum Getraenk { Kaffee, Tee, Milch, OrangenSaft, Wasser }
enum Nummer { Eins, Zwei, Drei, Vier, Fuenf }

abstract sig Haus { 
    bewohner: Landsmann,
    nachbar: Haus,
    nummer: Nummer
}    
sig RotesHaus, WeißesHaus, GruenesHaus, GelbesHaus, BlauesHaus extends Haus {}

abstract sig Landsmann { 
    haelt: Haustier,
    trinkt: Getraenk,
    raucht: Zigaretten
}
sig Englaender, Spanier, Ukrainer, Norweger, Japaner extends Landsmann {}


fact englaender_lebt_im_roten_haus {
    RotesHaus.bewohner = Englaender
}

fact spanier_hat_einen_hund {
    Spanier.haelt = Hund
}

fact kaffee_im_gruenen_haus {
    GruenesHaus.bewohner.trinkt = Kaffee
}

fact ukrainer_trinkt_tee {
    Ukrainer.trinkt = Tee
}

fact gruenes_haus_links_vom_weißen_haus {
    GruenesHaus.next = WeißesHaus and WeißesHaus.prev = GruenesHaus
}

fact old_gold_raucher_haelt_schnecken {
    // Landsmann.haelt = Schnecken and Landsmann.raucht = OldGold
}

fact kools_im_gelben_haus {
    // GelbesHaus.bewohner.Zigaretten = Kools
}

fact milch_im_mittleren_haus {
    Milch implies Drei
}

fact norweger_im_ersten_haus {

}

fact chesterfield_raucher_wohnt_neber_fuchs_besitzer {

}

run {}
