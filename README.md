# Elmsta

## Purpose

Testing out Elm and answering questions like:

* How does it integrate into e.g. a pre-existing angular environment?
* Can I reuse any testing tools like Karma/Testing or is there an alternative?
* How do modules work? Can I use Webpack? How do I import modules other than Elm (e.g. img/font assets)? -> 
    see https://www.elm-tutorial.org/en/04-starting/03-webpack-1.html
* Integrating Bootstrap (elm bootstrap)
* If Elm can compile to JavaScript, can it be used on the back-end? Would this make any sense?
* Integrating Reactive Extensions? [2 minute introduction to Rx](https://medium.com/@andrestaltz/2-minute-introduction-to-rx-24c8ca793877) by Andre Staltz (“Think of an Observable as an asynchronous immutable array.”)
* Integrating State containers (e.g. Redux)
* Syntax highlighting in different editors (Webstorm, Sublime)
* Build process (beyond elm-reactor)

## Reference

* Using Getty Images API http://developers.gettyimages.com/en/trytheapi.html
* Elm tutorial https://www.elm-tutorial.org/en/
* Elm packages https://package.elm-lang.org/

## Run development

* nvm use 7.10.0
* installation: `elm package install`
* run: `elm reactor` (or `elm reactor -p 8100`)

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

