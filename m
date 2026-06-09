Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB62248AF;
	Tue,  9 Jun 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013826; cv=none; b=Dq14Q3W3MOS3uMa0rqjDz9vx0642rCZjriblbuOBRw2KgnGFkiK6l7oagrQELNb8BPBAyHoPaMMIwvk/RF6De+TEJEy4llB3IZKjq60SSbsSb6PhOPjkMTptLpwquv72QoDNqKsErOl6Mu0tlE9Q4PwV1/d7/DfyhnLeDbbOnL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013826; c=relaxed/simple;
	bh=sSOjIsLE5Nob1WrXPlgyAzaHus973NCR8/k8alZvajU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7W/AWtfJy7Xa6D2O5NZoqlWUzXmnD7cbrhHY823keFJSO+ub4N8oyjFfhg7A/HBaQ54eDgnG7ICR15PtNNmTv9zv9PgBfA1n+iOoc99FhsKn3heJWXCoOlvCagyf3HfsMZtbbce5PkmGfq5i9pd06qCIG30c3K7TP9tYY1PG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJX4aPJD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJX4aPJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEE21F00893;
	Tue,  9 Jun 2026 14:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781013824;
	bh=1DnO0LF4fbrVsRf3xF1uvDWwo3p9DT9VB41B8Luh+ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jJX4aPJDj37XfcRWvIDJ9tAk8xTYnbvSgrR9WZGXrxIfKE8JgYHz94xwDZX72pJEK
	 s71Q5lEoqQX2iFMCSzuYmIMTQi0H1uWM2oN/hZZM8TUDHTCOOtnVWF+2JQNiwHGQ61
	 JNwwWpvAHMcbKL9M2tHiOQ6K79biqp2/Qt4KNT1l9bdyNxvM3XqpaaUYCJzAnyCJ9Q
	 CxVOOiITRQzDncePVWTHmM2jsAy0VtfSv64ZjPJ+llOuOQ8ajay6+JWL5+dZN/slnB
	 RrQXNxjOp5uynPc+TvI/SkSiRO4+n09r1CZfQvUV5L8gAz6PSdB34rOoXr5M6dey+8
	 NsGKxMXSoM7GA==
Date: Tue, 9 Jun 2026 19:33:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christian Bruel <christian.bruel@foss.st.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Senchuan Zhang <zhangsenchuan@eswincomputing.com>, 
	Alex Elder <elder@riscstar.com>, Nam Cao <namcao@linutronix.de>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Randolph Lin <randolph@andestech.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: PCI: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <kwan2ci7umcckod2623tt2ebwaz6v7ypczz3bqmhfxc6awrkfc@jrjf73wzehcc>
References: <20260517014841.254085-1-inochiama@gmail.com>
 <20260517014841.254085-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517014841.254085-5-inochiama@gmail.com>

On Sun, May 17, 2026 at 09:48:39AM +0800, Inochi Amaoto wrote:
> Add binding support for the PCIe controller on the SpacemiT K3 SoC.
> This controller is almost a standard Synopsys DesignWare PCIe IP,
> with some extra link and reset state control.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Why can't you reuse the existing spacemit,k1-pcie-host.yaml binding? I see very
few differences which could be added using conditionals. Also, this binding
defines the PHY property in the controller node, which is a way backwards as we
now prefer to define these in Root Port node as spacemit,k1-pcie-host.yaml does.

- Mani

> ---
>  .../bindings/pci/spacemit,k3-pcie-host.yaml   | 135 ++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> new file mode 100644
> index 000000000000..46147a37a9ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> @@ -0,0 +1,135 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/spacemit,k3-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K3 PCI Express Host Controller
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +description:
> +  The SpacemiT K3 SoC PCIe host controller is based on the Synopsys
> +  DesignWare PCIe IP. The controller uses the external MSI interrupt
> +  controller.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: spacemit,k3-pcie
> +
> +  reg:
> +    items:
> +      - description: DesignWare PCIe registers
> +      - description: Data Bus Interface (DBI) shadow registers
> +      - description: ATU address space
> +      - description: PCIe configuration space
> +      - description: Link control registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: atu
> +      - const: config
> +      - const: link
> +
> +  clocks:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) clock
> +      - description: DWC PCIe application AXI-bus master interface clock
> +      - description: DWC PCIe application AXI-bus slave interface clock
> +
> +  clock-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  resets:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) reset
> +      - description: DWC PCIe application AXI-bus master interface reset
> +      - description: DWC PCIe application AXI-bus slave interface reset
> +
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  msi-parent: true
> +
> +  phys:
> +    description:
> +      PHY phandle from the Combo PHY, the lane number does not depends
> +      on this, since the number of lanes provided by Combo PHY can be
> +      1 or 2.
> +    minItems: 1
> +    maxItems: 6
> +
> +  phy-names:
> +    minItems: 1
> +    maxItems: 6
> +
> +  spacemit,apmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle that refers to the APMU system controller, whose regmap is
> +      used in managing resets and link state, along with and offset of its
> +      reset control register.
> +    items:
> +      - items:
> +          - description: phandle to APMU system controller
> +          - description: register offset
> +
> +required:
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - msi-parent
> +  - spacemit,apmu
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie@80000000 {
> +        compatible = "spacemit,k3-pcie";
> +        reg = <0x0  0x80000000 0x0 0x00001000>,
> +              <0x0  0x80100000 0x0 0x00001000>,
> +              <0x0  0x80300000 0x0 0x00003f20>,
> +              <0x11 0x00000000 0x0 0x00010000>,
> +              <0x0  0x82900000 0x0 0x00001000>;
> +        reg-names = "dbi", "dbi2", "atu", "config", "link";
> +        device_type = "pci";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        clocks = <&syscon_apmu 89>,
> +                 <&syscon_apmu 56>,
> +                 <&syscon_apmu 57>;
> +        clock-names = "dbi", "mstr", "slv";
> +        msi-parent = <&simsic>;
> +        ranges = <0x01000000 0x00 0x00010000 0x11 0x00010000 0x0 0x00100000>,
> +                 <0x02000000 0x0  0x00110000 0x11 0x00110000 0x0 0x7fef0000>,
> +                 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x1 0x00000000>;
> +        resets = <&syscon_apmu 76>,
> +                 <&syscon_apmu 78>,
> +                 <&syscon_apmu 77>;
> +        reset-names = "dbi", "mstr", "slv";
> +        linux,pci-domain = <0>;
> +        spacemit,apmu = <&syscon_apmu 0x1f0>;
> +      };
> +    };
> +
> -- 
> 2.54.0
> 

-- 
மணிவண்ணன் சதாசிவம்
