open util/relation

sig User {
    follows: set User,
    sees: set Photo,
    posts: set Photo,
    suggested: set User
}

sig Influencer extends User {}

sig Photo {
    date: one Day
}

sig Ad extends Photo {}
sig Day {}

pred EveryPhotoIsPostedByOneUser {
    // Photo muss von ein User gepostet werden und
    // ein Photo kann nicht von mehreren Nutzern gepostet werden

    // surjective[posts, Photo] and injective[posts,Photo]

    // This should be equivilant to (according to docs):
    bijective[posts, Photo]
}

pred UserCannotFollowItself {
    irreflexive[follows]
}

pred UserSeesOnlyPhotosOfFollowers {
    // Wenn ein Nutzer ein Nutzer folgt, folgt daraus, dass der folgende Nutzer
    // die Bilder des gefolgten sehen kann. 
    // D.h. eine sees-Relation impliziert, dass der Nutzer der das Bild sieht,
    // dem Poster des Bildes folgt.  Eine folgen-Relation impliziert, dass ich
    // eine Relation in sees zu den Bildern meines Followers habe.
    //  Jedes Foto ist einsehbar bei den followern seines Posters
    all u: User | u.sees = (u.follows.posts)
}

fun poster[p: Photo]: User {
    posts.p
}

pred IfUserPostsAnAdThenAllPostsOfThisUserShallBeAds {
    // Für jede Ad die gepostet wurde folgt, dass deren Poster ausschließlich Ad
    // posten darf.
    // D.h. Photo und Ad schließen sich gegenseitig aus.
    all ad: Ad | ad.poster.posts in Ad
}

pred InfluencersAreFollowedByEveryoneElse {
    // Für jeden Nutzer gilt, dass alle Influencer (die Menge Influencer) in
    // seiner folgen-Menge ist. "- u" verhindert, dass ein Influencer (welcher
    // auch eine Nutzter ist) sich selbst folgen muss - was im Konflikt mit
    // UserCannotFollowItself steht.
    all u: User | (Influencer - u) in u.follows
}

pred InfluencersPostEveryDay {
    // Jeder Post/Photo eines Influencers muss zu allen Daten mappen.
    // Anders ausgedrückt: Jeder Tag muss von einem Influencer über Posts erreichbar sein.
    all i: Influencer | Day in i.posts.date
}

pred SuggestedUsers {
    all u: User | u.suggested = (u.follows.follows - u.follows - u)
}

pred UserOnlySeesAdsFromFollowedOrSuggestedUsers {
    // all u: User | u.sees.
    // (Influencer$2.sees & Ad).poster

    // Das ist so ziemlich das selbe wie UserSeesOnlyPhotosOfFollowers
    // Ein User sieht nur die Ad-Posts seiner gefolgten User und der vorgeschlagenen User
    all u: User | u.sees = (u.(follows + suggested).posts & Ad)
}

run {
    EveryPhotoIsPostedByOneUser
    UserCannotFollowItself
    UserSeesOnlyPhotosOfFollowers
    IfUserPostsAnAdThenAllPostsOfThisUserShallBeAds
    InfluencersAreFollowedByEveryoneElse
    InfluencersPostEveryDay
    SuggestedUsers
    UserOnlySeesAdsFromFollowedOrSuggestedUsers
} // for exactly 3 Influencer, 3 User, 3 Ad, 3 Photo, 3 Day