Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199456;
	b=AsJORrYR80NG6IJBc2kwwrDb/OFCP1oDUnoDSBapA8BhIx1VWaG2KtvY92xvD7dFZqEk
	 6Oq0cvKJZu8XdB5yYkHz5jgQ6LMysFuC2hLFTLZIVxhlaHPfaznm75kZh+UMnci6k0SUb
	 KKYo35kc47rTJ0K0DN03V5k2dpbsVPRJg7P25d885bo9f59RzeY6HGErSrR94NVhPkd+G
	 C6dInNkOFYWilnInrNRW9fHdsJH7dG9rV6Ez57OkGb9CDfQcQenY0bT2QJCZ0BiybHm7/
	 PGdFZiKRBxE1HTzJPkoncYiO/StQAh0B0AxrFyv+IJvDhDDRLZ31i/jerVWQuztS71g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199456;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=mIGs1095/pi5A3phf200bT5vD03Lp1U81y8sX9m5/iA=;
	b=rZT34JuyaJWeuUzDeKfMImkxl/EJNVU0xULwyI5tSBFPyKg6rZ4YTCp2otgMMiW5f06l
	 o7aqvgW+5m/ha2BaLB/L7WLK+FnMkt/mP44txpzW1mPxbeiza4JhyP5SYXMTxuWPepVW/
	 whip29ddixH9e39JJd/eJhOEobiB46Uiq64eHlK7zaNk3Td2MvXa1DBg2j9GWSgnnGvu/
	 mxnBBypKaJ3d0evVPoQ4tfQuXSywn1TG2oZkI3tM1Cn+FPr1X2K8qPeP+SxKG3+SEy6Ht
	 JBUieSh6x/iOQR0WoPq2x+41IjYIyDy4bGaVJIVdgVfch310vxTCjY+BsQwmExTEj9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2HHLBXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211B8606A322
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 14:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2HHLBXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C496F1F01825
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793199455;
	bh=mIGs1095/pi5A3phf200bT5vD03Lp1U81y8sX9m5/iA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=W2HHLBXt6yBVAcplFhzpJ6jtmHOuCp53by4m98jBMIziA5t6rtB1YlnGlq/AWRlr1
	 FQCh8fULMVw/6c1o5lmtjYYX1FdF3w72Vhh92y18FIUEBg0iAf6b+hQSp3YxO7o3w2
	 NQLLEEEfBL2s7t9h24eEfYn4v1g4zC2nlqA6M7EuEQI6Z/6RdZsFX+guKD90fItizi
	 a5xwC9YeA2FjWj8rfFo0XC4Al+7AXrBxYs7rFrO7GZB83wfNqD7ZuWZjpWyVfYaV++
	 N/jtBDuxvPA74FBRxmYZeLCP5ayrbJBci8gmbYKVr5V6NwlSuhUqDS5ZcWnGUFJWgu
	 d4cwa2zYelD2A==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a98fc80925so12202531fa.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 07:57:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxCAhm43w18IMu0pYuFya/vqUQY9nodPYP07jZezdToh6x6xKmauoQOLjDVM7toAWjJe9gDek0Xsfk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6bKcYgVFmM/EZ1t5jOP3fiPegguTEXcCjOKAplVciR9Nxpq3x
	44pBzJ6iXE3orueZJcJDZVw9nrVusm1swgTZEAjKgLtJsB7pcQMuWLM1WCPEk2BhS+a3ZlpFJsU
	NyqqS8iKyqaED5d8a/UIpPm3exPwrr1MmEPCpefwhjA==
X-Received: by 2002:a05:651c:1543:b0:3a9:d756:bfdd with SMTP id
 38308e7fff4ca-3ac9cf1d2cdmr6179361fa.7.1793199454407; Wed, 28 Oct 2026
 07:57:34 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 07:57:32 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 07:57:32 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028120216.2657397-1-robh@kernel.org>
Date: Wed, 28 Oct 2026 07:57:32 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md2xhYPdUEQ2SeqiGq9uG1qcc9Hi77T4k3ta_wmd56BhQ@mail.gmail.com>
X-Gm-Features: AclHuK-L3iqt92WsRHLJE8OI5aNBBhyNCiN5RHrPr_WcVOO_RomVfpU-3_RxU7E
Message-ID: <CAMRc=Md2xhYPdUEQ2SeqiGq9uG1qcc9Hi77T4k3ta_wmd56BhQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	freedreno@lists.freedesktop.org, imx@lists.linux.dev, 
	dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Bjorn Andersson <andersson@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Eric Anholt <eric@anholt.net>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>, 
	Aakarsh Jain <aakarsh.jain@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 13:02:12 +0100, "Rob Herring (Arm)" <robh@kernel.org> said:
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
>  .../devicetree/bindings/clock/qcom,kpss-gcc.yaml     |  2 +-
>  .../bindings/display/brcm,bcm2711-hdmi.yaml          |  2 +-
>  .../bindings/display/msm/dp-controller.yaml          |  2 +-
>  .../devicetree/bindings/display/msm/hdmi.yaml        |  4 ++--
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml  |  2 +-
>  .../devicetree/bindings/gpio/loongson,ls-gpio.yaml   |  2 +-

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
