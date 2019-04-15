Return-Path: <SRS0=Mgic=SR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33389C10F12
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D3A217D6
	for <linux-pci@archiver.kernel.org>; Mon, 15 Apr 2019 15:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm5k2ruH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfDOPIY (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:08:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51863 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfDOPIY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Apr 2019 11:08:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so21117527wmf.1;
        Mon, 15 Apr 2019 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pBr276DhLsncYgBcXxlLSpLKxbJGdZNzr21R3COQ9J4=;
        b=jm5k2ruHZytJhsJoC01MKBXnNRN6423J0GNM+yA0r30WzkIdGawrUBKr4N+WBif4Wu
         SqKPET4kq5iIKCBDFHkKgbOY9puJws2C05rnVm1BM9z7jVjZXSO2q/nxbK+VW7PKtxr1
         fKXr10Jakf90YNg8l0azBA01tG75lHtCP2GgT4U1dUCm7vZymCbN/l5LycOoj1UtnIlD
         HtUeGIJY36pgZgmxVqD11ZOlsgN3RNZD+HwOlVQEAouC5HAG5pV+lSPA+rkNPwRcEbV/
         sEzE0bIrRkVScjNa0RycYCoJtpOSYZzOo3dJqW/SIzXZBmmSXiLPoxOltwnlz4xyNG3O
         yLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pBr276DhLsncYgBcXxlLSpLKxbJGdZNzr21R3COQ9J4=;
        b=YGFGN9L3+rZGMC3Xao3MKOCGuIgYNmUaT7XpkrvLkf5m2iyJBUW5+Mhehph7wey1vt
         Vh1xmo3MDtZ0vSDaO4ykj+b4nPoodJ/gpxU4nrzZWYnzWT+6Te9kDlFdSruiwW8fBl6/
         u2lsYw1LJmkOfGHjBYFMAC1W2LxBn3e0AphK3p1kXxbIFNPveU09XeYbjydm5RMPLUJ+
         pRu1kj521b0EKOK6ShVRUbMQh6AnOlb8YOdK1k6t/d/eZMz016iO0rEbg0lZ67K+Xq36
         RptmK1hrwdElaor+rpYZ5IEVY8yPPl4k0oHC1gGgiEUaj9e9LvhtRCDkkigLAmQxFC1+
         5fJg==
X-Gm-Message-State: APjAAAVoUUOKafDTtS6/OdGt7gexmpR2lCxp2/D3eylxeuwg9MlKXdEq
        4THwFl3Usv5bBH2mgmAdPgY=
X-Google-Smtp-Source: APXvYqx8Te9XvM1zSolusTjZ8iQH1+oswHmHHFiCwqMm2xNVpmC7DK1wxBwgzQITYTTRhT8SvYf3iQ==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr21519808wmq.96.1555340901383;
        Mon, 15 Apr 2019 08:08:21 -0700 (PDT)
Received: from localhost (p2E5BE61D.dip0.t-ipconnect.de. [46.91.230.29])
        by smtp.gmail.com with ESMTPSA id s1sm40927025wrt.43.2019.04.15.08.08.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 08:08:20 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:08:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        jonathanh@nvidia.com, kishon@ti.com, catalin.marinas@arm.com,
        will.deacon@arm.com, lorenzo.pieralisi@arm.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 10/16] dt-bindings: PCI: tegra: Add device tree
 support for T194
Message-ID: <20190415150819.GG29254@ulmo>
References: <1554407683-31580-1-git-send-email-vidyas@nvidia.com>
 <1554407683-31580-11-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M8g8Xvd1npd+rU3W"
