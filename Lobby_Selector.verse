using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }

lobby_manager := class(creative_device):

    # Les 4 zones de ton lobby
    @editable ZoneBlue : mutator_zone_device = mutator_zone_device{}
    @editable ZoneRed : mutator_zone_device = mutator_zone_device{}
    @editable ZoneYellow : mutator_zone_device = mutator_zone_device{}
    @editable ZoneGreen : mutator_zone_device = mutator_zone_device{}

    # Un seul appareil de message pour tout le monde
    @editable HUDMessage : hud_message_device = hud_message_device{}

    # Messages en Anglais (localizes obligatoire pour les messages ATH)
    MsgJoinedBlue<localizes> : message = "YOU JOINED TEAM BLUE!"
    MsgJoinedRed<localizes> : message = "YOU JOINED TEAM RED!"
    MsgJoinedYellow<localizes> : message = "YOU JOINED TEAM YELLOW!"
    MsgJoinedGreen<localizes> : message = "YOU JOINED TEAM GREEN!"
    MsgTeamFull<localizes> : message = "TEAM IS FULL! PLEASE CHOOSE ANOTHER ONE."

    # Variables pour compter les joueurs
    var CountBlue : int = 0
    var CountRed : int = 0
    var CountYellow : int = 0
    var CountGreen : int = 0

    OnBegin<override>() : void =
        # On surveille les entrées et les sorties
        ZoneBlue.AgentEntersEvent.Subscribe(OnEnterBlue)
        ZoneBlue.AgentExitsEvent.Subscribe(OnExitBlue)
        
        ZoneRed.AgentEntersEvent.Subscribe(OnEnterRed)
        ZoneRed.AgentExitsEvent.Subscribe(OnExitRed)
        
        ZoneYellow.AgentEntersEvent.Subscribe(OnEnterYellow)
        ZoneYellow.AgentExitsEvent.Subscribe(OnExitYellow)
        
        ZoneGreen.AgentEntersEvent.Subscribe(OnEnterGreen)
        ZoneGreen.AgentExitsEvent.Subscribe(OnExitGreen)

    # --- LOGIQUE ÉQUIPE BLEUE ---
    OnEnterBlue(Agent : agent) : void =
        if (CountBlue < 4):
            set CountBlue += 1
            HUDMessage.SetText(MsgJoinedBlue)
            HUDMessage.Show(Agent)
        else:
            HUDMessage.SetText(MsgTeamFull)
            HUDMessage.Show(Agent)
            # Optionnel : téléporte le joueur un peu plus loin si c'est plein

    OnExitBlue(Agent : agent) : void =
        set CountBlue -= 1

    # --- LOGIQUE ÉQUIPE ROUGE ---
    OnEnterRed(Agent : agent) : void =
        if (CountRed < 4):
            set CountRed += 1
            HUDMessage.SetText(MsgJoinedRed)
            HUDMessage.Show(Agent)
        else:
            HUDMessage.SetText(MsgTeamFull)
            HUDMessage.Show(Agent)

    OnExitRed(Agent : agent) : void =
        set CountRed -= 1

    # --- LOGIQUE ÉQUIPE JAUNE ---
    OnEnterYellow(Agent : agent) : void =
        if (CountYellow < 4):
            set CountYellow += 1
            HUDMessage.SetText(MsgJoinedYellow)
            HUDMessage.Show(Agent)
        else:
            HUDMessage.SetText(MsgTeamFull)
            HUDMessage.Show(Agent)

    OnExitYellow(Agent : agent) : void =
        set CountYellow -= 1

    # --- LOGIQUE ÉQUIPE VERTE ---
    OnEnterGreen(Agent : agent) : void =
        if (CountGreen < 4):
            set CountGreen += 1
            HUDMessage.SetText(MsgJoinedGreen)
            HUDMessage.Show(Agent)
        else:
            HUDMessage.SetText(MsgTeamFull)
            HUDMessage.Show(Agent)

    OnExitGreen(Agent : agent) : void =
        set CountGreen -= 1