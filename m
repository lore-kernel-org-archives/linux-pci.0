Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473E3CEB8B
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521212; cv=none; b=Z945pAxM8kI7VKe+0dF6VOAIEM9ft+dtwHCEvcrhiQX466kCgnofsJOHSMbDydqrQycaA9Wx1z1GBb+7YdXbAFfqmFFS3tVlh2+YK8YTXuzZy80PA6lp8NEnTQEBtgze+98XE43S6IbaBS+Uz8b507/nuZD+OJ28Hp7WA1rqZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521212; c=relaxed/simple;
	bh=ZudevnbvHxuJFNRVUgY0l6TTlPYj57cCXzQfq18RxyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGND5Tk6sZo1QNAWUHcn9RSbt38jLPeNhR8XF9Cb4S54x6BT6xA9q7QDA9xvhqmDWev3uMpDjXwCa77UJlEbsvthk0ZGFLHAYe1NwaTAsiQ3VuoY1knVUCkYkUrl2M+aZWVkgJABCKeMTovZrAfCWdTH7MmhMsnkuIF2oxKZJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLAVn+yy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLAVn+yy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00C8C4AF0D
	for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774521211;
	bh=ZudevnbvHxuJFNRVUgY0l6TTlPYj57cCXzQfq18RxyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kLAVn+yyTl/Q8z+UhqbNmfz2LrWrp36HL1Ae4tSkcqPbq1qp3GRw4UjT323vqOUua
	 8ahJjFB01lxdM/2KIMuWIT/npAo065XzkAEJITt09khnLhIl+eLEP4WHkDeGlGhT4f
	 e0aeWHoRGhZBI4R40jiCJ1bYcjad052WCHxrFwLVGoii6XzPg7Pg1HGrPKXJuKh9dZ
	 FixFToi4dvl3Fnnmk6MV3sIitDaktMkzrAFWZVUVpwagZgrFRx2FtV0UYZvB2u1NgG
	 sqo55jxPVDBNxHLQcxm2vrGc3ZOgOvS+j+ZAYexlcyf+b06vLqMYU9z3zUlgUTwEUY
	 w55U+UPZxDs9w==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7982c3b7dfcso8234367b3.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2026 03:33:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCx3nZrYQuBLyUf6z8Wkm4aikZvR8S2qQAcYdOkmzkj3S/jRG9y+z4ky/s+YIM/UAaLguXNJqiJxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiAFBs170IBtaoRI9jqbp74qphtGbf3tBblvUgxpYvkBIIEp7L
	M3+Zu/SMetbk0EouskVESLAkrtFiY/upM1kVk0eRJx6YnIkcAMCYN4tLN44aSl5wPfo7MzcX13H
	j9n+4yLuEvFnNdKjfBzhZc6ulVPBYP5Q=
X-Received: by 2002:a05:690c:6086:b0:79a:69bc:f20f with SMTP id
 00721157ae682-79acf3a8b76mr76387137b3.21.1774521210579; Thu, 26 Mar 2026
 03:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com> <20260325143555.451852-21-herve.codina@bootlin.com>
In-Reply-To: <20260325143555.451852-21-herve.codina@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Mar 2026 11:33:19 +0100
X-Gmail-Original-Message-ID: <CAD++jLkFu+Z22QBFiaa9S+Epeh=RJZOYX8BOLVDFw4bhEoYF1Q@mail.gmail.com>
X-Gm-Features: AQROBzC4i_eE97sXtt89YSs_3fVQUuKW8eO9nnDvhVba5azUhozyRvIt7ceD-wY
Message-ID: <CAD++jLkFu+Z22QBFiaa9S+Epeh=RJZOYX8BOLVDFw4bhEoYF1Q@mail.gmail.com>
Subject: Re: [PATCH v6 20/27] misc: lan966x_pci: Fix dtso nodes ordering
To: Herve Codina <herve.codina@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Kalle Niemi <kaleposti@gmail.com>, 
	Matti Vaittinen <mazziesaccount@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Herve,

this is nitpicking, but if you respin the series consider the following:

On Wed, Mar 25, 2026 at 3:42=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Nodes available in the dtso are not ordered by their unit address.
>
> Fix that re-ordering them according to their unit address.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
(...)
> +                               switch: switch@e0000000 {

Recommended practice is:

ethernet-switch@...

> +                                       compatible =3D "microchip,lan966x=
-switch";
> +                                       reg =3D <0xe0000000 0x0100000>,
> +                                             <0xe2000000 0x0800000>;
> +                                       reg-names =3D "cpu", "gcb";
> +
> +                                       interrupt-parent =3D <&oic>;
> +                                       interrupts =3D <12 IRQ_TYPE_LEVEL=
_HIGH>,
> +                                                    <9 IRQ_TYPE_LEVEL_HI=
GH>;
> +                                       interrupt-names =3D "xtr", "ana";
> +
> +                                       resets =3D <&reset 0>;
> +                                       reset-names =3D "switch";
> +
> +                                       pinctrl-names =3D "default";
> +                                       pinctrl-0 =3D <&tod_pins>;
> +
> +                                       ethernet-ports {
> +                                               #address-cells =3D <1>;
> +                                               #size-cells =3D <0>;
> +
> +                                               port0: port@0 {

Recommended practice is:
ethernet-port@...

Yours,
Linus Walleij
