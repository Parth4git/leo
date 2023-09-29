#!/bin/bash
# First check that Leo is installed.
if ! command -v leo &> /dev/null
then
    echo "leo is not installed."
    exit
fi

echo "
###############################################################################
########                                                               ########
########                 STEP 1: Propose a new ballot                  ########
########                                                               ########
########                  ---------------------------                  ########
########                  |         |  Yes  |   No  |                  ########
########                  ---------------------------                  ########
########                  |  Votes  |       |       |                  ########
########                  ---------------------------                  ########
########                                                               ########
###############################################################################
"
# Run the `propose` program function
(
  cat ./inputs/propose.in | xargs leo run propose || exit
)

echo "
###############################################################################
########                                                               ########
########               STEP 2: Issue a new ballot ticket               ########
########                                                               ########
########                  ---------------------------                  ########
########                  |         |  Yes  |   No  |                  ########
########                  ---------------------------                  ########
########                  |  Votes  |   0   |   0   |                  ########
########                  ---------------------------                  ########
########                                                               ########
###############################################################################
"
# Run the `new_ticket` program function
(
  cat ./inputs/new_ticket.in | xargs leo run new_ticket || exit
)

echo "
###############################################################################
########                                                               ########
########            STEP 3: Vote 'Yes' on the ballot ticket            ########
########                                                               ########
########                  ---------------------------                  ########
########                  |         |  Yes  |   No  |                  ########
########                  ---------------------------                  ########
########                  |  Votes  |   1   |   0   |                  ########
########                  ---------------------------                  ########
########                                                               ########
###############################################################################
"
# Run the `agree` or `disagree` program function
(
  cat ./inputs/agree.in | xargs leo run agree || exit
  #cat ./inputs/disagree.in | xargs leo run disagree || exit
)
