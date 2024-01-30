# Nashville-Housing-Data-Cleaning
Welcome to the Nashville Housing SQL Data Cleaning repository! This repository contains SQL scripts for cleaning and preparing housing data in Nashville, Tennessee, extracted from the "portfolio project" database.

### Goal
The goal of this project is to perform data cleaning and preparation using SQL to ensure the dataset's quality and readiness for analysis. We aim to standardize date formats, populate missing property addresses, break down address fields into individual components (address, city, state), standardize "Sold As Vacant" values, and remove duplicate records.

### Dataset
The Nashville housing dataset comprises various fields such as UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, LegalReference, SoldAsVacant, OwnerName, OwnerAddress, Acreage, TaxDistrict, LandValue, BuildingValue, TotalValue, YearBuilt, Bedrooms, FullBath, and HalfBath. This dataset offers insights into property sales, ownership details, property characteristics, and transaction dates within the Nashville area.

### SQL Queries for Data Cleaning
- **Standardize Date Format:** Convert the SaleDate field to a standardized date format.
- **Populate Property Address Data:** Fill in missing property addresses by identifying and populating from other records with the same ParcelID.
- **Break Out Address Into Individual Columns:** Split the PropertyAddress field into separate columns for address, city, and state.
- **Split Owner Address:** Break down the OwnerAddress field into individual components (address, city, state).
- **Change Y and N to Yes and No in "Sold As Vacant" Field:** Standardize the "SoldAsVacant" field values.
- **Remove Duplicates:** Remove duplicate records based on specified criteria.
- **Drop Redundant Column:** Remove the SaleDate column after standardizing date formats.


