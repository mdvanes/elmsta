# Elmsta

## Purpose

Testing out Elm and answering questions like:

* How does it integrate into e.g. a pre-existing angular environment?
* Can I reuse any testing tools like Karma/Testing or is there an alternative?
* How do modules work? Can I use Webpack? How do I import modules other than Elm (e.g. img/font assets)?
* Integrating Bootstrap (elm bootstrap)
* If Elm can compile to JavaScript, can it be used on the back-end? Would this make any sense?
* Integrating Reactive Extensions?
* Integrating State containers (e.g. Redux)
* Syntax highlighting in different editors (Webstorm, Sublime)

## Reference

* Using Getty Images API http://developers.gettyimages.com/en/trytheapi.html
* Elm tutorial https://www.elm-tutorial.org/en/
* Elm packages https://package.elm-lang.org/

## Run development

* nvm use 7.10.0
* installation: `elm package install`
* run: `elm reactor`

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