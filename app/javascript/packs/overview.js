  var prepareSearch = function (list) {
    var i, q, searchStr
    for (i = 0; i < list.length; i++) {
      q = list[i]
      searchStr = q.name + q.creator
      if (q.creator === "You") {
        searchStr += "mine me"
      }
      q.searchStr = prepareQuery(searchStr)
    }
  }

  var prepareQuery = function (str) {
    return str.toLowerCase()
  }

  var app = Vue.createApp({
    data: function() {
      return {
        searchTerm: "",
        more: more,
        updateCounter: 0
      }
    },
    created: function() {
      this.listItems = dashboards.concat(queries)

      prepareSearch(this.listItems)

      this.queryIds = {}
      for (i = 0; i < queries.length; i++) {
        this.queryIds[queries[i].id] = true
      }

      if (this.more) {
        var _this = this

        $.getJSON(Routes.queries_path(), function (data) {
          var i, j, newValues, val, size = 500;

          var newValues = []
          for (j = 0; j < data.length; j++) {
            val = data[j]
            if (val && !_this.queryIds[val.id]) {
              newValues.push(val)
            }
          }

          prepareSearch(newValues)

          _this.listItems = _this.listItems.concat(newValues)
          _this.more = false
          // hack to get to update
          _this.updateCounter++
        })
      }
    },
    computed: {
      visibleItems: function () {
        // hack to get to update
        this.updateCounter

        var pageSize = 200
        var q, i

        if (this.searchTerm.length > 0) {
          var term = prepareQuery(this.searchTerm)
          var items = []
          var fuzzyItems = []
          for (i = 0; i < this.listItems.length; i++) {
            q = this.listItems[i]
            if (q.searchStr.indexOf(term) !== -1) {
              items.push(q)
              if (items.length == pageSize) {
                break
              }
            } else if (fuzzysearch(term, q.searchStr)) {
              fuzzyItems.push(q)
            }
          }
          return items.concat(fuzzyItems).slice(0, pageSize)
        } else {
          return this.listItems.slice(0, pageSize)
        }
      }
    },
    methods: {
      itemPath: function (item) {
        if (item.dashboard) {
          return Routes.dashboard_path(item.to_param)
        } else {
          return Routes.query_path(item.to_param)
        }
      }
    },
    directives: {
      focus: {
        inserted: function (el) {
          el.focus()
        }
      }
    }
  })
  app.config.compilerOptions.whitespace = "preserve"
  app.mount("#overview")