terraform { 
  cloud { 
    
    organization = "Naveen_org" 

    workspaces { 
      name = "aws-s3-bucket-kk" 
    } 
  } 
}