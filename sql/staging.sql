-- =====================================================================
-- DDL TABEL STAGING (AREA TRANSIT) - DATA WAREHOUSE PEMBELIAN
-- Kelompok 10 | Target Pekan 12 (Steering Review Pekan 13)
-- Database Target : dwh_kelompok_10
-- Database Sumber : dw_kelompok_10 (AdventureWorks)
-- =====================================================================

USE dwh_kelompok_10;

-- ---------------------------------------------------------------------
-- 1. STAGING TABEL DIMENSI
-- ---------------------------------------------------------------------

-- Staging Vendor (dim_vendor)
CREATE TABLE IF NOT EXISTS stg_vendor LIKE dw_kelompok_10.purchasing_vendor;

-- Staging Metode Kirim (dim_metode_kirim)
CREATE TABLE IF NOT EXISTS stg_shipmethod LIKE dw_kelompok_10.purchasing_shipmethod;

-- Staging Karyawan & Kontak Orang (dim_karyawan)
CREATE TABLE IF NOT EXISTS stg_employee LIKE dw_kelompok_10.humanresources_employee;
CREATE TABLE IF NOT EXISTS stg_person LIKE dw_kelompok_10.person_person;

-- Staging Produk, Kategori, & Riwayat Biaya SCD 2 (dim_produk)
CREATE TABLE IF NOT EXISTS stg_product LIKE dw_kelompok_10.production_product;
CREATE TABLE IF NOT EXISTS stg_productcosthistory LIKE dw_kelompok_10.production_productcosthistory;
CREATE TABLE IF NOT EXISTS stg_productmodel LIKE dw_kelompok_10.production_productmodel;
CREATE TABLE IF NOT EXISTS stg_productsubcategory LIKE dw_kelompok_10.production_productsubcategory;
CREATE TABLE IF NOT EXISTS stg_productcategory LIKE dw_kelompok_10.production_productcategory;

-- ---------------------------------------------------------------------
-- 2. STAGING TABEL FAKTA (fact_pembelian)
-- ---------------------------------------------------------------------

-- Staging Header Purchase Order
CREATE TABLE IF NOT EXISTS stg_purchaseorderheader LIKE dw_kelompok_10.purchasing_purchaseorderheader;

-- Staging Detail Baris Purchase Order (Grain Fakta)
CREATE TABLE IF NOT EXISTS stg_purchaseorderdetail LIKE dw_kelompok_10.purchasing_purchaseorderdetail;

-- ---------------------------------------------------------------------
-- 3. PEMERIKSAAN (Total harus ada 11 tabel stg_...)
-- ---------------------------------------------------------------------
SHOW TABLES LIKE 'stg_%';
