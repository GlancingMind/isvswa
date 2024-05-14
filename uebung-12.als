enum Name { Felderer, Schneehorn, Borken, Weldberg }
enum Land { Barunien, Gorabien, Seborien, Lusanien}
enum Eigenschaft { Steinhaufen, GigantischerFelsen, See, Huette}
enum Hoehe { H2317, H2518, H2128, H2222}

sig Berg {
    name: Name,
    land: Land,
    hoehe: Hoehe,
    eigenschaft: Eigenschaft
} 
// {
//     all disj other: Berg | this.name != other.name
// }

// Hätte dies gerne als implicit fact, aber habs nicht hinbekommen 😭😭😭
fact EinzigarteAttribute {
    all disj b1, b2: Berg |
            b1.name != b2.name 
        and b1.land != b2.land
        and b1.hoehe != b2.hoehe
        and b1.eigenschaft != b2.eigenschaft
}

assert EinzigarteAttribute {
    no disj b1, b2: Berg |
            b1.name = b2.name 
        and b1.land = b2.land
        and b1.hoehe = b2.hoehe
        and b1.eigenschaft = b2.eigenschaft
}
check EinzigarteAttribute

fact felderer_hat_keinen_steinhaufen {
    all b: Berg | b.name = Felderer implies b.eigenschaft != Steinhaufen
}

fact berg_in_barunien_ist_weder_schneehorn_noch_2317m {
    all b: Berg | b.land = Barunien implies b.name != Schneehorn and b.hoehe != H2317
}

fact gigantischer_felsen {
    some b: Berg | GigantischerFelsen in b.eigenschaft
}

fact weder_berg_in_gorabien_noch_felderer_sind_2518m {
    all b: Berg | b.hoehe = H2518 implies (b.land != Gorabien and b.name != Felderer)
}

fact berg_in_seborien_ist_2128m_hoch {
    some b: Berg | b.land = Seborien and b.hoehe = H2128
}

fact schneehorn_ist_nicht_2222m_hoch {
    all b: Berg | b.name = Schneehorn implies b.hoehe != H2222
}

fact berg_mit_huette_ist_weder_2222m_noch_der_borken_noch_in_seborien {
    all b: Berg | b.eigenschaft = Huette implies (b.hoehe != H2222 and b.name != Borken and b.land != Seborien)
}

fact berg_in_gorabien_ist_nicht_2317m {
    all b: Berg | b.land = Gorabien implies b.hoehe != H2317
}

fact weder_auf_dem_2222m_berg_noch_auf_dem_borken_gibt_es_einen_see {
    all b: Berg | b.eigenschaft = See implies (b.hoehe != H2222 and b.name != Borken)
}

fact es_gab_einen_weldberg {
    some b: Berg | b.name = Weldberg
}

fact in_lusanien_steht_der_borken {
    some b: Berg | b.name = Borken and b.land = Lusanien
}

run {} for exactly 4 Berg