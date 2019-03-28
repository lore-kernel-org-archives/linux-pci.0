Return-Path: <SRS0=vCch=R7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0020FC43381
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 13:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9BA2173C
	for <linux-pci@archiver.kernel.org>; Thu, 28 Mar 2019 13:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmALZ0KE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfC1NPO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:15:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfC1NPN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Mar 2019 09:15:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so3984787wml.1;
        Thu, 28 Mar 2019 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NudoUkV7W8ok0Xzq4GjiddIHjSlmlXYETBchar4WNYw=;
        b=WmALZ0KE0KLWXf8KSNQ+W6BrfEbZLi64LHwQpzWJBwGbi5zRtfxagr/hgb6z1xVI5H
         40qpArWAODdTyYcpHRGneETlExOTqxzK4CLynlVI1UtGf+nfweB1jUdwJN8pgOI/AhEI
         P7sio+IxjvkguIdjl8iuOsZ81kFRi6hwz25nVawa9q3Zm+7b4M3BoyMM8BrSYIxw+tG1
         QOKA2LoZr2A6hcU3Q+rpYlGT28UwK7QxjeUbi599uEonCHq/24IzO9cJ1YZvGEW+h4KO
         g0hIFw0zOTM80ipOW6ByMLNjaQCBg/1ITH+W/jQvyRjebUnnCbKWl260Vu406SqPy3NW
         6O9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NudoUkV7W8ok0Xzq4GjiddIHjSlmlXYETBchar4WNYw=;
        b=rfS2+hLKYzbll5waWLO97C84IbJezTNCXXWAAbiihvyc2/OC33LWmGZnIZQz/GUA+c
         xygZ6CNhTXenCsElwy+UgQyU62s62RukKxfrsTjiK7CFmYTfrfkKw6LvvdfF/6JlPK1/
         MWmcUSHTadb4cVMzY9MMIxbVccevypNZXGrI5RKzAIzKCqdvH4PpXmTQiWSY1pRiUWN6
         pXgcy8t8zELRfek+0xFKkdp9KiZUVnCMRJZdeCF/u3/ENpWtJ90uNPmCzcTddKDh0M29
         zcozJDD4yd44lOrhucIjwZMNfNtJXmNJylpxFPGe0lp8BWRDnszOxltbM6aXlJriBaKq
         ELTg==
X-Gm-Message-State: APjAAAUsZbsP+2CsyS8GHCUUSCd++YnRkgy7sRkF3BnSo0tNbLVNFSSY
        Dj8BekIbBT1fO2xX3oBT11s=
X-Google-Smtp-Source: APXvYqw5B+udrI49Xh0amc7KD7YudeigBqPMfFwK0Nso4vt6afzs/EovjUIszeHIcC6mPpUWJCArAA==
X-Received: by 2002:a1c:9ad1:: with SMTP id c200mr23538639wme.140.1553778910404;
        Thu, 28 Mar 2019 06:15:10 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id g19sm3102413wmh.17.2019.03.28.06.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:15:09 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:15:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, tiwai@suse.de, spujar@nvidia.com,
        skomatineni@nvidia.com, liviu.dudau@arm.com, krzk@kernel.org,
        heiko@sntech.de, horms+renesas@verge.net.au, olof@lixom.net,
        maxime.ripard@bootlin.com, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, jagan@amarulasolutions.com,
        enric.balletbo@collabora.com, ezequiel@collabora.com,
        stefan.wahren@i2se.com, marc.w.gonzalez@free.fr,
        l.stach@pengutronix.de, tpiepho@impinj.com,
        hayashi.kunihiko@socionext.com, yue.wang@amlogic.com,
        shawn.lin@rock-chips.com, xiaowei.bao@nxp.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH 05/10] dt-bindings: PCI: tegra: Add device tree support
 for T194
Message-ID: <20190328131508.GB5518@ulmo>
References: <1553613207-3988-1-git-send-email-vidyas@nvidia.com>
 <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <1553613207-3988-6-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 08:43:22PM +0530, Vidya Sagar wrote:
> Add support for Tegra194 PCIe controllers. These controllers are based
> on Synopsys DesignWare core IP.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../bindings/pci/nvidia,tegra194-pcie.txt          | 209 +++++++++++++++=
++++++
>  .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |  34 ++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194=
-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2=
u.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.t=
xt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> new file mode 100644
> index 000000000000..31527283a0cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> @@ -0,0 +1,209 @@
> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.t=
xt.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> +- device_type: Must be "pci"
> +- reg: A list of physical base address and length for each set of contro=
ller
> +  registers. Must contain an entry for each entry in the reg-names prope=
rty.
> +- reg-names: Must include the following entries:
> +  "appl": Controller's application logic registers
> +  "window1": This is the aperture of controller available under 4GB boun=
dary
> +             (i.e. within 32-bit space). This aperture is typically used=
 for
