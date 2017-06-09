# Elmsta

Compiled page is hosted on: https://mdvanes.github.io/elmsta/

## Purpose

Testing out Elm and answering questions like:

* If Elm can compile to JavaScript, can it be used on the back-end? Would this make any sense? -> does not look like it
* Integrating State containers (e.g. Redux) -> should not be needed since Elm is prior-art for Redux
* DONE Syntax highlighting in different editors (Webstorm OK, Sublime OK)
* DONE Integrating Bootstrap (elm bootstrap, Card can't contain arbitrary content)
* How does it integrate into e.g. a pre-existing angular environment? -> You can export as a JavaScript module instead of html and integrate it and interact with it via ports. To be tested.
* Can I reuse any testing tools like Karma/Testing or is there an alternative?
* How do modules work? Can I use Webpack? How do I import modules other than Elm (e.g. img/font assets)? -> 
    see https://www.elm-tutorial.org/en/04-starting/03-webpack-1.html
* Integrating Reactive Extensions? [2 minute introduction to Rx](https://medium.com/@andrestaltz/2-minute-introduction-to-rx-24c8ca793877) by Andre Staltz (“Think of an Observable as an asynchronous immutable array.”)
* Build process (beyond elm-reactor)
* test time travel debug (elm native)
* test Elm Js interop
* String interpolation possible?

## Reference

* Using Getty Images API http://developers.gettyimages.com/en/trytheapi.html
* Elm tutorial https://www.elm-tutorial.org/en/
* Elm packages https://package.elm-lang.org/

## Run development

* nvm use 8.0.0
* `npm install -g elm`
* installation: `elm package install`
* run: `elm reactor` (or `elm reactor -p 8100`)
* build for production: `elm make app/Main.elm --output=docs/index.html`

## Use case

Input field that autocompletes search results with a list of images from the Getty API.

Example Request:

`GET https://api.gettyimages.com/v3/search/images?fields=id,title,thumb,referral_destinations&sort_order=best&phrase=tree`

Example Response:

```json
{
  "result_count": 7634992,
  "images": [
    {
      "id": "675740234",
      "display_sizes": [
        {
          "is_watermarked": false,
          "name": "thumb",
          "uri": "https://media.gettyimages.com/photos/meadow-with-grass-and-apple-trees-in-beautiful-light-picture-id67
          5740234?b=1&k=6&m=675740234&s=170x170&h=JqE1zu4siwpkynsw9jX8TuJWREGYElbadr3-66zPZCI="
        }
      ],
      "referral_destinations": [
        {
          "site_name": "thinkstock",
          "uri": "http://www.thinkstockphotos.com/image/stock-photo-meadow-with-grass-and-apple-trees-in-beautiful/67574
          0234"
        },
        {
          "site_name": "istockphoto",
          "uri": "http://www.istockphoto.com/photo/meadow-with-grass-and-apple-trees-in-beautiful-light-gm675740234-1239
          73617"
        }
      ],
      "title": "meadow with grass and apple trees in beautiful light"
    }
  ]
}
```

TODO

* DONE link back to github (side banner/fork me on github)

* refactor https://medium.com/@_rchaves_/structured-todomvc-example-with-elm-a68d87cd38da
* add input element that responds to keydown
* fetch results from API
* subscribe to changes from the API
* render the result
* webpack
* unit tests
* search on key up (reactively)
* reactive test/excel example
* page title -> "Elmsta (Elm Demo)"
* websockets