Content-Disposition: inline
In-Reply-To: <1554407683-31580-11-git-send-email-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--M8g8Xvd1npd+rU3W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:24:37AM +0530, Vidya Sagar wrote:
> Add support for Tegra194 PCIe controllers. These controllers are based
> on Synopsys DesignWare core IP.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v1]:
> * Added documentation for 'power-domains' property
> * Removed 'window1' and 'window2' properties
> * Removed '_clk' and '_rst' from clock and reset names
> * Dropped 'pcie' from phy-names
> * Added entry for BPMP-FW handle
> * Removed offsets for some of the registers and added them in code and wo=
uld be pickedup based on
>   controller ID
> * Changed 'nvidia,max-speed' to 'max-link-speed' and is made as an option=
al
> * Changed 'nvidia,disable-clock-request' to 'supports-clkreq' with invert=
ed operation
> * Added more documentation for 'nvidia,update-fc-fixup' property
> * Removed 'nvidia,enable-power-down' and 'nvidia,plat-gpios' properties
> * Added '-us' to all properties that represent time in microseconds
> * Moved P2U documentation to a separate file
>=20
>  .../bindings/pci/nvidia,tegra194-pcie.txt          | 181 +++++++++++++++=
++++++
>  1 file changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194=
-pcie.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.t=
xt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> new file mode 100644
> index 000000000000..71aa01b6ccf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> @@ -0,0 +1,181 @@
> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.t=
xt.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> +- device_type: Must be "pci"
> +- power-domains: A phandle to the node that controls power to the respec=
tive
> +  PCIe controller and a specifier name for the PCIe controller. Followin=
g are
> +  the specifiers for the different PCIe controllers
> +  - Controller-0 - TEGRA194_POWER_DOMAIN_PCIEX8B
> +  - Controller-1 - TEGRA194_POWER_DOMAIN_PCIEX1A
> +  - Controller-2 - TEGRA194_POWER_DOMAIN_PCIEX1A
> +  - Controller-3 - TEGRA194_POWER_DOMAIN_PCIEX1A
> +  - Controller-4 - TEGRA194_POWER_DOMAIN_PCIEX4A
> +  - Controller-5 - TEGRA194_POWER_DOMAIN_PCIEX8A

I'm not sure if I missed it, but is there an include file that contains
definitions for these symbolic names? Might be worth referring to such
an include from this document.

Also, why do we have two different ways of specifying the controllers?
Why are they called Controller-* in one place and PCIEX* in another? Can
we just pick one and stick with it?

> +- reg: A list of physical base address and length for each set of contro=
ller
> +  registers. Must contain an entry for each entry in the reg-names prope=
rty.
> +- reg-names: Must include the following entries:
> +  "appl": Controller's application logic registers
> +  "config": As per the definition in designware-pcie.txt
> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Ad=
dress
> +             Translation Unit) registers of the PCIe core are made avail=
able
> +             fow SW access.
> +  "dbi": The aperture where root port's own configuration registers are
> +         available
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
> +  - core
> +- resets: Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - core_apb
> +  - core
> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
> +- phy-names: Must include an entry for each active lane.
> +  "p2u-N": where N ranges from 0 to one less than the total number of la=
nes
> +- nvidia,bpmp: Must contain a phandle to BPMP controller node.
> +- nvidia,controller-id : Controller specific ID
> +      0 - C0
> +      1 - C1
> +      2 - C2
> +      3 - C3
> +      4 - C4
> +      5 - C5

Again, here you use a different name to refer to the controllers than
before, although it's fairly obvious that these correspond to the
earlier Controller-*. But best to pick one and stick with it.

Also, the list for the power-domains property has description - value,
whereas you have value - description here. Since eventually the device
tree bindings will be converted to YAML, perhaps stick with:

    value: description

To help with a subsequent conversion.

> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> +
> +Optional properties:
> +- max-link-speed: Limits controllers max speed to this value. For more i=
nfo,
> +    please refer to Documentation/devicetree/bindings/pci/pci.txt file.
> +- nvidia,init-speed: Limits controllers init speed to this value.
> +    1 - Gen-1 (2. 5 GT/s)
> +    2 - Gen-2 (5 GT/s)
> +    3 - Gen-3 (8 GT/s)
> +    4 - Gen-4 (16 GT/s)

Please provide a description for when to use this and what the effects
are. "Limits controller's init speed" doesn't say anything about whether
the speed can be increased later, or whether it will always stay at this
speed. Also, does it actually mean "set" the initial speed, or would the
controller also be able to start out at a lower speed than the one given
by "nvidia,init-speed"? "Limits" would suggest the latter, but best to
clarify.

