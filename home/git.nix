{ ... }: {
    programs.git = {
        enable = true;
        settings = {
            user = {
                name = "hyeondobin";
                email = "dobinhyeon@gmail.com";
            };
            init.defaultBranch = "main";
            pull.rebase = true;
        };
    };
}
