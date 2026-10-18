{ ... }:
{
  programs.librewolf.policies.SearchEngines = {
    PreventInstalls = true;
    Remove = [
      "Bing"
      "DuckDuckGo"
      "DuckDuckGo Lite"
      "Ecosia"
      "Google"
      "Perplexity"
      "LibRedirect"
      "MetaGer"
      "Mojeek"
      "Searx Belgium"
      "Startpage"
      "Wikipedia (en)"
    ];
    Default = "DDG";
    Add = [
      # TODO add missing suggesturltemplates - or remove existing ones?
      ### GENERIC SEARCH ENGINES ###
      {
        # remove default DDG and readd it to have control over alias and URL Template etc.
        Name = "DDG";
        Description = "search privately";
        Alias = "ddg";
        Method = "GET";
        URLTemplate = "https://duckduckgo.com/?kp=-2&kbj=1&kav=1&k1=-1&kaj=m&kay=b&kak=-1&kax=-1&kaq=-1&kap=-1&kao=-1&kau=-1&kpsb=-1&kbg=-1&kbe=0&q={searchTerms}";
        SuggestURLTemplate = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
        IconURL = "https://duckduckgo.com/favicon.ico";
      }
      # TODO consider searXNG https://searx.be/
      # TODO consider https://metager.org/
      ### TRANSLATORS ###
      {
        Name = "translate en->de";
        Description = "wordreference: translate en to de";
        Alias = "ende";
        Method = "GET";
        URLTemplate = "https://www.wordreference.com/ende/{searchTerms}";
        #SuggestURLTemplate = "https://www.wordreference.com/autocomplete?dict=ende&query={searchTerms}"; TODO
        IconURL = "https://wordreference.com/favicon.ico";
      }
      {
        Name = "translate de->en";
        Description = "wordreference: translate de to en";
        Alias = "deen";
        Method = "GET";
        URLTemplate = "https://www.wordreference.com/deen/{searchTerms}";
        #SuggestURLTemplate = "https://www.wordreference.com/autocomplete?dict=deen&query={searchTerms}"; TODO
        IconURL = "https://wordreference.com/favicon.ico";
      }
      {
        Name = "nimi.li";
        Description = "toki pona dictionary";
        Alias = "tok";
        Mehod = "GET";
        URLTemplate = "https://nimi.li/{searchTerms}";
        IconURL = "https://nimi.li/favicon-96x96.png";
      }
      ### wikis
      {
        Name = "Wikipedia";
        Description = "one search away from the knowledge of the world!";
        Alias = "wk";
        Method = "GET";
        URLTemplate = "https://en.wikipedia.org/wiki/Special:Search?search={searchTerms}";
        #SuggestURLTemplate = "https://en.wikipedia.org/w/rest.php/v1/search/title?q={searchTerms}&limit=5"; TODO
        IconURL = "https://en.wikipedia.org/static/favicon/wikipedia.ico";
      }
      {
        Name = "Wikipedia DE";
        Description = "one search away from the knowledge of the world!";
        Alias = "wkde";
        Method = "GET";
        URLTemplate = "https://de.wikipedia.org/wiki/Special:Search?search={searchTerms}";
        #SuggestURLTemplate = "https://de.wikipedia.org/w/rest.php/v1/search/title?q={searchTerms}&limit=5"; TODO
        IconURL = "https://de.wikipedia.org/static/favicon/wikipedia.ico";
      }
      {
        Name = "Wiktionary";
        Description = "the free dictionary";
        Alias = "wikt";
        Method = "GET";
        URLTemplate = "https://en.wiktionary.org/w/index.php?search={searchTerms}";
        #SuggestURLTemplate = "https://en.wiktionary.org/w/rest.php/v1/search/title?q={searchTerms}&limit=5"; TODO
        IconURL = "https://en.wiktionary.org/static/favicon/wiktionary/en.ico";
      }
      ### NIXOS ###
      {
        Name = "Nix packages";
        Description = "the largest software collection in the world";
        Alias = "np";
        Method = "GET";
        URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
        IconURL = "https://search.nixos.org/favicon.ico";
      }
      {
        Name = "Nix options";
        Description = "search NixOS options by name or description";
        Alias = "no";
        Method = "GET";
        URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
        IconURL = "https://search.nixos.org/favicon.org";
      }
      {
        Name = "Nix Noogle";
        Description = "Search for nix functions by name.";
        Alias = "noo";
        Method = "GET";
        URLTemplate = "https://noogle.dev/q?term={searchTerms}";
        IconURL = "https://noogle.dev/favicon.ico";
      }
      {
        Name = "Nix HomeManager Options";
        Description = "Search for home manager options by name.";
        Alias = "nh";
        Method = "GET";
        URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}";
        IconURL = "https://home-manager-options.extranix.com/favicon.ico";
      }
      {
        Name = "Nixvim";
        Description = "a neovim configuration system for nix";
        Alias = "nv";
        Method = "GET";
        URLTemplate = "https://nix-community.github.io/nixvim/search?query={searchTerms}&option={searchTerms}";
        IconURL = "https://nix-community.github.io/favicon.ico";
      }
      ### software dev ###
      {
        Name = "GitHub";
        description = "Search GitHub";
        Alias = "gh";
        Method = "GET";
        URLTemplate = "https://github.com/search?q={searchTerms}&ref=opensearch";
        IconURL = "https://github.com/favicon.ico";
      }
      {
        Name = "IETF datatracker";
        Description = ""; # TODO
        Alias = "rfc";
        Method = "GET";
        URLTemplate = "https://datatracker.ietf.org/doc/html/rfc{searchTerms}";
        IconURL = "https://ietf.org/favicon.ico";
      }
      ### media ###
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
      ### DRUGS ###
      {
        Name = "PsychonautWiki";
        Description = "search for anything psychoactive";
        Alias = "psy";
        Method = "GET";
        URLTemplate = "https://psychonautwiki.org/w/index.php?title=Special:Search&search={searchTerms}";
        IconURL = "https://psychonautwiki.org/favicon.org";
      }
      {
        Name = "drugs.com";
        Description = "Drug and health information, from pharmacists you can trust.";
        Alias = "drug";
        Method = "GET";
        URLTemplate = "https://www.drugs.com/search.php?searchterm={searchTerms}";
        #SuggestURLTemplate = "https://www.drugs.com/api/autocomplete/?type=main&s={searchTerms}";
        IconURL = "https://drugs.com/img/logo/favicon/ddc-icon-32x32.png";
      }
      ### PIRACY ###
      {
        Name = "1337x";
        Description = "liberate media";
        Alias = "1337";
        Method = "GET";
        URLTemplate = "https://1337x.to/search/{searchTerms}/1/";
        IconURL = "https://1337x.to/favicon.ico";
      }
      {
        Name = "nyaa.si";
        Description = "liberate anime";
        Alias = "nyaa";
        Method = "GET";
        URLTemplate = "https://nyaa.si/?q={searchTerms}";
        IconURL = "https://1337x.to/static/favicon.png";
      }
      ### misc ###
      {
        Name = "UnicodeExplorer";
        Description = "lookup unicode characters";
        Alias = "unicode";
        Method = "POST";
        URLTemplate = "https://unicode-explorer.com/search/";
        PostData = "q={searchTerms}";
        IconURL = "https://unicode-explorer.com/static/img/favicon.png";
      }
    ];
  };
}
