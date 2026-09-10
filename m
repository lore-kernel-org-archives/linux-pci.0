Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244FE3C09E4;
	Thu, 10 Sep 2026 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024467; cv=none; b=ELpW94EIfnJ2UnnYPYNjiNxTRlmZoprwKK6NKyzTpC1/bXAngeyiZDk5IqnGDp1vXML3ocSAGnfZfwBWnF3QFikN5SXBKHM4eVUGep/ethxX7DdLVt1Y3U4CnX/vv8ImvvkZGNJ9F+Fixq0LcsP0ecMllwFrxurOJMlicfSuTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024467; c=relaxed/simple;
	bh=zBaiINS3BpG9Z2TlGP5+0hs5EnnIhZh+wdCdjZscm7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDKa27VqqucvBy9Pou0xYDeW5iy/S1vM3balkwdJGdBJ/q8+rrVJx+RvWd4EZReb/mXzzouwnZTs4GYbI9S8oYUOyqaJv6sLiw1MxskrCfO4pw4cHZwMdwvnzrKBOAIlxdfIo8Z8cgoZt1K00rFlQhcmoWee16wgdeuR4Kr3oFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2Nqjg8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2Nqjg8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A611F000FF;
	Thu, 10 Sep 2026 07:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024465;
	bh=Ck/QTBMs4OTZZTAxuuECwSs8jcuuVPPv3EwioUvA6Hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f2Nqjg8EFhvOvP+OPRX4174MoSCvgLl7sqPNEE3bovBBRaY3BejrUMVYJxLp3bSuY
	 ybHlpioOPfFQHkGxBD/NYVEj3l5ak9R0rBXV/m1ZmjcwVlyqb+TvHPIRvHXpDSx6oB
	 5N20OJ9IakgK+ig1quIqk3yMzXTYRx0X8ePp1cFWFCwWrpP5VbgPHerkNEaZ9mRoJI
	 N6WOLNjwufbj4Gqg+LwwrzcZlWnWd1rPcBZRkf36EUlLoKOHFZe3DVMI7j5qLZka5S
	 VL8QOBZQpCCgabkZAv4YN5l5Jt18V8cADwrTSiw0VS5rtNBlKMoUj+kXy4kRMm157/
	 fjwo0AuFiX8cg==
Date: Thu, 10 Sep 2026 09:14:14 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, shengchao.guo@oss.qualcomm.com
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Message-ID: <eazcoy6bftw4gnyxpswmcrrryjmnzxrdhdz5umpkeggtfpdyrx@or7l6tac6srh>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-1-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260909-nord-v3-1-b0a82721c547@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 05:18:16PM +0530, Krishna Chaitanya Chundru wrote:
> Document the PCIe PHY found on the Qualcomm Nord platform.
> 
> Nord has a Gen5-capable QMP PCIe PHY that can operate in multiple

Use data rate instead of 'Gen'.

> lane configurations using four PHY segments (A/B/C/D). The active
> topology is selected by firmware through a TCSR configuration
> register and may be configured as x16, x8+x8, x8+x4+x4, or
> x8+x4+x2+x2.
> 
> The binding describes the register regions, clocks, resets, power
> domains, regulators, PHY provider interface, clock provider interface,
> and the qcom,link-mode property used by the driver to discover the
> active lane configuration programmed by firmware.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  .../phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml        | 272 +++++++++++++++++++++
>  1 file changed, 272 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
> new file mode 100644
> index 000000000000..624ad7e7d13e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml
> @@ -0,0 +1,272 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,nord-qmp-gen5x16-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Nord QMP Quadfurcated PCIe multiple link-mode PHY
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
> +    maxItems: 17
> +
> +  clock-names:
> +    items:
> +      - const: aux_a
> +      - const: cfg_ahb_a
> +      - const: ref
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
> +
> +  power-domains:
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
> +    maxItems: 8
> +
> +  reset-names:
> +    items:
> +      - const: port_a
> +      - const: port_a_nocsr
> +      - const: port_b
> +      - const: port_b_nocsr
> +      - const: port_c
> +      - const: port_c_nocsr
> +      - const: port_d
> +      - const: port_d_nocsr
> +
> +  vdda-phy-a-supply: true
> +
> +  vdda-phy-b-supply: true
> +
> +  vdda-phy-c-supply: true
> +
> +  vdda-phy-d-supply: true
> +
> +  vdda-pll-a-supply: true
> +
> +  vdda-pll-b-supply: true
> +
> +  vdda-pll-c-supply: true
> +
> +  vdda-pll-d-supply: true
> +
> +  qcom,link-mode:
> +    description: |
> +      Reference to the TCSR syscon and the offset of the
> +      TCSR_PCIE_LINK_CONFIG_MODE register.
> +        0 (QMP_PCIE_NORD_MODE_X16)        — all ports ganged as x16
> +        1 (QMP_PCIE_NORD_MODE_X8_X8)      — x8 (port A) + x8 (port B+C+D)
> +        2 (QMP_PCIE_NORD_MODE_X8_X4_X4)   — x8 (A) + x4 (B) + x4 (C+D)
> +        3 (QMP_PCIE_NORD_MODE_X8_X4_X2_X2)— x8 (A) + x4 (B) + x2 (C) + x2 (D)
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: Phandle of the TCSR syscon
> +          - description: Offset of TCSR_PCIE_LINK_CONFIG_MODE register
> +
> +  "#clock-cells":
> +    const: 1
> +    description:
> +      Selects the pipe clock output by port index (0=A, 1=B, 2=C, 3=D).
> +      GCC pipe-clock mux parents reference this provider.
> +
> +  clock-output-names:
> +    items:
> +      - description: Name of the PHY A pipe clock output.
> +      - description: Name of the PHY B pipe clock output.
> +      - description: Name of the PHY C pipe clock output.
> +      - description: Name of the PHY D pipe clock output.
> +
> +  "#phy-cells":
> +    const: 1
> +    description: |
> +      Selects the PHY instance by index:
> +        0 — port A (up to Gen5 x8; anchor in x16 mode)
> +        1 — port B (up to Gen5 x4)
> +        2 — port C (up to Gen5 x2)
> +        3 — port D (up to Gen5 x2)
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - power-domains
> +  - power-domain-names
> +  - resets
> +  - reset-names
> +  - vdda-phy-a-supply
> +  - vdda-phy-b-supply
> +  - vdda-phy-c-supply
> +  - vdda-phy-d-supply
> +  - vdda-pll-a-supply
> +  - vdda-pll-b-supply
> +  - vdda-pll-c-supply
> +  - vdda-pll-d-supply
> +  - qcom,link-mode
> +  - "#clock-cells"
> +  - clock-output-names
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,nord-gcc.h>
> +    #include <dt-bindings/clock/qcom,nord-tcsrcc.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +

Drop 'soc' and address/size cells and use 32bit addresses for 'reg'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
