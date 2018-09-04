### introduction to GraphQL
GraphQL [官方介绍][graphql]，一套 GraphQL Server 或者 Data Query Language。

#### 为什么使用 GraphQL ?

- 超快
- 与存储解耦，以前端视图为中心，前端指定查询。
- 声明式，定义我们要什么，而不是如何获得。
- 结构化可验证
- 方便协作，通过 GraphiQL

反正挺好的，用就是了，不会就去学。

### GraphQL Schema

来看看查询语法。

```ruby
# Built-in scalar types: Int, Float, String, Boolean, ID

type User {
  id: ID!                # mandatory 强制
  name: String           # optional 可选
  friends: [User]!       # mandatory list
}

type Root {
  me: User
  friends(forUser: ID!, limit: Int = 5): [User]!
}

schema {
  query: Root,
  mutation: ...
}
```

上面的 schema 我们定义了两个入口 query 和 mutation。 用来读取和修改数据用。
schema 定义了两种类型：Root 和 User。

使用感叹号来指明不可为空（#4）或者参数（#11）。参数默认值使用等号（#11）

#### Queries and Output

查询

```js
query {                   // 匿名查询
  me {                    // Root Type
    id name              //  User Type
  }
}

query MyQuery {           //具名查询 MyQuery
  me {                    // 查询关键字可选
    id name
  }
}

// Using arguments 使用参数
query {
  friends(forUser: 'cir9') {
    id name
  }
}

query {
  friends(forUser: 'cir9', limit: 3) {
    id name
  }
}

// Nested queries 嵌套
query {
  me {
    id name
    friends {
      id name
    }
  }
}
```

来看看对应的输出：

```js
//query                                
{
  me {
    name
  }
}

// JSON output
{
  "data": {
    "me": {
      "name": "GraphQL ninja"
    }
  }
}

```
查询返回的 JSON 对象就在 data 关键字下。
你还可以使用 aliases 来改变 key 的名字。

```js
// query 
{
  user: me {
    fullName: name
  }
}

// JSON output
{
  "data": {
    "user": {
      "fullName": "GraphQL ninja"
    }
  }
}
```

#### Fields composition(fragments) 字段组合

重用和组合字段

```js
query {
  me {
    ...userInfo
    friends {
      ...userInfo
    }
  }
}

fragment userInfo on User {
  id 
  name
}
```

> Fragments can also be used by other fragments

#### Error handling
出现错误我们将得到错误输出：

```js
{  
  "data": {
    "me": null
  },
  "errors": [{
    "message": "[ERROR] Message"
  }]
}
```
进一步学习： [learn graphql][learn graphql]


[graphql]: https://facebook.github.io/graphql/
[learn graphql]: https://learngraphql.com/