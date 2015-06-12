#!/bin/bash


echo "Restarting Nginx"
service nginx restart > /dev/null 2>&1


echo "Finished"