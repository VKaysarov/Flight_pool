-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 23 2020 г., 19:53
-- Версия сервера: 5.6.41
-- Версия PHP: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `flight_pool`
--

-- --------------------------------------------------------

--
-- Структура таблицы `airport`
--

CREATE TABLE `airport` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `iata` varchar(3) NOT NULL,
  `sity` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `airport`
--

INSERT INTO `airport` (`id`, `name`, `iata`, `sity`) VALUES
(1, 'Sheremetyevo', 'SVO', 'Moscow'),
(2, 'INTERNATIONAL AIRPORT', 'DEL', 'GANDHI'),
(3, 'Anaa Airport', 'AAA', 'Anaa, Tuamotus'),
(4, 'Altay Airport', 'AAT', 'Altay, Xinjiang'),
(5, 'Alpha Airport', 'ABH', 'Alpha, Queensland'),
(6, 'Andizhan Airport', 'AZN', 'Andizhan'),
(7, 'LONDON CITY AIRPORT', 'LCY', 'LONDON');

-- --------------------------------------------------------

--
-- Структура таблицы `booking`
--

CREATE TABLE `booking` (
  `id` int(11) NOT NULL,
  `code` varchar(250) NOT NULL,
  `cost` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `booking`
--

INSERT INTO `booking` (`id`, `code`, `cost`, `flight_id`) VALUES
(21, 'ZUzek', 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `flight`
--

CREATE TABLE `flight` (
  `id` int(11) NOT NULL,
  `flight_code` varchar(32) NOT NULL,
  `date_from` date NOT NULL,
  `time_from` time NOT NULL,
  `airport_from_id` int(11) NOT NULL,
  `date_to` date NOT NULL,
  `time_to` time NOT NULL,
  `airport_to_id` int(11) NOT NULL,
  `cost` int(250) NOT NULL,
  `availability` int(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `flight`
--

INSERT INTO `flight` (`id`, `flight_code`, `date_from`, `time_from`, `airport_from_id`, `date_to`, `time_to`, `airport_to_id`, `cost`, `availability`) VALUES
(1, '123', '2020-10-06', '16:42:24', 1, '2020-10-04', '11:42:24', 2, 12400, 80),
(2, '321', '2020-10-06', '17:17:49', 5, '2020-10-13', '17:20:49', 7, 10400, 70),
(3, '300', '0000-00-00', '00:00:10', 3, '0000-00-00', '00:00:20', 4, 12000, 87),
(4, '301', '2020-02-20', '00:00:10', 4, '3020-01-20', '00:00:20', 3, 11000, 78),
(5, '302', '2020-02-20', '00:00:10', 4, '3020-01-20', '00:00:20', 5, 11500, 58),
(6, '303', '2020-02-20', '00:00:10', 5, '3020-01-20', '00:00:20', 6, 11000, 74),
(7, '304', '2020-02-20', '00:00:10', 6, '3020-01-20', '00:00:20', 7, 10000, 37),
(8, '305', '2020-02-20', '00:00:10', 4, '3020-01-20', '00:00:20', 7, 9999, 76),
(9, '306', '2020-02-20', '00:00:10', 4, '3020-01-20', '00:00:20', 1, 13000, 22),
(10, '307', '2020-02-20', '00:00:10', 1, '3020-01-20', '00:00:20', 3, 12300, 62);

-- --------------------------------------------------------

--
-- Структура таблицы `passenger`
--

CREATE TABLE `passenger` (
  `id` int(11) NOT NULL,
  `first_name` varchar(250) NOT NULL,
  `last_name` varchar(250) NOT NULL,
  `birth_date` date NOT NULL,
  `document_number` varchar(11) NOT NULL,
  `place_from` varchar(11) DEFAULT NULL,
  `place_back` varchar(11) DEFAULT NULL,
  `booking_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `passenger`
--

INSERT INTO `passenger` (`id`, `first_name`, `last_name`, `birth_date`, `document_number`, `place_from`, `place_back`, `booking_id`) VALUES
(32, 'Ivan', 'Ivanov', '1990-02-20', '1234567890', '', '', 21),
(33, 'Ivan', 'Gorbunov', '1990-03-20', '1224567890', '', '', 21);

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(250) NOT NULL,
  `last_name` varchar(250) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `document_number` varchar(10) NOT NULL,
  `password` varchar(250) NOT NULL,
  `access_token` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id`, `first_name`, `last_name`, `phone`, `document_number`, `password`, `access_token`) VALUES
(1, 'Viktor', 'Kaisarov', '+7934523243', '234234233', '123', ''),
(2, 'Jon', 'Si', '89345232432', '234561234', '1234', '2KOOiCFK56r-aOu_Ol9Nwy9rAnD50gxa'),
(8, 'wer', 'wer', '893452222', '345345345', '12342', '4lPMcBBCTGA3pF3edt5xDIrqYAXOztDu');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `airport`
--
ALTER TABLE `airport`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`id`),
  ADD KEY `airport_from_id` (`airport_from_id`),
  ADD KEY `airport_to_id` (`airport_to_id`);

--
-- Индексы таблицы `passenger`
--
ALTER TABLE `passenger`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `airport`
--
ALTER TABLE `airport`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `booking`
--
ALTER TABLE `booking`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `flight`
--
ALTER TABLE `flight`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `passenger`
--
ALTER TABLE `passenger`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`airport_from_id`) REFERENCES `airport` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`airport_to_id`) REFERENCES `airport` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