> +             accessing config space of root port itself and also the con=
nected
> +             endpoints (by appropriately programming internal Address
> +             Translation Unit's (iATU) out bound region) and also to map
> +             prefetchable/non-prefetchable BARs.
> +  "config": As per the definition in designware-pcie.txt

I see that you set this to a 256 KiB region for all controllers. Since
each function can have up to 4 KiB of extended configuration space, that
means you have space to address:

    256 KiB =3D 4 KiB * 8 functions * 8 devices

Each bus can have up to 32 devices (including the root port) and there
can be 256 busses, so I wonder how this is supposed to work. How does
the mapping work for configuration space? Does the controller allow
moving this 256 KiB window around so that more devices' configuration
space can be accessed?

> +  "atu_dma": iATU and DMA register. This is where the iATU (internal Add=
ress
> +             Translation Unit) registers of the PCIe core are made avail=
able
> +             fow SW access.
> +  "dbi": The aperture where root port's own configuration registers are
> +         available

This is slightly confusing because you already said in the description
of "window1" that it is used to access the configuration space of the
root port itself.

Is the root port configuration space available via the regular
configuration space registers?

> +  "window2": This is the larger (compared to window1) aperture available=
 above
> +             4GB boundary (i.e. in 64-bit space). This is typically used=
 for
> +             mapping prefetchable/non-prefetchable BARs of endpoints
> +- interrupts: A list of interrupt outputs of the controller. Must contai=
n an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: Must include the following entries:
> +  "intr": The Tegra interrupt that is asserted for controller interrupts
> +  "msi": The Tegra interrupt that is asserted when an MSI is received
> +- bus-range: Range of bus numbers associated with this controller
> +- #address-cells: Address representation for root ports (must be 3)
> +  - cell 0 specifies the bus and device numbers of the root port:
> +    [23:16]: bus number
> +    [15:11]: device number
> +  - cell 1 denotes the upper 32 address bits and should be 0
> +  - cell 2 contains the lower 32 address bits and is used to translate t=
o the
> +    CPU address space
> +- #size-cells: Size representation for root ports (must be 2)
> +- ranges: Describes the translation of addresses for root ports and stan=
dard
> +  PCI regions. The entries must be 7 cells each, where the first three c=
ells
> +  correspond to the address as described for the #address-cells property
> +  above, the fourth and fifth cells are for the physical CPU address to
> +  translate to and the sixth and seventh cells are as described for the
> +  #size-cells property above.
> +  - Entries setup the mapping for the standard I/O, memory and
> +    prefetchable PCI regions. The first cell determines the type of regi=
on
> +    that is setup:
> +    - 0x81000000: I/O memory region
> +    - 0x82000000: non-prefetchable memory region
> +    - 0xc2000000: prefetchable memory region
> +  Please refer to the standard PCI bus binding document for a more detai=
led
> +  explanation.
> +- #interrupt-cells: Size representation for interrupts (must be 1)
> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping propert=
ies
> +  Please refer to the standard PCI bus binding document for a more detai=
led
> +  explanation.
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - core_clk

It's redundant to name a clock _clk. Is this already required by the
standard Designware bindings or is this new?

> +- resets: Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - core_apb_rst
> +  - core_rst

Same comment as for clock-names.

> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
> +- phy-names: Must include an entry for each active lane.
> +  "pcie-p2u-N": where N ranges from 0 to one less than the total number =
of lanes

I'd leave away the "pcie-" prefix since the surrounding context already
makes it clear that this is for PCIe.

> +- Controller dependent register offsets
> +  - nvidia,event-cntr-ctrl: EVENT_COUNTER_CONTROL reg offset
> +      0x168 - FPGA
> +      0x1a8 - C1, C2 and C3
> +      0x1c4 - C4
> +      0x1d8 - C0 and C5
> +  - nvidia,event-cntr-data: EVENT_COUNTER_DATA reg offset
> +      0x16c - FPGA
> +      0x1ac - C1, C2 and C3
> +      0x1c8 - C4
> +      0x1dc - C0 and C5
> +- nvidia,controller-id : Controller specific ID
> +      0x0 - C0
> +      0x1 - C1
> +      0x2 - C2
> +      0x3 - C3
> +      0x4 - C4
> +      0x5 - C5

It's redundant to have both a controller ID and parameterized register
offsets based on that controller ID. I would recommend keeping the
controller ID and then moving the register offsets to the driver and
decide based on the controller ID.

> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> +
> +Optional properties:
> +- nvidia,max-speed: limits controllers max speed to this value.
> +    1 - Gen-1 (2.5 GT/s)
> +    2 - Gen-2 (5 GT/s)
> +    3 - Gen-3 (8 GT/s)
> +    4 - Gen-4 (16 GT/s)
> +- nvidia,init-speed: limits controllers init speed to this value.
> +    1 - Gen-1 (2. 5 GT/s)
> +    2 - Gen-2 (5 GT/s)
> +    3 - Gen-3 (8 GT/s)
> +    4 - Gen-4 (16 GT/s)
> +- nvidia,disable-aspm-states : controls advertisement of ASPM states
> +    bit-0 to '1' : disables advertisement of ASPM-L0s
> +    bit-1 to '1' : disables advertisement of ASPM-L1. This also disables
> +                 advertisement of ASPM-L1.1 and ASPM-L1.2
> +    bit-2 to '1' : disables advertisement of ASPM-L1.1
> +    bit-3 to '1' : disables advertisement of ASPM-L1.2

These seem more like configuration options rather than hardware
description.

> +- nvidia,disable-clock-request : gives a hint to driver that there is no
> +    CLKREQ signal routing on board
> +- nvidia,update-fc-fixup : needs it to improve perf when a platform is d=
esigned
> +    in such a way that it satisfies at least one of the following condit=
ions
> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and M=
PS)
> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths =
and
> +       a) speed is Gen-2 and MPS is 256B
> +       b) speed is >=3D Gen-3 with any MPS

