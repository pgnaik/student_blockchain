// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/access/Ownable.sol";

contract CertificateNFT is ERC721URIStorage, Ownable {

    uint256 private _tokenIds;

    struct Certificate {
        string studentName;
        string course;
    }

    mapping(uint256 => Certificate) public certificates;

    constructor() ERC721("UniversityCertificate", "UCERT") {}

    function mintCertificate(
        address student,
        string memory studentName,
        string memory course,
        string memory metadataURI   // ✅ JSON URL
    ) public onlyOwner {

        _tokenIds++;
        uint256 newTokenId = _tokenIds;

        _mint(student, newTokenId);

        // ✅ Set metadata URI
        _setTokenURI(newTokenId, metadataURI);

        certificates[newTokenId] = Certificate(
            studentName,
            course
        );
    }

    function getCertificate(uint256 tokenId)
        public
        view
        returns (
            string memory,
            string memory,
            string memory,
            address
        )
    {
        Certificate memory cert = certificates[tokenId];

        return (
            cert.studentName,
            cert.course,
            tokenURI(tokenId),
            ownerOf(tokenId)
        );
    }
}
