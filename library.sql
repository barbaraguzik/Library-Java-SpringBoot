-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Czas generowania: 10 Sty 2025, 19:32
-- Wersja serwera: 5.7.36
-- Wersja PHP: 8.1.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `library`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `author` varchar(255) NOT NULL,
  `available` bit(1) NOT NULL,
  `genre` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `reserved_by` bigint(20) DEFAULT NULL,
  `reservation_date` date DEFAULT NULL,
  `loan_date` date DEFAULT NULL,
  `borrowed_by` bigint(20) DEFAULT NULL,
  `loan_due` date DEFAULT NULL,
  `reservation_due` date DEFAULT NULL,
  `prolonged` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `books`
--

INSERT INTO `books` (`id`, `author`, `available`, `genre`, `title`, `reserved_by`, `reservation_date`, `loan_date`, `borrowed_by`, `loan_due`, `reservation_due`, `prolonged`) VALUES
(1, 'Stephen King', b'0', 'Horror', 'Cujo', NULL, NULL, '2025-01-06', 2, '2025-03-07', NULL, b'1'),
(2, 'Sarah J. Maas', b'0', 'Fantasy', 'Dwór cierni i róż', 2, '2025-01-06', NULL, NULL, NULL, '2025-01-13', b'0'),
(3, 'J.K. Rowling', b'1', 'Fantasy', 'Harry Potter i Kamień Filozoficzny', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(4, 'George R.R. Martin', b'0', 'Fantasy', 'Gra o Tron', NULL, NULL, '2025-01-06', 8, '2025-02-05', NULL, b'0'),
(5, 'Gabriel García Márquez', b'1', 'Powieść', 'Sto lat samotności', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(6, 'Michał Gołkowski', b'0', 'Science Fiction', 'Nocna Zmiana', 6, '2025-01-06', NULL, NULL, NULL, '2025-01-13', b'0'),
(7, 'Orson Scott Card', b'1', 'Science Fiction', 'Gra Endera', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(8, 'Philip K. Dick', b'1', 'Science Fiction', 'Czy androidy marzą o elektrycznych owcach?', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(9, 'Dan Brown', b'1', 'Thriller', 'Kod da Vinci', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(10, 'Agatha Christie', b'1', 'Kryminał', 'Morderstwo w Orient Expressie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(11, 'J.R.R. Tolkien', b'1', 'Fantasy', 'Hobbit, czyli tam i z powrotem', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(12, 'J.R.R. Tolkien', b'1', 'Fantasy', 'Władca Pierścieni: Drużyna Pierścienia', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(13, 'Terry Pratchett', b'1', 'Fantasy', 'Dobry Omen', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(14, 'Brandon Sanderson', b'1', 'Fantasy', 'Mistborn: Z mgły zrodzony', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(15, 'Harlan Coben', b'1', 'Thriller', 'Nie mów nikomu', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(16, 'John Grisham', b'1', 'Thriller', 'Firma', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(17, 'Lee Child', b'0', 'Thriller', 'Killing Floor', 2, '2025-01-06', NULL, NULL, NULL, '2025-01-13', b'0'),
(18, 'Tess Gerritsen', b'1', 'Thriller', 'Grzechy', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(19, 'Isabel Allende', b'1', 'Powieść', 'Dom duchów', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(20, 'Stephen King', b'1', 'Horror', 'To', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(21, 'Margaret Atwood', b'1', 'Powieść', 'Opowieść podręcznej', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(22, 'Isaac Asimov', b'1', 'Science Fiction', 'Fundacja', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(23, 'Arthur C. Clarke', b'1', 'Science Fiction', 'Odyseja kosmiczna 2001', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(24, 'George Orwell', b'1', 'Dystopia', 'Rok 1984', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(25, 'Ray Bradbury', b'1', 'Science Fiction', 'Fahrenheit 451', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(26, 'Orson Scott Card', b'1', 'Science Fiction', 'Cień zaćmienia', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(27, 'Philip K. Dick', b'1', 'Science Fiction', 'Człowiek z Wysokiego Zamku', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(28, 'Neal Stephenson', b'1', 'Science Fiction', 'Złoto Równonocy', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(29, 'David Mitchell', b'0', 'Powieść', 'Atlas chmur', NULL, NULL, '2025-01-06', 6, '2025-02-05', NULL, b'0'),
(30, 'Katherine Arden', b'1', 'Fantasy', 'Zimowa opowieść', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(31, 'Robin Hobb', b'1', 'Fantasy', 'Uczeń zabójcy', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(32, 'Joe Abercrombie', b'1', 'Fantasy', 'Pierwsze prawo magii', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(33, 'H.G. Wells', b'1', 'Science Fiction', 'Wehikuł czasu', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(34, 'Margaret Atwood', b'1', 'Powieść', 'Dopóki mamy twarze', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(35, 'Neil Gaiman', b'1', 'Fantasy', 'Amerykańscy bogowie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(36, 'Patrick Rothfuss', b'1', 'Fantasy', 'Imię wiatru', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(37, 'L. E. Modesitt Jr.', b'1', 'Fantasy', 'Uczta dla wron', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(38, 'Katherine Arden', b'0', 'Fantasy', 'Czarna zima', 6, '2025-01-06', NULL, NULL, NULL, '2025-01-13', b'0'),
(39, 'M. R. Carey', b'1', 'Horror', 'Wydziedziczeni', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(40, 'Stephen King', b'0', 'Horror', 'Carrie', 19, '2025-01-06', NULL, NULL, NULL, '2025-01-13', b'0'),
(41, 'Samantha Shannon', b'0', 'Fantasy', 'Cień i kość', NULL, NULL, '2025-01-06', 6, '2025-02-05', NULL, b'0'),
(42, 'Harlan Coben', b'1', 'Thriller', 'Zostań przy mnie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(43, 'Jojo Moyes', b'1', 'Romans', 'Zanim się pojawiłeś', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(44, 'Khaled Hosseini', b'1', 'Powieść', 'Chłopiec z latawcem', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(45, 'Colleen Hoover', b'1', 'Romans', 'Verity', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(46, 'Danielle Steel', b'1', 'Romans', 'Słodkie kłamstwa', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(47, 'Gillian Flynn', b'1', 'Thriller', 'Zaginiona dziewczyna', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(48, 'Suzanne Collins', b'1', 'Dystopia', 'Igrzyska śmierci', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(49, 'Philip Pullman', b'1', 'Fantasy', 'Złoty kompas', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(50, 'J. R. R. Tolkien', b'1', 'Fantasy', 'Silmarillion', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(51, 'David Eddings', b'0', 'Fantasy', 'Belgariada', NULL, NULL, '2025-01-06', 19, '2025-02-05', NULL, b'0'),
(52, 'Terry Brooks', b'1', 'Fantasy', 'Shannara', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(53, 'Eoin Colfer', b'1', 'Fantasy', 'Artemis Fowl', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(54, 'C.S. Lewis', b'1', 'Fantasy', 'Opowieści z Narnii: Lew, czarownica i stara szafa', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(55, 'Rick Riordan', b'1', 'Fantasy', 'Percy Jackson i Bogowie Olimpijscy: Złodziej Pioruna', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(56, 'Ursula K. Le Guin', b'1', 'Fantasy', 'Człowiek z wysokiego zamku', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(57, 'Anne Rice', b'1', 'Horror', 'Wampir Lestat', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(58, 'Bram Stoker', b'1', 'Horror', 'Drakula', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(59, 'Chuck Palahniuk', b'1', 'Horror', 'Fight Club', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(60, 'Stephen King', b'1', 'Horror', 'Misery', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(61, 'Jodi Picoult', b'1', 'Powieść', 'Wszystko, co najlepsze', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(62, 'Gillian Flynn', b'1', 'Thriller', 'Ostry przedmiot', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(63, 'Colson Whitehead', b'1', 'Powieść', 'Podziemna kolej', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(64, 'Zadie Smith', b'1', 'Powieść', 'Białe zęby', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(65, 'Yaa Gyasi', b'1', 'Powieść', 'Homegoing', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(66, 'Alice Walker', b'1', 'Powieść', 'Kolor purpury', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(67, 'Chimamanda Ngozi Adichie', b'1', 'Powieść', 'Amerykańscy bogowie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(68, 'Chimamanda Ngozi Adichie', b'1', 'Powieść', 'Na rzecz dzieci', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(69, 'George R. R. Martin', b'1', 'Fantasy', 'Gra o Tron', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(70, 'Robert Jordan', b'1', 'Fantasy', 'Oko świata', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(71, 'Terry Pratchett', b'1', 'Fantasy', 'Świat Dysku: Czarodzicielstwo', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(72, 'Patrick Rothfuss', b'1', 'Fantasy', 'Strach mędrca', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(73, 'Sarah J. Maas', b'0', 'Fantasy', 'Dwór cierni i róż', 6, '2025-01-06', NULL, NULL, NULL, '2025-01-13', b'0'),
(74, 'N.K. Jemisin', b'1', 'Fantasy', 'Wszystkie nasze wczoraj', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(75, 'Brandon Sanderson', b'1', 'Fantasy', 'Cień przeszłości', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(76, 'G. R. R. Martin', b'1', 'Fantasy', 'Uczta dla wron', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(77, 'Veronica Roth', b'1', 'Dystopia', 'Zbuntowana', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(78, 'Marie Lu', b'1', 'Dystopia', 'Legend', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(79, 'Hugh Howey', b'1', 'Science Fiction', 'Wool', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(80, 'James S.A. Corey', b'1', 'Science Fiction', 'Przebudzenie Lewiatana', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(81, 'Katherine Arden', b'1', 'Fantasy', 'Prawa letnie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(82, 'Rick Riordan', b'1', 'Fantasy', 'Percy Jackson i Bogowie Olimpijscy: Morze potworów', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(83, 'L. E. Modesitt Jr.', b'1', 'Fantasy', 'Skrzydlaty cień', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(84, 'John Green', b'1', 'Powieść', 'Gwiazd naszych wina', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(85, 'Stephen King', b'1', 'Horror', 'Lśnienie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(86, 'Stephen King', b'1', 'Horror', 'Zielona mila', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(87, 'Bram Stoker', b'1', 'Horror', 'Duma i uprzedzenie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(88, 'Ray Bradbury', b'1', 'Science Fiction', 'Człowiek w wysokim zamku', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(89, 'Isaac Asimov', b'1', 'Science Fiction', 'Fundacja', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(90, 'Philip K. Dick', b'1', 'Science Fiction', 'Czy androidy śnią o elektrycznych owcach?', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(91, 'Orson Scott Card', b'1', 'Science Fiction', 'Gra Endera', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(92, 'Frank Herbert', b'1', 'Science Fiction', 'Diuna', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(93, 'Arthur C. Clarke', b'1', 'Science Fiction', 'Odyseja kosmiczna', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(94, 'Ray Bradbury', b'1', 'Science Fiction', '451° Fahrenheita', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(95, 'Nnedi Okorafor', b'1', 'Fantasy', 'Binti', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(96, 'N. K. Jemisin', b'1', 'Fantasy', 'Bardzo niegrzeczna dziewczynka', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(97, 'Bobby Adair', b'1', 'Horror', 'Wojna o przetrwanie', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(98, 'Anne Rice', b'1', 'Horror', 'Wywiad z wampirem', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(99, 'Stephen King', b'1', 'Horror', 'Bastion', NULL, NULL, NULL, NULL, NULL, NULL, b'0'),
(100, 'J. K. Rowling', b'1', 'Fantasy', 'Harry Potter i Kamień Filozoficzny', NULL, NULL, NULL, NULL, NULL, NULL, b'0');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `role`, `username`) VALUES
(1, 'librarian1@gmail.com', '123', 'librarian', 'lib1'),
(2, 'user1@gmail.com', '123', 'user', 'user1'),
(3, 'user2@gmail.com', '123', 'user', 'user2'),
(4, 'user3@gmail.com', '123', 'user', 'user3'),
(5, 'user4@gmail.com', '123', 'user', 'user4'),
(6, 'user5@gmail.com', '123', 'user', 'user5'),
(7, 'user6@gmail.com', '123', 'user', 'user6'),
(8, 'user7@gmail.com', '123', 'user', 'user7'),
(9, 'user8@gmail.com', '123', 'user', 'user8'),
(10, 'user9@gmail.com', '123', 'user', 'user9'),
(11, 'user10@gmail.com', '123', 'user', 'user10'),
(12, 'user11@gmail.com', '123', 'user', 'user11'),
(13, 'user12@gmail.com', '123', 'user', 'user12'),
(14, 'user13@gmail.com', '123', 'user', 'user13'),
(15, 'user14@gmail.com', '123', 'user', 'user14'),
(16, 'user15@gmail.com', '123', 'user', 'user15'),
(17, 'user16@gmail.com', '123', 'user', 'user16'),
(18, 'user17@gmail.com', '123', 'user', 'user17'),
(19, 'user18@gmail.com', '123', 'user', 'user18'),
(20, 'user19@gmail.com', '123', 'user', 'user19'),
(21, 'user20@gmail.com', '123', 'user', 'user20'),
(22, 'user21@gmail.com', '123', 'user', 'user21'),
(23, 'user22@gmail.com', '123', 'user', 'user22'),
(24, 'user23@gmail.com', '123', 'user', 'user23'),
(25, 'user24@gmail.com', '123', 'user', 'user24'),
(26, 'user25@gmail.com', '123', 'user', 'user25'),
(27, 'user26@gmail.com', '123', 'user', 'user26'),
(28, 'user27@gmail.com', '123', 'user', 'user27'),
(29, 'user28@gmail.com', '123', 'user', 'user28'),
(30, 'user29@gmail.com', '123', 'user', 'user29'),
(31, 'user30@gmail.com', '123', 'user', 'user30'),
(32, 'librarian2@gmail.com', '123', 'librarian', 'lib2'),
(33, 'librarian3@gmail.com', '123', 'librarian', 'lib3'),
(34, 'librarian4@gmail.com', '123', 'librarian', 'lib4');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_title` (`title`),
  ADD KEY `idx_author` (`author`),
  ADD KEY `FK9h87l7la00ok1yuugxocek325` (`reserved_by`),
  ADD KEY `FK73ff6b5r5510k1cvt79vrolb3` (`borrowed_by`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  ADD UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT dla tabeli `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `FK73ff6b5r5510k1cvt79vrolb3` FOREIGN KEY (`borrowed_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK9h87l7la00ok1yuugxocek325` FOREIGN KEY (`reserved_by`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
