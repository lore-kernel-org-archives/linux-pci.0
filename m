Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477934D385;
	Thu, 27 Aug 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835198; cv=none; b=ZmRGS66Q/Jn0Bp0IhUOcGXFzbXyp4JgxeN/JoBctyHamzGad7X5hzjcA5XUH3zjjx84PaWg6Dn9JoJ2RQD/EY88DMVAf7KT3aI6WQ9QfrhUkUZdSBNCvCm6k/nJWxhXuQ9hjErgr2EXgIfjb5fhtZM4u4PHUrjeSLpvSTTBpmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835198; c=relaxed/simple;
	bh=hB8J5rKgHQgIo8h/hxjtzyLJpP/TdCQHWkST/p7ZR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv4xmEiTYrTgU/gXfH+2ut322wUyrib5th3dklbwaAO2iGyBkjZVBTTJrrdYEWMTzD4aZLmsucM56sC9OTEUQ1xKs1lY4SQat9DHsWyIvm9dwRzBLJFfbpuYbFdIlE58REGCFohNvwwaPRsJJf1EWYOgQm1QSYE6bO1VvC1Z7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpxQ/he4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpxQ/he4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B61F000E9;
	Thu, 27 Aug 2026 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787835181;
	bh=Jv30IeE2s+n2A5GRghn5mbNA+ntwEskVEvnsJS/gqNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HpxQ/he4c1l/67bjg6zHCWSh7AxGIRhKnrX19FKhID1R0BcbkibPRl+2xW0tbC0ak
	 hJFvx1qCJqhl53iZGTG/JR7u301HQSljASB0swdFEdVZiKibGOnJN2iCVJHXEYbnTf
	 GTCBUKdpsBjmlMtHpvbarSgA6dZyeIoEjTP+/Oeo1lq7Q8tVwMRTyOl2wZZNfvhYA1
	 9RM2gDKmt7oe1am3axpJpa781gtZmH8OBSvfT08Xeg0hRghVLZPfZNQDoRaVSKZks6
	 UT3rnJOuGjx34CvvC3Nvte8iWDqvxO3jI9R1oIEGE2wOgx6fk6r/6aGuzyfLhzB/cZ
	 qVz1y3R5ubGhg==
Date: Thu, 27 Aug 2026 13:52:45 +0100
From: Lee Jones <lee@kernel.org>
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
	Fabio Estevam <festevam@gmail.com>,
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
	Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
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
Message-ID: <20260827125245.GI770273@google.com>
References: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>

On Wed, 26 Aug 2026, Krzysztof Kozlowski wrote:

> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Rob, Can you take it directly?
> ---
>  .../bindings/arm/arm,coresight-cti.yaml       |  2 +-
>  .../bindings/display/bridge/sil,sii9022.yaml  |  2 +-
>  .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml     |  4 ++--
>  .../bindings/iio/light/upisemi,us5182.yaml    |  2 +-
>  .../bindings/input/matrix-keymap.yaml         |  3 +--
>  .../devicetree/bindings/input/ti,tca8418.yaml | 21 +++++++++----------
>  .../bindings/media/nxp,imx8-jpeg.yaml         |  4 ++--
>  .../devicetree/bindings/mfd/ti,tps65910.yaml  |  2 +-

Acked-by: Lee Jones <lee@kernel.org>

>  .../bindings/pci/hisilicon,kirin-pcie.yaml    |  4 ++--
>  .../pinctrl/sunplus,sp7021-pinctrl.yaml       |  2 +-
>  .../bindings/spi/aspeed,ast2600-fmc.yaml      |  6 +++---
>  .../bindings/thermal/thermal-idle.yaml        |  2 +-
>  12 files changed, 26 insertions(+), 28 deletions(-)

-- 
Lee Jones
