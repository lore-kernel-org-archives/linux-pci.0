Received: from mail-244116.protonmail.ch (mail-244116.protonmail.ch [109.224.244.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87681F5825
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122260; cv=none; b=o2TJF5jDPGzE5pIH/Q1/gJxzxtxleWUBer9GsryZEEgtnBMy1M9OSUqA+UveezhxSebVuRBFT3ye+mE15XRMT3RtskOaagfc4Y+J5/lAAZCB6g1UolGR82rrnB+BfsvczIDzpjFche6E2T8gVFVHaxhtSV6Kwbw31FoGBnjT/HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122260; c=relaxed/simple;
	bh=achqBSDLTbG7ys9axw9+AqXqOsnM37AE7sOtn/+zDyI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cQy1R0/88VJ7PSylwKC3E22tAGRJKx4cB5vt5VoZ0VelH/TCo63Ym6HTRUAKWSap1KcvuPEZQAGLMxecit+u6TirC73Z0rZuXsSmILoxZVmIIb/8iP9tDhsuOsLv1DfsiQMIXwJlBCl6nNqFAp5njjkuToVxEcHtQGkGUCt0k5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=S+xGxBKl; arc=none smtp.client-ip=109.224.244.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="S+xGxBKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790122255; x=1790381455;
	bh=8Y9YIRMA/aNqzz8j7tnX4LACjbsTyfhJDnCkbsQY3r0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=S+xGxBKlSxOZ+/Tal2aI2zTaF20nMS+pR/2XDu3LidipckeZcL++k4UhbktFpW7Ps
	 NmjR6biFRb3JzbVYGtIHwbSlACj4WcdGoBDk3iZq2QVl/rDZo1K9adFthzuz7nFcb7
	 +KWcJ7tzg71edzHEC82hsdyfbsjlCayLvm5d3cnG3JWfWPwkmQkJ2ZLjhlb4UA8dJf
	 bqVVEJejINaXJ5NX4EGZenBA9u/TmpdBxtKLTt9bnMw4NPDyXoQLHenGaJg+2rRGHm
	 rK3VX1PGsEJuAeJFP+DMeW1wI8AeedeVfjfmAadMBUYdRzni2zONhMmlOdw2WAviN+
	 wxdfcEgTjlkOQ==
Date: Wed, 23 Sep 2026 00:10:51 +0000
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: "mani@kernel.org" <mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me>
In-Reply-To: <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me> <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 7695b5694f43d1f15643b036999988c94dcea520
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Qiang and Konrad,

Thank you, that was exactly what was missing. With your interrupts and with=
out msi-map, the NVMe behind the USB4 tunnel now gets real MSI-X at EL1. My=
 LaCie external SSD reads at about 2.6 GB/s and writes at 2.8 GB/s (16 GiB =
direct I/O on ext4), and safe removal and reconnect work repeatedly.

Two details were needed on top of the DT. The DBI MSI registers (0x820 to 0=
x830) had to be programmed after the tunnel BCR reset and the router reset =
requests, and MSI on the root port itself had to be opted out.

How would you like this to go upstream? Konrad mentioned that the Qualcomm =
USB4 router driver will be posted, so I've added him here. I'm happy to sen=
d the pcie0 interrupt setup as a patch, or leave it to that series if you'd=
 rather carry it there.

Konrad, I'd be glad to test the router driver on the Yoga Slim 7x as soon a=
s it's posted and report back with a Tested-by. Two things I've seen may ma=
tter for it. Now and then the PMIC firmware misses the cable e-marker at at=
tach (CCSts=3D2, PwrSts=3D1C, no VCONN), so the port stays in USB3 and neve=
r enters USB4 until a replug. And the PS8830 on the Yoga works in USB4 mode=
, while Jens Glathe's ps883x series from July would set parade,disable-usb4=
 on the Yoga.

Thanks again,
Birk


On Monday, September 21st, 2026 at 14:32, Qiang Yu <qiang.yu@oss.qualcomm.c=
om> wrote:

> On Sat, Sep 19, 2026 at 08:33:20PM +0000, Birk Skyum wrote:
> > Hi Mani,
> >
> > I'm working on experimental USB4 support for the Lenovo Yoga Slim 7x
> > (83ED, X1E80100), building on Jim Martin's published Glymur stack. This=
 is
> > an out-of-tree bring-up, not a regression report against mainline.
> >
> > A directly connected LaCie Rugged SSD4 negotiates USB4, enumerates thro=
ugh
> > a PCIe tunnel and completes a 4096-byte read into RAM. However, NVMe
> > completions are recovered through timeout polling, with zero
> > device-generated interrupts recorded.
> >
> > MSI-X is enabled and unmasked, and the table matches Linux's programmed
> > messages. Software ITS INT commands reach the NVMe handlers. In a
> > separate test, redirecting one MSI-X vector to owned coherent RAM
> > captured the expected endpoint payload, but that does not prove deliver=
y
> > to the ITS.
> >
> > The endpoint RID is 0x0100. The captured firmware IORT and our DT agree
> > on DeviceID 0x80100, with MSI address 0x17050040 and event data 0/1. Th=
e
> > PCIe SMMU remains firmware-owned.
> >
> > Source and test results are published here:
> > https://github.com/birkskyum/yoga-slim7x-usb4
> >
> > Is direct ITS delivery the intended route for USB4 PCI0 under EL1/Gunya=
h?
> > Is additional controller forwarding or DeviceID setup required?
> >
> > I also found the QCS8550 change using the internal DWC MSI receiver to
> > avoid a Gunyah limitation:
> > https://github.com/torvalds/linux/commit/33cae252054a694269f9dcd41b3540=
63193c8f59
> >
> > I realise that involves different hardware and symptoms. If an internal
> > receiver is appropriate for X1 PCI0, where can I find its parent IRQ an=
d
> > required initialization?
> >
>=20
> Hi Birk,
>=20
> Please add below dts change in pcie0 dts node and also remove msi-map if =
you added,
>=20
> interrupts =3D <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>,
>              <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> interrupt-names =3D "msi0",
>                   "msi1",
>                   "msi2",
>                   "msi3",
>                   "msi4",
>                   "msi5",
>                   "msi6",
>                   "msi7",
>                   "global";
>=20
> #interrupt-cells =3D <1>;
> interrupt-map-mask =3D <0 0 0 0x7>;
> interrupt-map =3D <0 0 0 1 &intc 0 0 GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH>,
>                 <0 0 0 2 &intc 0 0 GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH>,
>                 <0 0 0 3 &intc 0 0 GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>,
>                 <0 0 0 4 &intc 0 0 GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH>;
>=20
> - Qiang Yu
> 
