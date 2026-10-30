Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360672;
	b=c3lChteatUb+fYCoLZ6MvutcfB0Zaa3I2zHbnXPUUi5wkXqL1pjDVp9u7wGGtnKnrrRt
	 eCeZzPcRmAcYAHRjD0f0Kszo68sM2H2zeRfH4A1rIbxD9QqZSS4Wcukm/EuB2fO4SWZJ6
	 SAvsrlwX4GqH/r+qAx/EHDVG3o3PdB4yOLfk2NtwV6SMfR1HEUHpok4MW93a45iiJ6zgC
	 I2b/F7GEz7fOoG+SVpJ5l2GHoHVG2ZWmAGvBoGM4xCMf3JrJQacaaWVNTS8za9nKyH5XL
	 8ibEet+qL/GI+18VFJxQoQraoJfGnedfbwCcuq6Af7oCeyRHgYMYzY0n9tBDes7kliQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360672;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u22L97/jeI13IB20ysbQZcY423yThcHnEYQlKHEzxLc=;
	b=gS+kucei7Z6HMG27q7M5/Sl5rccD69VDEuloR30z8M2jdkfjA0STkSQkd1Eh43Otlxm2
	 Nvi55IkfWFQtrsqwEbqP3mZREBSluMhvSoAjAyX6qfn0HGvl0C+4nAZHLP9Yrz/00d779
	 QBPNxeaJeBJ5F2rwgsaP9jcesyp3+XyGb2eTFhknTMyWW7rtotv2/yF2AJL5f93kU8sW0
	 Dl9AQMzk1CFqSZgtiGcO85XJ0jnhB7a/DsvMkanlw4tIuQi3GgiV+ip2h8m/sCCPbtwnY
	 k6YAzGqPaSnX+vHUVbhdtTCGb8SZADCzxAGtPI8y/7c1zWkzXrkWkqffilswO36nRrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POEHrrX+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F8606A31A;
	Fri, 30 Oct 2026 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=POEHrrX+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4AD1F0093A;
	Fri, 30 Oct 2026 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793360671;
	bh=u22L97/jeI13IB20ysbQZcY423yThcHnEYQlKHEzxLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=POEHrrX+sPBo41n1mG2oZ7jZsPptJNOYuklpaJCho15lUx/hky0vAto0IGN9wUGU6
	 ND1CBDe5rZnFil1HZM1tjiLOFUAleLd3OoRXz2gYSIc3S0vbxzEcjwCfDh4zVMpSsf
	 EQlNPouP+PVpC+k2CwhIb/KtciGpEkUOTO8XdOVMGJFbCRhD4vWJqa17k4GdbY1Vlc
	 +22QWJSEiJS+ic6dfb3qVSAJmBMrYs3nndjOrrxn5UsvH0+zvXfwafKrObb+dlFg75
	 QjOl3vEY9Q5kPpMymCryWXA4Z8a6csZvMkbqWCkAqIOAa8OUIZNXAetDK6xKKo0Mfo
	 yZ+wl5iCt+jdg==
Date: Fri, 30 Oct 2026 12:44:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Eric Anholt <eric@anholt.net>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Peng Fan <peng.fan@nxp.com>, Aakarsh Jain <aakarsh.jain@samsung.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org, imx@lists.linux.dev, dmaengine@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
Message-ID: <20261030-musical-modest-butterfly-e7734f@quoll>
References: <20261028120216.2657397-1-robh@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>

On Wed, Oct 28, 2026 at 07:02:12AM -0500, Rob Herring (Arm) wrote:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
> 
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

I just git grepped kernel sources and weirdly no one made a typo in
"clocks" of forgetting the second letter. We became way too polite :).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

