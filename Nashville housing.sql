use [portfolio project]



-- Standardize Date format

select SaleDateConverted, CONVERT(Date, SaleDate)
from NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)




-- Populate Property Address data


select *
from NashvilleHousing
--where PropertyAddress is null
order by ParcelID


select house_1.ParcelID, house_1.PropertyAddress, house_2.ParcelID, house_2.PropertyAddress, ISNULL(house_1.PropertyAddress, house_2.PropertyAddress)
from NashvilleHousing house_1
JOIN NashvilleHousing house_2
	on house_1.ParcelID = house_2.ParcelID
	and house_1.[UniqueID ] <> house_2.[UniqueID ]
where house_1.PropertyAddress is null


Update house_1
SET PropertyAddress = ISNULL(house_1.PropertyAddress, house_2.PropertyAddress)
from NashvilleHousing house_1
JOIN NashvilleHousing house_2
	on house_1.ParcelID = house_2.ParcelID
	and house_1.[UniqueID ] <> house_2.[UniqueID ]
where house_1.PropertyAddress is null




-- Breaking out Address into individual columns (Address, City, State)


select PropertyAddress
from NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
from NashvilleHousing

ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


select PropertySplitAddress, PropertySplitCity
from NashvilleHousing



select OwnerAddress
from NashvilleHousing

select 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
from NashvilleHousing


ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

select *
from NashvilleHousing






-- Change Y and N to Yes and No in "Sold As Vacant" field


select distinct(SoldAsVacant), Count(SoldAsVacant)
from NashvilleHousing
Group by SoldAsVacant

Update NashvilleHousing
SET SoldAsVacant = 'Yes'
where SoldAsVacant = 'Y';

Update NashvilleHousing
SET SoldAsVacant = 'No'
where SoldAsVacant = 'N';




-- Remove Duplicates

WITH RowNumCTE As (
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelId,
				PropertyAddress,
				SalePrice,
				LegalReference
				ORDER BY UniqueId
				) row_num
from NashvilleHousing
)
DELETE
from RowNumCTE
Where row_num > 1
 -- order by PropertyAddress


ALTER TABLE NashvilleHousing
DROP COLUMN SaleDate


Select *
From NashvilleHousing