iOS数据存储-SQLite的使用
=======================

> 写在前面：最近正在找工作，发现很多的iOS基础知识都掌握得不牢固，两年工作经验却只停留在了只会使用第三方而不知其原理的程度，变成了典型的“搜索型程序员”和“stackoverflow程序员”，故打算一步一步回顾并整理成笔记，好记性不如烂笔头！

## SQL常用语句

[SQL语法](http://www.w3school.com.cn/sql/index.asp) 可以在这里看看，列出几个常用语句。

1. 创建表：

```    
CREATE TABLE Product (
    Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
    name TEXT, 
    details TEXT, 
    price DOUBLE, 
    quantity INTEGER, 
    image TEXT
);
```
2. 插入记录

```
INSERT INTO Product (name, details, price, quantity, image)
VALUES ('Product A', 'Detail of Product A', 10.00, 100, 'Cover A');
```
3. 删除记录

```
DELETE FROM Product WHERE Id = 1;
```
4. 修改记录

```
UPDATE Product set
    name = 'Product B',
    details = 'Detail of Product B',
    image = 'Cover B'
WHERE Id = 1;
```
5. 查询记录

```
SELECT name, details FROM Product WHERE Id = 1;
SELECT * FROM Product;
```

## SQLite 基本操作

### Swift中使用sqlite
* 建立桥接文件`xxx-Bridging-Header.h`，引入头文件`#import <sqlite3.h>`
* 在 General --> Linking frameworks And Library 中添加添加library `libsqlite3.0.tbd`

### The C API
所有的API和数据结构可以查阅[SQLite的官方文档](https://www.sqlite.org/cintro.html)。这里列出几个常用的API。

* sqlite3\_open ：如果数据库文件存在，则打开并连接数据库，如果不存在，则创建一个数据库文件，并建立连接。
* sqlite3\_close ：关闭数据库。
* sqlite3\_prepare\_v2 ：编译SQL语句（实际并没有执行语句），生成一个statement。
* sqlite3\_step ：单步执行编译后的statement，每次从statement中获取一条记录。返回`SQLITE_ROW`表示结果集里面还有数据，下一次会跳到下一条结果，返回`SQLite_DONE`表示已经是最后一条数据了，会结束整个查询。
* sqlite3\_reset ：重置statement到最初的状态。
* sqlite3\_finalize ：释放prepare创建的statement，防止内存泄漏。
* sqlite3\_exec ：执行SQL语句。其实是对 `sqlite3_prepare_v2()`, `sqlite3_step()`, 和 `sqlite3_finalize()`等多条语句的封装，可以少写很多c代码，第三个参数可以传入一个callback，能访问到结果集。
* sqlite3\_errmsg ：获取错误信息。

> 每个函数都会返回一个int类型的状态码，`SQLITE_OK`表示成功，根据状态码可以判断每一步是否执行成功，有没有出现异常。

#### 参数绑定
绑定对应类型的值到sql语句中用?代替的参数，第一个参数为statement，第二个参数为对应的下标，从1开始，第三个参数为值。

* sqlite3\_bind\_int
* sqlite3\_bind\_text

#### 获取字段值
获取对应类型的字段的值，第一个参数为statement，第二个参数为字段的下标，从0开始。

* sqlite3\_column\_int
* sqlite3\_column\_text

#### 打开数据库

```
// 数据库句柄
var db: OpaquePointer? = nil

func openDataBase(dbName: String) -> Bool {
    guard let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
        jf_print("Open database failed. Reason: Document path was nil.")
        return false
    }
    
    let dbPath = documentPath + "/" + dbName
    
    // Open database if existed or create if not existed.
    guard sqlite3_open(dbPath, &db) == SQLITE_OK else {
        jf_print("Open database failed.")
        close()
        return false
    }
    
    jf_print("Successfully opend connection to database at \(dbPath)")
    
    return true
}
```

#### 关闭数据库

```
func close() {
    sqlite3_close(db)
    db = nil
}
```

#### 创建表

```
func createTable() -> Bool {
    let sql = "CREATE TABLE IF NOT EXISTS Contact(" +
        "Id INT PRIMARY KEY NOT NULL," +
    "name TEXT);"
    if sqlite3_exec(db, String(utf8String: sql.cString(using: .utf8)!), nil, nil, nil) == SQLITE_OK {
        jf_print("Create table succeed.")
        return true
    } else {
        jf_print("Create table failed. \(errorMsg)")
        return false
    }
}
```

#### 插入一条记录

```
func insert() {
    let sql = "INSERT INTO Contact (Id, name) VALUES (?, ?);"
    var stmt: OpaquePointer? = nil
    // 1. Compiles the SQL statement and verify that all is well
    guard sqlite3_prepare_v2(db, String(utf8String: sql.cString(using: .utf8)!), -1, &stmt, nil) == SQLITE_OK else {
        jf_print("INSERT statement could not be prepared. \(errorMsg)")
        return
    }
    
    let id: Int32 = 10
    let name = "Ray 中文"
    
    // 2. binding values to the statement
    sqlite3_bind_int(stmt, 1, id)
    sqlite3_bind_text(stmt, 2, String(utf8String: name.cString(using: .utf8)!), -1, nil)
    
    // 3. execute the statement and verify that it finished
    if sqlite3_step(stmt) == SQLITE_DONE {
        jf_print("Successfully inserted row.")
    } else {
        jf_print("Could not insert row. \(errorMsg)")
    }
    
    // 4. Delete the compiled statement to avoid resource leaks
    sqlite3_finalize(stmt)
}
```

#### 插入多条记录

```
func insertMultipleRows() {
    let sql = "INSERT INTO Contact (Id, name) VALUES (?, ?);"
    var stmt: OpaquePointer? = nil
    let names = ["Ray", "Chris", "Tom", "Jim"]
    
    guard sqlite3_prepare_v2(db, String(utf8String: sql.cString(using: .utf8)!), -1, &stmt, nil) == SQLITE_OK else {
        jf_print("INSERT statement could not be prepared. \(errorMsg)")
        return
    }
    
    for (index, name) in names.enumerated() {
        let id = Int32(index + 1)
        sqlite3_bind_int(stmt, 1, id)
        sqlite3_bind_text(stmt, 2, String(utf8String: name.cString(using: .utf8)!), -1, nil)
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            jf_print("Successfully inserted row.")
        } else {
            jf_print("Could not insert row. \(errorMsg)")
        }
        
        // reset the compiled statement back to its initial state before execute it again.
        sqlite3_reset(stmt)
    }
    
    sqlite3_finalize(stmt)
}
```

#### 更新记录

```
func update() {
    let sql = "UPDATE Contact SET name = 'Chris' WHERE Id = 1;"
    var stmt: OpaquePointer? = nil
    guard sqlite3_prepare_v2(db, String(utf8String: sql.cString(using: .utf8)!), -1, &stmt, nil) == SQLITE_OK else {
        print("UPDATE statement could not be prepared. \(errorMsg)")
        return
    }
    
    guard sqlite3_step(stmt) == SQLITE_DONE else {
        print("Could not update row. \(errorMsg)")
        return
    }
    
    print("Successfully update row.")
    sqlite3_finalize(stmt)
}
```

或者使用 `exec`函数

```
func update() {        
    let sql = "UPDATE Contact SET name = 'Chris' WHERE Id = 1;"
    if sqlite3_exec(db, String(utf8String: sql.cString(using: .utf8)!), nil, nil, nil) == SQLITE_OK {
        jf_print("Successfully update row.")
    } else {
        jf_print("Could not update row. \(errorMsg)")
    }
}
```

#### 删除记录

```
func delete() {
    let sql = "DELETE FROM Contact WHERE Id = 2;"
    if sqlite3_exec(db, String(utf8String: sql.cString(using: .utf8)!), nil, nil, nil) == SQLITE_OK {
        jf_print("Successfully DELETE row.")
    } else {
        jf_print("Could not DELETE row. \(errorMsg)")
    }
}
```

#### 查询记录

```
func query() {
    let sql = "SELECT * FROM Contact;"
    var stmt: OpaquePointer? = nil
    
    guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
        print("SELECT statement could not be prepared. \(errorMsg)")
        return
    }
    
    // using a while loop to execute the step, which will happen as long as the return code is SQLITE_ROW. When you reach the last row, the return code will by SQLITE_DONE and the loop will break.
    while sqlite3_step(stmt) == SQLITE_ROW {
        // read values from the returned row
        let id = sqlite3_column_int(stmt, 0)
        let name = String(cString: UnsafePointer(sqlite3_column_text(stmt, 1))!)
        jf_print("Query Result: \(id) | \(name)")
    }
    
    sqlite3_finalize(stmt)
}
```

#### 获取错误信息

```
private var errorMsg: String {
    if let errorMsg = UnsafePointer(sqlite3_errmsg(db)) {
        return String(cString: errorMsg, encoding: .utf8)!
    } else {
        return "No error message provided from sqlite."
    }
}
```

#### 注意事项

> 注意：sql 语句或参数值最好使用UTF8编码，因为可能会有中文。
>
> 这里说一个坑，在Swift 3.0中，一开始以`sqlite3_prepare_v2()`和`sqlite3_bind_text()`等函数中传入的字符串是c语言的字符串，所以直接使用`sql.cString(using: .utf8)`，然后就发现运行的很不稳定，运行的结果一会儿正确的，一会儿错误，快把我搞死了，以为是线程问题或是使用姿势不对，折腾了一两个小时，后来发现必须这样写才行：`String(utf8String: sql.cString(using: .utf8)!)` 或者 `(sql as NSString).utf8String`



### 使用Swift简单封装SQLite API

占坑...

## FMDB

占坑...

## SQLite.swift

占坑...

-------

参考文档：

[SQLite Tutorial: Getting Started](https://www.raywenderlich.com/123579/sqlite-tutorial-swift)