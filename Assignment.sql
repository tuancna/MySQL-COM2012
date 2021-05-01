-- TẠO DB
create database ps15194_assignment;

-- TẠO BẢNG
-- THỦ THƯ
create table ps15194_assignment.thuthu(
	maThuThu varchar(5) not null,
    tenThuThu varchar(255) not null,
    ngayVaoLam date not null,
    ngaySinh date not null,
    cmnd varchar(13) not null,
    primary key(maThuThu)
);

-- TÀI KHOẢN
create table ps15194_assignment.taikhoan(
	maTaiKhoan varchar(5) not null,
    tenDangNhap varchar(50) not null,
    matKhau varchar(50) not null,
    laQuanLy bit default 0 not null,
    maThuThu varchar(5) not null,
    primary key(maTaiKhoan)
);

-- KHÓA NGOẠI
alter table ps15194_assignment.taikhoan
	add constraint FK_TK1 foreign key(maThuThu)
		references ps15194_assignment.thuthu(maThuThu);

-- SINH VIÊN
create table ps15194_assignment.sinhvien(
	maSinhVien varchar(5) not null,
    tenSinhVien varchar(50) not null,
    ngaySinh date not null,
    chuyenNganh varchar(50) default 'Không xác định' not null,
    email varchar(50) not null,
    soDT varchar(13) not null,
    primary key(maSinhVien)
);

-- THẺ SINH VIÊN
create table ps15194_assignment.thesinhvien(
	maTheSV varchar(5) not null,
    ngayHetHan date not null,
    maSinhVien varchar(5) not null,
    primary key(maTheSV)
);

-- KHÓA NGOẠI
alter table ps15194_assignment.thesinhvien
	add constraint FK_TSV1 foreign key(maSinhVien)
		references ps15194_assignment.sinhvien(maSinhVien);
        
-- LOẠI SÁCH
create table ps15194_assignment.loaisach(
	maLoaiSach varchar(5) not null,
    tenLoaiSach varchar(255) not null,
    primary key(maLoaiSach)
);
        
-- SÁCH
create table ps15194_assignment.sach(
	maSach varchar(5) not null,
    tieuDe varchar(50) not null,
    tacGia varchar(50) not null,
    nhaXuatBan varchar(50) not null,
    soTrang int not null,
    soBanSao int not null,
    giaTien double not null,
    ngayNhap date not null,
    viTri varchar(255) not null,
    maLoaiSach varchar(5) not null,
    primary key(maSach),
    check(soTrang > 0),
    check(soBanSao > 0),
    check(giaTien > 1)
);

-- KHÓA NGOẠI
alter table ps15194_assignment.sach
	add constraint FK_S1 foreign key(maLoaiSach)
		references ps15194_assignment.loaisach(maLoaiSach);

-- PHIẾU MƯỢN
create table ps15194_assignment.phieumuon(
	maPhieuMuon varchar(5) not null,
    ngayMuon date not null,
    ngayTra date,
    quaHan bit default 0 not null,
    phat double default 0 not null,
    maTaiKhoan varchar(5) not null,
    maSinhVien varchar(5) not null,
    primary key(maPhieuMuon),
    check(phat >= 0)
);

-- KHÓA NGOẠI
alter table ps15194_assignment.phieumuon
	add(
		constraint FK_PM1 foreign key(maTaiKhoan)
		references ps15194_assignment.taikhoan(maTaiKhoan),
		constraint FK_PM2 foreign key(maSinhVien)
		references ps15194_assignment.sinhvien(maSinhVien)
	);

-- CHI TIẾT PHIẾU MƯỢN
create table ps15194_assignment.chitietpm(
	maPhieuMuon varchar(5) not null,
    maSach varchar(5) not null,
    ghiChu varchar(255),
    soLuong int not null,
    primary key(maPhieuMuon, maSach),
    check(soLuong > 0)
);

-- KHÓA NGOẠI
alter table ps15194_assignment.chitietpm
	add(
		constraint FK_CT1 foreign key(maPhieuMuon)
		references ps15194_assignment.phieumuon(maPhieuMuon),
		constraint FK_CT2 foreign key(maSach)
		references ps15194_assignment.sach(maSach)
	);

