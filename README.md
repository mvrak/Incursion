# Incursion - Web3 RPG Game

A Godot-based RPG game that demonstrates Privy login integration and Web3 NFT functionality.

## Features

- **Privy Login Integration**: Web-based authentication using Privy's login system
- **Turn-based Combat**: Battle system with player and enemy entities
- **NFT Rewards**: Defeat enemies to earn NFT equipment
- **Web3 Integration**: Blockchain integration for NFT minting
- **Persistent Game Data**: Save/load system for player progress

## Project Structure

```
Incursion/
├── Assets/           # Game tilesets and textures
├── Scenes/          # Game scenes
│   ├── Login.tscn   # Login scene with Privy integration
│   ├── Dungeon.tscn # Battle scene
│   └── SwordDrop.tscn # Loot drop scene
├── Scripts/         # Game scripts
│   ├── LoginController.gd    # Handles Privy login
│   ├── BattleController.gd   # Manages combat
│   ├── GlobalGameData.gd     # Global game state
│   ├── Web3Integration.gd    # Web3 functionality
│   └── SwordDrop.gd          # Loot interaction
└── Sprites/         # Character sprites and animations
```

## Setup Instructions

### 1. Prerequisites

- Godot 4.4 or later
- Privy account and API keys
- Web3 provider (e.g., Infura, Alchemy)
- Smart contract for NFT minting

### 2. Configuration

#### Privy Integration

1. Update the `PRIVY_LOGIN_URL` in `Scripts/LoginController.gd`
2. Configure your Privy app settings
3. Set up proper authentication callbacks

#### Web3 Configuration

1. Update `web3_provider` in `Scripts/Web3Integration.gd`
2. Set your NFT contract address
3. Configure network settings (mainnet/testnet)

### 3. Running the Game

1. Open the project in Godot
2. Set the main scene to `Scenes/Login.tscn`
3. Run the project

## Game Flow

### 1. Login Scene
- Displays Privy login interface in a web frame
- Waits for user authentication
- Captures wallet address after successful login
- Transitions to battle scene

### 2. Battle Scene
- Player faces off against an enemy
- Turn-based combat system
- Health bars and battle log
- Automatic combat progression

### 3. Victory & Rewards
- Upon defeating the enemy:
  - Sword loot drops
  - NFT is minted to player's wallet
  - Experience points awarded
  - Game data saved

## Web3 Integration

### NFT Minting

The game includes a simplified Web3 integration system that:

- Simulates NFT minting process
- Generates unique token IDs
- Stores transaction information
- Manages player inventory

### Smart Contract Requirements

Your NFT smart contract should implement:

```solidity
function mint(address to, uint256 tokenId, string memory tokenURI) external
function ownerOf(uint256 tokenId) external view returns (address)
function tokenURI(uint256 tokenId) external view returns (string memory)
```

## Customization

### Adding New Enemies

1. Create enemy sprites in the `Sprites/characters/` folder
2. Update the battle scene to include new enemies
3. Modify `BattleController.gd` for enemy-specific behavior

### New Equipment Types

1. Create equipment drop scenes
2. Update the loot system in `BattleController.gd`
3. Add new NFT metadata in `Web3Integration.gd`

### Enhanced Combat

1. Modify `BattleController.gd` for new combat mechanics
2. Add special abilities and status effects
3. Implement equipment bonuses

## Development Notes

### Current Limitations

- Simplified Web3 integration (simulation mode)
- Basic combat system
- Limited enemy variety
- Demo login simulation

### Future Enhancements

- Full Web3 library integration
- Multiple enemy types and AI
- Equipment system with stats
- Quest system
- Multiplayer support
- Enhanced graphics and animations

## Troubleshooting

### Common Issues

1. **Web Frame Not Loading**: Check internet connection and Privy URL
2. **Script Errors**: Verify all script files are in the correct locations
3. **Scene Loading Issues**: Check scene file paths and dependencies
4. **Web3 Connection**: Verify provider URLs and network settings

### Debug Mode

Enable debug output by checking the console for:
- Login status messages
- Battle progression
- Web3 integration logs
- Error messages

## License

This project is provided as a proof of concept for educational purposes. Modify and extend as needed for your specific use case.

## Support

For issues and questions:
1. Check the console output for error messages
2. Verify all dependencies are properly configured
3. Ensure Godot version compatibility
4. Review Web3 and Privy documentation

## Contributing

Feel free to submit improvements and bug fixes. Focus areas:
- Enhanced Web3 integration
- Improved combat mechanics
- Better UI/UX
- Performance optimizations
- Additional game features
