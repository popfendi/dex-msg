// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {IHooks} from "v4-core/src/interfaces/IHooks.sol";
import {Currency} from "v4-core/src/types/Currency.sol";

/// @notice Shared configuration between scripts
contract Config {
    /// @dev populated with default anvil addresses
    IERC20 constant token0 = IERC20(address(0));
    IERC20 constant token1 = IERC20(address(0xa5dfC0feE856D42Cd67c97eF1fa08497547f4419));
    IHooks constant hookContract = IHooks(address(0xF3445C02e84E3Af05b0F37D092c6e19D680B4040));

    Currency constant currency0 = Currency.wrap(address(token0));
    Currency constant currency1 = Currency.wrap(address(token1));
}
