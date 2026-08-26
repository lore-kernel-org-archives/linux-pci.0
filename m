Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCD3DA5A7;
	Wed, 26 Aug 2026 10:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741322; cv=none; b=p+mnZ/NI3Oj+QPESbuQKeLLQkNwpllvY0zp0I6M3ICmGTiX60VEjCT3b/MmcNT5FzTC1uq3UZtt7zLrzfL16/f1ePWVYya0Ynb///W0KGxlCsAblx8C7AI8PaQ2fmKmAR4kvIMYRRPlkwjYEjKrMiBVMOeADE3oHB7K7TL0QsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741322; c=relaxed/simple;
	bh=dp2d4GT6xfse/AjmR5CCihdRxLdkONQ6FKx99trQjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot28dRxO0gSwknRmaMHEZyxq1OCo/8pdE2YOiXcRG4EKyVwKXvP00o1peb2sowQyaoiSzz4MtcRPx/rKzAfm9FcqQ/jFhu/GT6p5bLlZf6zhvc7m8rjr0ZwXT9OMHbWKqpEv59LKdsOvJgG3XFZdx0QhkPU4bwtmKgE4laQWUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbC9eXOZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbC9eXOZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DB71F000E9;
	Wed, 26 Aug 2026 10:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787741295;
	bh=2PBENmYs6fiknMrazp/50bVkNc1sBGJoebvvjy0eKx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CbC9eXOZ2dL6OuBJ1bWchF5seeE8ifsrT8Yw/a4Qo3Y5Rs2etS57xSuEdgQns99ei
	 QVPl74HmDPUGNZBf7+WL1hBpXywRwssYdENv9y3V+JkVXQ3w8kTmaN2R7sWY+TBwJt
	 rpd+iGj4akwD2mqMk+XymnQmIxApZFfAWUutiB9ezEi8bwZpp00uztIbITa3g+1Fx7
	 es9x6uOFAGNXG4NWRTnEbcER/UYbhW9caRHYj7iJhyEeIyDfIV9wtbDJ2QbkvyWlx0
	 dpH+wik6piKWJNDJwpfLl9XKfDWmEHKEB04XxOxRSgTnJpeatCCyZiHCa7kSHWZp/A
	 Z2tQRT+7IaTNA==
Date: Wed, 26 Aug 2026 11:47:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Michal Simek <michal.simek@amd.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mirela Rabulea <mirela.rabulea@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Boris Brezillon <bbrezillon@kernel.org>, info@mocean-labs.com,
	Olof Johansson <olof@lixom.net>,
	Shree Ramamoorthy <s-ramamoorthy@ti.com>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	imx@lists.linux.dev, linux-media@vger.kernel.org,
	mfd@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-spi@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop redundant white-space around values in
 <>
Message-ID: <92dfaa64-18c6-4ac0-8b17-f0a202dcf737@sirena.org.uk>
References: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hP4PYOBKxN+fM2z6"
Content-Disposition: inline
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Cookie: Obey all traffic laws.


--hP4PYOBKxN+fM2z6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2026 at 12:20:45PM +0200, Krzysztof Kozlowski wrote:
> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.

Acked-by: Mark Brown <broonie@kernel.org>

--hP4PYOBKxN+fM2z6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqOxF4ACgkQJNaLcl1U
h9Bdwwf+L6MG9Bumzzk/fUvAIBXVI/dikPCxxDKcuqi5O/yVCeQWiMHK4Kp/ca3l
imB6hoNyz9NRQmnZ45EXJhpRnz1LbTO357uK3N4zx/bi7V88563ixNa8HQIJZiCi
yBPtE5ToKgi349/KXca5/vSKWGfyCnD8DRL3icILcg9GwxUC14PEo2WFYcGR4/JP
ZmD11XU7MLSAhan3AUqcBiK9d+baT2FfEwmxCk4tm3wswPG29CNeUWP8OU145Yuq
YcOeBmOpgMeDFyqxfCLMwJTToaxX8FcAn5HDjE+mJ+/pTLge8S8d85cmy7dJrUoU
IMs1ngofm5Q82f4e9E8pPeXEh4y1iQ==
=ZN0I
-----END PGP SIGNATURE-----

--hP4PYOBKxN+fM2z6--
