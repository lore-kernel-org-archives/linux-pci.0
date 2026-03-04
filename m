Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D33390CA8;
	Wed,  4 Mar 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613863; cv=none; b=bhfqKpr2Z9n8G4OFuN1CvXr810Zb7ZpF7G2vPylF/CicRH8FT2n0ho6Kle1a2UeEdmoAMpou1FTBMkICo4ddpzKsWG5bCzBj1Lvz7fo0pwNSQKr+ZPaKFAs34QHl8NWg3LGh4dYjsQ01BPmso8N5hcxWwGcK57hfF9UGlvLHBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613863; c=relaxed/simple;
	bh=bJ5oHMvnEDqSRR/kfjx4LrLT56zcOOAt+qoZ/KCobTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLPFMNAkg2VR0O/JD2bzsUg1B8uwOZPzvJnS+vZmNcltv8uupZjg+63qFwU1H/icJ5A+p1kkWgD3vb6j4EfDyTW1sx19hzsdFAlzhLb2hcqGEvRLs2NveFUHYRmAqX+lbekEwOuccRd1nzLvlOrPjwmr3x5iwmd/7hcM9AlQMS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExQv6fcU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExQv6fcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98119C19423;
	Wed,  4 Mar 2026 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772613863;
	bh=bJ5oHMvnEDqSRR/kfjx4LrLT56zcOOAt+qoZ/KCobTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExQv6fcUjaxXCqkb10ek6GOSiyT8xcIBKgqmQrOlEenEjB9c8BZquWvtJQrBMMJxR
	 9SIsFZSNgO/9yv41Kogy3NSU+q7mZKq5+9Xw0ItZcmAX0QgYWIG3uOaRu74UIHRzP7
	 X5aDeGBqLkhnodHuYnxJN1qxxDJ5X2OrWfK1KB4pxTuP5jyh2u/IgX3JobvmmL/Xkt
	 xueWhr9XiE3PThGwYhvvDFEExh+0PUCTDeZ+C6fKYAz9gKddW5rUGHrZptFJGbdeWg
	 zQ0kSrzrxmBMT6IL4WYaFjoMOYbavyFWvrfsR3Jf+nPMV885MSblPtMjFZSq+l4TN6
	 t22/DuEv9Wq4A==
Date: Wed, 4 Mar 2026 09:44:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: linux-mips@vger.kernel.org, naseefkm@gmail.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, tsbogend@alpha.franken.de, ryder.lee@mediatek.com, 
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, vkoul@kernel.org, neil.armstrong@linaro.org, 
	p.zabel@pengutronix.de, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	nbd@nbd.name, ansuelsmth@gmail.com, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/8] dt-bindings: phy: Document PCIe PHY in EcoNet
 EN751221 and EN7528
Message-ID: <20260304-proficient-coati-of-lightning-df2cab@quoll>
References: <20260303190948.694783-1-cjd@cjdns.fr>
 <20260303190948.694783-4-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303190948.694783-4-cjd@cjdns.fr>

On Tue, Mar 03, 2026 at 07:09:43PM +0000, Caleb James DeLisle wrote:
> EN751221 and EN7528 SoCs have two PCIe slots, and each one has a
> PHY which behaves slightly differently because one slot is Gen1/Gen2
> while the other is Gen1 only.
> 
> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> ---
>  .../phy/econet,en751221-pcie-phy.yaml         | 57 +++++++++++++++++++

Why are you mixing multiple subsystems in the same patchset? That's
like three or four different ones. Don't, just make it difficult to
apply pieces and understand the dependencies.

>  MAINTAINERS                                   |  6 ++
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/econet,en751221-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/econet,en751221-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/econet,en751221-pcie-phy.yaml
> new file mode 100644
> index 000000000000..8e1d3c791c6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/econet,en751221-pcie-phy.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/econet,en751221-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EcoNet PCI-Express PHY for EcoNet EN751221 and EN7528
> +
> +maintainers:
> +  - Caleb James DeLisle <cjd@cjdns.fr>
> +
> +description:
> +  The PCIe PHY supports physical layer functionality for PCIe Gen1 and
> +  Gen1/Gen2 ports. On these SoCs, port 0 is a Gen1-only port while
> +  port 1 is Gen1/Gen2 capable.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - econet,en751221-pcie-phy0
> +      - econet,en751221-pcie-phy1

What is the difference between phy0 and phy1? This must be explicitly
explained in the description.

If phy1 means "port 1" (although first sentence disagrees, because it
says that THE SAME phy supports two ports), then the names aren't -gen1
and -gen2? Or what are other differences?

> +      - econet,en7528-pcie-phy0
> +      - econet,en7528-pcie-phy1
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#phy-cells'

Use consisent quotes.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/phy/phy.h>

Where do you use it here?

> +    soc {
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +
> +      pcie_phy0: pcie-phy@1faf2000 {

Drop unused label.

> +        compatible = "econet,en7528-pcie-phy0";
> +        reg = <0x1faf2000 0x1000>;
> +        #phy-cells = <0>;
> +      };
> +
> +      pcie_phy1: pcie-phy@1fac0000 {
> +        compatible = "econet,en7528-pcie-phy1";

Drop node, same as previous one.

Best regards,
Krzysztof

