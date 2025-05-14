#!/bin/bash
for file in mock-data/*.sql
do
    sudo mysql -u root -p140605 BMF < "$file"
done
