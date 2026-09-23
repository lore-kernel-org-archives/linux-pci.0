Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFB53B840B;
	Wed, 23 Sep 2026 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135977; cv=none; b=ZKv5mNNK7hctVqax3X9XZYZQrAnkU5jJEY7vSbu3WNjN/iOJLfbA5gRN16Kzhp6k/yQdBzY8AFGB7WXCXOL4fpU4iBgUqOm70K0Nhi9Cfr73vKldGgEHao9+T381FUq1QHna5D1emy3wdi60DfLyAjl7Sjlj32btAchYyNY+AI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135977; c=relaxed/simple;
	bh=YXd2CoAUdAnBNgNQIDgFXd87SkNp2ShWIQJZJksV0ss=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcQsWhmbIgcfOpDWRRV5kxNJMnFZu4d/fY6z/mSZm4vio2heNKJXuyKPiBhFRIdnpF3Etb/AeewJn9GorBjlVRSgsHlqQZy9A3isd3cDNv3M3WMpx2acTXNenWhc7t90ZfuxuDv8Pp5hey2N9jft6q2hqFI1Bg7fq02R2+hzuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=B1k5Rm01; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="B1k5Rm01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790135958; x=1790395158;
	bh=SL/u2kwcZ0c5sE7eHjcS13950bnEfycQxOnZ5S8EQwo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=B1k5Rm01TS/OGX9JpNuG/hrykisSEN2030hrPpES7Oiv2bAP7t4RD0PlastUU0qZh
	 OE9Y7lp+S8y8ExPOmgoJ5/VEBLJheDTo6q9I+gSYv2tXt48H4d37+DsKK0i+YguTce
	 5Y8ZNW2jfHsggTrbSowrEdq5EmXi8wmESMK3P5Tf2baW0GJUkNrQC8AyY0zWLVB6q6
	 oOjAqthn3mKvQhLcSARkwnnRULEst6gC5EwYSJTyQ5/WyRcLGqUOA2oHc15mV/LzYi
	 SG/q75epKHOKI2P9z0CDoWInca+kRE1+mzNMiTb/6JtoOXWY/Rcvr8c0CGkRLkScb0
	 +DnQ63RcxZsKw==
Date: Wed, 23 Sep 2026 03:59:16 +0000
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: "mani@kernel.org" <mani@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <7PyP8TPDWSo4VXsNVgDQREx6MqiqQWWL_BsssgI4SBuA9jkR707AGw5AVnm6k1OgH6F2n6Y6QAxah6ZRtKpjZfIKOiOngog3eeLFXIXXf44=@pm.me>
In-Reply-To: <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me> <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com> <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 4194eb41cbbe7e32e0b8860b26e5396ae742a885
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Qiang and Konrad,

Two questions, if you have the answers at hand.

The first is about power. After we stop the USB4 router (MCU stopped, the e=
leven USB4_0 MISC resets asserted, PHY off, clocks and interconnect votes r=
eleased), gcc_usb4_0_gdsc can be switched off, but it never powers on again=
, and the GDSC driver reports "gcc_usb4_0_gdsc status stuck at 'off'". This=
 happens even after a completely clean stop with no USB4 device ever connec=
ted. While the GDSC is off, the USB4_0 PCIe pipe mux at GCC offset 0x9f104 =
reads as selecting the PHY source and ignores writes, while the DP0 and DP1=
 muxes do switch to XO. As long as we never let the GDSC turn off, stopping=
 and restarting the router works every time.

What does gcc_usb4_0_gdsc need in order to power on again? For example a cl=
ock that has to be running or parked on XO, a reset that has to be released=
 first, or the PHY providing its pipe clock. Or is it meant to stay on whil=
e the system runs? We would like to power the router down when nothing is c=
onnected and across suspend, and this is the last missing piece for sleep s=
upport.

The second is about the other two ports. The Yoga Slim 7x has three USB4 po=
rts, and so far only the one behind PCI0 works, thanks to your interrupt li=
st. Could you share the same assignment for PCI1 and PCI2, the eight DWC MS=
I interrupts plus the global one? I have everything else for those two cont=
rollers from the ACPI tables, including their INTx lines, but the MSI lines=
 are not listed anywhere, since Windows routes MSI through the ITS.

And one for Konrad as well. Will the USB4 router firmware go into linux-fir=
mware? The router needs it at startup, so without it no distribution can tu=
rn USB4 on out of the box.

Thanks,
Birk



On Wednesday, September 23rd, 2026 at 02:10, Birk Skyum <birk.skyum@pm.me> =
wrote:

