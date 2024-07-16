// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Mailbox} from "../solidity/contracts/Mailbox.sol";

contract MailboxScript is Script {
    Mailbox public mailbox;
    uint32 localDomain = 1;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        mailbox = new Mailbox(localDomain);

        vm.stopBroadcast();
    }
}
