Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E12D6E5A;
	Fri,  6 Mar 2026 00:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757814; cv=none; b=iq9yks5WqJh8G5WawlJXNu++pVRxxtteHWKZD7BV5kzeZF7dJcrLlkuAmZ/bk10qeHXPQ9k4O6Di5S7Igsw+ge262r3r8PTrHP7HfNM2RlCheNZ+WGF8i47zB3xFdRaT3l5p6SsBKg8vilmG9qYYMpk9KYmEtTVxi9ZE3L/X7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757814; c=relaxed/simple;
	bh=uynp/F1TEhsuEQvaU0KZCrYdvfuryfR+sRqkbJZUsSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIgTMVuP5/M2rZWT1S42wqjq17HSHbjZle/lRuv+BtPwSXakAS2J9YeSvLrj/YEAaD0g/ddiL06BxdUuYJMzvIark6WtwlJ4DAvkJE8eUdDpDyElrgfA+XoPnjbUch9KmDmVcResY6KEIBwxE482NRfA64ZFrAGQwJH+ZJXi90U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeJMMxwo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeJMMxwo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5595AC116C6;
	Fri,  6 Mar 2026 00:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772757814;
	bh=uynp/F1TEhsuEQvaU0KZCrYdvfuryfR+sRqkbJZUsSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeJMMxwo+BgL99hg9XvB8qmgZgDFQkBXJmOov9LE7YGicxw23xXh9YtRw0A5UGuEf
	 yPCYZps0UfU5La7gvtaXHwIv5jb8SniDhy6BQYQrm0fwX46d2xebX5k+U20NC5rXBJ
	 WeXjjWmn47YT9De+fJNjMWy+1gJqC2dPNpdoU0zdvhx5MGc525EYR+DxbZUpqO+FgT
	 MmKjnS5ZlVtipmyQyoIuvE6rnda7YgAd+D1GBRdKBsx6pz6JLPIJcZy2gjM7zu365a
	 orqRhbynoK/q+Ht8/xaKNseXbumoud5WWzkArxnwe7ppsNuFGjkhG/046+OBZnixey
	 zFlkv7dSiUBFg==
Date: Thu, 5 Mar 2026 18:43:33 -0600
From: Rob Herring <robh@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>,
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT
 schema
Message-ID: <20260306004333.GA863798-robh@kernel.org>
References: <20260224121948.25218-1-linux.amoon@gmail.com>
 <20260224121948.25218-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224121948.25218-2-linux.amoon@gmail.com>

On Tue, Feb 24, 2026 at 05:48:57PM +0530, Anand Moon wrote:
> Convert the existing text-based DT bindings documentation for the
> NVIDIA Tegra PCIe host controller to a DT schema format.

I just reviewed the same thing from Thierry... This one looks a bit 
better for overall structure (fewer if/then schemas), but I think misses 
some things like deprecated supplies. Please resolve the differences 
between the 2 and coordinate who is going to send the next version.

> 
> Also update the MAINTAINERS file to reflect this change.
> 
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v3: Tried to address the issues Krzysztof pointed out.
>    Added missing regulator binding as suggeested by Jon.
> v2: Tried to address the isssue Rob pointed
> [1] https://lkml.org/lkml/2025/9/26/704
> improve the $suject and commit message
> drop few examples only nvidia,tegra20-pcie and nvidia,tegra210-pcie
> 
> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> ---
>  .../bindings/pci/nvidia,tegra-pcie.yaml       | 528 ++++++++++++++
>  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 529 insertions(+), 671 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> new file mode 100644
> index 000000000000..0675bec205e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> @@ -0,0 +1,528 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra PCIe Controller
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <treding@nvidia.com>
> +
> +description:
> +  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
> +  root ports and platform-specific clock, reset, and power supply
> +  configurations.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra20-pcie
> +      - nvidia,tegra30-pcie
> +      - nvidia,tegra124-pcie
> +      - nvidia,tegra210-pcie
> +      - nvidia,tegra186-pcie
> +
> +  reg:
> +    items:
> +      - description: PADS registers
> +      - description: AFI registers
> +      - description: Configuration space region
> +
> +  reg-names:
> +    items:
> +      - const: pads
> +      - const: afi
> +      - const: cs
> +
> +  interrupts:
> +    items:
> +      - description: Controller interrupt
> +      - description: MSI interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: intr
> +      - const: msi
> +
> +  clocks:
> +    minItems: 3
> +    items:
> +      - description: PCIe clock
> +      - description: AFI clock
> +      - description: PLL_E clock
> +      - description: Optional CML clock
> +
> +  clock-names:
> +    description: Names of clocks used by the PCIe controller
> +    minItems: 3
> +    items:
> +      - const: pex
> +      - const: afi
> +      - const: pll_e
> +      - const: cml
> +
> +  resets:
> +    items:
> +      - description: PCIe reset
> +      - description: AFI reset
> +      - description: PCIe-X reset
> +
> +  reset-names:
> +    items:
> +      - const: pex
> +      - const: afi
> +      - const: pcie_x
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  interconnects:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: dma-mem
> +      - const: write
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: idle
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +
> +  operating-points-v2:
> +    description:
> +      Defines operating points with required frequency and voltage values,
> +      and the opp-supported-hw property.
> +
> +  iommus:
> +    maxItems: 1
> +
> +  avdd-pex-supply:
> +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> +
> +  vdd-pex-supply:
> +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> +
> +  avdd-pex-pll-supply:
> +    description: Power supply for dedicated (internal) PCIe PLL. Must supply 1.05 V.
> +
> +  avdd-plle-supply:
> +    description: Power supply for PLLE, which is shared with SATA. Must supply 1.05 V.
> +
> +  vddio-pex-clk-supply:
> +    description: Power supply for PCIe clock. Must supply 3.3 V.
> +
> +  vddio-pex-ctl-supply:
> +    description: Power supply for PCIe control I/O partition. Must supply 1.8 V.
> +
> +  hvdd-pex-supply:
> +    description: High-voltage supply for PCIe I/O and PCIe output clocks. Must supply 3.3 V.
> +
> +  avdd-pexa-supply:
> +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> +
> +  vdd-pexa-supply:
> +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> +
> +  avdd-pexb-supply:
> +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> +
> +  vdd-pexb-supply:
> +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> +
> +  avddio-pex-supply:
> +    description: Power supply for analog PCIe logic. Must supply 1.05 V.
> +
> +  dvddio-pex-supply:
> +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> +
> +  hvddio-pex-supply:
> +    description: High-voltage supply for PCIe I/O and PCIe output clocks. Must supply 1.8 V.
> +
> +  dvdd-pex-supply:
> +    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
> +
> +  hvdd-pex-pll-supply:
> +    description: High-voltage supply for PLLE (shared with USB3). Must supply 1.8 V.
> +
> +  vddio-pexctl-aud-supply:
> +    description: Power supply for PCIe side band signals. Must supply 1.8 V.
> +
> +patternProperties:
> +  "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
> +    type: object
> +    allOf:

Don't need allOf.

> +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      nvidia,num-lanes:
> +        description: Number of lanes used by this PCIe port
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [1, 2, 4]
> +
> +      phys:
> +        description: Phandles to PCIe PHYs
> +        items:
> +          maxItems: 1

How many cells a phy entry has depends on the provider which is outside 
the scope of this binding.

> +        minItems: 1
> +        maxItems: 4

