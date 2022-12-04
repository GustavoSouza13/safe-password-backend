-- Passos para execução da Blockchain --

1. Necessário ter o Geth instalado na máquina com as Development Tools; (Link para download: https://geth.ethereum.org/downloads/)
2. Abra o terminal na pasta raiz do projeto safe-password-backend;
3. Caso seja a primeira vez executando a Blockchain, execute o comando: geth --datadir Blockchain/ init Blockchain/safepass.json
4. Execute o comando abaixo:

geth --networkid 1234 --datadir Blockchain/ --port 30303 --ipcdisable --syncmode full --http --http.addr 0.0.0.0 --http.api admin,eth,miner,net,txpool,personal,web3 --allow-insecure-unlock --http.corsdomain "*" --http.vhosts "*" --http.port 8545 --unlock 0xfb6411fcb57dd3b48c7ae2a9c4cf22d5cff980b3 --mine console --password Blockchain/password.txt --ws --ws.port 8546 --ws.origins "*" --ws.api admin,eth,miner,net,txpool,personal,web3

geth --networkid 1234 --datadir Blockchain/ --port 30303 --http --http.addr 0.0.0.0 --http.api admin,eth,miner,net,txpool,personal,web3 --allow-insecure-unlock --http.corsdomain "*" --http.vhosts "*" --http.port 8545 --unlock 0xfb6411fcb57dd3b48c7ae2a9c4cf22d5cff980b3 --mine console --password Blockchain/password.txt --ws --ws.port 8546 --ws.origins "*" --ws.api admin,eth,miner,net,txpool,personal,web3 --miner.gasprice 0

5. Pronto, a Blockchain foi criada e está em execução.


-- Passos para deploy dos SmartContracts --

1. Necessário o Truffle instalado na máquina.
  1.1 Para instalar o Truffle execute o comando a seguir no terminal: npm install truffle -g
2. Com a Blockchain já em execução e o Truffle instalado, entre na pasta raiz do projeto safe-password-backend;
3. Execute o comando: truffle compile
4. Execute o comando: truffle migrate
5. Pronto, foram feitos os deploys dos SmartContracts.

* ATENÇÃO, SEMPRE QUE EXECUTAR O COMANDO "truffle migrate" É NECESSÁRIO COPIAR OS ARQUIVOS .JSON PARA PASTA DO PROJETO FRONTEND*