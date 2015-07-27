kor.directive "korAnno", [
  "$http", "$timeout", 
  (http, to) ->
    directive = {
      scope:
        iv: "&imageVisible"
        annos: "=korAnno"
        hide: "&ngClick"

      link: (scope, element, attrs) ->
        add = null
      
        doit = ->
          console.log "doit"
          anno.makeAnnotatable(myImage[0])
          for a in scope.annos
            anno.addAnnotation(a)

        scope.$watch "annos", (v) ->
          console.log "annos changed:", scope.annos, v
          if scope.annos.length == 0
            console.log "vide"
            anno.removeAll() 
        

        #element.on "click", ->
        #  console.log "light please !"
        #  console.log scope.light
        #  anno.removeAnnotation()
        #  scope.$apply()

        #scope.$watch "light()", (a) ->
        #  console.log "light changed: #{a}"
        #  anno.highlightAnnotation(scope.annos)

        anno.addHandler 'onAnnotationCreated', ->
          annotations = anno.getAnnotations()
          scope.annos = annotations
          scope.$apply()

        #aa = ->
        #  console.log "addAnnotation"
        #  #add = scope.annos[1]
        #  anno.addAnnotation(
        #    {
        #      src : 'http://localhost:3000/media/images/screen/000/000/001/image.jpg?1436190828',
        #      text : 'My annotation',
        #      shapes : [{
        #          type : 'rect',
        #          geometry : { x : 0.12, y: 0.14482758620689656, width : 0.215, height: 0.1413793103448276 }
        #        }]
        #    }
        #  )

        anno.addHandler 'onAnnotationRemoved', ->
          alert "Do you want to remove this annotation ?"
          anno.removeAnnotation(scope.annos)
          annotations = anno.getAnnotations()
          scope.annos = annotations
          console.log(scope.annos)
          scope.$apply()

        #attrs.$observe 'src', (value) ->
        #  console.log value

        myImage = jQuery('img.annotation')
        $(myImage).load ->
         console.log('loaded')
        $(myImage).ready ->
          console.log('ready')
        if myImage 
          console.log("img picked up")
          console.log(myImage)

        #myLight = jQuery('button.light')
        #console.log myLight

        window.s = scope
        window.e = element
        window.a = attrs
        window.d = aa
        window.z = add
        window.c = scope.annos
        
        to(doit, 2500)
        #to(aa, 2500)

      priority: 100
    }
]