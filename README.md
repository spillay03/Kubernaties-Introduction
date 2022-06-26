# Introduction to Kubernaties


<ul>
<li>Terraform code will create EC2 and ECR in AWS Cloud 9 enviroment </li>
<li>The K8-Manifest  folder contains manifest files to create pods, replicasets, deployment and NodePort Service </li>
</ul>



# Requirements
<table><th> Name</th> <th> Version </th>
  <tr><td>aws</td><td>>= 3.72r</td></tr>
  <tr><td>terraform</td><td>>= 0.13.1</td></tr>
  </table>
  
# Providers
<table><th> Name</th> <th> Version </th>
  <tr><td>aws</td><td>>= 3.72r</td></tr>
   </table>
   
   
# User Inputs

<ul>
<li> Deploy EC2 and ECR using Terraform code, Create Kind Cluster with one node  </li>
  </ul>
<table>
  <tr>
    <td>ssh-keygen -f week5<br>
    alias tf=terraform<br>
  tf init<br>
  tf apply --auto-approve<br>
  scp -i week5 init_kind.sh kind.yaml <"host ip">:/tmp<br>
  ssh -i week5 <"host ip"><br>
  cd /tmp<br>
  chmod 777 init_kind.sh<br>
  chmod 777 kind.yaml<br> 
  ./init_kind.sh <br>
  kubectl get nodes<br>
  alias k=kubectl<br>
      k cluster-info <br></tr>
   </table>


<ul>
<li> Run the following commands to deploy pPods, ReplicaSet, Deploymenet and Serve Manifest  </li>
  </ul>
<table>
    <tr>
    <td>kubectl apply -f /tmp/cats-pods.yaml -n cats<br>
      kubectl apply -f /tmp/cats-rs.yaml -n cats<br>
     kubectl apply  -f /tmp/cats-deployment.yaml -n cats<br>
     kubectl apply  -f /tmp/cats-ServiceNodePort.yaml -n cats<br>
      kubectl get all -n cats<br>
          </tr>
      </table>

 # Author
 

Sneha Pillay

 
# Acknowledgement
 
<b>Prof. Irina Geiman for her kind guidance and timely help  &#128512;</b>



