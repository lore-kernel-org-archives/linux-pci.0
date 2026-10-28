Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231232;
	b=2PYZCg3mThLzezw1w8n3cKmfiXois7312sqxBrg6f75mQfDuzrQrbW/WZs7xuOcOUmc3
	 rbvAyYsmgAxwb1liL0ds61kEzS0psOySjwAOK7dXCejsRXeZKbI9hw8qfkCSpGbJGl56c
	 ZzliyZUGe4HuKOTQJu0idfUKx4qe7qVKIb9xhmoceGfN2sArbnVHqK/zEO/p+T21gKS1B
	 SSOy32jI7FqP7nnvp7hFQC42b0O85ETPRx+PmLrdYsy8Rppmd4YAimx363Lpmsjqq2oTI
	 gChxwBW+3ztxI7apDI31m2qn6BEoF4vOhCmCo2980ad7MfUvrudDgMzVPSpVvbIvFQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231232;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=neOivWsfnHbQR3N6AKh/3PoW3tIDMGi3k5qezfAAwY4=;
	b=vbXkEV5Z5oBXMuPtH9KWc+F9vfTYPbVbrN5cEmremTKv0nHnm/7UM5fOrG9FrE/7JFUE
	 ad/hpOcLIMtiGa8hw6thvz2TRO/TXIiLOQfSwYLm9b9ndsVh15iGYoACBqO1XTrnPy3g6
	 QQ4S6jMU/Jj30PM5Wy4gVa5Q8w77jxf65ZhZ5aszGbjwECpywmB3psanHfgmuYMYLiy8v
	 Uj51XEXBrGg6jmoheaGi51m/TnS2gMoZaCVLVsS7d2QJRAMyo2uISZcXupc8b4CenzMgk
	 pW4XOb1uaxmdhfCTk+gJ42vG2R7sD1EKqH5oXwE9YZCBZdRyrmS7wx9X5XvRmlInZIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f/4cLrJ4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DF606A31A;
	Wed, 28 Oct 2026 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/4cLrJ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF611F01825;
	Wed, 28 Oct 2026 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231232;
	bh=neOivWsfnHbQR3N6AKh/3PoW3tIDMGi3k5qezfAAwY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f/4cLrJ4TGztgvmr14VBy6t7mBV8AM+uDlLfYVyShzm7APQvQBIiI0EDLgRGe0v7z
	 LrPP1CYrALPm5Q04g1ErXIwYEqxpncy7n/vcasP5VS7fxapXxWQMRvQ3eLtXYsxC4u
	 pO80RH6CgwyVic6xTA3E8YyB/WqO22L05DI08uL25eIqchvragaWR3rowAwilUDAAt
	 Xh6oVb4uczfsq1lW3toZ9+v63X4qnWgC+a2EdGz7QxrKclbDs6hRlAucgG9mlmv1zz
	 0pRXR0bqvqejkSM04r2n2wZ9K5nHoWUM+gUptsMAuOcN5EfgGaQV+XNpzRAcoIe2zH
	 rDwATDPNl5e/Q==
Date: Wed, 28 Oct 2026 23:46:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
 <jbrunet+clk@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Frank Li <Frank.Li@nxp.com>, Vinod Koul
 <vkoul@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Tiffany Lin
 <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5?=
 =?UTF-8?B?xYRza2k=?= <kwilczynski@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Eric Anholt <eric@anholt.net>, Kuogee Hsieh
 <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>, Aakarsh Jain
 <aakarsh.jain@samsung.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org,
 imx@lists.linux.dev, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
Message-ID: <20261028234652.0d075035@jic23-hlaptop>
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
References: <20261028120216.2657397-1-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Oct 2026 07:02:12 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

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
>  .../bindings/iio/adc/amlogic,meson-saradc.yaml       |  2 +-

For IIO

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

