# GPU Open Analytics Initiative
#Accelerating the Scalable Data Science Environment with GPU-enabled Python

## KDD'18 Hands-On Tutorial
## Tuesday 8am

##![](https://nvidianews.nvidia.com/media/sites/219/images/logo.png)


***
### Tutorial Agenda

1, **Introduction and Background**  - 20 min  slides / discussion

- Who we are




1. Background Presentation (not hands-on) (20 mins)
a. Big Data Ecosystem
b. Challenges in Big Data today
i. Technology interoperability 
ii. Compute limitations
c. Apache Arrow
d. GPUs for compute
e. The GPU Open Analytics Initiative
f. The GPU Data Frame (GDF)
g. Python library for GDF (PyGDF)
2. Tutorial (hands-on) (2 hrs 20 mins)
a. GPU-Accelerated Database
i. Ingesting data
ii. Sample SQL queries
iii. Traditional interface through Pandas
iv. Zero-Copy GPU interface through PyGDF
b. GPU-Accelerated Data Manipulation
i. Pandas to/from PyGDF
ii. Non-SQL Filters
iii. Test-Train-Validate Split
iv. One-hot encoding
v. Sorting
vi. User-Defined Functions
c. Machine Learning Algorithms
i. GLM
ii. k-Means Clustering
iii. XGBoost
3. Conclusion Presentation (not hands-on) (15 mins)
a. Scaling out to multi-GPU and multi-node
i. Dask
ii. Dask GDF
b. Additional Algorithms and Roadmaps (not hands-on due to time constraints)
i. Graph Algorithms
1. PageRank, Jaccard, BFS
ii. Visualization
1. Graphistry
iii. Machine Learning Algorithms
c. Future Work
i. TensorRT Integration
ii. nvGraph migration to GDF