-- THÊM DỮ LIỆU VÀO BẢNG
-- THỦ THƯ
insert into ps15194_assignment.thuthu values
	('TT001', 'Chung Nguyễn Anh Tuấn', '2019-02-15', '1997-12-16', '272744610'),
    ('TT002', 'Nguyễn Quang Bình', '2020-01-15', '2002-05-16', '242594610'),
    ('TT003', 'Nguyễn Minh Tiến', '2021-04-15', '2000-01-23', '274477887');
    
-- TÀI KHOẢN
insert into ps15194_assignment.taikhoan values
	('TK001', 'tuancna', '161297', 1, 'TT001'),
    ('TK002', 'binhnq', '160502', 0, 'TT002'),
    ('TK003', 'tiennm', '230100', 0, 'TT003');
    
-- SINH VIÊN
insert into ps15194_assignment.sinhvien values
	('SV001', 'Nguyễn Duy Tâm', '2002-03-18', 'Lập Trình Di Động', 'tamnd@fpt.edu.vn', '0934567890'),
    ('SV002', 'Cao Đăng Khoa', '2000-12-07', 'Ứng Dụng Phần Mềm', 'khoacd@fpt.edu.vn', '0934567890'),
    ('SV003', 'Trần Vũ Minh Đăng', '2001-07-20', 'Thiết Kế Đồ Họa', 'dangtvm@fpt.edu.vn', '0934567890'),
    ('SV004', 'Huỳnh Quốc Bảo', '1999-05-21', 'Thiết Kế Web', 'baohq@fpt.edu.vn', '0934567890'),
    ('SV005', 'Lâm Gia Bảo', '2000-06-25', 'Thương Mại Điện Tử', 'baolg@fpt.edu.vn', '0934567890'),
    ('SV006', 'Phan Hoàng Văn', '2000-02-04', 'Lập Trình Di Động', 'vanph@fpt.edu.vn', '0934567890'),
    ('SV007', 'Trần Quang Đạo', '1998-02-03', 'Lập Trình Di Động', 'daotq@fpt.edu.vn', '0934567890'),
    ('SV008', 'Trần Trọng Nghĩa', '1995-10-12', 'Marketing', 'nghiatt@fpt.edu.vn', '0934567890'),
    ('SV009', 'Nguyễn Vương Nhật Phúc', '1993-01-13', 'Quản Trị Khách Sạn', 'phucnvn@fpt.edu.vn', '0934567890'),
    ('SV010', 'Nguyễn Trần Cao Phi', '2000-04-17', 'Điện Công Nghiệp', 'phintc@fpt.edu.vn', '0934567890'),
    ('SV011', 'Đặng Vũ Tuấn Phong', '2002-02-28', 'Tự Động Hóa', 'phongdvt@fpt.edu.vn', '0934567890'),
    ('SV012', 'Đặng Vũ Cao Thiên', '2003-11-27', 'Lập Trình Di Động', 'thiendvc@fpt.edu.vn', '0934567890'),
    ('SV013', 'Lý Đức Thắng', '2001-12-18', 'Ứng Dụng Phần Mềm', 'thangld@fpt.edu.vn', '0934567890'),
    ('SV014', 'Phạm Hoàng Lâm', '2000-03-17', 'Thiết Kế Web', 'lamph@fpt.edu.vn', '0934567890'),
    ('SV015', 'Cao Phạm Kim Hòa', '1998-05-16', 'Thiết Kế Đồ Họa', 'hoacpk@fpt.edu.vn', '0934567890'),
    ('SV016', 'Mai Xuân Tấn', '1999-06-18', 'Lập Trình Di Động', 'tanmx@fpt.edu.vn', '0934567890');
    
-- THẺ SINH VIÊN
insert into ps15194_assignment.thesinhvien values
	('TH001', '2022-10-15', 'SV001'),
    ('TH002', '2023-06-16', 'SV001'),
    ('TH003', '2021-09-01', 'SV001'),
    ('TH004', '2022-11-20', 'SV001'),
    ('TH005', '2023-12-06', 'SV001'),
    ('TH006', '2023-12-08', 'SV001'),
    ('TH007', '2022-03-09', 'SV001'),
    ('TH008', '2023-05-15', 'SV001'),
    ('TH009', '2024-01-27', 'SV001'),
    ('TH010', '2021-10-21', 'SV001'),
    ('TH011', '2021-12-30', 'SV001'),
    ('TH012', '2022-05-12', 'SV001'),
    ('TH013', '2023-12-15', 'SV001'),
    ('TH014', '2021-11-11', 'SV001'),
    ('TH015', '2022-10-13', 'SV001'),
    ('TH016', '2023-08-11', 'SV001');

