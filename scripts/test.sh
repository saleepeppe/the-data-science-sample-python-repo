#!/bin/bash
########
# VARS #
########
PROJECT_NAME="project"
TASK_NAME="task"

#############
# FUNCTIONS #
#############
function print_header {
    echo -e ''$_{1..30}'\b=';
    echo $1;
    echo -e ''$_{1..30}'\b=';
}

function validate_command {
    if [ $1 -eq 0 ]; then
        echo "PASSED!";
    else
        echo "FAILED!";
        exit $2
    fi;
}

# move to project root
project_root=$(dirname $(dirname $(realpath $0)));
cd $project_root;

##########
# TEST 1 #
##########
print_header "TEST 1. Execute python program";
cd src;
poetry run python main.py;
validate_command $? 1;
cd $project_root;
echo "";

##########
# TEST 2 #
##########
print_header "TEST 2. Test container building";
docker build -q -t ${PROJECT_NAME}/${TASK_NAME} --build-arg USERNAME=$USER .
validate_command $? 2;
echo ""

##########
# TEST 3 #
##########
print_header "TEST 3. Test container run";
docker run --name ${PROJECT_NAME}_${TASK_NAME} --rm ${PROJECT_NAME}/${TASK_NAME}
validate_command $? 3
echo ""
echo "Clean up:"
docker rmi ${PROJECT_NAME}/${TASK_NAME}
echo ""

##########
# TEST 4 #
##########
print_header "TEST 4. Test docker-compose";
docker-compose --log-level CRITICAL up --quiet
validate_command $? 4
echo ""
echo "Clean up:"
docker-compose down --rmi all --volumes
echo ""

##########
# TEST 5 #
##########
print_header "TEST 5. Test docker-compose prototype";
docker-compose --log-level CRITICAL -f docker-compose.prototype.yml up --detach --quiet
validate_command $? 5
echo ""
echo "Clean up:"
docker-compose -f docker-compose.prototype.yml down --rmi all --volumes
echo ""

exit 0;

##########
# TEST 6 #
##########
print_header "TEST 6. Test pipeline";
docker-compose --log-level CRITICAL -f docker-compose.pipeline.yml up --detach --quiet
validate_command $? 6
echo ""
echo "Clean up:"
docker-compose -f docker-compose.pipeline.yml down --rmi all --volumes
echo ""

exit 0;
