if [ $# -ne 3 ]; then
echo "parameter error！"
fi

echo $1
echo $2
echo $3

WORKSPACE=/opt/project/code
SONAE_CONFIGFILE=sonar-project.properties
SOANR_HOME=/app/sonar-scanner-2.9.0.670/
SCANNER=bin/sonar-scanner
cd $WORKSPACE
PROJECT=$1
CODE_ADDRESS=$2
LANGUAGE=$3

mkdir -p $PROJECT

X=`echo $CODE_ADDRESS | grep ".git" | wc -l`

creat_file(){
echo sonar.projectKey=$1_$2 > $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.projectName=$1_$2 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.projectVersion=1.0 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.sources=$1_$2 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.language=$1 >> $WORKSPACE/$SONAE_CONFIGFILE
echo sonar.sourceEncoding=UTF-8 >> $WORKSPACE/$SONAE_CONFIGFILE
$SOANR_HOME$SCANNER

}



if [ "$X" == "0" ]
then
svn checkout $CODE_ADDRESS $LANGUAGE"_"$PROJECT --username username --password password --no-auth-cache
else
git clone  http://username:password@$CODE_ADDRESS $LANGUAGE"_"$PROJECT 
fi

creat_file $LANGUAGE $PROJECT

