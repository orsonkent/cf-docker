#!/bin/bash

# Basic init style script to handle start/stop/destroy/restart/etc of all containers


# TASKS:
# 	build (from a configured Dockerfile)
#	run (run from a previously created image)
#	start (starts a container that has been run previously)
# 	stop (stops a running container)
#	delete (deletes a previously run container)

# CONTAINERS:
# 	nats (should always start first, as other container contents depend on it being present.)
# 	test (should always start last, as it will run tests on everything else)

# Usage:  ./cfdocker.sh [build|run|start|stop|delete|test] [nats|postgres|test|all]

set -e

if [ !$# = '2' ]; then
	echo "Usage:  $0 [build|run|start|stop|delete|test] [base|nats|test|all]"
	exit 1
fi
 
task=$1
container=$2


case $task in
	build)
		case $container in
			base)
				echo "This may take some time..."
				echo ""
				echo "but it speeds up subsequent builds enormously"
				docker build -t cfd-base cfdbase/
				docker build -t cfd-gobase cfdgobase/
				docker build -t cfd-rubybase cfdrubybase/
				docker build -t cfd-javabase cfdjavabase/
			;;
			nats)
				docker build -t cfd-nats nats/
			;;
			postgres)
				docker build -t cfd-postgres postgres/
			;;
			test)
				docker build -t cfd-test test/
			;;
			all)
				$0 build base
				$0 build nats
				$0 build postgres
				$0 build test
			;;
			*)
				echo "I don't know how to $task $container"
			;;
		esac
	;;
	run)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker run -d --name=nats -i -t cfd-nats
				sudo ./pipework/pipework br1 nats 192.168.78.1/24
			;;
			postgres)
				docker run -d --name=postgres -i -t cfd-postgres
				sudo ./pipework/pipework br1 postgres 192.168.78.2/24
			;;
			all)
				$0 run nats
				$0 run postgres
				$0 test all
			;;
			*)
				echo "I don't know how to $task $container"
			;;
		esac
		sudo ip addr add 192.168.78.254/24 dev br1
	;;
	start)
		case $container in
			base)
			echo "The base platform is never run."
			;;
			nats)
				docker start nats
			;;
			postgres)
				docker start postgres
			;;
			all)
				$0 start nats
				$0 start postgres
				$0 start test
			;;
			*)
				echo "I don't know how to $task $container"
			;;
		esac
	;;
	stop)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker stop nats
			;;
			postgres)
				docker stop postgres
			;;
			all)
				$0 stop nats
				$0 stop postgres
			;;
			*)
				echo "I don't know how to $task $container"
			;;
		esac
	;;
	delete)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker rm -f nats
			;;
			postgres)
				docker rm -f postgres
			;;
			test)
				docker rm -f test
			;;
			all)
				$0 delete nats
				$0 delete postgres
				$0 delete test
			;;
			*)
				echo "I don't know how to $task $container"
			;;
		esac
	;;
	test)
		case $container in
			base)
				echo "The base platform is never tested."
			;;
			test)
				echo "testing the test container is meaningless."
			;;
			nats|all|postgres)
				set +e
				docker run -d --name=test -i -t cfd-test /vcap/tests/$container.rb
				sudo ./pipework/pipework br1 nats 192.168.78.1/24
				while ! [ `docker inspect test | grep Running | awk '{print $2}' | sed 's/,//g'` = false ]; do
					echo "Tests still running..."
					sleep 1
				done
				docker logs test
				docker rm test
			;;
			*)
				echo "I don't know how to $task $container"
			;;
		esac
	;;
esac

