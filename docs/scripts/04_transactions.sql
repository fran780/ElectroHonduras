CREATE TABLE `transactions` (
    `transactionId` INT NOT NULL AUTO_INCREMENT,
    `usercod` BIGINT(10) NOT NULL,
    `orderid` VARCHAR(128) NOT NULL,
    `transdate` DATETIME NOT NULL,
    `transstatus` VARCHAR(45) NOT NULL,
    `amount` DECIMAL(10,2) NOT NULL,
    `currency` VARCHAR(5) NOT NULL,
    `orderjson` JSON NOT NULL,
    PRIMARY KEY (`transactionId`),
    KEY `fk_transactions_user_idx` (`usercod`),
    CONSTRAINT `fk_transactions_user` FOREIGN KEY (`usercod`) REFERENCES `usuario`(`usercod`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;