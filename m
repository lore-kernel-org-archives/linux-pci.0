Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D992BFC85
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300436; cv=none; b=sjnZcx4g19WMtIp3BgjY3Db6jcPLFO7ZT31Mxouwund5zgawpX667Rt09+B8iOYizTgDMxupxJcTnpiwgo2jwVWVX4xJtXnBvR6XsaGNlbL7k7o269ANKaZPw5c4YxBx2/sP4aTKiE3p9kESHZAD084GpqLpucQ3ydYDBsXMrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300436; c=relaxed/simple;
	bh=OdxGEVLDGfCzmwySpRONhPp8fjCDJ1uuCN5VyQfhs+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaqK0C58aa8HdgfFF1Xn6BQAzDJi6YwimMdrh76TyWtdwqZFttziCL+I7R6BtRxrLiH7X7NP9aFkbPkBOg8yK8cgOH0QtTDZ++aiprSsvtwRElhnDZsFl2XaNIQ6jyIcQtmuaaRBAmj5Alm0GezrGeEJn3yIukyrVKZ6LA3jdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI+ebUoe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI+ebUoe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9B7C2BCFA
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777300436;
	bh=OdxGEVLDGfCzmwySpRONhPp8fjCDJ1uuCN5VyQfhs+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fI+ebUoeH5hWPcG/wBq6WXo+uDqrD7zDrJCB0V6xJH97cEPHEb6ih0xyph6z4WGY4
	 FQZZQkfSjg9YUdNic1DKGx2zL7IShuHZs9fk/U0aqCUwEleso1RPa1hUfUgEdchW3i
	 tQCVJ8nKEBmJMHtDURiFWzJxjPKHY0u0birO+d/p6dK57m8IHevLHDhiJI0+ZAxmUz
	 nlhHbDi8GvzQdbCS82cdd6LQPFt/L3tVDUDZb5+ffZe/bVMACLzbGmycmwEqLc49wu
	 cY3jsiqD1CDYPU4GKl2/33IUG04DaB7XrbVGKm8XKl3OTN+/TNb0gI5ZUyrEhcZiE/
	 A6KEmzkaljblA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67893fba9c3so8175414a12.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 07:33:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8+w3cEE+VgciHEYZ0+mGPNvV9OhWawvzLj+c27YI1/0+WDeqos7RLBkDDZPr8ZKSygawJHftXJLQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv52rt3+zovJabdgnt7OD0Kl30EtYQw+MTTKr9+EZ/CIBiZAyD
	sfFWzRplYlHAaZENukVw0ipKnFwl48VzJ2Pqoh1aVvxtL3VJkGu6LJGMU1qAPKjA3lV2aMXas3V
	JQtKx5WtCQKmHucJ7YDze4KsVM2j5Tg==
X-Received: by 2002:a05:6402:2804:b0:672:f7a:1e7 with SMTP id
 4fb4d7f45d1cf-672bfdca2b4mr20198931a12.17.1777300434403; Mon, 27 Apr 2026
 07:33:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224121948.25218-1-linux.amoon@gmail.com> <20260224121948.25218-2-linux.amoon@gmail.com>
 <20260306004333.GA863798-robh@kernel.org> <CANAwSgS7RhZ1D-zPR8LpvrQJVp+1be9ALC5HcE1XhouyNOS6Jg@mail.gmail.com>
In-Reply-To: <CANAwSgS7RhZ1D-zPR8LpvrQJVp+1be9ALC5HcE1XhouyNOS6Jg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 27 Apr 2026 09:33:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJY2Wv5YFVmW5P7dTmNK5QVdfxZZsMFt-Zn4i-ubPkf3Q@mail.gmail.com>
X-Gm-Features: AVHnY4KbfNzxvVk_fcwP_CGe9fDgzTP7yX99CVzMt3_OyekAOqH2-F6dcA50sp0
Message-ID: <CAL_JsqJY2Wv5YFVmW5P7dTmNK5QVdfxZZsMFt-Zn4i-ubPkf3Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
To: Anand Moon <linux.amoon@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-tegra@vger.kernel.org>, 
	"open list:PCI DRIVER FOR NVIDIA TEGRA" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 1:46=E2=80=AFAM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Hi Rob,
