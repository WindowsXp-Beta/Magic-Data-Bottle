# Magic Data Bottle
Our goal is to design and implement a secure personal data analysis and storage system.

# Repo Structure
## app
An android app written in [flutter](https://flutter.dev/) in which users can import, display and use their own personal data.
## blockchain_dashboard
A dashboard which indicates if the transaction has been recorded into a blockchain.
## secure_storage
The TA(trusted application) which communicates with the [OPTEE](https://www.op-tee.org/) and stores all the data with no leakage crisis even the host OS(AOSP in this case) has been hacked.
## tools
Tools consists of a mail_crawler and a pdf-to-csv transformation tool.