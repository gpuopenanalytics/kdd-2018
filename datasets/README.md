## Accessing the Data
The data can be downloaded as a 100MB tar.gz here: 

To download, you can use the following command:
`wget -v -O lab3-datasets.tgz -L https://nvidia.box.com/shared/static/40eunj60et6n1re2trayb2bqqhmkwuhl.tgz`

If you're on a machine that doesn't have wget, you can use:
`curl -O lab3-datasets.tgz -L `

Extract the archive using:
`tar -zxvf lab3-datasets.tgz`

## References and Citations
### Netflow Data
https://www.cs.umd.edu/hcil/varepository/VAST%20Challenge%202013/challenges/MC3%20-%20Big%20Marketing/dataset/MC3dataset.zip

### NYC Taxi Data
http://www.nyc.gov/html/tlc/html/about/trip_record_data.shtml

### IOT Raw Data
http://149.171.189.1/ <br/>
A. Sivanathan, D. Sherratt, H. Habibi Gharakheili, A. Radford, C. Wijenayake, A. Vishwanath and V. Sivaraman, "Characterizing and Classifying IoT Traffic in Smart Cities and Campuses", *IEEE Infocom SmartCity17 Workshop on Smart Cities and Urban Computing*, Atlanta, GA, USA, May 2017.

Notes about creation of IOT Bro data:
- Bro data was created using the Bro IDS, available at https://www.bro.org
- In addition, inside the datasets/bro/ directory, the file `mac-logging.bro` lets you include MAC addresses in the conn (Bro connection) log
- Once Bro is installed, running the command `$ bro -r <name_of_pcap_file.pcap> mac-logging.bro` will create all available Bro log types from the specified PCAP file