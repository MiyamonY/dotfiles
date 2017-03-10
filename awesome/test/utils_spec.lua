local utils = require "utils"

describe("utils test.", function()
            describe("test for array join.", function()
                        it("join arrays.", function()
                              assert.are.same({1,2,3,4,5}, utils.array_join({1,2,3}, {4,5}))
                        end)

                        it("join nil to array.", function()
                              assert.are.same({1,2,3}, utils.array_join({1,2,3}, nil))
                        end)

                        it("join array to nil", function()
                              assert.are.same({1,2,3}, utils.array_join(nil, {1,2,3}))
                        end)

                        it("join nil to nil", function()
                              assert.are.same({}, utils.array_join(nil, nil))
                        end)
            end)

end)
