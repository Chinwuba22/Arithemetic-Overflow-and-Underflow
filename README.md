## Arithemetic Overflow and Underflow

**This type of hack occur as a result of a value going beyond its limit(overflow), or going below its limit(underflow).**

For example, uint8 max amount is 255(2^8 -1), any code which results to any addition in 255(assumption that it is a uint8), would result to 0. While it goes back to 255 when any code action tries to reduces it below 0.

Best way to reduce the potention of an overflow attack is to use a solidity version greater or equal 0.8.0, as **Solidity** made provisions to allow for overflow to be reverted and easy to detect on testing. There is however possibility that many other facctors could result to overflow even though the right solidity version is used. So developers should be very mindful of the varaibles they use to avoid attacks.

The simple code below is a prove that overflows are reverted in solididy version >=0.8.0 but not reverted in versions lesser than 0.8.0. You can copy to Remix to understand better.

```shell
// SPDX-License-Identifier: MIT
pragma solidity 0.7.2; //use any version lesser than 0.8.0 for testing

contract OverflowTest {
    uint8 value = 254

    function add() public {
        value ++;
    }

    function getValue() public view {
        return value;
    }
}
```

Another example can be seen in `.src/Timelock.sol` which uses solidity version 0.7.6. The code was expected to allow for only withdrawals after one week of making deposits but was able to exploited, as the contract allowed for this time frame to be changed by anyone. Hence, by causing an overflow in this timeframe(which made it result to zero) as seen in `./src/Attack.sol`, it will be possible to withdraw the balance immediately.

## TESTING

To test this contract simple run the following command:

1. Clone the Repo

```shell
git clone https://github.com/Chinwuba22/Arithemetic-Overflow-and-Underflow
```

2. Read and understand the contracts in `src` folder

3. Compile all file

```shell
forge build
```

or

```shell
forge compile
```

4. Read and understand the contracts in `test` folder

5. Run Test

```shell
forge test
```
