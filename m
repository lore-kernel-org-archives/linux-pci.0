Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE03413250
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201486; cv=none; b=HnA74PGbF2C4t7MplSRJXnQd4BcB7mHG+EvWSAtmdJiZ6P0dQJzgZXnk5GxJy1JDhOasmGZhljUCeGwblG/6dkPffW7B5MVPFZfMUVWWG2b8moZQyyuiWvU5tH0b2aRPsK8K0y1SNS+C9KsNGBcuXDcsXDodDe1GAkayiSzbT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201486; c=relaxed/simple;
	bh=ShiqjwbVycNVDc/NOYYT7WllWbuKawKGkYhqIEShcUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGO1S5T2IdCDUqVQT/255nyLMOsEJuGGvSfqYZI5r93X8yjLzZyxyJLWrFTuP8WI/GYREJUT/Xf7jxhrAcjZzm0PHwwZ4P8g+2/Vz3AcW5O3kGv+VJA0UxaC23sxFvyS+LfYKol2Q7tji4CkZZFf6dL0D7XntTexLBYyh0JyPHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/J2WabN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/J2WabN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E407C116C6
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201486;
	bh=ShiqjwbVycNVDc/NOYYT7WllWbuKawKGkYhqIEShcUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C/J2WabNfx6aqKYcZk2YBDRGl+D4VcEwySLhOnrMvIsuJ/Bg4x9OQfmpvMOMIUUd2
	 7wFVKgkauqPv9hbmi0jWg0b/GZDj8QjFkvfzppK7qRqE1Kz3VVLbCtWt6eFdm5EShO
	 0LB0ftXVSAZIrU7/ytrsB40OquUiOpuHUXOLlNBXmgxaaIJdYDo5IRczTmBJyC9rmj
	 aUpoLLyhi3mzaJE6Y/IRK0S1YINU/4k3rKx1vcb4vuKyZu6Vf1RSrLZDC9gKEz/PJq
	 GbDwA7Kwh9YcwKVyXWaYzGesaQ6YVxthWBVjWmQa1ILxXUhOTETuLeM5sqoikvK/qi
	 vpytOqH0T6Smg==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-79885f4a900so5987207b3.2
        for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 06:11:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0Ug7exF/PeeYwk4ceqbW9mc/8Vx1E7bEqZwK9RluhCbikI76AMeX1+PIPiyVyyhtgVdc6CyNx8/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jR6mqaaIgHH98j6fkIgwedJWBzvVrVPnz+KPycyFh2b36PD1
	4jzdgWO6jvUnfUQa94Rdl1T8ajjivwEOQernp7LdYrCkLLbid5n2NhAKsZ1ucs0FVQHjzdkYbQm
	5p3kfedlcB6k78GCsvwPRmykDLSnphDY=
X-Received: by 2002:a05:690c:60c4:b0:798:6666:26bd with SMTP id
 00721157ae682-7988557f476mr30565677b3.37.1772201484696; Fri, 27 Feb 2026
 06:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227135428.783983-1-herve.codina@bootlin.com> <20260227135428.783983-10-herve.codina@bootlin.com>
In-Reply-To: <20260227135428.783983-10-herve.codina@bootlin.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 27 Feb 2026 15:11:13 +0100
X-Gmail-Original-Message-ID: <CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
X-Gm-Features: AaiRm51ZxE6GtTyodhFmvZhWZO__2ijK76G9lNPmnmTqvkqKfSl89e994OIKOE4
Message-ID: <CAD++jLmbg1FVGxv_7Lq4rOEbLAGh72YPTppOBcdpcsdLDo8B_A@mail.gmail.com>
Subject: Re: [PATCH v5 09/28] pinctrl: cs42l43: Use fw_devlink_set_device()
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

On Fri, Feb 27, 2026 at 2:57=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:

> The code set directly fwnode->dev field.
>
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Linus Walleij <linusw@kernel.org>

Tell me if I should apply this directly to the pinctrl tree, right
now I'm under the impression that all patches need to go in
together?

Yours,
Linus Walleij