-- LOẠI SÁCH
insert into ps15194_assignment.loaisach values
	('L0001', 'Sách Khoa học - Kỹ thuật'),
    ('L0002', 'Sách Kinh tế'),
    ('L0003', 'Sách Tham khảo'),
    ('L0004', 'Sách Giáo khoa - Giáo trình'),
    ('L0005', 'Sách Thiếu nhi'),
    ('L0006', 'Sách Văn học'),
    ('L0007', 'Sách Học Ngoại ngữ'),
    ('L0008', 'Sách Truyện Tranh'),
    ('L0009', 'Sách Kiến thức Tổng hợp'),
    ('L0010', 'Sách Tôn giáo - Tâm linh'),
    ('L0011', 'Sách Thường thức - Gia đình'),
    ('L0012', 'Sách Công nghệ Thông tin'),
    ('L0013', 'Sách Tạp chí'),
    ('L0014', 'Sách Từ điển'),
    ('L0015', 'Sách Y học'),
    ('L0016', 'Sách Chính trị - Pháp lý'),
    ('L0017', 'Sách Lịch sử'),
    ('L0018', 'Sách Văn hóa - Địa lý - Du lịch'),
    ('L0019', 'Sách Kỹ năng sống'),
    ('L0020', 'Sách Nông - Lâm - Ngư nghiệp');

-- SÁCH
insert into ps15194_assignment.sach values
	('S0001', 'Excel Dành Cho Người Tự Học', 'Phạm Quang Huấn', 'Nhà Xuất Bản Thanh Niên', 464, 15, 129000, '2021-04-15', 'Kệ A1', 'L0012'),
    ('S0002', 'Python cơ bản', 'ĐHQG Hà Nội', 'ĐHQG Hà Nội', 253, 8, 125000, '2021-02-15', 'Kệ A2', 'L0012'),
    ('S0003', 'Lập Trình Nâng Cao PHP Và MySQL', 'TRƯỜNG ĐẠI HỌC FPT', 'TRƯỜNG ĐẠI HỌC FPT', 233, 5, 68000, '2020-04-15', 'Kệ A1', 'L0012'),
    ('S0004', 'Osho - Ươm Mầm', 'Chickn', 'Nhà Xuất Bản Hà Nội', 324, 11, 75700, '2021-01-01', 'Kệ B1', 'L0010'),
    ('S0005', 'Muôn Kiếp Nhân Sinh (Khổ Nhỏ)', 'Nguyên Phong', 'Nhà Xuất Bản Tổng hợp TP.HCM', 482, 10, 67700, '2020-02-11', 'Kệ B1', 'L0010'),
    ('S0006', 'Nữ Thần Bãi Biển', 'Báo Sinh Viên VN - Hoa Học Trò', 'Báo Sinh Viên VN - Hoa Học Trò', 156, 8, 56800, '2020-04-17', 'Kệ C5', 'L0013'),
    ('S0007', 'Mắt Biếc (Tái Bản 2019)', 'Nguyễn Nhật Ánh', 'NXB Trẻ', 300, 25, 72400, '2019-12-15', 'Kệ D1', 'L0006'),
    ('S0008', 'Nhà (Tái Bản)', 'Nguyễn Bảo Trung', 'Saigon Books', 208, 7, 54500, '2021-04-15', 'Kệ D1', 'L0006'),
    ('S0009', 'Biên Niên Cô Đơn', 'Nguyễn Ngọc Thạch', 'Nhà Xuất Bản Phụ Nữ Việt Nam', 220, 12, 64000, '2020-04-15', 'Kệ D1', 'L0006'),
    ('S0010', 'Nhà Giả Kim', 'Paulo Coelho', 'Nhà Xuất Bản Văn Học', 228, 18, 51750, '2021-02-01', 'Kệ D1', 'L0006'),
    ('S0011', 'Bến Xe (Tái Bản 2020)', 'Thương Thái Vi', 'Nhà Xuất Bản Văn Học', 284, 2, 51400, '2020-12-15', 'Kệ D1', 'L0012'),
    ('S0012', 'Hoàng Tử Bé (Tái Bản 2019)', 'Nhã Nam', 'Nhà Xuất Bản Hội Nhà Văn', 102, 3, 53400, '2019-07-15', 'Kệ E1', 'L0005'),
    ('S0013', 'Thần Thoại Hy Lạp (Bìa Cứng)', 'Nguyễn Văn Khỏa', 'Nhà Xuất Bản Văn Học', 900, 3, 169000, '2020-10-15', 'Kệ E2', 'L0005'),
    ('S0014', 'Payback Time - Ngày Đòi Nợ', 'Phil Town', 'Nhà Xuất Bản Văn Hóa - Văn Nghệ', 284, 10, 299000, '2020-07-29', 'Kệ F3', 'L0002'),
    ('S0015', 'Nhà Đầu Tư Thông Minh (Tái Bản 2020)', 'Benjamin Graham', 'Nhà Xuất Bản Dân Trí', 464, 15, 149250, '2021-09-15', 'Kệ F4', 'L0002'),
	('S0016', 'Quản Trị Tài Chính', 'Eugene Brigham', 'Nhà Xuất Bản Hồng Đức', 1036, 2, 571800, '2021-01-15', 'Kệ D2', 'L0004'),
    ('S0017', 'Kinh Tế Học Vĩ Mô', 'N Gregory Mankiw', 'Nhà Xuất Bản Hồng Đức', 102, 4, 250800, '2018-07-15', 'Kệ E2', 'L0004'),
    ('S0018', 'Thiết Kế Nội Thất (Tái Bản)', 'Francis D.K. Ching', 'Nhà Xuất Bản Xây Dựng', 900, 7, 111200, '2020-10-15', 'Kệ E3', 'L0004'),
    ('S0019', 'Sự Tiến Hóa Của Vật Lý (Tái bản)', 'Albert Einstein & Leopold Infeld', 'NXB Trẻ', 348, 3, 115800, '2019-04-20', 'Kệ F4', 'L0009'),
    ('S0020', 'Các Thế Giới Song Song (Tái Bản 2018)', 'Michio Kaku', 'Nhà Xuất Bản Thế Giới', 480, 5, 94600, '2020-09-01', 'Kệ F5', 'L0009');
    
