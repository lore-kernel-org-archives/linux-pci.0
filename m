Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=140.211.166.183
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430841;
	b=3o4FRZ1bZ104G41gkBzKoICGOnR6Hwgo1YvyFUsyhxSZuGkp8PLg3WH+TzlaxCfT00Y3
	 PnOcZVRBILuHDa1ZRua7q8zD6qt8B8lOgL6kpgT/25KW/1Ic6NAV9ZMv8VESH+HkGOSZQ
	 2+ccjX3gAWziWGBiwfYMyv3h39Pn8F4vkYespEJUzPOsJZ56KdskEJTzCkjSOuBy7JZe3
	 Rw6ZkyJphO0QljeY35IdPJF0N53DdFqQ1t6/W7b/c7rspAJGvkkC5Xkueprxp9lmiMMJo
	 A6IuTe/pX/QBTTMkOKoqg2VcT1dijAuvQc/XN6pX/oO5nP3rd4uRKnEPPUzqHe/xKAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430841;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:User-Agent:MIME-Version;
	bh=I/oiiX03qNL53Uv9fPTsL/AAOaoF5LyQFc02hL+26Js=;
	b=5PGP/l4FBxxq6fb8ZCJaUQWL4R7fU18p+l5/OHDL8MBB8pMxjjgctwmivr4HT/hGf6MU
	 XV1pulIGaXRjxwaas0y00jMQPckYP+XG1X4ER633tJabDROW8RCSWDx0JaKNEzKNi54uc
	 zg+4eZVMGoiH1Dox9N2e4ttBT1lZSFyuYCTPZRwC+ukkZMB25MHe5eWFB7wO1KUEZ9V49
	 rpeXG9Ikg/xHS3aGu2L7KvLiqgymlmHd+R2v7fEdetmJClG5kQmkFH3wcLawz3LMYYmvq
	 7HP6sCNw86sPLergGEakdYrqdklfZ34/nYpkv1FnsUdp8HUwqpFHWC84aZtlLMTLkMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentoo.org;
	spf=pass smtp.mailfrom=gentoo.org;
	arc=none smtp.remote-ip=140.211.166.183
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C22606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 10:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from 6.1.6.a.a.4.0.0.3.b.d.7.8.f.c.9.c.6.e.0.c.6.2.0.0.b.8.0.1.0.0.2.ip6.arpa (unknown [IPv6:2001:8b0:26c:e6c:9cf8:7db3:4a:a616])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: chewi)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BEE2F342BA3;
	Mon, 23 Nov 2026 10:47:18 +0000 (UTC)
Message-ID: <39bd808037e8eed09e40f7731a41e71e58d10070.camel@gentoo.org>
Subject: Re: PCI: dw-rockchip: Unable to boot Quartz64 Model B from NVMe
 since reset changes
From: James Le Cuirot <chewi@gentoo.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>, Manivannan Sadhasivam	
 <manivannan.sadhasivam@oss.qualcomm.com>, Bjorn Helgaas
 <bhelgaas@google.com>, 	linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Shawn Lin	 <shawn.lin@rock-chips.com>
Date: Mon, 23 Nov 2026 10:47:03 +0000
In-Reply-To: <av7Vvw5CpQo0gt1d@ryzen>
References: <08cc96c5171fc969b074371692e6d95d46eba60b.camel@gentoo.org>
	 <av7Vvw5CpQo0gt1d@ryzen>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-zwn4MhrHzB+5uyxiHqhx"
User-Agent: Evolution 3.60.2 
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-zwn4MhrHzB+5uyxiHqhx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-11-19 at 11:55 +0100, Niklas Cassel wrote:
> On Wed, Nov 18, 2026 at 04:03:11PM +0000, James Le Cuirot wrote:
> > Hello Wilfred,
> >=20
> > Unfortunately, since your commit "PCI: dw-rockchip: Implement
> > .reset_root_port() and use for link down" (b376b3ff9cb0527), I have bee=
n
> > basically unable to boot my Quartz64 Model B from NVMe. Sometimes if I =
wait
> > long enough, it will eventually work, albeit very slowly. If I revert t=
his
> > (and 4e9f69d08253) against 7.3.5, then it boots normally. Here is the r=
elevant
> > output.
> >=20
> > rockchip-dw-pcie 3c0000000.pcie: host bridge /pcie@fe260000 ranges:
> > rockchip-dw-pcie 3c0000000.pcie:       IO 0x00f4100000..0x00f41fffff ->=
 0x00f4100000
> > rockchip-dw-pcie 3c0000000.pcie:      MEM 0x00f4200000..0x00f5ffffff ->=
 0x00f4200000
> > rockchip-dw-pcie 3c0000000.pcie:      MEM 0x0300000000..0x033fffffff ->=
 0x0300000000
