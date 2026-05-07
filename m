Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF047AF4B;
	Thu,  7 May 2026 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181186; cv=none; b=EZxmH3BcaAGW8qHz0WRofWrZNO8kUrfaqV/kT41YCSneP23ZIencwMX/kTy6pQMoo3qiWvMBlmP8aXQwphZ3KHm74uSrdnB2dSH1ryQ2KJAFk/mPL3S6+QJ0xZNfnmCyTDxYn6GyE3CUdjapkSOq0/qCG4mceAupcNE2JN3czuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181186; c=relaxed/simple;
	bh=wryvf8h8saMxe/tJcVAN8lMbAU21FCA47IoyVg/yQ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng6Kt17N0AyqgVhdZN+IHADIEUTIfAivYcbbQ877kHRB2jYFWKZvjp3KbuoUM+F5+0GfELZbmh0jTn8y1Cbje5J48lXJiUpfb7OtgzRwNigPBi0Tla9fWSU1KLRpkeB0PV+0/WLEn2um176H1KSq6u/aVRvSOsYdksv58IzJlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwTN2U7O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwTN2U7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7A9C2BCB2;
	Thu,  7 May 2026 19:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778181185;
	bh=wryvf8h8saMxe/tJcVAN8lMbAU21FCA47IoyVg/yQ88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwTN2U7ORZdeCaNaxaUSr4neb9ESj0k6NNIQR360HUAN4dPJuj/2NR7QTGu+yzcwV
	 3QesyvlsNJ7RlTfQyJ8yFVT1D1PCrzRzO3eg38ekUO6lyk/KreWR6jlgfvgPL/HTIR
	 9m2WpzcIgl0L0Q11PBqP3pmIAIhV5YGBZYrKEitGK6m/TQVtjzdmU9xKrxtp79CyvP
	 xYc5MEGfRojNdD+zCIaKorIlYYwrYaMc9mz0R01kIdjMKX9ouIBKFGgcxik2671DgK
	 eaYoouGTPxeLo/dyd9F9zjdimTwozLoPHN5x6kUHl1Oy1JAF5qPOSZGhSJpFSJ0/xe
	 MgNuHeqHAzZbg==
Date: Thu, 7 May 2026 14:13:02 -0500
From: Rob Herring <robh@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alex Elder <elder@riscstar.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: pci: spacemit: Introduce Spacemit K3
 PCIe host controller
Message-ID: <20260507191302.GA2284447-robh@kernel.org>
References: <20260502101319.2364052-1-inochiama@gmail.com>
 <20260502101319.2364052-5-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502101319.2364052-5-inochiama@gmail.com>

On Sat, May 02, 2026 at 06:13:17PM +0800, Inochi Amaoto wrote:
> Add binding support for the PCIe controller on the SpacemiT K3 SoC.
> This controller is almost a standard Synopsys Designware PCIe IP,
> with some extra link and reset state control.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../bindings/pci/spacemit,k3-pcie-host.yaml   | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> new file mode 100644
> index 000000000000..be2641526b19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k3-pcie-host.yaml
> @@ -0,0 +1,142 @@
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
> +  DesignWare PCIe IP.  The controller uses the external MSI interrupt
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
> +  interrupts:
> +    items:
> +      - description: Interrupt used for port state
> +
> +  interrupt-names:
> +    const: app
> +
> +  msi-parent: true
> +
> +  phys:
> +    minItems: 1
> +    maxItems: 6

You have to define what each entry is. I assume this is 1 per lane 
though I thought only a power of 2 number of lanes was valid.

Rob
