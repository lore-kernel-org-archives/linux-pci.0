Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008634AB1D;
	Tue, 30 Jun 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831308; cv=none; b=UKNHSkhfvVdW4QcqlEq3zOYZh9N38uF8W6rm19MvFRx37BXCFdzPWz4ApYnKvwMNuTuG2aTLR4rQBVEKjVloz0kGOwYeBessBgWefGEvVCTjGqBlb9ShHfmKZGsLQJShVPSA1nE4YF/JDuCdizrVw2JSl3MM22RqmyrsvJVKg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831308; c=relaxed/simple;
	bh=awFFWtgVL1TAG14f5CYmC0LELd9S2Tl5LSXPyhVTyk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyIJpDoQKKpjjqj09D4H79EaCquVfqrWkWNziM3T6imsZqqv7nUm3ryZeXvEoZcEdbEg9ZYcdXytzXzclGU8pbcZdPcvlUKhZpx7X/yyGshMpT5sPo42YuC9/LksxWRw/4D3ToURIldYXYHxTJU+yMEFihDIhr5ENy5lhdkfWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKfVzFZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKfVzFZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DB41F00A3E;
	Tue, 30 Jun 2026 14:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831307;
	bh=FrOy3rj9ErYPsJBF3jjZifi/JmWhngje4d+c3PkjfiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oKfVzFZ6b/XSsHTT24iTlGuILVTem1fiPHNzbqfkkfEvgofuYcLnT0ZBgbClmJSyU
	 1Lje1eKxqCR4srhyHKb8b43TaGt/wOdQZXmv9MCfqI/QaKY0Sm3heWK7BVrIeOZDzf
	 P2zz/ZVNqH0yjYGkLQQLLiGvp654MVGM2V4RrpCvRDYfrZqeDqSFpN1iBK/jQBipio
	 GzOMvwzGE77O+3r4MhfmAyJvycRC+cbAkpZPfltFgLx+L3FcsZRkJbecwAdR5VffFu
	 7XRMQ3++8oaFXaRC4M35PtNbbbb3CmOuL7Rrw8sLRlduulgMHMNmiiOglxx3k9yzNS
	 XQhqm13RH8Dug==
Date: Tue, 30 Jun 2026 16:54:52 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jianjun Wang <jianjun.wang@mediatek.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: mediatek-gen3: Split Airoha
 schema and document 2-lanes
Message-ID: <alqqddz52csz4pcbiilfca7a47x6jsazf2um4ydwiqq6ejrgz4@4qhkbj4k5i5s>
References: <20260627121450.3529133-1-ansuelsmth@gmail.com>
 <20260627121450.3529133-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260627121450.3529133-4-ansuelsmth@gmail.com>

On Sat, Jun 27, 2026 at 02:14:44PM +0200, Christian Marangi wrote:
> To permit proper documentation of required property to support PCIe
> configured for 2-lanes mode, split the Airoha schema part from the
> mediatek-gen3 schema to a dedicated schema.
> 
> A PCIe configured for 2-lanes mode require an additional reg for the
> secondary PCIe to be configured and the airoha,scu phandle to correctly
> configure the PCIe MUX.
> 
> Rework the mediatek-gen3 schema to drop any redundant constraint previsouly
> introduced for Airoha PCIe properties.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/airoha,en7581-pcie.yaml      | 251 ++++++++++++++++++
>  .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
>  2 files changed, 256 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml b/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
> new file mode 100644
> index 000000000000..c690ba7f207c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
> @@ -0,0 +1,251 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/airoha,en7581-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Gen3 PCIe controller on Airoha SoCs
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: |+
> +  PCIe Gen3 MAC controller for Airoha SoCs, it supports Gen3 speed
> +  and compatible with Gen2, Gen1 speed.
> +
> +  This PCIe controller supports up to 256 MSI vectors, the MSI hardware
> +  block diagram is as follows:
> +
> +                    +-----+
> +                    | GIC |
> +                    +-----+
> +                       ^
> +                       |
> +                   port->irq
> +                       |
> +               +-+-+-+-+-+-+-+-+
> +               |0|1|2|3|4|5|6|7| (PCIe intc)
> +               +-+-+-+-+-+-+-+-+
> +                ^ ^           ^
> +                | |    ...    |
> +        +-------+ +------+    +-----------+
> +        |                |                |
> +  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
> +  |0|1|...|30|31|  |0|1|...|30|31|  |0|1|...|30|31| (MSI sets)
> +  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
> +   ^ ^      ^  ^    ^ ^      ^  ^    ^ ^      ^  ^
> +   | |      |  |    | |      |  |    | |      |  |  (MSI vectors)
> +   | |      |  |    | |      |  |    | |      |  |
> +
> +    (MSI SET0)       (MSI SET1)  ...   (MSI SET7)
> +
> +  With 256 MSI vectors supported, the MSI vectors are composed of 8 sets,
> +  each set has its own address for MSI message, and supports 32 MSI vectors
> +  to generate interrupt.
> +
> +properties:
> +  compatible:
> +    const: airoha,en7581-pcie
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ranges:
> +    minItems: 1
> +    maxItems: 8

8 entries? Really?

> +
> +  iommu-map:
> +    maxItems: 1
> +
> +  iommu-map-mask:
> +    const: 0

Why these iommu properties are not present in the example?

> +
> +  resets:
> +    minItems: 1
> +    maxItems: 4
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 4
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: sys-ck

sys-clk?

> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: pcie-phy

If there is going to be only one PHY, then I think you can drop the phy-names
property.

> +
> +  num-lanes:
> +    enum: [1, 2]
> +
> +  mediatek,pbus-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to pbus-csr syscon
> +          - description: offset of pbus-csr base address register
> +          - description: offset of pbus-csr base address mask register
> +    description:
> +      Phandle with two arguments to the syscon node used to detect if
> +      a given address is accessible on PCIe controller.
> +
> +  airoha,scu:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to airoha SCU syscon
> +    description:
> +      Phandle to SCU syscon to configure PCIe MUX for 2 lines support.
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupt-controller:
> +    description: Interrupt controller node for handling legacy PCI interrupts.

s/legacy/INTx

> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 0
> +      '#interrupt-cells':
> +        const: 1
> +      interrupt-controller: true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        num-lanes:
> +          const: 2
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +
> +        reg-names:
> +          items:
> +            - const: pcie-mac
> +            - const: sec-pcie-mac
> +
> +        resets:
> +          minItems: 4
> +
> +        reset-names:
> +          items:
> +            - const: phy-lane0
> +            - const: phy-lane1
> +            - const: perstout
> +            - const: sec-perstout
> +
> +      required:
> +        - airoha,scu
> +
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        reg-names:
> +          items:
> +            - const: pcie-mac
> +
> +        resets:
> +          minItems: 2
> +          maxItems: 3
> +
> +        reset-names:
> +          minItems: 2
> +          items:
> +            - enum: [ phy-lane0, phy-lane1, phy-lane2 ]
> +            - enum: [ phy-lane1, perstout ]
> +            - const: phy-lane2
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +

You can drop bus node.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