If we know these conditions, can we not determine that the fixup is
needed at runtime?

> +- nvidia,cdm-check : Enables CDM checking. For more information, refer S=
ynopsis
> +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter S.4

Why should this be configurable through device tree?

> +- nvidia,enable-power-down : Enables power down of respective controller=
 and
> +    corresponding PLLs if they are not shared by any other entity

Wouldn't we want this to be the default? Why keep things powered up if
they are not needed?

> +- "nvidia,pex-wake" : Add PEX_WAKE gpio number to provide wake support.
> +- "nvidia,plat-gpios" : Add gpio number that needs to be configured befo=
re
> +   system goes for enumeration. There could be platforms where enabling =
3.3V and
> +   12V power supplies are done through GPIOs, in which case, list of all=
 such
> +   GPIOs can be specified through this property.

For power supplies we usually use the regulator bindings. Are there any
other cases where we'd need this?

> +- "nvidia,aspm-cmrt" : Common Mode Restore time for proper operation of =
ASPM to
> +   be specified in microseconds
> +- "nvidia,aspm-pwr-on-t" : Power On time for proper operation of ASPM to=
 be
> +   specified in microseconds
> +- "nvidia,aspm-l0s-entrance-latency" : ASPM L0s entrance latency to be s=
pecified
> +   in microseconds
> +
> +Examples:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Tegra194:
> +--------
> +
> +SoC DTSI:
> +
> +	pcie@14180000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";

It doesn't seem to me like claiming compatibility with "snps,dw-pcie" is
correct. There's a bunch of NVIDIA- or Tegra-specific properties below
and code in the driver. Would this device be able to function if no
driver was binding against the "nvidia,tegra194-pcie" compatible string?
Would it work if you left that out? I don't think so, so we should also
not list it here.

> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> +		reg =3D <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  =
*/
> +		reg-names =3D "appl", "config", "atu_dma";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <8>;
> +		linux,pci-domain =3D <0>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> +		clock-names =3D "core_clk";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +		reset-names =3D "core_apb_rst", "core_rst";
> +
> +		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 72 0x04>;
> +
> +		nvidia,bpmp =3D <&bpmp>;
> +
> +		nvidia,max-speed =3D <4>;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <&bpmp 0x0>;

Why is there a reference to the BPMP in this propert?

> +		nvidia,aux-clk-freq =3D <0x13>;
> +		nvidia,preset-init =3D <0x5>;

aux-clk-freq and preset-init are not defined in the binding above.

