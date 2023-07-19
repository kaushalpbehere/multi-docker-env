
#declare -a allRepositories=("<Name of Repository 1>::<RepositoryUrl1>@@<BranchName1>" "<Name of Repository 2>::<RepositoryUrl2>@@<BranchName2>")

declare -a allRepositories=("weatherApp::https://github.com/kaushalpbehere/WeatherApplication.git@@main" "FollowApp::https://github.com/kaushalpbehere/FollowApp@@main" "LocationBasedSearch::https://github.com/kaushalpbehere/LocationBasedSearch@@main" "DesignPatterns::https://github.com/kaushalpbehere/DesignPatterns@@main" "NetDesignPatterns::https://github.com/kaushalpbehere/NetDesignPatterns@@main")

for eachRepository in "${allRepositories[@]}";
 do 
 	repositoryName="${eachRepository%%::*}"
    repositoryUrl="${eachRepository%%@@*}"
    url="${repositoryUrl##*::}"
    branchName="${eachRepository##*@@}"

    echo "Cloning $repositoryName - $url - $branchName ..."
    
    if [ -d "$repositoryName" ]
	then 
	    if [ "$(ls -A $repositoryName)" ]; then
         #echo "Take action $repositoryName is not Empty"
         cd $(echo $repositoryName)
         git checkout $branchName
         git branch --list
         git pull
	    else
        echo "$eachRepository is Empty"
	    fi
	else 
        git clone -b $branchName $url

        echo "Resetting...."
        git reset --hard 
        git pull 
    fi
done 