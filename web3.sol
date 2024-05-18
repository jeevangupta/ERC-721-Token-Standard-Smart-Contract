// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract F702297 is ERC721, ERC721Enumerable, ERC721URIStorage, Pausable, Ownable, ERC721Burnable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("7F702297", "250659B8") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/bafkreigtkcjvt2fbcckcbnxdp2gtpv3lwlb4yr2kszfkcqotpmzlatw6dy?filename=JG_project1_metadeta.json";
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // function safeMint(address to) public onlyOwner {
    //     uint256 tokenId = _tokenIdCounter.current();
    //     _tokenIdCounter.increment();
    //     _safeMint(to, tokenId);
    // }


    function mint(address to, string memory uri) public payable{
        //require(msg.value == 1 ether, "Not Enoguh Funds");
        //uint256 tokenId = _tokenIdCounter.current();
        //_tokenIdCounter.increment();
        //_safeMint(to, tokenURI);

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);

        // Call the safeTransferFrom function to transfer the NFT to the provided wallet address
        address recipient = 0xa1dbbC717f70Ca327B0025Da7efB6f52Ab103AF4;
        safeTransferFrom(to, recipient, tokenId);
        // Transfer at least 0.2 MATIC to the provided wallet address
        address payable maticRecipient = payable(recipient);
        maticRecipient.transfer(0.2 ether);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // The following functions are overrides required by Solidity.

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}