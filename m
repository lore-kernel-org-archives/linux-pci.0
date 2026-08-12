Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02F36166A;
	Wed, 12 Aug 2026 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517665; cv=none; b=ZeWFFqFJHhk+/hXsJx2bE8JjIG1cyTI0Fq4BGAaUn3riByjy0nkJu+seqo6IHa2czBnZLZ4Ac9Crxgb9NeeWR3fY4Ck1Ip1KrSiNbBays+fpYfr7UmaWzKxwWt/RCT3upM/ndzhdXRan8jnFTQoPueSb1dSQEfmgoy13y7xa0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517665; c=relaxed/simple;
	bh=cgGjsx1To54vHWxSHVCbCt6UiwKkcdepoNf0HAf8E78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndkKcOMSZ6C56F02SZxoiw+MEbVT39w3DK6xOPxFcXkISd8AvOKdX+JlBsNgmqTdQNIPTIUo3V0/sk5ZQqrM6L6oN6DrlyBr2UIjoOyXlCgV/biKpltlMz7S6OOOWJBcGgnnFV+Adbi5saMupws6D//mRcaKApRJ8G0VhEtzKf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0QXGYR9X; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0QXGYR9X"
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DF5621F8D7;
	Wed, 12 Aug 2026 08:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1786517654;
	bh=K39uuHk/UNMQZhBdj5TasfypJyUYUsGh0yflU9COlDk=;
	h=Received:From:To:Subject;
	b=0QXGYR9XVy2tWfcdw0C2Imm7v+w5+A75aA0Iqha1YYOZTrrv/nIPiOLGIgD8lKxgg
	 teTdD1LVChyu+Nv3WjTM0GIy6e/MtU2YA3TyvLrOI3FT0TSEYcmDYb3qaIsmjnFXHm
	 kj6A2ehTMP1JL58s0DQX2U1FS4kJTzrAFQ8Br3KtKX7NSdahlTGLiIBJT1pUYlVqeQ
	 WfLX/CXkMD7FX5zvFomll+iKaom+4ZH4IpW4lVRrh4ECfEQncCwr3Pm+ePuPvc+nq3
	 94LWq627pKscK9iPabVWAX989jSdeawsFxzmiUJYZLKIigB18A5RsecIDB73PFR2xh
	 vjazWyZj6fZzA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 931E47FB68; Wed, 12 Aug 2026 08:54:13 +0200 (CEST)
Date: Wed, 12 Aug 2026 08:54:13 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	"Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>,
	Leonardo Costa <leoreis.costa@gmail.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Frank Li <frank.li@nxp.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"leonardo.costa@toradex.com" <leonardo.costa@toradex.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	Sherry Sun <sherry.sun@nxp.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Message-ID: <anwYlX0uC1nFCxnp@gaggiata.pivistrello.it>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
 <i6x6wpua7wlwmdq3hitoo53wkptgp62tvegmkabcru3d54eqg3@yk4eehwaarn2>
 <3hxiy6aaiagt5zunntpidaeqc4or4wrebf7mu7asvyyibqmvo2@xhvasdqp64rw>
 <GV2PR04MB12019BD5B14FA63CDFCC2015B8CDD2@GV2PR04MB12019.eurprd04.prod.outlook.com>
 <20260811063752.GA7332@francesco-nb>
 <GV2PR04MB12019BC21C743E1BEF1BE8F4C8CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB12019BC21C743E1BEF1BE8F4C8CDC2@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Wed, Aug 12, 2026 at 06:22:57AM +0000, Hongxing Zhu wrote:
