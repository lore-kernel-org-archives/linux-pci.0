Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18553E4C99;
	Wed, 26 Aug 2026 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741596; cv=none; b=KUFF0zpxhj6kiVIxuCowyexEsigRJgkrYOmi6Qq/Z2aFgoTNj3SHCtMbyzIGcyQjdB5NPOfNysctmmUApUO9gNGQBOl68iSS68aMbX3+zccCyOqvFRQe0Yq2eO66gQ7TOd1LhJePJZliB9a01ZIqOI8t7Jga/Y9WKXdxvyUU8X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741596; c=relaxed/simple;
	bh=/UacBLoGcMB9zLAU9jMbtSM3o5RdK2Bxf4dOMT0ihgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:To:From:
	 References:In-Reply-To; b=tg7444SCPZF0iT0yxdcoDaAdNBoTroz7RACEKpSbpanzRYJHAz48ZXsCctX16s2wLafdN5z+V9kbF/ANA4fkuYXVPAjfQRbgYzhHV3eZ7NfwYB0hsHSKeSDrgJQQs0je91BVHQFwYGOyd031itAmjeoAS988k1UjOc1Sug4hR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YwzOoaUv; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YwzOoaUv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 64CC71A1841;
	Wed, 26 Aug 2026 10:52:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28841604ED;
	Wed, 26 Aug 2026 10:52:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 23C1A11C7AC46;
	Wed, 26 Aug 2026 12:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787741569; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ey9RYH2RFNaz6azoD+KUbSwAq0kYLs0uc4QHAcA42gw=;
	b=YwzOoaUvCBxvOqya44IQRmcChvhXL8vgHGxbcCmbhbmECnpLcwRQMcP313YXEjBjIbGjtb
	I3Wid39NLAGygcDi2YmXtYo3AnvhAC8qiwoT3eV4cBJRzRjsj5XRyCYrw6G4qiA7F8Zjly
	vEXRD7XVgML/YjQ2Uyrc+ngfVs8rycv3oyvd6Hm0WMNZvz7S4w0rvpxlqOaEK5j0BYuwCJ
	L8Oeso8gBo83WUUPKcbxUYj/zwWIS4h0vUpJl6+JVbBurpBXA6XJKvKWQUQD1lfPaBrb6L
	0YOhDZdzMEyQk7IuWvSDDzCZv3a6OjEkFdKfO+U7ZZbKTgyueYwGfJ0tIk2zlA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Aug 2026 12:52:21 +0200
Message-Id: <DKYTHI4WWQ6V.2CAMI1VACSS7N@bootlin.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant white-space around values
 in <>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>, "Suzuki K
 Poulose" <suzuki.poulose@arm.com>, "Mike Leach" <mike.leach@arm.com>,
 "James Clark" <james.clark@linaro.org>, "Leo Yan" <leo.yan@arm.com>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Michal Simek"
 <michal.simek@amd.com>, "Andi Shyti" <andi.shyti@kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, "Mirela
 Rabulea" <mirela.rabulea@nxp.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Frank Li" <Frank.Li@nxp.com>, "Sascha Hauer"
 <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Lee Jones"
 <lee@kernel.org>, "Xiaowei Song" <songxiaowei@hisilicon.com>, "Binghui
 Wang" <wangbinghui@hisilicon.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Dvorkin Dmitry" <dvorkin@tibbo.com>, "Wells
 Lu" <wellslutw@gmail.com>, "Linus Walleij" <linusw@kernel.org>, "Chin-Ting
 Kuo" <chin-ting_kuo@aspeedtech.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Mark Brown" <broonie@kernel.org>, "Joel Stanley"
 <joel@jms.id.au>, "Andrew Jeffery" <andrew@codeconstruct.com.au>, "Ryan
 Chen" <ryan_chen@aspeedtech.com>, "Billy Tsai" <billy_tsai@aspeedtech.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@kernel.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Boris Brezillon" <bbrezillon@kernel.org>,
 <info@mocean-labs.com>, "Olof Johansson" <olof@lixom.net>, "Shree
 Ramamoorthy" <s-ramamoorthy@ti.com>, <coresight@lists.linaro.org>,
 <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-i2c@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-input@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-media@vger.kernel.org>, <mfd@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
 <linux-spi@vger.kernel.org>, <linux-pm@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Last-TLS-Session-Version: TLSv1.3

On Wed Aug 26, 2026 at 12:20 PM CEST, Krzysztof Kozlowski wrote:
> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