> +		nvidia,aspm-cmrt =3D <0x3C>;
> +		nvidia,aspm-pwr-on-t =3D <0x14>;
> +		nvidia,aspm-l0s-entrance-latency =3D <0x3>;

These should be in decimal notation to make them easier to deal with. I
don't usually read time in hexadecimal.

> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000   =
   /* downstream I/O (1MB) */
> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non=
-prefetchable memory (30MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* pre=
fetchable memory (16GB) */
> +
> +		nvidia,cfg-link-cap-l1sub =3D <0x1c4>;
> +		nvidia,cap-pl16g-status =3D <0x174>;
> +		nvidia,cap-pl16g-cap-off =3D <0x188>;
> +		nvidia,event-cntr-ctrl =3D <0x1d8>;
> +		nvidia,event-cntr-data =3D <0x1dc>;
> +		nvidia,dl-feature-cap =3D <0x30c>;

These are not defined in the binding above.

> +	};
> +
> +Board DTS:
> +
> +	pcie@14180000 {
> +		status =3D "okay";
> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_2>,
> +		       <&p2u_3>,
> +		       <&p2u_4>,
> +		       <&p2u_5>;
> +		phy-names =3D "pcie-p2u-0", "pcie-p2u-1", "pcie-p2u-2",
> +			    "pcie-p2u-3";
> +	};
> diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b=
/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt

Might be better to split this into a separate patch.

> new file mode 100644
> index 000000000000..cc0de8e8e8db
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
> @@ -0,0 +1,34 @@
> +NVIDIA Tegra194 P2U binding
> +
> +Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA=
 High
> +Speed) each interfacing with 12 and 8 P2U instances respectively.
> +A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP'=
s PIPE
> +interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one =
PCIe
> +lane.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-phy-p2u".

Isn't the "phy-" implied by "p2u"? The name of the hardware block is
"Tegra194 P2U", so that "phy-" seems gratuitous to me.

> +- reg: Should be the physical address space and length of respective eac=
h P2U
> +       instance.
> +- reg-names: Must include the entry "base".

"base" is a bad name. Each of these entries will be a "base" of the
given region. The name should specify what region it is the base of.

Thierry

> +
> +Required properties for PHY port node:
> +- #phy-cells: Defined by generic PHY bindings.  Must be 0.
> +
> +Refer to phy/phy-bindings.txt for the generic PHY binding properties.
> +
> +Example:
> +
> +hsio-p2u {
> +	compatible =3D "simple-bus";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	ranges;
> +	p2u_0: p2u@03e10000 {
> +		compatible =3D "nvidia,tegra194-phy-p2u";
> +		reg =3D <0x0 0x03e10000 0x0 0x00010000>;
> +		reg-names =3D "base";
> +
> +		#phy-cells =3D <0>;
> +	};
> +}
> --=20
> 2.7.4
>=20

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlycyNkACgkQ3SOs138+
s6GpjBAAnfsiJGzvtmgEZRoKrb8lW61I5jlj+yisBemGjx0jhZ0RbSk38WWOY6BP
K1eKwFt2em7cifBnaUmB7G3gWnovirAJhW9B3nLVsyjeiz0i3iau/6Y8rR08OxAF
4C2LvvhHQyn+EzR7TCj6M9oZCjyVuHwxAUYDQI9CHeaK/HHW2FTexc+tBPACXaIa
vqStaJk8x1Ygh0qr1lGVZygf5TZZc+5WPRcYyip+tgZMAcGxXAig0jD9k1GqTdRT
QT2WYtuEB12n3459FNMXcShETDasdjH0ieNRSeGtiqKf3f8/DEw9saI5iXroouDx
QMI2hX9VX9dwLc+fOQaXTIa9814+s756tQn7eTPhAKGUiznx0lrPSFt2/Me5pb8t
vz2TxEqNhQnt45rNibsTC/9BIlKyez9GqCe5Wl4UdP6EY+0K0GLKCgyrRfeqZfpa
B42e92L581bPM5ha6Q9FZygpCXP/oQ2jaQ5316bN6qpqKJAZ5rin82ttIFkmmgD9
/wuJIThSwUoIa3133NWG2FuBqwHGUNqte2e9HDL0c/fZ4c/HdI4EQi8IWrNMZRae
q6mWoSi9VrcN48qK+FH++SgjZgdJn2VZ96FoA1LyYJg6jwPnsdq3MVJokm67omSl
T2EmrEmgzRjcVNtAaFomRYClbg5cstTNyNysTisUEweDDnVhCPU=
=jwTz
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
