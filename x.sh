if [ $# -ne 3 ]; then
echo "parameter error！"
fi

WORKSPACE=/application/workspace/sonarwork/
SONAE_CONFIGFILE=sonar-project.properties
SOANR_HOME=/application/sonar-scanner-3.3.0.1492-linux/
SCANNER=bin/sonar-scanner
cd $WORKSPACE
PROJECT=$1
CODE_ADDRESS=$2
LANGUAGE=$3

mkdir -p $LANGUAGE"_"$PROJECT

X=`echo $CODE_ADDRESS | grep ".git" | wc -l`

creat_file(){
echo sonar.projectKey=$1_$2 > $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.projectName=$1_$2 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.projectVersion=1.0 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.sources=$1_$2 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.language=$1 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.java.binaries=target/classes >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.sourceEncoding=UTF-8 >> $WORKSPACE/$SONAE_CONFIGFILE
$SOANR_HOME$SCANNER
}


if [ "$X" == "0" ]
then
echo $LANGUAGE"_"$PROJECT
echo $CODE_ADDRESS
pwd
svn checkout $CODE_ADDRESS $LANGUAGE"_"$PROJECT --username username --password password --no-auth-cache
else
git clone  http://username:password@$CODE_ADDRESS $LANGUAGE"_"$PROJECT 
fi
cd $LANGUAGE"_"$PROJECT
mvn clean package
cd ..
creat_file $LANGUAGE $PROJECT
