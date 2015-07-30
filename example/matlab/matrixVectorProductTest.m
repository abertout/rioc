function tests = matrixVectorProductTest
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)

    numberOfRows = randi([1 1000], 1, 1);
    numberOfColumns = randi([1 1000], 1, 1);
    
    testCase.TestData.randomVector = rand(numberOfColumns, 1);
    testCase.TestData.randomMatrix = rand(numberOfRows, numberOfColumns);
 
end

function testMatrixVectorProduct(testCase)

    expectedProduct = testCase.TestData.randomMatrix * testCase.TestData.randomVector;
    actualProduct = matrixVectorProduct(testCase.TestData.randomMatrix, testCase.TestData.randomVector);
    
    verifyEqual(testCase, actualProduct, expectedProduct, 'RelTol', 1e-12)

end