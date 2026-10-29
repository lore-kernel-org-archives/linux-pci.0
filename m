Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254389;
	b=Tes/sfBGuImzrGcRTSeX4LG4ZuUcqZm91UM4Iu1r8vc8GQaFcfGsaRsiJsvjMkJs3VXq
	 ejUaASoxMs0NvbLVz3cY/TTtE0UlDSHIkmAwNvO/blIYLwudLdkMDxZToY6EU1uALehBs
	 SjzuclP/WvxVrbDbJcAUG2uXXwGeriHthTzE/LNGZ5jChWo4R7Ch0GwSmoqihsxCaXRko
	 yEEEbaAT4xDeq/v+pqyq4henciKcwPyepS58oP2bsSKFFtvD5uJcOTQtkDYniia8mwciv
	 +cytMTeG7vajxP5sf6XpSZ7jgXTYvJQfQHK4COkThC9Jqe9UKjxxfKOVsquq3EifBqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254389;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8HfICeltQZtZCQ5hD60I+Ms/gO7apKM3P6RJyOQSEUI=;
	b=ygpf8oSIetfgdHDl0NfHPaR6Yo2nxtU/ayi5CGecBeXHfOd/8UUHYzeBpyXRe8gpL7NV
	 oD3Af+M27S4KG1WZi3Ksgf5Wvptf3sVJo5COf8NYvF3xxAGJtcwd+kDaWSl58bszJK8RY
	 B1MNXrhG6jCrkqQAhBj0GyG1hd7YhH5m3Uo4L3XpP0wKLOeyoFYgCG7b41rUCBnMp55sm
	 WRssEs3XmoMUXuCF9ErOr+rPvbazyHDnL0yRfJRE2slgITnb2fc0jJd2O70n5Kkvka0y1
	 y6hxAGXmAYNczyOGDdovVMYW6O8Svx8qiVXBmH/6+5iJ0QjU1gwIKdWtjRrGdvKZcBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AY9fCZM8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0309606A31D;
	Thu, 29 Oct 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AY9fCZM8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFD61F01825;
	Thu, 29 Oct 2026 06:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793254387;
	bh=8HfICeltQZtZCQ5hD60I+Ms/gO7apKM3P6RJyOQSEUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AY9fCZM838jxvzO1LZjlGpXv0W8K3teqSZL7RijTgFK+vMuR9I/rLM2tTDsuEdu49
	 D2/wj4MDZjo91NakOEaX5qSF5O95U3YG8/G5UHWIxf80ZCUvpFSL90WwQh/5OnZhB+
	 IxV3Ir9hpPOUOgGFeO+ZNTpumWj+emmZLNf8wkK2peC6tx3JvxcCwhRjIp/8vl4fIF
	 5Te7rIsn3LXYjnylmmiG2eWT/I2O7NNXE/I6Z/jqqYBvXQ+flDBPRbsCb9u28Gwj8Z
	 Wm++8Vi3KmsJ2uSOrdepJb1M4tZjsQyVIQao8cR8k7StT66yaZCypWnGb4AtixMYe1
	 607LwJx2luOOA==
Date: Thu, 29 Oct 2026 07:12:52 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Martin Blumenstingl
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
Message-ID: <20261029071252.586c8cbc@foz.lan>
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
References: <20261028120216.2657397-1-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

For media:

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

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



Thanks,
Mauro
