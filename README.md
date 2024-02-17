# Kd

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Container

```bash
docker build -t khmer-dictionary .
```

Run the app:

```bash
# don't use this key in production, generate 64 bytes random string
export SECRET_KEY_BASE="/4mSfOc6jCMveCINKAkJmCyWMsIa+xzIKF9zqaePbwNlwkZSuFDqMxhhWYdy77et"
docker run --rm -p 4000:4000 -e SECRET_KEY_BASE=$SECRET_KEY_BASE khmer-dictionary
```

## Text-to-speech

Piggy back on [https://github.com/seanghay/klea-js](https://github.com/seanghay/klea-js) to deliver text-to-speech. Alright, Microservice 101.

```bash
docker-compose up
```

| Service        | Port |
| -------------- | ---- |
| Text-to-Speech | 3000 |
| Dictionary     | 4000 |

Visit: [http://localhost:4000](http://localhost:4000)

## Stack

- [Elixir Phoenix Liveview](https://hexdocs.pm/phoenix_live_view/welcome.html)
- [Tailwind CSS](https://tailwindcss.com/docs/installation)
- Dictionary data borrowed from [https://khmerdict.com/](https://khmerdict.com/)
