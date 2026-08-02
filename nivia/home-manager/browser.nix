{
  lib,
  config,
  name,
  pkgs,
  ...
}:
{
  programs.librewolf = {
    # TODO learn and use about:profiles
    enable = true;

    # https://firefox-source-docs.mozilla.org/index.html
    # https://mozilla.github.io/policy-templates/
    # https://mynixos.com/home-manager/option/programs.firefox.policies
    # TODO go through all policies and review which of them should be set as policy, and which as settings
    policies = {
      # TODO go through the ideas here
      # https://mozilla.github.io/policy-templates/#bookmarks
      # https://mozilla.github.io/policy-templates/#captiveportal
      # TODO implement but not as policy? https://mozilla.github.io/policy-templates/#handlers
    
      # option for browsercrimes https://mozilla.github.io/policy-templates/#localfilelinks 
      # https://superuser.com/questions/1617161/how-to-enable-local-file-links-in-firefox-on-windows
      # https://superuser.com/questions/1513156/how-do-i-instruct-firefox-to-allow-me-to-open-file-urls-on-a-localhost-serve

      # ui-crimes https://mozilla.github.io/policy-templates/#managedbookmarks

      # TODO https://mozilla.github.io/policy-templates/#preferences
      # TODO https://mozilla.github.io/policy-templates/#proxy  
      # TODO https://mozilla.github.io/policy-templates/#searchengines
      # TODO https://mozilla.github.io/policy-templates/#securitydevices
      
      ###############
      ### PRIVACY ###
      ###############
      "AIControls.default" = {
        "Value" = "blocked";
        "Locked" = true;
      };
      "GenerativeAI" = {
        "Enabled" = false;
        "Locked" = true;
      };

      # using DNScrypt in ../nixos/networking/dns.nix already; prevent from mistakenly turning this on
      "DNSOverHTTPS" = {
        "Enabled" = false;
        "Locked" = true;
      };

      #tracking
      "DisableFeedbackCommands" = true;
      #"DisableFirefoxAccounts" = true; # TODO first move everything out of firefox acc and backup regularly
      "DisableFirefoxStudies" = true;
      "DisableRemoteImprovements" = false; # ! - there are ~emergency-hotfixes, we want that
      "DisableTelemetry" = true;
      "EnableTrackingProtection" = {
        "Value" = true;
        "Locked" = true;
        "Category"= "strict"; # this might make all further values redundant
        #"Cryptomining" = true;
        #"Fingerprinting" = true;
        #"EmailTracking" = true;
        #"SuspectedFingerprinting"= true;
        "BaselineExceptions"= false;
        "ConvenienceExceptions"= false;
        #"Exceptions"= ["https://example.com"];
      };
      "FirefoxSuggest" = {
        "WebSuggestions" = false;
        "SponsoredSuggestions" = false;
        "ImproveSuggest" = false;
        "Locked"= true;
      };
      "IPProtectionAvailable" = false; 
      "SanitizeOnShutdown" = {
        #"Cache" = false;
        "Cookies" =  true;
        #"FormData" = false;
        #"History" = false;
        #"Sessions" = false;
        #"SiteSettings" = false;
        "Locked" = true;
      };
      "VisualSearchEnabled" = false; # google lens bloatware
      
      ################
      ### security ###
      ################
      "AutofillCreditCardEnabled" = false;
      "DisableMasterPasswordCreation" = true; # use password manager instead
      #"PrimaryPassword" = false; # obsolete; DisableMasterPasswordCreation takes precedent
      "OfferToSaveLogins" = false;
      "PasswordManagerEnabled" = false;

      ##########
      ### UX ###
      ##########
      "DefaultDownloadDirectory" = "/home/nivia/Downloads";
      "PromptForDownloadLocation" = false;

      # TODO research newtab deeper
      "NewTabPage" = true;
      "FirefoxHome" = {
        #"Search": true,
        #"TopSites": true,
        "SponsoredTopSites" = false;
        "Highlights" = false;
        #"Pocket": true | false,
        "Stories" = false;
        "SponsoredPocket" = false;
        "SponsoredStories" = false;
        #"Snippets": true | false,
        "Locked" = false;
      };
      "RequestedLocales" = "en-US, de, tok";
      # "NoDefaultBookmarks" = true;
      
      "DisableSetDesktopBackground" = true; # declutter UI
      "DisplayBookmarksToolbar" = "newtab";
      "OverridePostUpdatePage" = ""; # TODO check if firefox updates get too annoying / are hostile to privacy
      "SearchBar" = "unified";
      "SkipTermsOfUse" = true;
      #"UseSystemPrintDialog" = true; # TODO make sure to have a good system print dialog as we rely on that
      "policies"."UserMessaging" = { #TODO check if its actually policies.
        "ExtensionRecommendations" = false;
        "FeatureRecommendations" = false;
        "UrlbarInterventions" = false;
        "SkipOnboarding" = true;
        "MoreFromMozilla" =  false;
        "FirefoxLabs" = false;
        "Locked" = true;
      };

      ##############
      ### SEARCH ###
      ##############
      SearchEngines = {
        PreventInstalls = false;
        Remove = [
          "Google"
          "Bing"
          "Amazon.com"
          "eBay"
          "Twitter"
          "MetaGer"
          "StartPage"
          "4get.ca (captcha)"
          "DuckDuckGo Lite"
        ];
        Default = "DuckDuckGo";
        Add = [
          # TODO searXNG https://searx.be/
          # TODO https://metager.org/
          # translate
          {
            Name = "wordreference_en-de";
            Description = "translate en to de";
            Alias = "ende";
            Method = "GET";
            URLTemplate = "https://www.wordreference.com/ende/{searchTerms}";
            IconURL = "https://wordreference.com/favicon.ico";
          }
          {
            Name = "wordreference_de-en";
            Description = "translate de to en";
            Alias = "ende";
            Method = "GET";
            URLTemplate = "https://www.wordreference.com/deen/{searchTerms}";
            IconURL = "https://wordreference.com/favicon.ico";
          }
          {
            Name = "NixOS packages";
            Description = "the largest software collection in the world";
            Alias = "np";
            Method = "GET";
            URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
            IconURL = "https://search.nixos.org/favicon.ico";
          }
          {
            Name = "Noogle";
            Description = "Search for nix functions by name.";
            Alias = "noo";
            Method = "GET";
            URLTemplate = "https://noogle.dev/q?term={searchTerms}";
            IconURL = "https://noogle.dev/favicon.ico";
          }
          {
            Name = "Home Manager Options Search";
            Description = "Search for home manager options by name.";
            Alias = "nh";
            Method = "GET";
            URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}";
            IconURL = "https://home-manager-options.extranix.com/favicon.ico";
          }
          {
            Name = "NixOS options";
            Description = "search NixOS options by name or description";
            Alias = "nio";
            Method = "GET";
            URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
            IconURL = "https://search.nixos.org/favicon.org";
          }
          {
            Name = "YouTube";
            Description = "Search for videos on YouTube.";
            Alias = "yt";
            Method = "GET";
            URLTemplate = "https://www.youtube.com/results?search_query={searchTerms}&page={startPage?}&utm_source=opensearch";
            IconURL = "https://youtube.com/favicon.ico";
          }
          {
            Name = "YouTube Music";
            Description = "search for songs on YouTube Music";
            Alias = "ytm";
            Method = "GET";
            URLTemplate = "https://music.youtube.com/search?q={searchTerms}&utm_source=opensearch";
            IconURL = "https://music.youtube.com/favicon.ico";
          }
          {
            Name = "GitHub";
            description = "Search GitHub";
            Alias = "gh";
            Method = "GET";
            URLTemplate = "https://github.com/search?q={searchTerms}&ref=opensearch";
            IconURL = "https://github.com/favicon.ico";
          }
          {
            Name = "Wikipedia";
            Alias = "wk";
            Method = "GET";
            URLTemplate = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}&sourceid=Mozilla-search";
            Description = "one search away from the knowledge of the world!";
          }
          {
            Name = "PsychonautWiki";
            Description = "search for anything psychoactive";
            Alias = "psy";
            Method = "GET";
            URLTemplate = "https://psychonautwiki.org/w/index.php?title=Special:Search&search={searchTerms}";
            IconURL = "https://psychonautwiki.org/favicon.org";
          }
          {
            Name = "IETF datatracker";
            Description = ""; #TODO
            Alias = "rfc";
            Method = "GET";
            URLTemplate = "https://datatracker.ietf.org/doc/html/rfc{searchTerms}";
            IconURL = "https://ietf.org/favicon.ico";
          }
          {
            Name = "1337x";
            Description = "liberate media";
            Alias = "1337";
            Method = "GET";
            URLTemplate = "https://1337x.to/search/{searchTerms}/1/";
            IconURL = "https://1337x.to/favicon.ico";
          }
        ];
      };

      ##################
      ### EXTENSIONS ###
      ##################
      ExtensionSettings = {
        # To add additional extensions, find it on addons.mozilla.org, find
        # the short ID in the url
        # (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
        # then to find the extension UUID, go to
        # about:debugging#/runtime/this-firefox in your browser and grab the
        # extension ID, not the Internal UUID
        "uBlock0@raymondhill.net" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };

        /*
          TODO add some of these extensions
          ExtensionSettings = lib.listToAttrs [
            #(extension "simple-tab-groups" "simple-tab-groups@drive4ik")
            #(extension "umatrix" "uMatrix@raymondhill.net")
            (extension "clearurls" "{74145f27-f039-47ce-a470-a662b129930a}")
            #(extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
            #(extension "bonjourr-startpage" "{4f391a9e-8717-4ba6-a5b1-488a34931fcb}")
            #(extension "canvasblocker" "CanvasBlocker@kkapsner.de")
            #(extension "consent-o-matic" "gdpr@cavi.au.dk")
            #(extension "deadname-remover" "deadname-remover@willhaycode.com")
            #(extension "debrid-link-plugin" "jid1-6kU7yIbrTcZvJg@jetpack")
            #(extension "downthemall" "{DDC359D1-844A-42a7-9AA1-88A850A938A8}")
            #(extension "duckduckgo-for-firefox" "ddg@search.mozilla.org")
            #(extension "fastforwardteam" "addon@fastforward.team")
            #(extension "firefox-translations" "firefox-translations-addon@mozilla.org")
            #(extension "localcdn-fork-of-decentraleyes" "{b86e4813-687a-43e6-ab65-0bde4ab75758}")
            #(extension "libredirect" "7esoorv3@alefvanoon.anonaddy.me")
            (extension "privacy-badger17" "jid1-MnnxcxisBPnSXQ@jetpack")
            #(extension "search_by_image" "{2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c}")
            #(extension "sixindicator" "{8c9cad02-c069-4e93-909d-d874da819c49}")
            #(extension "torproject-snowflake" "{b11bea1f-a888-4332-8d8a-cec2be7d24b9}")
            (extension "sponsorblock" "sponsorBlocker@ajay.app")
            #(extension "styl-us" "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}")
            #(extension "temp-mail" "{2d97895d-fcd3-41ab-82e6-6a1d4d2243f6}")
            #(extension "terms-of-service-didnt-read" "jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack")
            #(extension "user-agent-string-switcher" "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}")
            #(extension "darkreader" "addon@darkreader.org")
          ];
          */  
      };
    };
    settings = {
      # documentation 
      # https://kb.mozillazine.org/
      # https://firefox-admin-docs.mozilla.org/reference/policies/ 
      # https://support.mozilla.org/en-US/questions/983116 


      ###############
      # preferences #
      ###############
      "alerts.totalOpenTime" = 2500;
      
      # this is a nice feature :3
      "accessibility.typeaheadfind" = true;
      #"accessibility.typeaheadfind.soundURL" = "home/nivia/Downloads/sample-3s.wav"; #TODO figure out how to have own sound here, for the lulz
      
      # resume previous session
      "browser.startup.page" = 3; 


      ##########
      ### UX ###
      ##########
      "sidebar.verticalTabs" = true;
      

      # make link trans colored on keydown event
      "browser.active_color" = "#F5ABB9";

      # TODO configure startup, newtabpage
      #"browser.startup.homepage" = "https://duckduckgo.com";
      #"browser.newtabpage.enabled" = false;
      #"browser.newtab.preload" = false;
      #"browser.startup.homepage_override.extensionControlled" = false;
      #"browser.startup.homepage_override.privateAllowed" = true;

      # hide anooying feature popups
      "browser.eme.ui.firstContentShown" = true;
      "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
      "browser.protections_panel.infoMessage.seen" = true;
      "sidebar.old-sidebar.has-used" = true; #TODO check function

      # bookmarks
      #"browser.bookmarks.defaultLocation" = "1KCyr_fRt7-D"; # TODO figure out what this thing does
      "browser.toolbars.bookmarks.visibility" = "newtab";
      "browser.bookmarks.editDialog.confirmationHintShowCount" = 3;
      "browser.bookmarks.editDialog.showForNewBookmarks" = true;
      # "browser.bookmarks.showMobileBookmarks" = true; # TODO figure out if this requires a firefox account or alike
      
      # downloads
      "browser.download.autohideButton" = true;
      #"browser.download.dir" = "/home/nivia/Downloads"; #"${download_dir}"; TODO even required with policies?
      #"browser.download.lastDir" = "/home/nivia/Downloads"; #"${download_dir}"; TODO even required with policies?
      "browser.download.folderList" = 2;
      "browser.download.panel.shown" = false; # TODO figure out what this thing does
      "browser.download.useDownloadDir" = true; # direct download
      
      "browser.download.viewableInternally.enabledTypes" = "xml, svg, webp, avif, jxl"; # TODO is this even needed?
      "browser.download.viewableInternally.typeWasRegistered.avif" = true;
      "browser.download.viewableInternally.typeWasRegistered.webp" = true;
      # TODO figure out where in the settings default apps are defined (signal, matrix etc. links so they open in the app)
      

      # internationalization / locale
      "intl.accept_languages" = "en-US, en, de, tok";
      "intl.locale.requested" = "en-US, en, de, tok";
      "browser.translations.neverTranslateLanguages" = "en-US, de"; # TODO review
      
      # performance
      # force enable GPU acceleration
      "gfx.webrender.all" = true;


      ###########
      # privacy #
      ###########
      "app.normandy.enabled" = false;
      #"app.shield.optoutstudies.enabled" = false; # is set to true usually to allow users to opt out, but as fully block studies, this isnt necessary?
      # browser.dictionaries.download.url = "" # FIXME create a mirror of this?
      "browser.newtabpage.activity-stream.feeds.telemetry" = false;
      "browser.newtabpage.activity-stream.telemetry" = false;
      "browser.newtabpage.activity-stream.feeds.snippets" = false;
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
      "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
      "browser.newtabpage.activity-stream.default.sites" = "";
      "browser.safebrowsing.downloads.remote.block_potentially_unwanted" = false;
      "browser.safebrowsing.downloads.remote.block_uncommon" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;
      "browser.safebrowsing.downloads.remote.url" = "";
      "browser.safebrowsing.provider.google.reportMalwareMistakeURL" = "";
      "browser.safebrowsing.provider.google.reportPhishMistakeURL" = "";
      "browser.safebrowsing.provider.google.reportURL" = "";
      "browser.safebrowsing.provider.google4.dataSharingURL" = "";
      "browser.safebrowsing.provider.google4.reportMalwareMistakeURL" = "";
      "browser.safebrowsing.provider.google4.reportPhishMistakeURL" = "";
      "browser.safebrowsing.provider.google4.reportURL" = "";
      "browser.safebrowsing.provider.google5.reportMalwareMistakeURL" = "";
      "browser.safebrowsing.provider.google5.reportPhishMistakeURL" = "";
      "browser.safebrowsing.provider.google5.reportURL" = "";
      "browser.safebrowsing.provider.google5.updateURL" = "";
      "browser.safebrowsing.provider.mozilla.gethashURL" = "";
      "browser.safebrowsing.provider.mozilla.updateURL" = "";
      "browser.safebrowsing.reportPhishURL" = "";
      "browser.search.geoip.url" = "";
      "browser.region.network.url" = "";
      "browser.region.update.enabled" = false;
      "browser.ping-centre.telemetry" = false;
      "breakpad.reportURL" = "";
      "datareporting.dau.cachedUsageProfileGroupID" = "";
      "datareporting.dau.cachedUsageProfileID" = "";
      "datareporting.healthreport.service.enabled" = false;
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "datareporting.sessions.current.clean" = true;
      "devtools.onboarding.telemetry.logged" = false;
      "extensions.getAddons.cache.enabled" = false;
      "messaging-system.rsexperimentloader.enabled" = false;
      "toolkit.telemetry.archive.enabled" = false;
      "toolkit.telemetry.bhrPing.enabled" = false;
      "toolkit.telemetry.cachedProfileGroupID" = "";
      "toolkit.telemetry.dap.helper.hpke" = "";
      "toolkit.telemetry.dap.leader.hpke" = "";
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.firstShutdownPing.enabled" = false;
      "toolkit.telemetry.hybridContent.enabled" = false;
      "toolkit.telemetry.newProfilePing.enabled" = false;
      "toolkit.telemetry.prompted" = 2; 
      "toolkit.telemetry.rejected" = true;
      "toolkit.telemetry.reportingpolicy.firstRun" = false;
      "toolkit.telemetry.server" = "";
      "toolkit.telemetry.shutdownPingSender.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.unifiedIsOptIn" = false;
      "toolkit.telemetry.updatePing.enabled" = false;
      
     
      #########################
      ### smoother rebuilds ###
      #########################
      "browser.bookmarks.added_static_root" = true;
      "browser.bookmarks.restore_default_bookmarks" = false;
      "browser.policies.applied" = true;
      "browser.policies.runOncePerModification.extensionsInstall" =
        ''["https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"]'';
      "browser.policies.runOncePerModification.extensionsUninstall" =
        ''["google@search.mozilla.org","bing@search.mozilla.org","amazondotcom@search.mozilla.org","ebay@search.mozilla.org","twitter@search.mozilla.org"]'';
      "browser.policies.runOncePerModification.removeSearchEngines" =
        ''["Google","Bing","Amazon.com","eBay","Twitter"]'';
      "browser.policies.runOncePerModification.setDefaultSearchEngine" = "DuckDuckGo";
      
     
      
      


      # TODO get inspiration from https://gist.github.com/jornane/f47c344bae4c04ac761ee48b0b88c869
      # and https://brainfucksec.github.io/firefox-hardening-guide 
      # TODO look deeper into https://mozilla.github.io/policy-templates/#permissions (but rather dont do it as policy?)
      ##### from alina and not filtered properly yet
      /*
      #"browser.contentblocking.category" = "off"; # TODO research, is this even an option?
      #"browser.contextual-services.contextId" = "b016524a-080e-4db0-b8e0-699a61b84031"; #TODO choose different ID, read this https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/contextualIdentities
      
      
      #"browser.formfill.enable" = true;
      #"browser.ml.enable" = false;
      #"browser.newtabpage.activity-stream.asrouter.devtoolsEnabled" = true;
      #"browser.newtabpage.activity-stream.feeds.section.highlights" = false;
      #"browser.newtabpage.activity-stream.feeds.topsites" = false;
      #"browser.newtabpage.activity-stream.impressionId" = "";
      #"browser.newtabpage.activity-stream.topSitesRows" = 0;
      #"browser.newtabpage.blocked" =
      #  ''{"JXL+aK9F49vqamiUgDBMew==":1,"HxuLLvFts8CF9xiN6mlvjw==":1,"U1Q7azjZY3qZXPsrFyRvAg==":1,"/3SEo1ZtnEJOSRN9WJu8RA==":1,"FDbC6KNDInDavAHigtONBA==":1,"tifhq27ZM7UyZlxWWP4t0g==":1,"QgHbFUbmJuY3fl0l9wYzKg==":1,"HpNnn4X7x63zgqw0t9UjNA==":1,"AI7ERT/zFRP0OJPLp6oxyA==":1,"ddpK6zJ5J14twl3q1dgcPg==":1,"ER2Urnj4G4QO/e+IxHRStg==":1,"CFj1fz8AnbRVmD6f/vFOVw==":1,"0A0nnxMvBtygzWp+s7M20A==":1,"eiBTvu0N4ZXqfABy3NzQ+Q==":1,"ma3j2Ycz8XEVGPF2bDYzIw==":1,"JsXDxHf2zatU+EF75O5+tg==":1,"liU5nX2WxICX0/ybTwdLog==":1,"meEqpdxKYq84DxyXABgOPg==":1,"Eg/rlXk651Pur1WJxtoOEg==":1,"v/yeFlmgWHA848xjWjFNWQ==":1,"ihlKRI8T0yIkT2Q1uI2Hvg==":1,"pQ/WgUy966a/oOWbc6lByw==":1,"+acIB5/uCOtZOzu2R2uEMQ==":1,"grJ6pb1sxJx3pq6jPguUxw==":1,"aiVzfVWEHSpIFElfRK1P3w==":1}'';
      #"browser.newtabpage.pinned" =
      #  ''[{"url":"https://www.youtube.com/","label":"YouTube","baseDomain":"youtube.com"}, {"url":"https://mail.proton.me/u/0/inbox","label":"mail","baseDomain":"mail.proton.me"},{"url":"https://1337x.to/","label":"1337x","baseDomain":"1337x.to"},{"url":"https://dht.kyouma.net/torrents","label":"magnetico","baseDomain":"dht.kyouma.net"},{"url":"https://redacted.sh/","label":"redacted","baseDomain":"redacted.sh"},{"url":"https://eu.doubledouble.top/","label":"double double top","baseDomain":"eu.doubledouble.top"},{"url":"https://trainsear.ch/","baseDomain":"trainsear.ch"},{"url":"https://travelynx.de/","label":"travelynx","baseDomain":"travelynx.de"},{"url":"https://bahn.expert/","label":"bahn.expert","baseDomain":"bahn.expert"}]'';
      #"browser.pageActions.persistedActions" =
      #  ''{"ids":["bookmark","_3c078156-979c-498b-8990-85f7987dd929_","canvasblocker_kkapsner_de"],"idsInUrlbar":["_3c078156-979c-498b-8990-85f7987dd929_","canvasblocker_kkapsner_de","bookmark"],"idsInUrlbarPreProton":[],"version":1}'';
      #"browser.preferences.experimental.hidden" = false;
      
      
      
      
      
      #"browser.uiCustomization.state" =
      #  ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_ddc359d1-844a-42a7-9aa1-88a850a938a8_-browser-action","passff_invicem_pro-browser-action","deadname-remover_willhaycode_com-browser-action","jid1-6ku7yibrtczvjg_jetpack-browser-action","jid0-3guet1r69sqnsrca5p8kx9ezc3u_jetpack-browser-action","_8c9cad02-c069-4e93-909d-d874da819c49_-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","sponsorblocker_ajay_app-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","_12cf650b-1822-40aa-bff0-996df6948878_-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_0981817c-71b3-4853-a801-481c90af2e8e_-browser-action","gdpr_cavi_au_dk-browser-action","wayback_machine_mozilla_org-browser-action","atbc_easonwong-browser-action","_4f391a9e-8717-4ba6-a5b1-488a34931fcb_-browser-action","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","addon_fastforward_team-browser-action","canvasblocker_kkapsner_de-browser-action","_2d97895d-fcd3-41ab-82e6-6a1d4d2243f6_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","search_kagi_com-browser-action"],"nav-bar":["back-button","forward-button","vertical-spacer","stop-reload-button","urlbar-container","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","downloads-button","developer-button","fullscreen-button","sync-button","screenshot-button","unified-extensions-button","firefox_tampermonkey_net-browser-action","umatrix_raymondhill_net-browser-action","_46551ec9-40f0-4e47-8e18-8e5cf550cfb8_-browser-action","_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"vertical-tabs":[],"PersonalToolbar":["personal-bookmarks"]},"seen":["developer-button","ublock0_raymondhill_net-browser-action","screenshot-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","firefox_tampermonkey_net-browser-action","_12cf650b-1822-40aa-bff0-996df6948878_-browser-action","jid0-3guet1r69sqnsrca5p8kx9ezc3u_jetpack-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_0981817c-71b3-4853-a801-481c90af2e8e_-browser-action","gdpr_cavi_au_dk-browser-action","sponsorblocker_ajay_app-browser-action","wayback_machine_mozilla_org-browser-action","atbc_easonwong-browser-action","_4f391a9e-8717-4ba6-a5b1-488a34931fcb_-browser-action","_8c9cad02-c069-4e93-909d-d874da819c49_-browser-action","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","addon_fastforward_team-browser-action","_2e5ff8c8-32fe-46d0-9fc8-6b8986621f3c_-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","addon_darkreader_org-browser-action","canvasblocker_kkapsner_de-browser-action","_2d97895d-fcd3-41ab-82e6-6a1d4d2243f6_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action","search_kagi_com-browser-action","deadname-remover_willhaycode_com-browser-action","jid1-6ku7yibrtczvjg_jetpack-browser-action","umatrix_raymondhill_net-browser-action","passff_invicem_pro-browser-action","_ddc359d1-844a-42a7-9aa1-88a850a938a8_-browser-action","_46551ec9-40f0-4e47-8e18-8e5cf550cfb8_-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action"],"dirtyAreaCache":["nav-bar","vertical-tabs","toolbar-menubar","TabsToolbar","PersonalToolbar","unified-extensions-area"],"currentVersion":23,"newElementCount":10}'';
      "browser.urlbar.showSearchTerms.enabled" = true;
      "browser.urlbar.suggest.engines" = true;
      "browser.urlbar.suggest.history" = false;
      "browser.urlbar.suggest.searches" = true;
      "browser.urlbar.suggest.topsites" = false;
      #"captivedetect.canonicalURL" = "http://captive"; # TODO: setup nginx upstream for captive portals to this

      "browser.dom.window.dump.enabled" = true;
      "devtools.aboutdebugging.collapsibilities.processes" = true;
      "devtools.aboutdebugging.collapsibilities.tab" = true;
      "devtools.aboutdebugging.showReduxActionsInConsole" = true;
      "devtools.aboutdebugging.tmpExtDirPath" = "/home/alina/src/octane";
      "devtools.accessibility.enabled" = false;
      "devtools.application.enabled" = false;
      "devtools.browserconsole.enableNetworkMonitoring" = true;
      "devtools.browserconsole.filter.css" = true;
      "devtools.browserconsole.filter.net" = true;
      "devtools.browserconsole.filter.netxhr" = true;
      "devtools.browserconsole.input.editor" = true;
      "devtools.cache.disabled" = true;
      "devtools.command-button-measure.enabled" = true;
      "devtools.command-button-noautohide.enabled" = true;
      "devtools.command-button-rulers.enabled" = true;
      # devtools.command-button-screenshot.enabled" = true;
      # devtools.console.stdout.chrome" = true;
      # devtools.console.stdout.content" = true;
      # devtools.custom-formatters.enabled" = true;
      # devtools.debugger.auto-pretty-print" = true;
      # devtools.debugger.features.code-folding" = true;
      # devtools.debugger.features.javascript-tracing" = true;
      # devtools.debugger.remote-enabled" = true;
      # devtools.debugger.show-content-scripts" = true;
      # devtools.debugger.xhr-breakpoints-visible" = true;
      # devtools.dom.enabled" = true;
      # devtools.editor.keymap" = "vim";
      # devtools.inspector.chrome.three-pane-enabled" = true;
      # devtools.inspector.showAllAnonymousContent = true;
      # devtools.inspector.showUserAgentStyles = true;
      # devtools.inspector.three-pane-enabled = false;
      # devtools.layout.boxmodel.highlightProperty = true;
      # devtools.layout.boxmodel.opened = false;
      # devtools.layout.flex-container.opened = false;
      # devtools.layout.flex-item.opened = false;
      # devtools.layout.flexbox.opened = false;
      # devtools.layout.grid.opened = false;
      # devtools.markup.beautifyOnCopy = true;
      # devtools.markup.collapseAttributes = false;
      # devtools.memory.enabled = false;
      # devtools.netmonitor.columnsData = ''[{"name":"override","minWidth":20,"width":2},{"name":"status","minWidth":30,"width":12.33},{"name":"method","minWidth":30,"width":11.36},{"name":"domain","minWidth":30,"width":17.03},{"name":"file","minWidth":30,"width":17.98},{"name":"url","minWidth":30,"width":55.81},{"name":"initiator","minWidth":30,"width":12.44},{"name":"type","minWidth":30,"width":8.05},{"name":"transferred","minWidth":30,"width":22.18},{"name":"contentSize","minWidth":30,"width":12.45},{"name":"waterfall","minWidth":150,"width":5.65},{"name":"cookies","minWidth":30,"width":5.4},{"name":"setCookies","minWidth":30,"width":5.33},{"name":"remoteip","minWidth":30,"width":6.4},{"name":"path","minWidth":30,"width":14.03},{"name":"protocol","minWidth":30,"width":7.41},{"name":"scheme","minWidth":30,"width":7.41}]'';
      # devtools.netmonitor.filters = ''["xhr","other"]'';
      # devtools.netmonitor.har.compress = true;
      # devtools.netmonitor.har.defaultLogDir = "/home/alina/log/web";
      # devtools.netmonitor.har.enableAutoExportToFile = true;
      # devtools.netmonitor.har.forceExport = true;
      # devtools.netmonitor.har.jsonp = true;
      # devtools.netmonitor.har.multiple-pages = true;
      # devtools.netmonitor.msg.visibleColumns = ''["data","time"]'';
      # devtools.netmonitor.panes-network-details-width = 492;
      # devtools.netmonitor.persistlog = true;
      # devtools.netmonitor.visibleColumns = ''["status","method","url","type","contentSize","waterfall"]'';
      # devtools.performance.enabled = false;
      # devtools.screenshot.clipboard.enabled = true;
      # devtools.selfxss.count = 5;
      # devtools.serviceWorkers.testing.enabled = true;
      # devtools.storage.enabled = false;
      # devtools.theme = "dark";
      # devtools.toolbox.host = "window";
      # devtools.toolbox.previousHost = "window";
      # devtools.toolbox.selectedTool = "netmonitor";
      # devtools.toolbox.zoomValue = 1.2;
      # dom.forms.autocomplete.formautofill = true;
      # dom.push.userAgentID = "c5f2621662f7454aab4dd5b748d18cef";
      # dom.security.https_only_mode_ever_enabled = true;
      # dom.security.https_only_mode_ever_enabled_pbm = true;
      # #extensions.activeThemeID =	"firefox-compact-dark@mozilla.org";
      # extensions.pictureinpicture.enable_picture_in_picture_overrides = false;
      # extensions.ui.dictionary.hidden = false;
      # extensions.ui.extension.hidden = false;
      # extensions.ui.locale.hidden = false;
      # extensions.ui.plugin.hidden = false;
      # extensions.ui.sitepermission.hidden = false;
      # extensions.ui.theme.hidden = false;
      # extensions.webcompat.enable_shims = true;
      # extensions.webcompat.perform_injections = true;
      
      # extensions.webextensions.uuids = ''{"formautofill@mozilla.org":"d0b2b0fe-3f5a-47b7-86e9-bc62d021f9c5","newtab@mozilla.org":"94121165-2b5e-485f-8dd1-0898fa377bc8","pictureinpicture@mozilla.org":"f18d5604-48eb-4223-af7a-67671f9570b3","addons-search-detection@mozilla.com":"16e09d63-d26b-4b0f-9c7b-816b2e839b3a","webcompat@mozilla.org":"9a310967-e580-48bf-b3e8-4eafebbc122d","default-theme@mozilla.org":"deb98097-bfb0-4d89-8f2d-6f64872cb44f","uBlock0@raymondhill.net":"fa62f6ad-b409-48cb-9497-4f0b8d93d2fb","firefox-compact-dark@mozilla.org":"c0139ff7-0129-4975-9011-87a970d8fa9d","{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}":"d860513b-ad42-4b3c-a2a5-5632141b4dad","{446900e4-71c2-419f-a6a7-df9c091e268b}":"f4a0a1b0-5000-41ef-b8e9-d4130b05e1d6","firefox@tampermonkey.net":"ae92079c-a1a7-4eb4-9817-04c6a3de98e0","{12cf650b-1822-40aa-bff0-996df6948878}":"238f8872-b4aa-4631-a3ea-4e2e645580e8","jid1-ZAdIEUB7XOzOJw@jetpack":"f58a9440-580a-4bdf-8c46-74987cb821bb","jid0-3GUEt1r69sQNSrca5p8kx9Ezc3U@jetpack":"3f7d5aa3-8561-4c38-a22b-6f0daa595215","{74145f27-f039-47ce-a470-a662b129930a}":"3c1e79a8-71d9-46d1-938f-2ef406ee106f","{0981817c-71b3-4853-a801-481c90af2e8e}":"61a2d3a8-b627-433b-9156-4f64ed1fe3f1","wappalyzer@crunchlabz.com":"5d4a9e95-ee83-40ee-b48a-885300b39a77","gdpr@cavi.au.dk":"7c7b3ffb-9a00-4369-81ce-6ba9c533313b","simple-tab-groups@drive4ik":"5854b6a4-5c03-4c33-8a2b-ba47f8232327","sponsorBlocker@ajay.app":"fcca04af-5679-4f49-a237-29831dd600b5","wayback_machine@mozilla.org":"c7799ba2-834f-4af0-8d85-09c549580b45","ATBC@EasonWong":"6836a917-fd90-43ef-90e6-50bb68782eeb","{4f391a9e-8717-4ba6-a5b1-488a34931fcb}":"bca01fe3-9bea-4e04-b606-4248f1b5986e","{8c9cad02-c069-4e93-909d-d874da819c49}":"c85213dd-28cb-4db0-aeed-f2c829622db5","{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}":"3f17d76d-6fac-49e3-8a3f-1501df21821d","addon@fastforward.team":"5e95cff4-d162-4756-9548-6130eb6a0837","ipvfoo@pmarks.net":"8c374a88-eca0-49e0-852b-0337eeea456e","7esoorv3@alefvanoon.anonaddy.me":"2660c1a5-638d-43dd-9291-c388f1097019","{73a6fe31-595d-460b-a920-fcc0f8843232}":"9845bad3-cfd6-4a88-a492-a795fd3ccae5","{3c078156-979c-498b-8990-85f7987dd929}":"38804940-7d28-4ba1-8b05-f870d42cf9db","jid1-MnnxcxisBPnSXQ@jetpack":"5069b42f-264d-4f0d-86ee-149229903675","lean-tab-limiter@etienneguerlain.fr":"b44526b7-d428-44a6-aaea-bd765ff90228","addon@darkreader.org":"035664e9-c3f7-4a25-99fe-6219b9e1c2a7","CanvasBlocker@kkapsner.de":"425aadd5-008d-4832-b806-19ef59450c28","{2d97895d-fcd3-41ab-82e6-6a1d4d2243f6}":"98d22a89-cfd6-47d9-9d21-ceb2487fb7ed","{b86e4813-687a-43e6-ab65-0bde4ab75758}":"dab50314-653f-4358-a66b-f93b1d976bc7","{aecec67f-0d10-4fa7-b7c7-609a2db280cf}":"4951f424-e6b8-4d98-9de1-0a5b780c42a6","deadname-remover@willhaycode.com":"09cc41a4-2425-416e-a0d9-24140f62a7ec","jid1-6kU7yIbrTcZvJg@jetpack":"296767bb-aee1-469c-ad67-aea23aa516fa","passff@invicem.pro":"149e629f-ba0b-4119-bb7b-2cd4c722056c","ipp-activator@mozilla.com":"3fdb7e67-e363-4564-8848-8d693b19a045","{DDC359D1-844A-42a7-9AA1-88A850A938A8}":"796939a0-7aa4-4a2c-9f7c-6e14de1dc35d","hi@alina.cx":"668e7f1d-22c2-4705-8455-68da1338f16e","{46551EC9-40F0-4e47-8E18-8E5CF550CFB8}":"48b26f63-8d51-4bf3-ab02-289545933b4d","data-leak-blocker@mozilla.com":"5328e0e3-162f-4199-a60b-76c74e410dfd"}'';
      # findbar.highlightAll = true;
      # layout.css.prefers-color-scheme.content-override = 1;
      # network.captive-portal-service.enabled = true;
      # network.connectivity-service.enabled = false;
      # network.http.speculative-parallel-limit = 10;
      # network.prefetch-next = true;
      # network.trr.excluded-domains = "";
      # network.trr.mode = 3;
      # network.trr.uri = "https://doh.libredns.gr/noads";
      # pdfjs.enableAltText = true;
      # pdfjs.enableAltTextForEnglish = true;
      # privacy.disable_button.cookie_exceptions = false;
      # privacy.annotate_channels.strict_list.enabled = true;
      # privacy.clearOnShutdown.formdata = false;
      # privacy.clearOnShutdown_v2.downloads = false;
      
      # privacy.fingerprintingProtection = true;
      # privacy.globalprivacycontrol.was_ever_enabled = true;
      # privacy.history.custom = true;
      # privacy.query_stripping.enabled = true;
      # "privacy.query_stripping.enabled.pbmode" = true;
      # privacy.resistFingerprinting = false;
      # privacy.trackingprotection.allow_list.baseline.enabled = false;
      # privacy.trackingprotection.allow_list.convenience.enabled = false;
      # privacy.trackingprotection.allow_list.hasMigratedCategoryPrefs = true;
      # privacy.trackingprotection.consentmanager.skip.pbmode.enabled = false;
      # privacy.trackingprotection.emailtracking.enabled = true;
      # privacy.trackingprotection.enabled = true;
      # privacy.trackingprotection.socialtracking.enabled = true;
      # privacy.userContext.extension = "passff@invicem.pro";
      # security.OCSP.enabled = 0;
      # security.disable_button.openDeviceManager = false;
      # security.tls.enable_0rtt_data = true;
      # services.sync.username = "alina@duck.com";
      
      
      # sidebar.visibility = "hide-sidebar";
      # webgl.disabled = false;
      # widget.gtk.overlay-scrollbars.enabled = true;

      #"toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      #"identity.fxaccounts.enable" = true;
      #"identity.fxaccounts.enabled" = true;
      #"identity.fxaccounts.device.name" = "alina's librewolf on " + name;
      #"identity.fxaccounts.autoconfig.uri" = "https://ffsync.alina.cx/";
      #"identity.fxaccounts.remote.root = "https://ffsync.alina.cx/";
      #"identity.fxaccounts.auth.uri" = "https://api.ffsync.alina.cx/v1";
      # identity.fxaccounts.account.device.name = "arielle";
      # identity.fxaccounts.account.telemetry.sanitized_uid = "86eedc6e3830f1b68d4ecdf73538e7de";
      # identity.fxaccounts.lastSignedInUserHash = "WjTxgIrvgnH6548E+M5TXWatlPv5eLInNLN9bJnpDJE=";
      

      "browser.tabs.insertAfterCurrent" = true;
      #"browser.search.suggest.enabled" = true;
      #"network.http.referer.XOriginPolicy" = 2;
      #"svg.context-properties.content.enabled" = true;
      #"browser.display.background_color" = "#000000";
      #"browser.display.foreground_color" = "#ffffff";

      
      # Hide the "sharing indicator", it's especially annoying
      # with tiling WMs on wayland
      #"privacy.webrtc.legacyGlobalIndicator" = false;
      */
    };
    profiles.default = {
      search = {
        engines = {
          nixvim = {
            name = "Nixvim";
            definedAliases = [ "nv" ];
            urls = [
              {
                template = "https://nix-community.github.io/nixvim/search/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                  {
                    name = "option";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            iconMapObj."16" = "https://nix-community.github.io/favicon.ico";
          };
        };
      };
      userChrome = ''
        /* Hide scrollbar in FF Quantum */
        *{scrollbar-width: 2px !important}

        /* Hide tab bar in FF Quantum */
        @-moz-document url(chrome://browser/content/browser.xul), url(chrome://browser/content/browser.xhtml) {
          #TabsToolbar {
            visibility: collapse !important;
            margin-bottom: 21px !important;
          }

          #sidebar-box[sidebarcommand="treestyletab_piro_sakura_ne_jp-sidebar-action"] #sidebar-header {
            visibility: collapse !important;
          }
        }
        #main-window #TabsToolbar {
            visibility: initial;
        }

        #main-window #TabsToolbar {
            visibility: collapse !important;
        }

        #main-window #tabbrowser-tabs {
            z-index: 0 !important;
        }
        :root {
            --autohide-sidebar-width: 0px;
            --uc-window-control-width: 0x; /* Space reserved for window controls */
            --uc-window-drag-space-width: 1px; 
            /* Extra space reserved on both sides of the nav-bar to be able to drag the window */
            --uc-toolbar-height: 0px;
            --autohide-sidebar-toolbar-height: var(--uc-toolbar-height, 0px); /* variable from hide_titlebar.css */
        }
        :root[sizemode="normal"] {
            --autohide-sidebar-toolbar-height: var(--uc-toolbar-height, 0px); /* variable from hide_titlebar.css */
        }
      '';
    };
  };
}