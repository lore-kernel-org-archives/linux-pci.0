Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1B3C1D57;
	Mon, 31 Aug 2026 08:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165789; cv=none; b=Vv4DZz/1JpvcafueSy982kp47ZwmF6rl4gF6aCZZM819D1AQPSZ2vEhofUbcu2DLRpbCABEv539Vncpn7gH7bQHHteAT6SYOknS5t9rxol+zlIH4MJEtkfTbPbc5rwnwLLZK6jTcuJKiFSyXlWYkoQgLQiI1MZY6UikZxqncffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165789; c=relaxed/simple;
	bh=63EF8E7OSIzNRXdm8DlnEr/qVEbeWNvc8td5k+e+XgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+hZnWVt2SPacxtO5precUXxfBLfW5W73rgR08xODB/ry2jyLFWFufw4tQ5HH+tWO+N9yVu31G8VvgHzS09IqIr8rDVrNhM6EVnjkyVNDYRHYD04ciYTxJIM4jDU2WlpwAaMxxLXFVwkrYnBT+SpEOkjTmuIvg7mZt3xF5f0dJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+G+2623; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+G+2623"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5781F000E9;
	Mon, 31 Aug 2026 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788165788;
	bh=1w90RamCq8kQA6nW338QTgFUlpWXufn6MR62nUVpPe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z+G+2623x10QPEB0jnES28VWBD5um4aMqQGeSMNchFO09smrqtLvWeFo61Np/x/aO
	 RBtXA4rdRm+Frn9cyAe/fnUETUixVAlYA5Lqo7q1vFOjEc/stF0Zw4X8yhgsmnZMJm
	 InNnRV1iYB68CXueGcSzfw9fK/fdrkj1xtXIuNQfP1tXFv4PvPdeDG5MnskUZZoTKN
	 zFloaNL0meq9/UHSNDoHNjOA2f7o5EZP0ObS5u0MzFPUZxdZ+GPTaJzt9YgGEH4wAT
	 Rz3Zi0o+CAGL0VLi1g8ATW9QFNTIFmdQoouTzxbis1AbthCBIqGmRsKvG/43DQJOqC
	 lxg6d0WfTw2yw==
Date: Mon, 31 Aug 2026 10:43:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Message-ID: <20260831-bizarre-invincible-badger-e4a7cc@quoll>
References: <20260828-nord-v2-0-18bf59d19d6f@oss.qualcomm.com>
 <20260828-nord-v2-1-18bf59d19d6f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260828-nord-v2-1-18bf59d19d6f@oss.qualcomm.com>

On Fri, Aug 28, 2026 at 02:13:35PM +0530, Krishna Chaitanya Chundru wrote:
> diff --git a/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
> new file mode 100644
> index 000000000000..37198f82c611
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
> @@ -0,0 +1,276 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Nord QMP Bifurcated PCIe PHY
> +
> +maintainers:
> +  - Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> +
> +description: |
> +  The Qualcomm Nord PCIe PHY is a Gen5-capable QMP PCIe PHY composed
> +  of four PHY ports (A/B/C/D). The ports can be combined to support
> +  multiple lane topologies, including x16, x8+x8, x8+x4+x4 and
> +  x8+x4+x2+x2 configurations.
> +
> +  The selected topology is determined by the PCIe link configuration mode
> +  programmed in TCSR registers. Depending on the selected mode, PHY ports
> +  may operate independently or be grouped together to form wider PCIe links.
> +
> +  Each port provides dedicated register space, clocks, resets and power
> +  resources required for PHY operation.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,nord-qmp-gen5x16-pcie-phy
> +
> +  reg:
> +    minItems: 4

Drop minItems, not needed.

> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: port_a
> +      - const: port_b
> +      - const: port_c
> +      - const: port_d
> +
> +  clocks:
> +    minItems: 17

Similarly, you can look at other examples.

> +    maxItems: 17
> +
> +  clock-names:
> +    items:
> +      - const: aux_a
> +      - const: cfg_ahb_a
> +      - const: rchng_a
> +      - const: pipe_a
> +      - const: aux_b
> +      - const: cfg_ahb_b
> +      - const: rchng_b
> +      - const: pipe_b
> +      - const: aux_c
> +      - const: cfg_ahb_c
> +      - const: rchng_c
> +      - const: pipe_c
> +      - const: aux_d
> +      - const: cfg_ahb_d
> +      - const: rchng_d
> +      - const: pipe_d
> +      - const: ref

To match other variants, ref should be the third clock.

> +
> +  power-domains:
> +    minItems: 4

Dop

> +    maxItems: 4
> +
> +  power-domain-names:
> +    items:
> +      - const: port_a
> +      - const: port_b
> +      - const: port_c
> +      - const: port_d
> +
> +  resets:
> +    minItems: 8

Drop

> +    maxItems: 8

Best regards,
Krzysztof

