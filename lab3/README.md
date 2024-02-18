::: titlepage
::: center
::: large
Санкт-Петербургский Политехнический университет\
Петра Великого\
Физико-механический институт\
:::

Высшая школа прикладной математики и вычислительной физики\
:::

::: center
**Отчёт\
по лабораторной работе №3\
по дисциплине\
\"Компьютерные сети\"**
:::

Выполнил студент: Аникин Алексадр Алексевич,
группа 5040102$\backslash$`<!-- -->`{=html}20201 Проверил:
к.ф.-м.н., доцент Баженов Александр Николаевич

::: center
Санкт-Петербург, 2024
:::
:::

# Постановка задачи

Требуется реализовать алгоритм, позволяющий обрабатывать неисправные
компоненты компьютерной системы, которые передают противоречивую
информацию в разные части этой системы. Исторически эта задача известна
как \"Задача византийский генералов\". Вокруг вражеского города
расположены лагеря групп генералов византийской армии со своими
войсками. Общаясь только посредством гонца, генералы должны согласовать
общий план сражения (атаковать или отступать). Однако один или несколько
из них могут оказаться предателями, которые попытаются сбить с толку
остальных. Задача состоит в поиске алгоритма, гарантирующий, что
лояльные генералы придут к соглашению.

# Теория

В 1982 году Лэсли Лэмпорт предложил следующее алгоритм решения данной
задачи. Он показывает, что при использовании устных сообщений
(\"АТАКА\" и \"ОТСТУПЛЕНИЕ\" ) эта проблема разрешима тогда и только
тогда, когда более двух третей генералов лояльны.

Алгоритм Лэмпорта выглядит следующим образом (m - уровень
рекурсии/количество предателей, \"командир\" - генерал-отправитель,
\"лейтенант\" - генерал-получатель):

## Алгоритм OM(0) (базовый вариант)

1.  Командир отправляет свое сообщение каждому лейтенанту.

2.  Каждый лейтенант принимает сообщение, которое он получает от
    командира, или принимает сообщение \"ОТСТУПЛЕНИЕ\" , если он не
    получает никакого сообщения.

## Алгоритм OM(m), m \> O.

1.  Командир отправляет свое сообщение каждому лейтенанту.

2.  Для каждого $i$ пусть $v[i]$ - сообщение, которое i-ый генерал
    получает от командира, или же \"ОТСТУПЛЕНИЕ\" , если он не получает
    никакого сообщения. i-ый генерал действует как командир в алгоритме
    OM(m - 1), отправляя значение $v[i]$ каждому из N - 2 других
    лейтенантов.

3.  Для каждого $i$ и каждого $j \neq i$ пусть $v[j]$ будет сообщением,
    полученным i-ым генералом от j-ого генерала на предыдущем шаге
    (используя алгоритм OM(m - 1)), или же \"ОТСТУПЛЕНИЕ\" , если он не
    получил такого сообщения. В общем случае i-ый генерал принимает
    наиболее часто встречающееся значение (v\[0\]\.....v\[N\]).

# Результаты

Пусть войсками командуют 10 генералов и был отдан пркиказ \"АТАКА\".
Рассмотрим несколько конфигураций предателей:

## 0 предателей, m = 0

::: center
   General 0   ('ATTACK', 1)
  ----------- ---------------
   General 1   ('ATTACK', 1)
   General 2   ('ATTACK', 1)
   General 3   ('ATTACK', 1)
   General 4   ('ATTACK', 1)
   General 5   ('ATTACK', 1)
   General 6   ('ATTACK', 1)
   General 7   ('ATTACK', 1)
   General 8   ('ATTACK', 1)
   General 9   ('ATTACK', 1)
:::

В случае полностью лояльного войска каждый из генералов получает ровно
по одному приказу к атаке, соответственно все генералы смогли
договориться.

## 1 предатель (генерал с индексом 2), m = 1

::: center
   General 0   ('ATTACK', 8)   ('RETREAT', 1)
  ----------- --------------- ----------------
   General 1   ('ATTACK', 9)         \-
   General 2   ('ATTACK', 8)   ('RETREAT', 1)
   General 3   ('ATTACK', 9)         \-
   General 4   ('ATTACK', 8)   ('RETREAT', 1)
   General 5   ('ATTACK', 9)         \-
   General 6   ('ATTACK', 8)   ('RETREAT', 1)
   General 7   ('ATTACK', 9)         \-
   General 8   ('ATTACK', 8)   ('RETREAT', 1)
   General 9   ('ATTACK', 9)         \-
:::

В случае c одним предателем войску по-пержнему удается договриться об
общем решении, каждый из генералов получил 8 или 9 сообщений об атаке и
максимум одно обратное.

## 3 предателя (генералы с индексами 2, 5, 9), m = 3

::: center
   General 0   ('ATTACK', 303)   ('RETREAT', 273)
  ----------- ----------------- ------------------
   General 1   ('ATTACK', 403)   ('RETREAT', 173)
   General 2   ('ATTACK', 303)   ('RETREAT', 273)
   General 3   ('ATTACK', 403)   ('RETREAT', 173)
   General 4   ('ATTACK', 303)   ('RETREAT', 273)
   General 5   ('ATTACK', 403)   ('RETREAT', 173)
   General 6   ('ATTACK', 303)   ('RETREAT', 273)
   General 7   ('ATTACK', 403)   ('RETREAT', 173)
   General 8   ('ATTACK', 303)   ('RETREAT', 273)
   General 9   ('ATTACK', 403)   ('RETREAT', 173)
:::

В случае c тремя предателем войску по-пержнему удается договриться об
общем решении, однако количество сообщений от предателей заметно
увеличилось. Тем не менее, количество правдивых сообщений остается в
большинстве. Данный случай (7 лояльных и 3 предателя) является краевым,
так как не существует решения, если количество предателей строго
превышает $\frac{1}{3}$ общего числа генералов.

## 4 предателя (генералы с индексами 2, 5, 8, 9), m = 4

::: center
   General 0   ('RETREAT', 2326)   ('ATTACK', 2282)
  ----------- ------------------- -------------------
   General 1   ('ATTACK', 2630)    ('RETREAT', 1978)
   General 2   ('RETREAT', 2326)   ('ATTACK', 2282)
   General 3   ('ATTACK', 2630)    ('RETREAT', 1978)
   General 4   ('RETREAT', 2326)   ('ATTACK', 2282)
   General 5   ('ATTACK', 2630)    ('RETREAT', 1978)
   General 6   ('RETREAT', 2326)   ('ATTACK', 2282)
   General 7   ('ATTACK', 2630)    ('RETREAT', 1978)
   General 8   ('RETREAT', 2326)   ('ATTACK', 2282)
   General 9   ('ATTACK', 2630)    ('RETREAT', 1978)
:::

В случае c четырьмя предателем наблюдается разрозненность значений,
решения не существует.