> > rockchip-dw-pcie 3c0000000.pcie: iATU: unroll T, 8 ob, 8 ib, align 64K,=
 limit 8G
> > rockchip-dw-pcie 3c0000000.pcie: PCIe Gen.2 x1 link up
>=20
> Here the link is reported as being up, at Gen2 speed.
>=20
>=20
> > rockchip-dw-pcie 3c0000000.pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-0f]
> > pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0=
xf4100000-0xf41fffff])
> > pci_bus 0000:00: root bus resource [mem 0xf4200000-0xf5ffffff]
> > pci_bus 0000:00: root bus resource [mem 0x300000000-0x33fffffff]
> > pci 0000:00:00.0: [1d87:3566] type 01 class 0x060400 PCIe Root Port
> > pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
> > pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref=
]
> > pci 0000:00:00.0: supports D1 D2
> > pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> > pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-0f]=
 (conflicts with (null) [bus 00-0f])
> > pci 0000:01:00.0: [1e0f:0009] type 00 class 0x010802 PCIe Endpoint
> > pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
> > pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 G=
T/s PCIe x1 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe=
 x4 link)
> > pci 0000:01:00.0: ASPM: default states L1
> > pci 0000:00:00.0: bridge window [mem 0xf4200000-0xf42fffff]: assigned
> > pci 0000:00:00.0: ROM [mem 0xf4300000-0xf430ffff pref]: assigned
> > pci 0000:01:00.0: BAR 0 [mem 0xf4200000-0xf4203fff 64bit]: assigned
> > pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> > pci 0000:00:00.0:   bridge window [mem 0xf4200000-0xf42fffff]
> > pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
> > pci_bus 0000:00: resource 5 [mem 0xf4200000-0xf5ffffff]
> > pci_bus 0000:00: resource 6 [mem 0x300000000-0x33fffffff]
> > pci_bus 0000:01: resource 1 [mem 0xf4200000-0xf42fffff]
> > pcieport 0000:00:00.0: PME: Signaling with IRQ 86
> > pcieport 0000:00:00.0: AER: enabled with IRQ 95
> > pcieport 0000:00:00.0: Recovering Root Port due to Link Down
>=20
> Here you get a link down IRQ.
>=20
> Why is the link going down?
>=20
> You seem to have already trained in Gen2, and your board seems to only
> support Gen2 (so even if it was related to speed change - normally a
> speed should not trigger a link down - a speed change does not seem to
> happen here).
>=20
>=20
> Perhaps you can enable CONFIG_PCIE_DW_DEBUGFS and then look at
> /sys/kernel/debug/dwc_pcie_<dev>/
> to try to see if that gives any more information about why the link goes =
down.

Gave that a try but it revealed nothing. All the counter values were 0.

> Like Wilfred said, you could also try to disable ASPM.

Tried that. No difference, unfortunately.

> Also make sure that your device is attached to the slot properly (and
> hopefully you are not using any extender cables or similar).

Actually, I am using an extender, but only because it's practically impossi=
ble
not to with this board. The slot is positioned on the edge of the board,
pointing *outwards*. This does get joked about. However, it's worked perfec=
tly
fine like this for years until now.

> I guess we could also try to clear the interrupt just before unmasking it=
,
> to see if this is a spurious interrupt, something like:
>=20
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -692,7 +692,7 @@ static int rockchip_pcie_configure_rc(struct platform=
_device *pdev,
>         struct device *dev =3D &pdev->dev;
>         struct dw_pcie_rp *pp;
>         int irq, ret;
> -       u32 val;
> +       u32 reg, val;
>=20
>         if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
>                 return -ENODEV;
> @@ -739,6 +739,9 @@ static int rockchip_pcie_configure_rc(struct platform=
_device *pdev,
>                 return ret;
>         }
>=20
> +       reg =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS=
_MISC);
> +       rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_M=
ISC);
> +
>         /* unmask hot reset/link-down reset */
>         val =3D FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
>         rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MIS=
C);

The good news is that this worked! :) Please go ahead and commit it if you
believe it makes sense.

--=-zwn4MhrHzB+5uyxiHqhx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEDBAAWCgCrFiEE6qETVs4yu3Lfuc3XsNCJZ6jP87QFAmsEGbEbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRFQUExMTM1NkNFMzJCQjcyREZCOUNE
RDdCMEQwODk2N0E4Q0ZGM0I0ERxjaGV3aUBnZW50b28ub3JnAAoJELDQiWeoz/O0
S0oBAJL1uYNumrFXENhHAHLjXAjyueiaq2OQXs2HpV1F3d21AQDGNCfYDTDW3HV4
Wwe4cm/J8qVTPQfEi1K+i76PODvgDg==
=urbL
-----END PGP SIGNATURE-----

--=-zwn4MhrHzB+5uyxiHqhx--