> 
> NXP Confidential
> > -----Original Message-----
> > From: Francesco Dolcini <francesco@dolcini.it>
> > Sent: Tuesday, August 11, 2026 2:38 PM
> > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > Cc: Leonardo Costa <leoreis.costa@gmail.com>; Bjorn Helgaas
> > <helgaas@kernel.org>; robh@kernel.org; krzk+dt@kernel.org;
> > conor+dt@kernel.org; Frank Li <frank.li@nxp.com>; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; leonardo.costa@toradex.com;
> > devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > regressions@lists.linux.dev; Sherry Sun <sherry.sun@nxp.com>; Manivannan
> > Sadhasivam <mani@kernel.org>; Hongxing Zhu <hongxing.zhu@nxp.com>;
> > linux-pci@vger.kernel.org
> > Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
> >
> > On Tue, Aug 11, 2026 at 12:47:18AM +0000, Hongxing Zhu (OSS) wrote:
> > > > -----Original Message-----
> > > > From: Leonardo Costa <leoreis.costa@gmail.com>
> > > > Sent: Tuesday, August 11, 2026 2:26 AM
> > > > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > > > Cc: Bjorn Helgaas <helgaas@kernel.org>; robh@kernel.org;
> > > > krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li
> > > > krzk+<frank.li@nxp.com>;
> > > > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > > > leonardo.costa@toradex.com; devicetree@vger.kernel.org;
> > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> > > > kernel@vger.kernel.org; regressions@lists.linux.dev; Sherry Sun
> > > > <sherry.sun@nxp.com>; Manivannan Sadhasivam <mani@kernel.org>;
> > > > Hongxing Zhu <hongxing.zhu@nxp.com>; linux-pci@vger.kernel.org
> > > > Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer
> > > > boots
> > > >
> > > > On Thu, Jul 16, 2026 at 02:09:19PM -0300, Leonardo Costa wrote:
> > > > > On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
> > > > > > Hi Leonardo,
> > > > > >
> > > > > > Would you be able to test this patch on your affected boards?
> > > > > > Your testing would help expedite the merge process and ensure
> > > > > > the fix resolves the boot issue you're experiencing.
> > > > > >
> > > > > > Best Regards
> > > > > > Richard Zhu
> > > > >
> > > > > Hi Richard,
> > > > >
> > > > > Sorry for taking long to respond, I was caught up with something.
> > > > > I tested the patch and it solved the issue. I sent a Tested-by tag there.
> > > > > Thanks for looking into this!
> > > > >
> > > > > Best Regards
> > > > > Leonardo
> > > >
> > > > Hi Richard,
> > > >
> > > > That patch might have introduced/exposed a second regression where
> > > > PCI devices are not linked properly during the initialization. Sorry
> > > > for not catching this before, as I didn't have any device connected during
> > the previous test.
> > > Hi Leonardo:
> > > Sorry to hear about that.
> > > I did test commit 7678e81498e2 with one Intel NIC (82574L) connected,
> > > and I've double-checked today based on v7.2-rc7. The PCIe link can be
> > > set up properly on the i.MX6Q Sabresd board in my testing.
> > >
> > > Here are the logs:
> > > root@imx6qpdlsolox:~# lspci
> > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
> > > Connection root@imx6qpdlsolox:~# uname -a Linux imx6qpdlsolox
> > > 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l GNU/Linux
> > > root@imx6qpdlsolox:~# dmesg | grep pci
> > > [    0.256138] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
> > > [    0.256307] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff ->
> > 0x0000000000
> > > [    0.256339] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -
> > > 0x0001000000
> > > [    0.256434] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu
> > 0x01f00000
> > > [    0.458388] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K,
> > limit 4G
> > > [    0.458492] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
> > > [    0.555294] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
> > > [    0.555783] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> > > ...
> > >
> > > The following endpoint devices also yielded the same results.
> > > root@imx6qpdlsolox:~# lspci
> > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network
> > > Adapter (PCI-Express) (rev 01) root@imx6qpdlsolox:~# uname -a Linux
> > > imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l
> > > GNU/Linux ...
> > >
> > > root@imx6qpdlsolox:~# lspci
> > > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > > 01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host
> > > Controller (rev 04) root@imx6qpdlsolox:~# uname -a Linux imx6qpdlsolox
> > > 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l GNU/Linux
> > >
> > > Could you provide more details of your hardware setup (board,
> > > connected devices, PERST# present or not)?
> > > This may help us identify if there's a specific scenario that triggers
> > > the regression you're experiencing.
> >
> > It's an apalis imx6, as reported already in this email thread.
> > The DT is in Linux, you can check
> > arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts every details about
> > PERST# and more.
> >
> > This is the device connected:
> >
> > 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> > 01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial
> > ATA Controller (rev 02)
> >
> > 01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial
> > ATA Controller (rev 02) (prog-if 01 [AHCI 1.0])
> >       Subsystem: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA
> > Controller
> >       Flags: bus master, fast devsel, latency 0, IRQ 308
> >       I/O ports at 1020 [size=8]
> >       I/O ports at 1030 [size=4]
> >       I/O ports at 1028 [size=8]
> >       I/O ports at 1034 [size=4]
> >       I/O ports at 1000 [size=32]
> >       Memory at 01100000 (32-bit, non-prefetchable) [size=512]
> >       Expansion ROM at 01200000 [virtual] [disabled] [size=64K]
> >       Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
> >       Capabilities: [78] Power Management version 3
> >       Capabilities: [80] Express Legacy Endpoint, IntMsgNum 0
> >       Capabilities: [100] Virtual Channel
> >       Kernel driver in use: ahci
> >       Kernel modules: ahci
> >

I just did one additional test, trying to help out Leonardo.

Unfortunately I do not have the same PCIe card available, so I tested with a

01:00.0 Network controller: Intel Corporation Wireless 7260 (rev 73)
	Subsystem: Intel Corporation Dual Band Wireless-AC 7260 [Wilkins Peak 2]
	Flags: fast devsel
	Memory at 01100000 (64-bit, non-prefetchable) [disabled] [size=8K]
	Capabilities: [c8] Power Management version 3
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [40] Express Endpoint, IntMsgNum 0
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number ac-7b-a1-ff-ff-4e-a1-d8
	Capabilities: [14c] Latency Tolerance Reporting
	Capabilities: [154] Vendor Specific Information: ID=cafe Rev=1 Len=014 <?>

no wi-fi driver is loaded (but this seems unrelevant for the issue here), but
the card is detected with the current mainline Linux 7.2.0-rc7+. I tested the
apalis SoM on both the eval carrier board and on ixora v1.2.

Same kernel config as the one failing.

So, unless I did some mistake in my manual test, the issue is related to the specific
PCIe card or some other subtle difference I cannot see yet.

For the record, the failure was detected by our CI/CD, and it is systematically
reproduced on multiple hardware boards.

Leonardo: any chance you can test with the same PCIe board that is failing?

Francesco

