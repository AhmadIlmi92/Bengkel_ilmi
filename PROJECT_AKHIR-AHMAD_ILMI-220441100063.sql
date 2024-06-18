SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";



CREATE TABLE IF NOT EXISTS `admin` (
  `id_adm` INT(11) NOT NULL,
  `nama_adm` VARCHAR(50) NOT NULL,
  `telp_adm` VARCHAR(15) NOT NULL,
  `user_adm` VARCHAR(50) NOT NULL,
  `pass_adm` VARCHAR(100) NOT NULL,
  `foto_adm` TEXT NOT NULL
) ENGINE=INNODB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;



INSERT INTO `admin` (`id_adm`, `nama_adm`, `telp_adm`, `user_adm`, `pass_adm`, `foto_adm`) VALUES
(1, 'Administrator', '08962878534', 'admin', 'admin', 'user.jpg');



CREATE TABLE IF NOT EXISTS `barangjasa` (
  `id_brg` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jenis` varchar(20) NOT NULL,
  `stok` varchar(10) NOT NULL,
  `harga` varchar(20) NOT NULL,
  `keterangan` text NOT NULL,
  `id_adm` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;



INSERT INTO `barangjasa` (`id_brg`, `nama`, `jenis`, `stok`, `harga`, `keterangan`, `id_adm`) VALUES
(1, 'Oli Yamalube 800cc', 'barang', '12', '35000', 'Oli Yamalube 800cc', 1),
(4, 'Paket Service Ekonomis', 'jasa', '1', '30000', 'Ekonomis', 1),
(5, 'Suspensi Matic', 'barang', '5', '175000', 'Suspensi matic', 1);



CREATE TABLE IF NOT EXISTS `kasir` (
  `id_kasir` int(11) NOT NULL,
  `nama_kasir` varchar(50) NOT NULL,
  `telp_kasir` varchar(20) NOT NULL,
  `user_kasir` varchar(50) NOT NULL,
  `pass_kasir` varchar(100) NOT NULL,
  `foto_kasir` text NOT NULL,
  `id_adm` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;


INSERT INTO `kasir` (`id_kasir`, `nama_kasir`, `telp_kasir`, `user_kasir`, `pass_kasir`, `foto_kasir`, `id_adm`) VALUES
(1, 'Test Kasir', '0210181928', 'kasir', 'password', '06062019071454r.jpg', 1);

-- --------------------------------------------------------



CREATE TABLE IF NOT EXISTS `konsumen` (
  `id_kon` int(11) NOT NULL,
  `nama_kon` varchar(50) NOT NULL,
  `telp_kon` varchar(20) NOT NULL,
  `alamat_kon` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;



INSERT INTO `konsumen` (`id_kon`, `nama_kon`, `telp_kon`, `alamat_kon`) VALUES
(0, 'Umum', '0', '-'),
(3, 'Test Konsumen', '012391839', 'Bekasi');



CREATE TABLE IF NOT EXISTS `supplier` (
  `id_spl` int(11) NOT NULL,
  `nama_spl` varchar(50) NOT NULL,
  `telp_spl` varchar(20) NOT NULL,
  `alamat_spl` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;



INSERT INTO `supplier` (`id_spl`, `nama_spl`, `telp_spl`, `alamat_spl`) VALUES
(2, 'Test Supplier', '08129828919', 'Bekasi'),
(3, 'Supplier Oli', '012123910', 'Bekasi\r\n');



CREATE TABLE IF NOT EXISTS `tmp_trx` (
  `id_tmp` int(11) NOT NULL,
  `id_trx` varchar(20) NOT NULL,
  `id_brg` int(11) NOT NULL,
  `jml` int(11) NOT NULL,
  `id_kasir` int(11) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;



INSERT INTO `tmp_trx` (`id_tmp`, `id_trx`, `id_brg`, `jml`, `id_kasir`, `status`) VALUES
(2, '02062019094643', 4, 1, 1, 'Done'),
(4, '02062019094643', 1, 2, 1, 'Done'),
(7, '02062019120923', 4, 1, 1, 'Done'),
(8, '02062019121127', 4, 1, 1, 'Done'),
(10, '06062019094346', 1, 1, 1, 'Done'),
(11, '06062019100803', 4, 1, 1, 'Done');



CREATE TABLE IF NOT EXISTS `trx` (
  `id_trx` varchar(20) NOT NULL,
  `id_kon` int(11) NOT NULL,
  `tgl_trx` date NOT NULL,
  `total` varchar(20) NOT NULL,
  `id_kasir` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT INTO `trx` (`id_trx`, `id_kon`, `tgl_trx`, `total`, `id_kasir`) VALUES
('02062019094643', 0, '2019-06-02', '100000', 1),
('02062019120923', 3, '2019-06-02', '30000', 1),
('02062019121127', 0, '2019-06-02', '30000', 1),
('06062019094346', 0, '2019-06-06', '35000', 1),
('06062019100803', 3, '2019-06-06', '30000', 1);



CREATE TABLE IF NOT EXISTS `trxbarang` (
  `id_trxbrg` varchar(20) NOT NULL,
  `tgl_trxbrg` date NOT NULL,
  `id_brg` int(11) NOT NULL,
  `id_spl` int(11) NOT NULL,
  `jml_brg` int(11) NOT NULL,
  `ket_trxbrg` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT INTO `trxbarang` (`id_trxbrg`, `tgl_trxbrg`, `id_brg`, `id_spl`, `jml_brg`, `ket_trxbrg`) VALUES
('00365602062019', '2019-06-02', 1, 3, 10, 'Oli'),
('04184902062019', '2019-06-02', 5, 2, 5, 'suspensi'),


CREATE VIEW view_kasir AS
SELECT k.id_kasir, k.nama_kasir, k.telp_kasir, k.user_kasir, a.nama_adm
FROM kasir 
INNER JOIN admin a ON k.id_adm = a.id_adm;


CREATE VIEW vw_transaksi_barang AS
SELECT tb.id_trxbrg, tb.tgl_trxbrg, b.nama AS nama_barang, s.nama_spl AS nama_supplier, tb.jml_brg, tb.ket_trxbrg
FROM trxbarang 
INNER JOIN barangjasa b ON tb.id_brg = b.id_brg
INNER JOIN supplier s ON tb.id_spl = s.id_spl;


CREATE VIEW vw_transaksi_penjualan AS
SELECT t.id_trx, k.nama_kon, t.tgl_trx, t.total, kas.nama_kasir
FROM trx 
LEFT JOIN konsumen k ON t.id_kon = k.id_kon
LEFT JOIN kasir kas ON t.id_kasir = kas.id_kasir;


CREATE VIEW vw_barangjasa_admin AS
SELECT bj.id_brg, bj.nama, bj.jenis, bj.stok, bj.harga, bj.keterangan, a.nama_adm
FROM barangjasa 
INNER JOIN admin a ON bj.id_adm = a.id_adm;


DELIMITER //
CREATE PROCEDURE add_konsumen(
    IN p_nama VARCHAR(50),
    IN p_telp VARCHAR(20),
    IN p_alamat TEXT
)
BEGIN
    INSERT INTO konsumen (nama_kon, telp_kon, alamat_kon)
    VALUES (p_nama, p_telp, p_alamat);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE update_stok(
    IN p_id_brg INT,
    IN p_stok INT
)
BEGIN
    UPDATE barangjasa
    SET stok = p_stok
    WHERE id_brg = p_id_brg;
END //
DELIMITER ;

DELIMITER // 
CREATE PROCEDURE lihat_transaksi()
BEGIN
    SELECT * FROM trx;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE add_transaksi(
    IN p_id_kon INT,
    IN p_tgl DATE,
    IN p_total VARCHAR(20),
    IN p_id_kasir INT
)
BEGIN
    INSERT INTO trx (id_trx, id_kon, tgl_trx, total, id_kasir)
    VALUES (CONCAT(DATE_FORMAT(p_tgl, '%Y%m%d'), LPAD(FLOOR(RAND() * 10000), 4, '0')), p_id_kon, p_tgl, p_total, p_id_kasir);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE add_barang(
    IN p_nama VARCHAR(100),
    IN p_jenis VARCHAR(20),
    IN p_stok VARCHAR(10),
    IN p_harga VARCHAR(20),
    IN p_keterangan TEXT,
    IN p_id_adm INT
)
BEGIN
    INSERT INTO barangjasa (nama, jenis, stok, harga, keterangan, id_adm)
    VALUES (p_nama, p_jenis, p_stok, p_harga, p_keterangan, p_id_adm);
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER after_tmp_trx_insert
AFTER INSERT ON tmp_trx
FOR EACH ROW
BEGIN
    UPDATE barangjasa
    SET stok = stok - NEW.jml
    WHERE id_brg = NEW.id_brg;
END //
DELIMITER ;


DELIMITER //
CREATE TRIGGER after_tmp_trx_delete
AFTER DELETE ON tmp_trx
FOR EACH ROW
BEGIN
    UPDATE barangjasa
    SET stok = stok + OLD.jml
    WHERE id_brg = OLD.id_brg;
END //
DELIMITER ;


