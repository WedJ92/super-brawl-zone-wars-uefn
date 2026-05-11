using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }
using { /Verse.org/Simulation }
using { /Verse.org/Random }

stuff_aleatoire := class(creative_device):

    @editable ChronoDepart : timer_device = timer_device{}
    @editable PlaquesDeSpawn : []player_spawner_device = array{}
    @editable FournisseurArmes : item_granter_device = item_granter_device{}
    @editable FournisseurItems : item_granter_device = item_granter_device{}
    @editable FournisseurSoins : item_granter_device = item_granter_device{}

    # Les 2 appareils message d'ATH dans ta scène
    @editable HudReady : hud_message_device = hud_message_device{}
    @editable HudFight : hud_message_device = hud_message_device{}

    OnBegin<override>() : void =
        ChronoDepart.SuccessEvent.Subscribe(LancerLeMatch)

    LancerLeMatch(MaybePlayer : ?agent) : void =
        AllPlayers := GetPlayspace().GetPlayers()
        for (Index -> Player : AllPlayers):
            DonnerStuffAleatoire(Player)
            if (PlaqueCible := PlaquesDeSpawn[Index]):
                TeleporterEtFiger(Player, PlaqueCible)
        spawn:
            LibererJoueursApresDelai()

    TeleporterEtFiger(Player : player, Plaque : player_spawner_device) : void =
        if (Character := Player.GetFortCharacter[]):
            TransformPlaque := Plaque.GetTransform()
            if (Character.TeleportTo[TransformPlaque.Translation, TransformPlaque.Rotation]):
                Character.PutInStasis(stasis_args{})

    LibererJoueursApresDelai() <suspends> : void =
        AllPlayers := GetPlayspace().GetPlayers()

        # Afficher READY
        for (Player : AllPlayers):
            HudReady.Show(Player)

        Sleep(2.0)

        # Cacher READY + afficher FIGHT
        for (Player : AllPlayers):
            HudReady.Hide(Player)
            HudFight.Show(Player)

        Sleep(1.0)

        # Libérer les joueurs + cacher FIGHT
        for (Player : AllPlayers):
            if (Character := Player.GetFortCharacter[]):
                Character.ReleaseFromStasis()
            HudFight.Hide(Player)

    DonnerStuffAleatoire(Player : player) : void =
        IndexArme := GetRandomInt(0, 9)
        FournisseurArmes.SetNextItem(IndexArme)
        FournisseurArmes.GrantItem(Player)
        IndexItem := GetRandomInt(0, 7)
        FournisseurItems.SetNextItem(IndexItem)
        FournisseurItems.GrantItem(Player)
        IndexSoin := GetRandomInt(0, 6)
        FournisseurSoins.SetNextItem(IndexSoin)
        FournisseurSoins.GrantItem(Player)