> +- nvidia,disable-aspm-states : Controls advertisement of ASPM states
> +    bit-0 to '1' : Disables advertisement of ASPM-L0s
> +    bit-1 to '1' : Disables advertisement of ASPM-L1. This also disables
> +                   advertisement of ASPM-L1.1 and ASPM-L1.2
> +    bit-2 to '1' : Disables advertisement of ASPM-L1.1
> +    bit-3 to '1' : Disables advertisement of ASPM-L1.2
> +- supports-clkreq : Refer to Documentation/devicetree/bindings/pci/pci.t=
xt
> +- nvidia,update-fc-fixup : This is a boolean property and needs to be pr=
esent to
> +    improve perf when a platform is designed in such a way that it satis=
fies at
> +    least one of the following conditions thereby enabling root port to
> +    exchange optimum number of FC (Flow Control) credits with downstream=
 devices
> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and M=
PS)
> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths =
and
> +       a) speed is Gen-2 and MPS is 256B
> +       b) speed is >=3D Gen-3 with any MPS
> +- nvidia,cdm-check : Enables CDM checking. For more information, refer S=
ynopsis
> +    DesignWare Cores  PCI Express Controller Databook r4.90a Chapter S.4
> +- "nvidia,pex-wake" : Add PEX_WAKE gpio number to provide wake support.

If it's a GPIO number it should have a -gpio or -gpios suffix. I think
-gpios is preferred. Since the parent of the property is already a PEX
controller, perhaps omit the pex- prefix and just call this:

    "nvidia,wake-gpios"

?

Thierry

> +- "nvidia,aspm-cmrt-us" : Common Mode Restore time for proper operation =
of ASPM
> +   to be specified in microseconds
> +- "nvidia,aspm-pwr-on-t-us" : Power On time for proper operation of ASPM=
 to be
> +   specified in microseconds
> +- "nvidia,aspm-l0s-entrance-latency-us" : ASPM L0s entrance latency to be
> +   specified in microseconds
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
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +		reset-names =3D "core_apb", "core";
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
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;
> +		nvidia,controller-id =3D <0>;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000   =
   /* downstream I/O (1MB) */
> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non=
-prefetchable memory (30MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* pre=
fetchable memory (16GB) */
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
> +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3";
> +	};
> --=20
> 2.7.4
>=20

--M8g8Xvd1npd+rU3W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAly0nmEACgkQ3SOs138+
s6EH7Q//eHUrIuvTFE+YHMhzuGzhgU7aS7tqUDKG/VU7F9RdjffHLfKyKDl2I+Ww
naGpo3x7pE/VPp6bGLUEpubXODM1hrkQP27CaC+lzhpxN67Dg+2yWyUtQQbCf4ZO
N5o8lyImPrUgs0Wl0LdJeGoQYSxaZPsm+IbbED4KvOcEwAauZd6M/6ni/8mYLwyJ
InSfB5XhvHs2jrxvoNCB5WRjepbsNZudrrfXDDwbVXaTCYEhiel+cHe0XXfskdrV
MdCNfueN3KDRhEjz9HCvcF/DFbciycPfGhvkWc1nkU8Slc6l9q8yDxWKeHf4NuEC
MSCR3sBvwMezU23ozTcoHKD9TdM76IQXQREc4R2rFUFPdd3Wm+acODtlYTwrmElZ
aAmXDY/tEfa5CQYH5U+ze76ETgPlxz7M+CvZ2+kHHyxcp3N4xPvHFglzjQnaPIzt
AkW6CmVxdkRSDRc3FkKZvpgpq/nPeg3lMv82SZ76BRh3iR5Ex4KeIcRFWOs/iRL/
t5XIgRelwE+6BbXdYzVd9vKzu3Unad1rSBGjIzTszTTzPErjJeOYsO9PC6QqEn9g
sn44ZUgq1fR+8NGwzPTIEaQe9BDS9Tyc9lVujAlsYqWUDy8cYr0r0B968sIYT8hk
jC5YLul57j1bwryersis791WeonEA2/ITPa0vH6ecESEwMhb12Y=
=SjBv
-----END PGP SIGNATURE-----

--M8g8Xvd1npd+rU3W--
