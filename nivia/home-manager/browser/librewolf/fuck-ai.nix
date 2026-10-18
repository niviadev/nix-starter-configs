{ ... }:
{
  # holy fuck firefox why do I have to manage 3 different policies
  # finely grained just to get rid of all slop.
  # AI policies are banished here to prevent retraumatizing
  programs.librewolf.policies = {
    AIControls.Default = {
      Locked = true;
      Value = "blocked";
    };
    AIChatbot = {
      Locked = true;
      Prompts = {
        Enabled = false;
        Builtin = {
          Summarize = false;
          Explain = false;
          Quiz = false;
          Proofread = false;
        };
      };
      Providers.Builtin = {
        "Anthropic Claude" = false;
        "ChatGPT" = false;
        "Copilot" = false;
        "Google Gemini" = false;
        "HuggingChat" = false;
        "Le Chat Mistral" = false;
        "localhost" = false;
      };
    };
    GenerativeAI = {
      Enabled = false;
      Locked = true;
    };
  };
}