>
> Thanks for your review comments. Sorry for the late reply.
>
> On Fri, 6 Mar 2026 at 06:13, Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Feb 24, 2026 at 05:48:57PM +0530, Anand Moon wrote:
> > > Convert the existing text-based DT bindings documentation for the
> > > NVIDIA Tegra PCIe host controller to a DT schema format.
> >
> > I just reviewed the same thing from Thierry... This one looks a bit
> > better for overall structure (fewer if/then schemas), but I think misse=
s
> > some things like deprecated supplies. Please resolve the differences
> > between the 2 and coordinate who is going to send the next version.
> >
> Ok, I checked this, but couldn't find the deprecated supplies.
>
> The drive code maps SoC-supplied regulators to an array for the buck regu=
lators.
> [1] https://github.com/torvalds/linux/blob/master/drivers/pci/controller/=
pci-tegra.c#L1929-L2078
>
> I will fix it if I need to.
> > >
> > > Also update the MAINTAINERS file to reflect this change.
> > >
> > > Cc: Jon Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > v3: Tried to address the issues Krzysztof pointed out.
> > >    Added missing regulator binding as suggeested by Jon.
> > > v2: Tried to address the isssue Rob pointed
> > > [1] https://lkml.org/lkml/2025/9/26/704
> > > improve the $suject and commit message
> > > drop few examples only nvidia,tegra20-pcie and nvidia,tegra210-pcie
> > >
> > > $ make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bi=
ndings/pci/nvidia,tegra-pcie.yaml
> > > ---
> > >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 528 ++++++++++++++
> > >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ----------------=
--
> > >  MAINTAINERS                                   |   2 +-
> > >  3 files changed, 529 insertions(+), 671 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegr=
a-pcie.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegr=
a20-pcie.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.=
yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..0675bec205e8
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > > @@ -0,0 +1,528 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: NVIDIA Tegra PCIe Controller
> > > +
> > > +maintainers:
> > > +  - Jon Hunter <jonathanh@nvidia.com>
> > > +  - Thierry Reding <treding@nvidia.com>
> > > +
> > > +description:
> > > +  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
> > > +  root ports and platform-specific clock, reset, and power supply
> > > +  configurations.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - nvidia,tegra20-pcie
> > > +      - nvidia,tegra30-pcie
> > > +      - nvidia,tegra124-pcie
> > > +      - nvidia,tegra210-pcie
> > > +      - nvidia,tegra186-pcie
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: PADS registers
> > > +      - description: AFI registers
> > > +      - description: Configuration space region
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: pads
> > > +      - const: afi
> > > +      - const: cs
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: Controller interrupt
> > > +      - description: MSI interrupt
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: intr
> > > +      - const: msi
> > > +
> > > +  clocks:
> > > +    minItems: 3
> > > +    items:
> > > +      - description: PCIe clock
> > > +      - description: AFI clock
> > > +      - description: PLL_E clock
> > > +      - description: Optional CML clock
> > > +
> > > +  clock-names:
> > > +    description: Names of clocks used by the PCIe controller
> > > +    minItems: 3
> > > +    items:
> > > +      - const: pex
> > > +      - const: afi
> > > +      - const: pll_e
> > > +      - const: cml
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: PCIe reset
> > > +      - description: AFI reset
> > > +      - description: PCIe-X reset
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: pex
> > > +      - const: afi
> > > +      - const: pcie_x
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  interconnects:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +
> > > +  interconnect-names:
> > > +    items:
> > > +      - const: dma-mem
> > > +      - const: write
> > > +
> > > +  pinctrl-names:
> > > +    items:
> > > +      - const: default
> > > +      - const: idle
> > > +
> > > +  pinctrl-0: true
> > > +  pinctrl-1: true
> > > +
> > > +  operating-points-v2:
> > > +    description:
> > > +      Defines operating points with required frequency and voltage v=
alues,
> > > +      and the opp-supported-hw property.
> > > +
> > > +  iommus:
> > > +    maxItems: 1
> > > +
> > > +  avdd-pex-supply:
> > > +    description: Power supply for analog PCIe logic. Must supply 1.0=
5 V.
> > > +
> > > +  vdd-pex-supply:
> > > +    description: Power supply for digital PCIe I/O. Must supply 1.05=
 V.
