# Архитектура

| type   | sizeof |
|--------|--------|
| bool   | 1      |
| char   | 1      |
| int    | 4      |
| double | 8      |

**class shape [4]**

| type    | name   | sizeof |
|---------|--------|--------|
| colours | color  | 4      |

**class point [8]**

| type    | name   | sizeof |
|---------|--------|--------|
| int     | x_     | 4      |
| ixt     | y_     | 4      |

**class rectangle [20]**

| type    | name   | sizeof |
|---------|--------|--------|
| colours | color  | 4      |
| point   | f_     | 8      |
| point   | s_     | 8      |

**class triangle [28]**

| type    | name   | sizeof |
|---------|--------|--------|
| colours | color  | 4      |
| point   | f_     | 8      |
| point   | s_     | 8      |
| point   | t_     | 8      |

**class circle [16]**

| type    | name   | sizeof |
|---------|--------|--------|
| colours | color  | 4      |
| int     | radius | 4      |
| point   | center | 8      |

**class container [80008]**

| type            | name    | sizeof |
|-----------------|---------|--------|
| size_t          | MAX_LEN | 4      |
| size_t          | len_    | 4      |
| shape*[10000]   | array_  | 80000  |

## Память программы

**main [1572]**

| type            | name          | sizeof | place          |
|-----------------|---------------|--------|----------------|
| int             | argc          | 4      | stack          |
| char*[]         | argv          | 8      | stack, heap    |
| container*      | c             | 8      | stack          |
| FILE*           | file          | 8      | stack, heap    |
| std::ifstream   | inst          | 520    | stack, heap    |
| std::ofstream   | ofst1         | 512    | stack, heap    |
| std::ofstream   | ofst2         | 512    | stack, heap    |

**container(std::ifstream) [40]**

| type            | name          | sizeof | place          |
|-----------------|---------------|--------|----------------|
| int             | type          | 4      | stack          |
| std::string     | name          | 32     | stack, heap    |
| shape::colour   | colour        | 4      | stack          |

**container(int) [12]**

| type            | name          | sizeof | place          |
|-----------------|---------------|--------|----------------|
| int             | type          | 4      | stack          |
| int             | chosen        | 4      | stack          |
| shape::colour   | colour        | 4      | stack          |

**container::sort **

| type            | name          | sizeof | place          |
|-----------------|---------------|--------|----------------|
| int             | i             | 4      | stack          |
| int             | j             | 4      | stack          |
| int             | k             | 4      | stack          |
| shape*          | sp            | 8      | stack, heap    |
