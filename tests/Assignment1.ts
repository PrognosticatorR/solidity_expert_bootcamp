import { expect } from "chai";
import { ethers } from "hardhat";
import { Assignment1 } from "../typechain-types";

describe("Assignment1", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deploy() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();
    const DAY2 = await ethers.getContractFactory("Assignment1");
    const contract = await DAY2.deploy();
    return { contract, owner, otherAccount };
  }
  let contract: Assignment1;
  this.beforeAll(async function () {
    const data = await deploy();
    contract = data.contract;
  });
  describe("RemoveElement", function () {
    it("must remove elements by indexes", async function () {
      const arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
      const indexes = [2, 5, 8];
      let data: any = arr;
      for (let idx = 0; idx < indexes.length; idx++) {
        data = await contract.removeElement(data, idx);
      }
      expect(data.length).to.equal(arr.length - indexes.length);
      for (let i = 0; i < indexes.length; i++) {
        expect(data).to.not.includes(indexes[i]);
      }
    });
  });

  describe("removeWithOrder", function () {
    it("must remove elements while preserving initial state", async function () {
      const arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
      const indexes = [2, 5, 8];
      let data: any = arr;
      for (let idx = 0; idx < indexes.length; idx++) {
        data = await contract.removeWithOrder(data, idx);
      }
      expect(data.length).to.equal(arr.length - indexes.length);
      for (let i = 0; i < indexes.length; i++) {
        expect(data).to.not.includes(indexes[i]);
      }
      for (let i = 0; i < data.length - 1; i++) {
        expect(data[i]).to.be.lessThanOrEqual(data[i + 1]);
      }
    });
  });
});
