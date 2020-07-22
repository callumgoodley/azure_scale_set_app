#!/bin/bash

# Create resource group

az group create -n milestonerg -l uksouth

# Create vm1 in resource group running app on start up

az vm create -g milestonerg -n vm1 -l uksouth --image UbuntuLTS --admin-username callumgoodley --generate-ssh-keys --custom-data /Users/user1/Documents/Code/QA/milestonetask/cloud-init.txt

# Create load balanced scale set that runs the app on start on vm's

az vmss create -g milestonerg -n myScaleSet --image UbuntuLTS --upgrade-policy-mode automatic --admin-username callumgoodley --generate-ssh-keys --custom-data /Users/user1/Documents/Code/QA/milestonetask/cloud-init.txt

# Create loadbalancer rule to allow port 5000

az network lb rule create \
-g milestonerg \
-n myLoadBalancerRule \
--lb-name myScaleSetLB \
--backend-pool-name myScaleSetLBBEPool \
--backend-port 5000 \
--frontend-ip-name loadBalancerFrontEnd \
--frontend-port 5000 \
--frontend-port 5000 \
--protocol tcp

# Display public IP address for loadbalancer to access application through browser

az network public-ip show \
  --resource-group milestonerg \
  --name myScaleSetLBPublicIP \
  --query '[ipAddress]' \
  --output tsv

# add any changes commit and push to github