> > > +
> > > +  avdd-pex-pll-supply:
> > > +    description: Power supply for dedicated (internal) PCIe PLL. Mus=
t supply 1.05 V.
> > > +
> > > +  avdd-plle-supply:
> > > +    description: Power supply for PLLE, which is shared with SATA. M=
ust supply 1.05 V.
> > > +
> > > +  vddio-pex-clk-supply:
> > > +    description: Power supply for PCIe clock. Must supply 3.3 V.
> > > +
> > > +  vddio-pex-ctl-supply:
> > > +    description: Power supply for PCIe control I/O partition. Must s=
upply 1.8 V.
> > > +
> > > +  hvdd-pex-supply:
> > > +    description: High-voltage supply for PCIe I/O and PCIe output cl=
ocks. Must supply 3.3 V.
> > > +
> > > +  avdd-pexa-supply:
> > > +    description: Power supply for analog PCIe logic. Must supply 1.0=
5 V.
> > > +
> > > +  vdd-pexa-supply:
> > > +    description: Power supply for digital PCIe I/O. Must supply 1.05=
 V.
> > > +
> > > +  avdd-pexb-supply:
> > > +    description: Power supply for analog PCIe logic. Must supply 1.0=
5 V.
> > > +
> > > +  vdd-pexb-supply:
> > > +    description: Power supply for digital PCIe I/O. Must supply 1.05=
 V.
> > > +
> > > +  avddio-pex-supply:
> > > +    description: Power supply for analog PCIe logic. Must supply 1.0=
5 V.
> > > +
> > > +  dvddio-pex-supply:
> > > +    description: Power supply for digital PCIe I/O. Must supply 1.05=
 V.
> > > +
> > > +  hvddio-pex-supply:
> > > +    description: High-voltage supply for PCIe I/O and PCIe output cl=
ocks. Must supply 1.8 V.
> > > +
> > > +  dvdd-pex-supply:
> > > +    description: Power supply for digital PCIe I/O. Must supply 1.05=
 V.