-- PHIẾU MƯỢN
insert into ps15194_assignment.phieumuon values
	('PM001', '2019-07-15', '2019-07-25', 0, 0, 'TK002', 'SV001'),
    ('PM002', '2019-08-11', '2019-08-25', 1, 20000, 'TK001', 'SV002'),
    ('PM003', '2019-08-15', '2019-09-01', 0, 0, 'TK002', 'SV003'),
    ('PM004', '2019-08-26', '2019-09-24', 0, 0, 'TK002', 'SV004'),
    ('PM005', '2019-09-03', '2019-10-01', 0, 0, 'TK002', 'SV005'),
    ('PM006', '2019-09-13', '2019-11-02', 1, 50000, 'TK003', 'SV007'),
    ('PM007', '2019-09-18', '2019-09-29', 0, 0, 'TK001', 'SV010'),
    ('PM008', '2019-10-01', '2019-10-25', 0, 0, 'TK002', 'SV008'),
    ('PM009', '2019-11-11', '2019-12-10', 0, 0, 'TK002', 'SV002'),
    ('PM010', '2019-12-15', '2020-01-27', 1, 20000, 'TK001', 'SV009'),
    ('PM011', '2020-01-02', '2020-01-23', 0, 0, 'TK003', 'SV003'),
    ('PM012', '2020-01-02', '2020-02-05', 1, 0, 'TK003', 'SV001'),
    ('PM013', '2020-01-10', '2020-02-01', 0, 0, 'TK003', 'SV011'),
    ('PM014', '2020-01-15', '2020-02-13', 0, 0, 'TK003', 'SV015'),
    ('PM015', '2020-01-28', '2020-02-25', 0, 0, 'TK003', 'SV006'),
    ('PM016', '2020-02-02', '2020-02-25', 0, 0, 'TK002', 'SV013'),
    ('PM017', '2020-02-12', '2020-03-01', 0, 0, 'TK003', 'SV014'),
    ('PM018', '2020-04-13', '2020-05-10', 0, 0, 'TK002', 'SV007'),
    ('PM019', '2021-02-10', '2021-02-25', 0, 0, 'TK002', 'SV005'),
    ('PM020', '2021-05-13', '2021-05-25', 0, 0, 'TK002', 'SV016'),
    ('PM021', '2021-03-20', null , 0, 0, 'TK003', 'SV014'),
    ('PM022', '2021-04-01', null , 0, 0, 'TK001', 'SV004'),
    ('PM023', '2021-04-10', null , 0, 0, 'TK002', 'SV013'),
    ('PM024', '2021-04-13', null , 0, 0, 'TK003', 'SV001');
    
