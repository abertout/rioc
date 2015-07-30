function[product] = matrixVectorProduct(matrix, vector)

[numberOfRows, numberOfColumns] = size(matrix);

if( length(vector) ~= numberOfColumns )
    error('The length of the input vector must equal the number of columns of the input matrix.');
end

product = zeros(numberOfRows, 1);
parfor rowIndex = 1 : numberOfRows
    product(rowIndex) = matrix(rowIndex,:) * vector;
end