BLOWITUP="./blowitup/cmd/"

new-cluster:
	${BLOWITUP}new-kind-cluster.sh

up:
	${BLOWITUP}up.sh

down:
	${BLOWITUP}down.sh

trigger:
	${BLOWITUP}trigger.sh
tabs:
	${BLOWITUP}tabs.sh

view-replication-logs:
	${BLOWITUP}view-replication-logs.sh
