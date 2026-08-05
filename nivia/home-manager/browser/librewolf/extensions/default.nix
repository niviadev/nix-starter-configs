# TODO backup/persist extension settings

{ lib, ... }:
let
  extStruct = tuple:
    let
      shortId   = builtins.elemAt tuple 0;
      uuid      = builtins.elemAt tuple 1;
      overrides = builtins.elemAt tuple 2; #FIXME any way to make this optional?
    in
    {
      name = uuid;
      value = {
        default_area = "menupanel";
        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
        installation_mode = "force_installed";
        private_browsing = true;
      } // overrides;
    };

  extensions = [
    # To add additional extensions one needs shortID and UUID.
    # short ID is in URL:
    # - https://addons.mozilla.org/en-US/firefox/addon/${shortId}/
    # UUID is at the bottom of the page:
    # - More information > add-on links > "Copy add-on ID"
    # - alternatively in browser:
    # -- about:debugging#/runtime/this-firefox 
    # -- uuid = extensionID (not Internal UUID)      

    ### UX ###
    [ "simple-tab-groups" "simple-tab-groups@drive4ik" {} ]
    [ "bonjourr-startpage" "{4f391a9e-8717-4ba6-a5b1-488a34931fcb}" { private_browsing = false; } ] # TODO use sync feature for backups
    [ "darkreader" "addon@darkreader.org" { default_area = "navbar"; } ]
    [ "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" {} ]
    [ "sixindicator" "{8c9cad02-c069-4e93-909d-d874da819c49}" {} ] # show if IP6 is used
    #[ "deadname-remover" "deadname-remover@willhaycode.com" {} ]
    #[ "downthemall" "{DDC359D1-844A-42a7-9AA1-88A850A938A8}" {} ]
    #[ "fastforwardteam" "addon@fastforward.team" {} ]
    #[ "terms-of-service-didnt-read" "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack" {} ] # give un-legalesed info on TOS
    
    ### TOOLS ###
    [ "search_by_image" "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}" {} ] # reverse image search
    #[ "temp-mail" "{2d97895d-fcd3-41ab-82e6-6a1d4d2243f6}" {} ]
    #[ "user-agent-string-switcher" "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" {} ]
    ### PRIVACY ###
    [ "ublock-origin" "uBlock0@raymondhill.net" { default_area = "navbar"; } ]
    #["umatrix" "uMatrix@raymondhill.net" {} ]
    [ "canvasblocker" "CanvasBlocker@kkapsner.de" {} ]
    #[ "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}" {} ] # remove tracking from URLs automatically
    #[ "consent-o-matic" "gdpr@cavi.au.dk" {} ] # autoselect cookie consent
    [ "noscript" "{73a6fe31-595d-460b-a920-fcc0f8843232}" {} ]
    #[ "localcdn-fork-of-decentraleyes" "{b86e4813-687a-43e6-ab65-0bde4ab75758}" {} ]
    #[ "libredirect" "7esoorv3@alefvanoon.anonaddy.me" {} ]
    #[ "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack" {} ]
    
    ### PASSWORD MANAGER ###
    [ "keepassxc-browser" "keepassxc-browser@keepassxc.org" {} ]
    #[ "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}" {} ]
    ### YOUTUBE ###
    [ "sponsorblock" "sponsorBlocker@ajay.app" {} ]
    [ "enhancer-for-youtube" "enhancerforyoutube@maximerf.addons.mozilla.org" {} ]
    [ "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" {} ]
    [ "youtube-shorts-block" "{34daeb50-c2d2-4f14-886a-7160b24d66a4}" {} ]
    ### TORRENT ###
    #[ "debrid-link-plugin" "jid1-6kU7yIbrTcZvJg@jetpack" {} ]
    ### SOLIDARITY ###
    [ "torproject-snowflake" "{b11bea1f-a888-4332-8d8a-cec2be7d24b9}" {} ] # requires consenting once on first run
  ];
in
{
  programs.librewolf = {
    policies.ExtensionSettings = lib.listToAttrs (map extStruct extensions);

    settings = {
      "browser.startup.homepage" = "moz-extension://ea86149b-2370-48b6-97dc-a069288eb0f5/index.html";
      "browser.startup.homepage_override.extensionControlled" = true;
    };
  };
}