-- CHI TIẾT PM
insert into ps15194_assignment.chitietpm values
	('PM001', 'S0001', '', 2),
    ('PM001', 'S0003', '', 1),
    ('PM001', 'S0005', '', 1),
    ('PM002', 'S0001', '', 2),
    ('PM002', 'S0002', '', 1),
    ('PM003', 'S0006', '', 2),
    ('PM003', 'S0007', '', 1),
    ('PM003', 'S0010', '', 1),
    ('PM004', 'S0005', '', 1),
    ('PM005', 'S0017', '', 1),
    ('PM006', 'S0001', '', 1),
    ('PM006', 'S0002', '', 1),
    ('PM007', 'S0010', '', 1),
    ('PM008', 'S0011', '', 1),
    ('PM009', 'S0019', '', 1),
    ('PM010', 'S0008', '', 2),
    ('PM010', 'S0011', '', 1),
    ('PM010', 'S0015', '', 1),
    ('PM011', 'S0002', '', 1),
    ('PM011', 'S0003', '', 1),
    ('PM012', 'S0009', '', 2),
	('PM013', 'S0016', '', 2),
    ('PM013', 'S0001', '', 1),
    ('PM014', 'S0003', '', 1),
    ('PM015', 'S0006', '', 2),
    ('PM016', 'S0011', '', 1),
    ('PM016', 'S0007', '', 1),
    ('PM017', 'S0002', '', 1),
    ('PM018', 'S0005', '', 1),
    ('PM019', 'S0004', '', 2),
    ('PM019', 'S0010', '', 1),
    ('PM019', 'S0017', '', 1),
    ('PM019', 'S0018', '', 2),
    ('PM020', 'S0002', '', 1),
    ('PM020', 'S0015', '', 1),
    ('PM021', 'S0001', '', 1),
    ('PM021', 'S0010', '', 1),
    ('PM022', 'S0008', '', 1),
    ('PM022', 'S0001', '', 1),
    ('PM023', 'S0003', '', 2),
    ('PM024', 'S0006', '', 1);
    
    use ps15194_assignment;
    
-- HIỂN THỊ THÔNG TIN CÁC ĐẦU SÁCH CÔNG NGHỆ THÔNG TIN (MÃ: L0012)
select
	sach.maSach as 'Mã sách',
    sach.tieuDe as 'Tên sách',
    sach.tacGia as 'Tác giả',
    loai.tenLoaiSach as 'Loại sách',
    sach.giaTien as 'Giá tiền'
from
	ps15194_assignment.sach sach
    inner join
    ps15194_assignment.loaisach loai
    on sach.maLoaiSach = loai.maLoaiSach
where
	sach.maLoaiSach = 'L0012';
    
-- HIỂN THỊ THÔNG TIN PHIẾU MƯỢN CÓ NGÀY MƯỢN TRONG THÁNG 8/2019
select
	pm.maPhieuMuon as 'Mã phiếu mượn',
    sach.maSach as 'Mã sách',
    sach.tieuDe as 'Tên sách',
    sv.maSinhVien as 'Mã sinh viên',
    sv.tenSinhVien as 'Tên sinh viên',
    date_format(pm.ngayMuon, '%d-%m-%Y') as 'Ngày mượn'
from
	ps15194_assignment.sinhvien sv
    inner join ps15194_assignment.phieumuon pm
    on sv.maSinhVien = pm.maSinhVien
    inner join ps15194_assignment.chitietpm ctpm
    on pm.maPhieuMuon = ctpm.maPhieuMuon
    inner join ps15194_assignment.sach sach
    on sach.maSach = ctpm.maSach
where
	month(pm.ngayMuon) = 8 and year(pm.ngayMuon) = 2019;
    
