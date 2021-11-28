## Example ECS Service
This is an example of how I (or you, if you want to replicate this) would deploy some specific containerised workload to the Infinity cluster.  

---

### Things to remember:  
- Remove the `count` meta-argument, this is just here locally so I don't accidentally deploy these resources (tf doesn't seem to support an 'ignore' file)
- Ensure your image is written to the existing ECR repository (best practice is to perform the image build and push operations inside a CI/CD pipeline and run on change merge)
- Consider IAM roles with custom policies for ECS/ECR, and CloudWatch logs
