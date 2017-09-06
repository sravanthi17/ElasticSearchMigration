#!/usr/bin/env bash
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 6`
reset=`tput sgr0`
curator action-create-index.yml --config config.yml
if  [ $? -eq 0 ]
then
    echo "${green} Index successfully Created ${reset}"
    echo "${yellow}Starting to Reindex ${reset}"
    curator action-reindex.yml --config config.yml
    if  [ $? -eq 0 ]
    then
       echo "${green}Successfully reindexed ${reset}"
       echo "${yellow}Creating Alias ${reset}"
       curator action-create-alias.yml --config config.yml
       if  [ $? -eq 0 ]
       then
          echo "${green}Successfully created alias for new index ${reset}"
       else
           echo "${red}Failed to create alias${reset}"
       fi
    else
           echo "${red}Failed to re-index${reset}"
    fi
else
    echo "${red}Failed to create index${reset}"
fi