-- HIỂN THỊ PHIẾU MƯỢN CHƯA TRẢ VỚI NGÀY MƯỢN TĂNG DẦN
select
	pm.maPhieuMuon as 'Mã phiếu mượn',
    pm.maSinhVien as 'Mã sinh viên',
    sv.tenSinhVien as 'Tên sinh viên',
    tk.maTaiKhoan as 'Mã tài khoản',
    date_format(pm.ngayMuon, '%d-%m-%Y') as 'Ngày mượn'
from
	ps15194_assignment.sinhvien sv
    inner join ps15194_assignment.phieumuon pm
    on pm.maSinhVien = sv.maSinhVien
    inner join ps15194_assignment.taikhoan tk
    on pm.maTaiKhoan = tk.maTaiKhoan
where
	pm.ngayTra is null
order by pm.ngayMuon asc;

-- LIỆT KÊ TỔNG ĐẦU SÁCH CỦA MỖI LOẠI SÁCH
select
	loai.maLoaiSach as 'Mã loại sách',
	loai.tenLoaiSach as 'Tên loại sách',
    count(*) as 'Số lượng'
from
	ps15194_assignment.loaisach loai
    inner join ps15194_assignment.sach sach
	on loai.maLoaiSach = sach.maLoaiSach
group by sach.maLoaiSach;

-- ĐẾM SỐ LƯỢT MƯỢN SÁCH
-- LƯỢT MƯỢN SÁCH = TỔNG SỐ PHIẾU MƯỢN
select 
	count(maPhieuMuon) as 'Số lượt mượn'
from
	ps15194_assignment.phieumuon;

-- LIỆT KÊ TẤT CẢ CÁC SÁCH MÀ TIÊU ĐỀ CHỨA 'SQL'
select
	sach.maSach as 'Mã sách',
    sach.tieuDe as 'Tên sách',
    sach.tacGia as 'Tác giả',
    loai.tenLoaiSach as 'Loại sách',
    sach.giaTien as 'Giá tiền'
from
	ps15194_assignment.sach sach
    inner join
    ps15194_assignment.loaisach loai
    on sach.maLoaiSach = loai.maLoaiSach
where
	sach.tieuDe like '%SQL%';
    
-- HIỂN THỊ THÔNG TIN PHIẾU MƯỢN VỚI NGÀY MƯỢN TĂNG DẦN
select
	pm.maPhieuMuon as 'Mã phiếu mượn',
    sach.maSach as 'Mã sách',
    sach.tieuDe as 'Tên sách',
    sv.maSinhVien as 'Mã sinh viên',
    sv.tenSinhVien as 'Tên sinh viên',
    date_format(pm.ngayMuon, '%d-%m-%Y') as 'Ngày mượn',
    date_format(pm.ngayTra, '%d-%m-%Y') as 'Ngày trả'
from
	ps15194_assignment.sinhvien sv
    inner join ps15194_assignment.phieumuon pm
    on sv.maSinhVien = pm.maSinhVien
    inner join ps15194_assignment.chitietpm ctpm
    on pm.maPhieuMuon = ctpm.maPhieuMuon
    inner join ps15194_assignment.sach sach
    on sach.maSach = ctpm.maSach
order by pm.ngayMuon asc;

-- LIỆT KÊ ĐẦU SÁCH CÓ LƯỢT MƯỢN > 3
-- SUM(SỐ LƯỢNG MƯỢN Ở CTPM) -> SỐ LƯỢT MƯỢN
-- GROUP MÃ SÁCH LẠI
select
	sach.maSach as 'Mã sách',
	sach.tieuDe as 'Tên sách',
	sum(ctpm.soLuong) as 'Số lượt mượn'
from
	ps15194_assignment.sach sach
    inner join
    ps15194_assignment.chitietpm ctpm
    on sach.maSach = ctpm.maSach
group by ctpm.maSach
having sum(ctpm.soLuong) > 3;

-- CẬP NHẬT GIÁ -30% ĐỐI VỚI CÁC ĐẦU SÁCH CÓ NGÀY NHẬP TRƯỚC 2020
update ps15194_assignment.sach
	set giaTien = giaTien * 0.7
	where year(ngayNhap) < 2020;

select * from ps15194_assignment.sach where year(ngayNhap) < 2020;

