{
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        "title"
        "separator"
        "os"
        # "host"
        "kernel"
        "packages"
        "shell"
        "wm"
        "terminal"
        "display"
        "cpu"
        "gpu"
        "memory"
        "break"
        "colors"
      ];
    };
  };
}
