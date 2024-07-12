// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../solidity/contracts/test/TestMailbox.sol";
import "../solidity/contracts/test/TestIsm.sol";
import "../solidity/contracts/test/TestRecipient.sol";
import "../solidity/contracts/test/TestPostDispatchHook.sol";
import {StandardHookMetadata} from "../solidity/contracts/hooks/libs/StandardHookMetadata.sol";




contract Empty {}

contract EmptyFallback {
    fallback() external {}
}

contract mailboxTest is Test {
    using StandardHookMetadata for bytes;
    using TypeCasts for address;
    using Message for bytes;

    uint32 localDomain = 1;
    uint32 remoteDomain = 2; // so the domain of the mailbox in wasmvm has to be 2 
    TestMailbox mailbox;

    // MerkleTreeHook merkleHook; *NOTE: really curious if the test passes without this hook

    TestPostDispatchHook defaultHook;
    TestPostDispatchHook overrideHook;
    TestPostDispatchHook requiredHook;

    TestIsm defaultIsm;
    TestRecipient recipient;
    bytes32 recipientb32;

    address owner;

    function setUp() public {
        mailbox = new TestMailbox(localDomain);
        recipient = new TestRecipient();
        recipientb32 = address(recipient).addressToBytes32();
        defaultHook = new TestPostDispatchHook();
        // merkleHook = new MerkleTreeHook(address(mailbox));
        requiredHook = new TestPostDispatchHook();
        overrideHook = new TestPostDispatchHook();
        defaultIsm = new TestIsm();

        owner = msg.sender;
        mailbox.initialize(
            owner,
            address(defaultIsm),
            address(defaultHook),
            address(requiredHook)
        );
    }

    function test_localDomain() public {
        assertEq(mailbox.localDomain(), localDomain);
    }

}