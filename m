Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B43C198A
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146053; cv=none; b=bS2vHuLT325+XplGppYlKjQHvtkDlmdsbK22eqTjF/jaN/lOmp3B07Glsl48b43AJyLbuY01HlKYXvKkJTj4kirAsBLrOUrCW6rCLAviqAmxJ8gW5uNhmCLjv1qoFgk3+iFyUGn+j5EIhTCjV4TrLUu40YYRCxvvt6I5+RrYbS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146053; c=relaxed/simple;
	bh=x/JAxKHI7Ael5G6MScPlk2H+HssAyXfZZlY70tK9iiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeJnYEXcJrGn4XDQWpz9AFKbzCHtKmOZipOcz3ditdt6LWZQYkd93VA1AZiJniuUznWXa7+xc4f4IBY5aACs0HZONq4mHTvP45FpELSUzZKWA8FveKuJe2n9ZmZ2lnCAz69yuGL2t28X0yuv0iEd5fluDOFC5AIRG1Sslw2xW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0rprqbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0rprqbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9912FC2BCFB
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778146052;
	bh=x/JAxKHI7Ael5G6MScPlk2H+HssAyXfZZlY70tK9iiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M0rprqbASG9AzM5L1LoCdxk36ssdaXCyannccq+gQqgcNbj1cx719RJBDVV3bb4dG
	 oLT/r6JTAbAuNB26XMU7HHp6cDkKBiYx3jN993WhWhZ6kfi+qMGLgO0G8fQGJpRJia
	 Rpu5solDUtB9CV0evm1gwu3/GX6cqyKIjJLF2YlSZ1CIvL2LYruBuBV/6ZzR29YVmN
	 +UmK6BCu/NQKuvEQmqLRV3a3ZVy4l6WAo9/EUUwrLIfYVgY5x/TaIglHYErxlJS+l8
	 4Ec1tWvIAlyKoFjj01NnecWNOa/mexcdaTbvHwmLzL86VJeL087WfJaJMARbT1XVU7
	 jhVz9zWSmDrhQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59dea72099eso578175e87.0
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 02:27:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8/GY5uA00s8pct8cvLjXjoIjPW10rXLwIr5Pwkka3BJI81IA8wUMwcezwvauJ/WfV69z2o5J7Y3d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLZe8avpnHLBcBL+W2+DNwhGla4GnHu3HqJ3RGz2uQerauz+W
	u3W1lLfz2ZG2M0NAe8c/apTnvdwIx8PWzSU2M1nUI27K1pYgpY25JBwVpY8rURQfm5Xtr7AfDqG
	f79sxVU0tipNOTnP9dqVjogVq3xelG+M=
X-Received: by 2002:a05:6512:3ba7:b0:5a4:d34:5b38 with SMTP id
 2adb3069b0e04-5a887ada944mr2206033e87.2.1778146051005; Thu, 07 May 2026
 02:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325143555.451852-1-herve.codina@bootlin.com>
 <20260325143555.451852-21-herve.codina@bootlin.com> <CAD++jLkFu+Z22QBFiaa9S+Epeh=RJZOYX8BOLVDFw4bhEoYF1Q@mail.gmail.com>
 <20260507092326.2f8e3b47@bootlin.com>
In-Reply-To: <20260507092326.2f8e3b47@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 7 May 2026 11:27:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLmsaddK4MLYhfK+1OkK263QqJfMZ3HF=L0Y7QdDsgX4XQ@mail.gmail.com>
X-Gm-Features: AVHnY4J4kpHKlWyF60L1gEgZ_kRiVmUaWPxnRdg2mF7S7on9qK93oGWvqiVfuCU
Message-ID: <CAD++jLmsaddK4MLYhfK+1OkK263QqJfMZ3HF=L0Y7QdDsgX4XQ@mail.gmail.com>
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

On Thu, May 7, 2026 at 9:23=E2=80=AFAM Herve Codina <herve.codina@bootlin.c=
om> wrote:

> > Recommended practice is:
> >
> > ethernet-switch@...
(...)
> > Recommended practice is:
> > ethernet-port@...
>
> Yes, it should be but the DT binding [0] says "switch" and "port".
(...)
> Those node names have to follow the DT binding even if this binding doesn=
't
> follow recommended practice.

Aha this binding is not referencing the standard ethernet-switch.yaml,
that's why I got confused.

OK let's just fix it then, I sent a patch.

Yours,
Linus Walleij
