{ lib, ... }:
with lib;
{
  enabled = {
    ## option을 빠르게 활성화 한다.
    ##
    ## ```nix
    ## services.ngnix = enabled;
    ## ```
    ##
    #@ true
    enable = true;
  };
  disabled = {
    enable = false;
  };
}