> > > +
> > > +  hvdd-pex-pll-supply:
> > > +    description: High-voltage supply for PLLE (shared with USB3). Mu=
st supply 1.8 V.
> > > +
> > > +  vddio-pexctl-aud-supply:
> > > +    description: Power supply for PCIe side band signals. Must suppl=
y 1.8 V.
> > > +
> > > +patternProperties:
> > > +  "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
> > > +    type: object
> > > +    allOf:
> >
> > Don't need allOf.
> Ok.
> >
> > > +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> > > +    properties:
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      nvidia,num-lanes:
> > > +        description: Number of lanes used by this PCIe port
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [1, 2, 4]
> > > +
> > > +      phys:
> > > +        description: Phandles to PCIe PHYs
> > > +        items:
> > > +          maxItems: 1
> >
> > How many cells a phy entry has depends on the provider, which is outsid=
e
> > the scope of this binding.
> Ok, actually, phys and phys-name are not part of patternProperties.
>
> phys and phy-name are required properties for Tegra124 and later.
>
> [2] https://github.com/torvalds/linux/blob/master/Documentation/devicetre=
e/bindings/pci/nvidia%2Ctegra20-pcie.txt#L153-L158
>
> And the board's example is as follows.
>
> [3] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/nvi=
dia/tegra210-p2371-2180.dts#L11-L32
>
> [4] https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/nvi=
dia/tegra210-p3450-0000.dts#L36-L63
> >
> > > +        minItems: 1
> > > +        maxItems: 4
> >
> So I have modified the device tree binding as follows.
> -----8<----------8<----------8<----------8<----------8<----------8<-----
>
> $ git diff .
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> index 0675bec205e8..73af8d2895a8 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> @@ -103,6 +103,18 @@ properties:
>    iommus:
>      maxItems: 1
>
> +  phys:
> +    description: Phandles to PCIe PHYs
> +    minItems: 1
> +    maxItems: 4
> +
> +  phy-names:
> +    description: Names of PCIe PHYs
> +    items:
> +      pattern: "^pcie(-[0-3])?$"
> +    minItems: 1
> +    maxItems: 4
> +
>    avdd-pex-supply:
>      description: Power supply for analog PCIe logic. Must supply 1.05 V.
>
> @@ -157,8 +169,8 @@ properties:
>  patternProperties:
>    "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
>      type: object
> -    allOf:
> -      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
>      properties:
>        reg:
>          maxItems: 1
> @@ -168,20 +180,6 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          enum: [1, 2, 4]
>
> -      phys:
> -        description: Phandles to PCIe PHYs
> -        items:
> -          maxItems: 1
> -        minItems: 1
> -        maxItems: 4
> -
> -      phy-names:
> -        description: Names of PCIe PHYs
> -        items:
> -          pattern: "^pcie(-[0-3])?$"
> -        minItems: 1
> -        maxItems: 4
> -
>      required:
>        - nvidia,num-lanes
>
> @@ -274,6 +272,33 @@ allOf:
>          - pinctrl-0
>          - pinctrl-1
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra124-pcie
> +              - nvidia,tegra210-pcie
> +    then:
> +      required:
> +        - phys
> +        - phy-names
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra20-pcie
> +              - nvidia,tegra30-pcie
> +              - nvidia,tegra186-pcie
> +    then:
> +      properties:
> +        phys:
> +          deprecated: true
> +        phy-names:
> +          deprecated: true
> +
>    - if:
>        properties:
>          compatible:
> @@ -495,34 +520,19 @@ examples:
>              dvddio-pex-supply =3D <&reg_pex_1v05>;
>              vddio-pex-ctl-supply =3D <&reg_pexctl_1v8>;
>
> -            status =3D "okay";
> -
>              pci@1,0 {
> -                device_type =3D "pci";
> -                assigned-addresses =3D <0x82000800 0 0x01000000 0 0x1000=
>;
> -                reg =3D <0x000800 0 0 0 0>;
> -                bus-range =3D <0x00 0xff>;
> +                phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
> +                    <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
> +                    <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
> +                    <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
> +                phy-names =3D "pcie-0", "pcie-1", "pcie-2", "pcie-3";
>                  status =3D "okay";
> -
> -                #address-cells =3D <3>;
> -                #size-cells =3D <2>;
> -                ranges;
> -
> -                nvidia,num-lanes =3D <4>;
>              };
>
>              pci@2,0 {
> -                device_type =3D "pci";
> -                assigned-addresses =3D <0x82001000 0 0x01001000 0 0x1000=
>;
> -                reg =3D <0x001000 0 0 0 0>;
> -                bus-range =3D <0x00 0xff>;
> +                phys =3D <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
> +                phy-names =3D "pcie-0";
>                  status =3D "okay";
> -
> -                #address-cells =3D <3>;
> -                #size-cells =3D <2>;
> -                ranges;
> -
> -                nvidia,num-lanes =3D <1>;
>              };
>          };
>      };
>
> -----8<----------8<----------8<----------8<----------8<----------8<-----
>
> But I am not able to resolve the build error
>
> $ make -j$(nproc) dt_binding_check DT_SCHEMA_FILES=3Dnvidia,tegra-pcie.ya=
ml
>   DTC [C] Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example=
.dtb
> Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dts:179.2=
5-186.19:
> Warning (unit_address_vs_reg): /example-1/bus/pcie@1003000/pci@1,0:
> node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dts:188.2=
5-192.19:
> Warning (unit_address_vs_reg): /example-1/bus/pcie@1003000/pci@2,0:
> node has a unit name, but no reg or ranges property

PCI nodes have to have a 'reg' entry. Otherwise, how do we match a
node to a device?

> FATAL ERROR: Can't generate fixup for reference to path
> &{/padctl@7009f000/pads/pcie/lanes/pcie-0}

You can't use paths that don't exist. You can only use labels which
don't exist. The examples are built as overlays to allow that.

Rob