-- CẬP NHẬT NGÀY TRẢ CHO PHIẾU MƯƠN PM022
update ps15194_assignment.phieumuon
	set ngayTra = '2021-04-15'
    where maPhieuMuon = 'PM022';

select * from ps15194_assignment.phieumuon where maPhieuMuon = 'PM022';

-- LẬP DANH SÁCH PHIẾU MƯỢN QUÁ HẠN CHƯA TRẢ
-- CHƯA TRẢ: NGAYTRA = NULL
-- HẠN TRẢ: 30 NGÀY
select
	ctpm.maPhieuMuon as 'Mã phiếu mượn',
    sv.tenSinhVien as 'Tên sinh viên',
    sv.email as 'Email',
    ctpm.maSach as 'Mã sách',
    sach.tieuDe as 'Tên sách',
    pm.ngayMuon as 'Ngày mượn'
from
	ps15194_assignment.phieumuon pm
    inner join ps15194_assignment.sinhvien sv
    on pm.maSinhVien = sv.maSinhVien
    inner join ps15194_assignment.chitietpm ctpm
    on pm.maPhieuMuon = ctpm.maPhieuMuon
    inner join ps15194_assignment.sach sach
    on ctpm.maSach = sach.maSach
where pm.ngayTra is null and date_add(pm.ngayMuon, interval 30 day) < date(now());

-- TĂNG THÊM 5 BẢN SAO CHO SÁCH CÓ LƯỢT MƯỢN LỚN HƠN 5
update ps15194_assignment.sach
	set soBanSao = soBanSao + 5
    where(
		select sum(soLuong) from ps15194_assignment.chitietpm
        where ps15194_assignment.sach.maSach = ps15194_assignment.chitietpm.maSach
        group by ps15194_assignment.chitietpm.maSach
	) > 5;

select * from ps15194_assignment.sach
	where(
		select sum(soLuong) from ps15194_assignment.chitietpm
        where ps15194_assignment.sach.maSach = ps15194_assignment.chitietpm.maSach
        group by ps15194_assignment.chitietpm.maSach
	) > 5;
    
-- XÓA CÁC PHIẾU MƯỢN CÓ NGÀY MƯỢN VÀ NGÀY TRẢ TRƯỚC 01-01-2020
-- Thêm ràng buộc khóa ngoại với on delete cascade
alter table ps15194_assignment.phieumuon
	drop foreign key FK_PM2;
    
alter table ps15194_assignment.phieumuon
	add constraint FK_PM2 foreign key(maSinhVien)
		references ps15194_assignment.sinhvien(maSinhVien) on delete cascade;

alter table ps15194_assignment.chitietpm
	drop foreign key FK_CT1;

alter table ps15194_assignment.chitietpm
	add constraint FK_CT1 foreign key(maPhieuMuon)
		references ps15194_assignment.phieumuon(maPhieuMuon) on delete cascade;
    
alter table ps15194_assignment.chitietpm
	drop foreign key FK_CT2;

alter table ps15194_assignment.chitietpm
	add constraint FK_CT2 foreign key(maSach)
		references ps15194_assignment.sach(maSach) on delete cascade;
        
-- Viết lệnh
delete from ps15194_assignment.phieumuon
	where ngayMuon < '2020-01-01' and ngayTra < '2020-01-01';
    
select * from ps15194_assignment.phieumuon;
    
-- HIỂN THỊ THÔNG TIN QUẢN LÝ THƯ VIỆN
select
	tt.maThuThu as 'Mã thủ thư',
    tt.tenThuThu as 'Tên thủ thư',
    date_format(tt.ngayVaoLam, '%d-%m-%Y') as 'Ngày vào làm',
    date_format(tt.ngaySinh, '%d-%m-%Y') as 'Ngày sinh',
    tt.cmnd as 'CMT',
    tk.maTaiKhoan as 'Mã tài khoản',
    tk.tenDangNhap as 'Tên đăng nhập'
from
	ps15194_assignment.thuthu tt
    inner join ps15194_assignment.taikhoan tk
    on tt.maThuThu = tk.maThuThu
where tk.laQuanLy = 1;

-- ĐỔI MẬT KHẨU CHO TÀI KHOẢN TK003
update ps15194_assignment.taikhoan
	set matKhau = 'qwerty'
    where maTaiKhoan = 'TK003';
