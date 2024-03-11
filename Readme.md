## Content
```
1. Backend Initialization
2. Provider Configuration
3. VPC Creation
4. Subnet Creation
5. Firewall Configuration
6. Instance Creation
7. Bucket Creation
```
```
# list all resources
terraform state list

# remove that resource you don't want to destroy
# you can add more to be excluded if required
terraform state rm <resource_to_be_deleted> 

# destroy the whole stack except above excluded resource(s)
terraform destroy

```
