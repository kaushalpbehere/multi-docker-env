
#declare -a allRepositories=("<Name of Repository 1>::<RepositoryUrl1>@@<BranchName1>" "<Name of Repository 2>::<RepositoryUrl2>@@<BranchName2>")

declare -a allRepositories=("lab-work-server::https://github.com/lab-work-projects/lab-work-server.git@@dev/kaushalb" "lab-work-client::https://github.com/lab-work-projects/lab-work-client.git@@dev/kaushalb")

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
       
       echo "Installing npm packages..."
       npm prune 
       npm i
       echo "List of installed packages ..."
       npm ll

    else 
        git clone -b $branchName $url

        echo "Resetting...."
        git reset --hard 
        git pull 
    fi
    echo "Installing npm packages..."
    cd $repositoryName
    npm i 
    cd ..
done 