>  .../bindings/media/mediatek,vcodec-encoder.yaml      | 12 ++++--------
>  .../devicetree/bindings/media/samsung,s5p-mfc.yaml   |  2 +-
>  .../devicetree/bindings/pci/mediatek-pcie.yaml       | 12 ++++++------
>  10 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> index 88b7672123a0..ed347096df46 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> @@ -62,7 +62,7 @@ then:
>      - '#clock-cells'
>  else:
>    properties:
> -    clock: false
> +    clocks: false
>      clock-names: false
>      '#clock-cells': false
>  
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> index c1cefd547391..fd4d598f6ff8 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> @@ -145,7 +145,7 @@ allOf:
>              - description: CEC stuck at low interrupt
>              - description: Hotplug connected interrupt
>              - description: Hotplug removed interrupt
> -        interrupts-names:
> +        interrupt-names:
>            items:
>              - const: cec-tx
>              - const: cec-rx
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb77..f72d1b354007 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -304,7 +304,7 @@ allOf:
>          clocks:
>            minItems: 6
>            maxItems: 6
> -        clocks-names:
> +        clock-names:
>            minItems: 6
>            maxItems: 6
>  
> diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> index dfec6c3480f3..02d27ccad024 100644
> --- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> @@ -113,7 +113,7 @@ allOf:
>              - const: core
>              - const: master_iface
>              - const: slave_iface
> -        core-vcc-supplies: false
> +        core-vcc-supply: false
>  
>    - if:
>        properties:
> @@ -136,7 +136,7 @@ allOf:
>              - const: core
>              - const: alt_iface
>              - const: extp
> -        hdmi-mux-supplies: false
> +        hdmi-mux-supply: false
>  
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index f609038e35ae..0260d177c7d0 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -172,7 +172,7 @@ allOf:
>              const: fsl,imx7ulp-edma
>      then:
>        properties:
> -        clock:
> +        clocks:
>            minItems: 2
>            maxItems: 2
>          clock-names:
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> index 69852444df23..07c8b233c6bd 100644
> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -80,7 +80,7 @@ allOf:
>          - resets
>      else:
>        properties:
> -        "#interrupts-cells": false
> +        "#interrupt-cells": false
>          interrupt-controller: false
>          resets: false
>  
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> index 70ab4e140e71..535213ba0c5e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -92,7 +92,7 @@ allOf:
>      else:
>        properties:
>          nvmem-cells: false
> -        mvmem-cel-names: false
> +        nvmem-cell-names: false
>          clocks:
>            minItems: 4
>          clock-names:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index 4505e66876a2..52f471a070d5 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -110,19 +110,15 @@ allOf:
>  
>      then:
>        properties:
> -        clock:
> -          items:
> -            minItems: 1
> -            maxItems: 1
> +        clocks:
> +          maxItems: 1
>          clock-names:
>            items:
>              - const: venc_lt_sel
>      else:
>        properties:
> -        clock:
> -          items:
> -            minItems: 1
> -            maxItems: 1
> +        clocks:
> +          maxItems: 1
>          clock-names:
>            items:
>              - const: venc_sel
> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> index b46cc780703c..4488d5ca9b9c 100644
> --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -174,7 +174,7 @@ allOf:
>              - const: mfc
>          iommus:
>            maxItems: 2
> -        iommus-names: false
> +        iommu-names: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> index c009a7a52bc6..7c40361f95ec 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> @@ -127,7 +127,7 @@ allOf:
>          phy-names:
>            const: pcie-phy1
>  
> -        power-domain: false
> +        power-domains: false
>  
>        required:
>          - resets
> @@ -150,7 +150,7 @@ allOf:
>            minItems: 2
>            maxItems: 2
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -171,7 +171,7 @@ allOf:
>          clocks:
>            minItems: 6
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -193,7 +193,7 @@ allOf:
>          clocks:
>            minItems: 6
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -215,7 +215,7 @@ allOf:
>          clock-names:
>            maxItems: 1
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -223,7 +223,7 @@ allOf:
>  
>          phy-names: false
>  
> -        power-domain: false
> +        power-domains: false
>  
>          mediatek,pbus-csr: false
>  

