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

# Usage:  ./cfdocker.sh [build|run|start|stop|delete|rebuild] [nats|test|all]

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
				docker build -t cfd/base cfdbase/
				docker build -t cfd/gobase cfdgobase/
			;;
			nats)
				docker build -t cfd/nats nats/
			;;
			test)
				docker build -t cfd/test test/
			;;
		esac
	;;
	run)
		case $container in
			base)
				echo "The base platform is never run."
			;;
			nats)
				docker run -d --name=nats -i -t cfd/nats
				sudo ./pipework/pipework br1 nats 192.168.78.1/24

			;;
			test)
				docker run -d --name=test -i -t cfd/test 
				sudo ./pipework/pipework br1 test 192.168.78.200/24
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
			test)
				docker start test
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
			test)
				docker stop test
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
			test)
				docker rm -f test
			;;
		esac
	;;
	test)
		case $container in
			base)
				echo "The base platform is never tested."
			;;
			nats)
				# NATS container tests go here.
			;;
			test)
				echo "testing the test container is meaningless."
			;;
		esac
	;;
esac