>=20
> Hi Qiang and Konrad,
>=20
> Thank you, that was exactly what was missing. With your interrupts and wi=
thout msi-map, the NVMe behind the USB4 tunnel now gets real MSI-X at EL1. =
My LaCie external SSD reads at about 2.6 GB/s and writes at 2.8 GB/s (16 Gi=
B direct I/O on ext4), and safe removal and reconnect work repeatedly.
>=20
> Two details were needed on top of the DT. The DBI MSI registers (0x820 to=
 0x830) had to be programmed after the tunnel BCR reset and the router rese=
t requests, and MSI on the root port itself had to be opted out.
>=20
> How would you like this to go upstream? Konrad mentioned that the Qualcom=
m USB4 router driver will be posted, so I've added him here. I'm happy to s=
end the pcie0 interrupt setup as a patch, or leave it to that series if you=
'd rather carry it there.
>=20
> Konrad, I'd be glad to test the router driver on the Yoga Slim 7x as soon=
 as it's posted and report back with a Tested-by. Two things I've seen may =
matter for it. Now and then the PMIC firmware misses the cable e-marker at =
attach (CCSts=3D2, PwrSts=3D1C, no VCONN), so the port stays in USB3 and ne=
ver enters USB4 until a replug. And the PS8830 on the Yoga works in USB4 mo=
de, while Jens Glathe's ps883x series from July would set parade,disable-us=
b4 on the Yoga.
>=20
> Thanks again,
> Birk
>=20
>=20
> On Monday, September 21st, 2026 at 14:32, Qiang Yu <qiang.yu@oss.qualcomm=
.com> wrote:
>=20
> > On Sat, Sep 19, 2026 at 08:33:20PM +0000, Birk Skyum wrote:
> > > Hi Mani,
> > >
> > > I'm working on experimental USB4 support for the Lenovo Yoga Slim 7x
> > > (83ED, X1E80100), building on Jim Martin's published Glymur stack. Th=
is is
> > > an out-of-tree bring-up, not a regression report against mainline.
> > >
> > > A directly connected LaCie Rugged SSD4 negotiates USB4, enumerates th=
rough
> > > a PCIe tunnel and completes a 4096-byte read into RAM. However, NVMe
> > > completions are recovered through timeout polling, with zero
> > > device-generated interrupts recorded.
> > >
> > > MSI-X is enabled and unmasked, and the table matches Linux's programm=
ed
> > > messages. Software ITS INT commands reach the NVMe handlers. In a
> > > separate test, redirecting one MSI-X vector to owned coherent RAM
> > > captured the expected endpoint payload, but that does not prove deliv=
ery
> > > to the ITS.
> > >
> > > The endpoint RID is 0x0100. The captured firmware IORT and our DT agr=
ee
> > > on DeviceID 0x80100, with MSI address 0x17050040 and event data 0/1. =
The
> > > PCIe SMMU remains firmware-owned.
> > >
> > > Source and test results are published here:
> > > https://github.com/birkskyum/yoga-slim7x-usb4
> > >
> > > Is direct ITS delivery the intended route for USB4 PCI0 under EL1/Gun=
yah?
> > > Is additional controller forwarding or DeviceID setup required?
> > >
> > > I also found the QCS8550 change using the internal DWC MSI receiver t=
o
> > > avoid a Gunyah limitation:
> > > https://github.com/torvalds/linux/commit/33cae252054a694269f9dcd41b35=
4063193c8f59
> > >
> > > I realise that involves different hardware and symptoms. If an intern=
al
> > > receiver is appropriate for X1 PCI0, where can I find its parent IRQ =
and
> > > required initialization?
> > >
> >
> > Hi Birk,
> >
> > Please add below dts change in pcie0 dts node and also remove msi-map i=
f you added,
> >
> > interrupts =3D <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH>,
> >              <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
> > interrupt-names =3D "msi0",
> >                   "msi1",
> >                   "msi2",
> >                   "msi3",
> >                   "msi4",
> >                   "msi5",
> >                   "msi6",
> >                   "msi7",
> >                   "global";
> >
> > #interrupt-cells =3D <1>;
> > interrupt-map-mask =3D <0 0 0 0x7>;
> > interrupt-map =3D <0 0 0 1 &intc 0 0 GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH>,
> >                 <0 0 0 2 &intc 0 0 GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH>,
> >                 <0 0 0 3 &intc 0 0 GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>,
> >                 <0 0 0 4 &intc 0 0 GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH>;
> >
> > - Qiang Yu
> >
