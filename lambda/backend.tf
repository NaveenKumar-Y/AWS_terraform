terraform { 
  cloud { 
    
    organization = "Naveen_org" 

    workspaces { 
      name = "aws-lambda-1" 
    } 
  } 
}