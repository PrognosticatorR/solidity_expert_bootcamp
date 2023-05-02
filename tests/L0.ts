import { expect } from "chai";
import { ethers } from "hardhat";
import { Level_1_Solution } from "../typechain-types";

describe("Assignment1", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deploy() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();
    const DAY2 = await ethers.getContractFactory("Level_1_Solution");
    const contract = await DAY2.deploy();
    return { contract, owner, otherAccount };
  }
  let contract: Level_1_Solution;
  this.beforeAll(async function () {
    const data = await deploy();
    contract = data.contract;
  });
  describe("return42", function () {
    it("must return desired value", async function () {
      const res = await contract.solution(
        [
          [2, 2],
          [2, 2],
        ],
        [
          [4, 4],
          [4, 4],
        ]
      );
      console.log(
        [
          ["2", "2"],
          ["2", "2"],
        ],
        [
          ["4", "4"],
          ["4", "4"],
        ]
      );

      console.log(res);

      // expect(res).to.be.equal(42);
    });
  });
});
