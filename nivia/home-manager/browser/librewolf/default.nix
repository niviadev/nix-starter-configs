{
    lib,
    config,
    name,
    pkgs,
    ...
}:
let
    userChromeCss = builtins.readFile ./userchrome.css;
    userContentCss = builtins.readFile ./usercontent.css;
in
{
    imports = [
        ./extensions
        ./fuck-ai.nix
        ./search-engines.nix
    ];

    programs.fish.shellAliases = {
        librewolf = "librewolf --name librewolf";
    }

    #environment.systemPackages = with pkgs; [
    #
    #];

    programs.librewolf = {
        # docs: https://firefox-source-docs.mozilla.org/index.html
        enable = true;

        policies = {
            # docs: https://firefox-admin-docs.mozilla.org/reference/policies/

            ### BOOKMARKS ###
            NoDefaultBookmarks = true;

            ### BROWSER UI ###
            DisableFeedbackCommands = true;
            DisableSetDesktopBackground = true;
            DisplayMenuBar = "never";

            ### CLOUD REPORTING ###
            CrashReportsSubmit.Enabled = false;

            ### CONTENT SETTINGS ###
            Permissions = {
                Notifications = {
                    Allow = [
                        "https://mk.absturztau.be"
                    ];
                    Block = [
                        "https://www.youtube.com"
                        "https://mail.proton.me"
                    ];
                };
            };
            PictureInPicture = {
                Enabled = true;
                Locked = true;
            };

            ### DOWNLOADS ###
            DefaultDownloadDirectory = "/home/nivia/Downloads";
            PromptForDownloadLocation = false;

            ### EXTENSIONS ###
            # ExtensionSettings: see ./extensions.nix

            ### LOCAL DATA STORAGE ###

            ### MISCELLANEOUS ###
            DisableAccounts = true;
            #DisableFirefoxAccounts = true;
            DisableFirefoxScreenshots = true;
            DisableFirefoxStudies = true;
            DisableTelemetry = true;
            UserMessaging = {
                ExtensionRecommendations = false;
                FeatureRecommendations = false;
                UrlbarInterventions = false;
                SkipOnboarding = true;
                MoreFromMozilla = false;
                FirefoxLabs = false;
                Locked = true;
            };

            ### NETWORK SECURITY ###
            CaptivePortal = true;
            /*
              Cookies = {
                  Behaviour = "partition-foreign";
                  BehaviourPrivateBrowsing = "partition-foreign";
                  Locked = true;
              };
            */
            DNSOverHTTPS = {
                # using DNScrypt in ../nixos/networking/dns.nix already; prevent from mistakenly turning this on
                Enabled = false;
                Locked = true;
            };
            #EnableTrackingProtection = {
            #    Value = true;
            #    Locked = true;
            #    Category= "strict";
            #};
            IPProtectionAvailable = false;

            ### PASSWORD MANAGER ###
            AutofillAddressEnabled = false;
            AutofillCreditCardEnabled = false;
            PrimaryPassword = false;
            OfferToSaveLogins = false;

            ### SEARCH ###
            SearchBar = "unified";
            SearchSuggestEnabled = true;
            VisualSearchEnabled = false; # bloatware: google lens

            ### SECURITY ###
            # TODO https://firefox-admin-docs.mozilla.org/reference/policies/preferences/
            Preferences = {
                /*
                  # enable userChrome.css
                  "toolkit.legacyUserProfileCustomizations.stylesheets" = {
                      Value = true;
                      Status = "locked";
                  };
                */
            };

            ### STARTUP ###
            DontCheckDefaultBrowser = true;
            FirefoxHome = {
                Search = true;
                TopSites = true;
                Weather = true;
                Highlights = false;
                Pocket = false;
                Stories = false;
                Snippets = false;
                SponsoredPocket = false;
                SponsoredStories = false;
                SponsoredTopSites = false;
                Locked = true;
            };
            Homepage = {
                Startpage = "none";
                NewTabOnRestore = false;
                Locked = true;
            };
            NewTabPage = false;
            OverrideFirstRunPage = "";
            OverridePostUpdatePage = "";
            ShowHomeButton = false;
            SkipTermsOfUse = true;

            ### UNDEFINED ###
            # TODO https://firefox-admin-docs.mozilla.org/reference/policies/handlers/
        };

        settings = {
            # enable userChrome.css
            # TODO move some over to policies.preferences
            # TODO order the preferences nicely

            # documentation
            # https://kb.mozillazine.org/About:config_entries
            # https://searchfox.org/
            # https://searchfox.org/firefox-main/source/modules/libpref/init/StaticPrefList.yaml
            # resource:///defaults/preferences/firefox.js
            # resource://gre/greprefs.js

            # TODO sift through guides for better hardening
            # https://gist.github.com/jornane/f47c344bae4c04ac761ee48b0b88c869
            # https://brainfucksec.github.io/firefox-hardening-guide

            ###############
            # preferences #
            ###############
            "dom.input.fallbackUploadDir" = "/home/nivia";
            # enable userchrome.css
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

            # resume previous session
            "browser.startup.page" = 3;

            "browser.tabs.insertAfterCurrent" = true;
            "browser.display.background_color" = "#000000";
            "browser.display.foreground_color" = "#ffffff";

            # Hide the "sharing indicator", it's especially annoying
            # with tiling WMs on wayland
            #"privacy.webrtc.legacyGlobalIndicator" = false;

            ##########
            ### UX ###
            ##########

            "sidebar.verticalTabs" = true;
            "browser.active_color" = "#F5ABB9"; # make link trans colored on keydown event
            # hide annoying feature popups
            "browser.eme.ui.firstContentShown" = true;
            "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
            "browser.protections_panel.infoMessage.seen" = true;

            # bookmarks
            "browser.toolbars.bookmarks.visibility" = "newtab";
            "browser.bookmarks.editDialog.confirmationHintShowCount" = 3;
            "browser.bookmarks.editDialog.showForNewBookmarks" = true;
            "browser.bookmarks.added_static_root" = true;
            "browser.bookmarks.restore_default_bookmarks" = false;

            # downloads

            # internationalization / locale
            "intl.accept_languages" = "en-US, en, de-DE, de, tok";
            "browser.translations.neverTranslateLanguages" = "en-US, en, de-DE, de";

            # performance
            # force enable GPU acceleration
            "gfx.webrender.all" = true;

            ###########
            # privacy #
            ###########
            "app.normandy.enabled" = false;
            "browser.newtabpage.activity-stream.feeds.telemetry" = false;
            "browser.newtabpage.activity-stream.telemetry" = false;
            "browser.newtabpage.activity-stream.feeds.snippets" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "browser.newtabpage.activity-stream.default.sites" = "";
            "browser.region.network.url" = "";
            "browser.region.update.enabled" = false;
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
        };

        profiles = {
            default = {
                # TODO profile for standard use
                # --> use https://www.reddit.com/r/firefox/comments/r0dgfz/comment/hlrr0ed for inspiration
                userChrome = userChromeCss;
                userContent = userContentCss;
            };
            /*
              failsafe = {
                  # TODO failsafe profile for single use websites that break on standard profile
              };
              temp = {
                  # TODO temporary profile that gets discarded after every use, amnesic
              };
              webapps = {
                  # TODO webapp profile with services where im permanently logged in
              };
            */
        };
    };
}
