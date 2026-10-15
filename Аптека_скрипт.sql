use Shapkin_apteka;

CREATE TABLE Orders (
    IdOrder INT IDENTITY(1,1) PRIMARY KEY,
    ClientId INT NOT NULL,
    StatusId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE OrderProducts (
    IdOrderProduct INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    [Count] INT NOT NULL
);

CREATE TABLE OrderStatusHistory (
    IdOrderStatusHistory INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    OldStatusId INT NOT NULL,
    NewStatusId INT NOT NULL
);

CREATE TABLE Products (
    IdProduct INT IDENTITY(1,1) PRIMARY KEY,
    Article NVARCHAR(50) NOT NULL UNIQUE,
    ProductName NVARCHAR(200) NOT NULL,
    CategoryId INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Image NVARCHAR(MAX) NULL,
    ManufactureDate DATE NOT NULL,
    BestBeforeDate DATE NULL,
    CompanyId INT NOT NULL,
    ManufacturerCountryId INT NOT NULL
);

CREATE TABLE Companies (
    IdCompany INT IDENTITY(1,1) PRIMARY KEY,
    CompanyName NVARCHAR(100) NOT NULL
);

CREATE TABLE ManufacturerCountry (
    IdManufacturerCountry INT IDENTITY(1,1) PRIMARY KEY,
    CountryName NVARCHAR(100) NOT NULL,
    CountryShortName NVARCHAR(10) NOT NULL
);

CREATE TABLE ProductCategories (
    IdCategory INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);

CREATE TABLE Status (
    IdStatus INT IDENTITY(1,1) PRIMARY KEY,
    [Text] NVARCHAR(50) NOT NULL
);

CREATE TABLE Clients (
    IdClient INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    SurName NVARCHAR(50) NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(100) NOT NULL
);

CREATE TABLE Sales (
    IdSale INT IDENTITY(1,1) PRIMARY KEY,
    SoldDate DATETIME DEFAULT GETDATE(),
    PayMethodId INT NOT NULL,
    EmployeeId UNIQUEIDENTIFIER NOT NULL,
    ClientId INT NOT NULL
);

CREATE TABLE PayMethods (
    IdPayMethod INT IDENTITY(1,1) PRIMARY KEY,
    MethodName NVARCHAR(50) NOT NULL
);

CREATE TABLE SaleProduct (
    IdSaleProduct INT IDENTITY(1,1) PRIMARY KEY,
    SaleId INT NOT NULL,
    ProductId INT NOT NULL,
    [Count] INT NOT NULL
);

CREATE TABLE Employees (
    IdEmployee UNIQUEIDENTIFIER DEFAULT NEWID() PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    SurName NVARCHAR(50) NULL,
    BirthDate DATE NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    [Address] NVARCHAR(200) NOT NULL
);


INSERT INTO Orders (ClientId, StatusId, OrderDate) VALUES
(1, 1, '2026-02-15 11:30:00'),
(2, 2, '2026-02-16 12:45:00'),
(3, 3, '2026-02-17 13:20:00'),
(4, 1, '2026-02-18 14:15:00'),
(5, 4, '2026-02-19 15:40:00');

INSERT INTO OrderProducts (OrderId, ProductId, [Count]) VALUES
(1, 1, 1),
(1, 2, 5),
(2, 3, 2),
(3, 4, 1),
(4, 5, 3);

INSERT INTO OrderStatusHistory (OrderId, OrderDate, OldStatusId, NewStatusId) VALUES
(1, '2026-02-15 11:30:00', 1, 1),
(2, '2026-02-16 12:45:00', 1, 2),
(2, '2026-02-17 13:20:00', 2, 3),
(4, '2026-02-18 14:15:00', 1, 1),
(5, '2026-02-19 15:40:00', 2, 4);

INSERT INTO Products (Article, ProductName, CategoryId, Price, Image, ManufactureDate, BestBeforeDate, CompanyId, ManufacturerCountryId) VALUES
('AB001', N'Парацетамол, в таблетках', 5, 129.99, NULL, '2025-01-15', NULL, 1, 1),
('AB002', N'Минеральная вода "Айова"', 4, 189.50, NULL, '2026-02-01', '2028-08-01', 2, 2),
('AB003', N'Ушные капли при раздражении внутренней части уха', 1, 199.00, NULL, '2023-11-20', NULL, 3, 5),
('AB004', N'Нурафен-ка', 2, 150.00, NULL, '2023-12-10', NULL, 4, 2),
('AB005', N'Леденцы с эвкалиптом', 3, 599.99, NULL, '2026-01-05', NULL, 4, 4);

INSERT INTO ManufacturerCountry (CountryName, CountryShortName) VALUES
(N'Россия', 'RU'),
(N'Германия', 'DE'),
(N'Испания', 'ES'),
(N'Китай', 'CN'),
(N'Великобритания', 'GB');

INSERT INTO Companies (CompanyName) VALUES
(N'ООО "Спокойное Лечение"'),
(N'German Industries'),
(N'Aperture Sciense'),
(N'China Health'),
(N'Great Medicine');

INSERT INTO ProductCategories (CategoryName) VALUES
(N'Лекарство'),
(N'Медицинский препарат'),
(N'БАД'),
(N'Не-медицинские товары'),
(N'Только по рецепту');

INSERT INTO Status ([Text]) VALUES
(N'Новый'),
(N'В работе'),
(N'Выполнен'),
(N'Отклонён'),
(N'Отменён');

INSERT INTO Clients (FirstName, LastName, SurName, Phone, Email) VALUES
(N'Иван', N'Иванов', N'Иванович', '+79161234567', 'ivanov@mail.ru'),
(N'Петр', N'Петров', N'Иванович', '+79162345678', 'petrov@ya.ru'),
(N'Николай', N'Константинов', NULL, '+79163456789', 'nikolayka@gmail.com'),
(N'Агата', N'Кристи', N'Себастьяновна', '+79164567890', 'agata.pisateltitsa@glamil.com'),
(N'Игорь', N'Шапкин', NULL, '+79165678901', 'igorek@yahoo.com');

DECLARE @EmpID1 UNIQUEIDENTIFIER, @EmpID2 UNIQUEIDENTIFIER, @EmpID3 UNIQUEIDENTIFIER;
SELECT @EmpID1 = IdEmployee FROM Employees WHERE FirstName = N'Владимир' AND LastName = N'Шапкин';
SELECT @EmpID2 = IdEmployee FROM Employees WHERE FirstName = N'Сергей' AND LastName = N'Васильков';
SELECT @EmpID3 = IdEmployee FROM Employees WHERE FirstName = N'Наталья' AND LastName = N'Ковальчук';
INSERT INTO Sales (SoldDate, PayMethodId, EmployeeId, ClientId) VALUES
('2026-02-20 12:00:00', 1, @EmpID1, 1),
('2026-02-20 13:30:00', 4, @EmpID2, 2),
('2026-02-21 10:15:00', 4, @EmpID1, 3),
('2026-02-21 15:45:00', 4, @EmpID3, 4),
('2026-02-22 11:20:00', 5, @EmpID2, 5);

INSERT INTO PayMethods (MethodName) VALUES
(N'Карта'),
(N'Наличные'),
(N'Перевод'),
(N'СБП'),
(N'Рецепт');

INSERT INTO Employees (IdEmployee, FirstName, LastName, SurName, BirthDate, Phone, [Address]) VALUES
(NEWID(), N'Сергей', N'Васильков', N'Петрович', '1990-05-15', '+79999999999', N'ул. Пушкина, д. 1'),
(NEWID(), N'Татьяна', N'Силахина', N'Валентиновна', '1985-08-22', '+78888888888', N'ул. Калатушкина, д. 10'),
(NEWID(), N'Екатерина', N'Мизулина', NULL, '1992-03-10', '+77777777777', N'ул. Бассейная, д. 25'),
(NEWID(), N'Владимир', N'Шапкин', N'Алексеевич', '1968-11-30', '+76666666666', N'ул. Рассейная, д. 15'),
(NEWID(), N'Наталья', N'Ковальчук', NULL, '1995-07-05', '+75555555555', N'ул. Сладкая, д. 8');
