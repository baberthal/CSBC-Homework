#!/usr/bin/env bash

#
# Finds all losses and outputs them to stdout. To generate the
# "Roulette_Losses" file, run like this:
#
#     ./find_all_losses.sh > Roulette_Losses
#

grep "\-\$\d\+" *_win_loss_player_data | sed "s/_win_loss_player_data:/ /"
