pragma solidity ^0.9.0;

contract NFT {
    mapping (uint256 => address) public owners;
    mapping (uint256 => string) public imageHashes;
    uint256 public totalSupply;
    string public name;
    string public symbol;
    string public website;
    address[] public authorizedAddresses;
    address public owner;

    constructor(string memory _name, string memory _symbol, string memory _website) public {
        name = _name;
        symbol = _symbol;
        website = _website;
        owner = msg.sender;
    }

    function mint(address _to, uint256 _tokenId, string memory _imageHash) public {
        require(totalSupply < 100, "Too many NFTs already minted");
        require(owners[_tokenId] == address(0), "NFT already exists");

        owners[_tokenId] = _to;
        imageHashes[_tokenId] = _imageHash;
        totalSupply++;
    }

    function addAuthorizedAddress(address _address) public {
        require(msg.sender == owner, "Only owner can add authorized addresses");
        authorizedAddresses.push(_address);
    }

    function burn(uint256 _tokenId) public {
        address caller = msg.sender;
        require(caller == owner || isAuthorized(caller), "Address not authorized");
        require(owners[_tokenId] == caller, "Caller does not own this NFT");

        owners[_tokenId] = address(0);
        imageHashes[_tokenId] = "";
        totalSupply--;
    }

    function setImage(uint256 _tokenId, string memory _imageHash) public {
        address caller = msg.sender;
        require(caller == owner || isAuthorized(caller), "Address not authorized");
        require(owners[_tokenId] == caller, "Caller does not own this NFT");

        imageHashes[_tokenId] = _imageHash;
    }

    function isAuthorized(address _address) internal view returns (bool) {
        for (uint256 i = 0; i < authorizedAddresses.length; i++) {
            if (_address == authorizedAddresses[i]) {
                return true;
            }
        }
        return false;
    }
}
