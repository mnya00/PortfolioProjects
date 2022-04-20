 /****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [PortfolioProject].[dbo].[NashvilleHousing]

  select*
  from PortfolioProject.dbo.NashvilleHousing 

  ---Standardize date format

  select saledateconverted, convert(date,saledate)
  from PortfolioProject.dbo.NashvilleHousing 

  update NashvilleHousing
  set saledate = convert(date,saledate)

  Alter table Nashvillehousing
  add Saledateconverted Date;

  update NashvilleHousing
  set Saledateconverted = convert(date,saledate)


  ---populate property address data

  select *
  from PortfolioProject.dbo.NashvilleHousing
  --where PropertyAddress is null
  order by ParcelID

  select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress, b.propertyaddress)
  from PortfolioProject.dbo.NashvilleHousing a
  join PortfolioProject.dbo.NashvilleHousing b
  on a.ParcelID = b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null

  Update a
  set propertyaddress = isnull(a.propertyaddress, b.propertyaddress)
  from PortfolioProject.dbo.NashvilleHousing a
  join PortfolioProject.dbo.NashvilleHousing b
  on a.ParcelID = b.ParcelID
  and a.[UniqueID ] <> b.[UniqueID ]
  where a.PropertyAddress is null


  ---Breaking out address into individual columns (address, city, state)


  select propertyaddress
   from PortfolioProject.dbo.NashvilleHousing
  --where PropertyAddress is null
  --order by ParcelID

  --Using substring and length to separate address before and after the comma

  Select
  SUBSTRING(Propertyaddress, 1, Charindex(',', Propertyaddress)-1) as address
  ,SUBSTRING(Propertyaddress, Charindex(',', Propertyaddress)+1, LEN(PropertyAddress)) as address

 from PortfolioProject.dbo.NashvilleHousing

 Alter table NashvilleHousing
  add PropertySplitaddress Nvarchar(255);

  update NashvilleHousing
  set PropertySplitaddress = SUBSTRING(Propertyaddress, 1, Charindex(',', Propertyaddress)-1)

  Alter table Nashvillehousing
  add PropertySplitCity Nvarchar(255);

  update NashvilleHousing
  set PropertySplitCity = SUBSTRING(Propertyaddress, Charindex(',', Propertyaddress)+1, LEN(PropertyAddress))

  select*
  from PortfolioProject.dbo.NashvilleHousing 

    select OwnerAddress
  from PortfolioProject.dbo.NashvilleHousing 


  select
  PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)
  ,PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)
  ,PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
    from PortfolioProject.dbo.NashvilleHousing 


	 Alter table Nashvillehousing
  add OwnerSplitAddress Nvarchar(255);

  update NashvilleHousing
  set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3)

   Alter table Nashvillehousing
  add OwnerSplitCity Nvarchar(255);

  update NashvilleHousing
  set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)

   Alter table Nashvillehousing
  add OwnerSplitState Nvarchar(255);

  update NashvilleHousing
  set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)



  ---Change Y and N to Yes and No in 'Sold as Vacant' field

  select distinct(Soldasvacant), count(Soldasvacant)
  from PortfolioProject.dbo.NashvilleHousing
  group by SoldAsVacant
  order by 2



select SoldasVacant
, Case when Soldasvacant = 'Y'then 'Yes'
when Soldasvacant = 'N'then 'No'
else SoldasVacant
end
from PortfolioProject.dbo.NashvilleHousing


Update NashvilleHousing
set SoldAsVacant =  Case when Soldasvacant = 'Y'then 'Yes'
when Soldasvacant = 'N'then 'No'
else SoldasVacant
end
from PortfolioProject.dbo.NashvilleHousing



---Remove duplicates


WITH RowNumCTE As(
Select*,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
PropertyAddress,
SalePrice,
SaleDate,
LegalReference
ORDER BY
UniqueID
) row_num

from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
select*
from RowNumCTE
where row_num> 1
Order by PropertyAddress


WITH RowNumCTE As(
Select*,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
PropertyAddress,
SalePrice,
SaleDate,
LegalReference
ORDER BY
UniqueID
) row_num

from PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
DELETE
from RowNumCTE
where row_num> 1
--Order by PropertyAddress




---Delete Unused Columns



Alter table PortfolioProject.dbo.NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate