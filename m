Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD103FC5D1;
	Tue, 11 Aug 2026 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430296; cv=none; b=AX3t905gb/kawKoOAgtRkeKX88hQO26cOtmETV8t0o+jGUb//Fwbs+moJuoGwXYPKPUKKeIcsBR9MYnQI7SLYPz0bENmH++XbPtIN/inEt9wTdhhsgpD+3FXaFGKM/F0pzWzE+esqJpBaulh9P5sgabNR+bfJKimxweip/WYM+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430296; c=relaxed/simple;
	bh=KrmseUJs+he1fokqoK+ierlL/CGpwzoasSMq+YQNgwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atRPYtJXnCtsDDwgAZ79bIslHKZ0GwGL0hVxB347OqRTZTHfleMMCxWSH403IBmx5/NpvMPH2A7pidiT8rA/crUEMXe55QHlwf0wxvtvoiOifHT8hQ6kbQBwouw2Pnbl3YyhNesqwV495EfxPwoYF75vlfdl3xlkVLtMT2j90SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=L6AUW32F; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="L6AUW32F"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id E5A431FD34;
	Tue, 11 Aug 2026 08:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1786430278;
	bh=bxQ/JVN7kCxCQB3HdoijyIyqrXUmPIZpcFd1H63BlNI=; h=From:To:Subject;
	b=L6AUW32FPrvIWnJ7D/WMO9AtzxEho4sGdj88qzGzFFjbjNO+jq4JwpO09+GDKkTrc
	 aEm2zGMnTaKsdDteXL9b6lRC7bLL/kaduvJYH8XHaWS71DnrxzWmnXXk5Y047nT2aA
	 rS+lZ9DbEECJdOfX8f5UBH2Ox1bpzfbj8UedIv97SzItyuM82Ra6JlbNOf4MHQ3dG2
	 IuVzDx7kLBLQbCzbsCb2iyhEsAtiIQFjBkf/r2KeN7lU5g/E9r+3xfKHpzKM480RPj
	 gFeShsQmLB0gaC8gYnpBckHhvQNtl/kkINzrjxLmFOOhOMS2/4Sw2WgXusxWe/bym1
	 edIWB8GeZDjcA==
Date: Tue, 11 Aug 2026 08:37:52 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Leonardo Costa <leoreis.costa@gmail.com>,
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
	Hongxing Zhu <hongxing.zhu@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
Message-ID: <20260811063752.GA7332@francesco-nb>
References: <20260629143439.361560-1-leoreis.costa@gmail.com>
 <20260715234736.GA288957@bhelgaas>
 <VI0PR04MB1200862BE9B7C137EC7C18AF18CC72@VI0PR04MB12008.eurprd04.prod.outlook.com>
 <i6x6wpua7wlwmdq3hitoo53wkptgp62tvegmkabcru3d54eqg3@yk4eehwaarn2>
 <3hxiy6aaiagt5zunntpidaeqc4or4wrebf7mu7asvyyibqmvo2@xhvasdqp64rw>
 <GV2PR04MB12019BD5B14FA63CDFCC2015B8CDD2@GV2PR04MB12019.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB12019BD5B14FA63CDFCC2015B8CDD2@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Tue, Aug 11, 2026 at 12:47:18AM +0000, Hongxing Zhu (OSS) wrote:
> > -----Original Message-----
> > From: Leonardo Costa <leoreis.costa@gmail.com>
> > Sent: Tuesday, August 11, 2026 2:26 AM
> > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>; robh@kernel.org;
> > krzk+dt@kernel.org; conor+dt@kernel.org; Frank Li <frank.li@nxp.com>;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > leonardo.costa@toradex.com; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; regressions@lists.linux.dev; Sherry Sun
> > <sherry.sun@nxp.com>; Manivannan Sadhasivam <mani@kernel.org>;
> > Hongxing Zhu <hongxing.zhu@nxp.com>; linux-pci@vger.kernel.org
> > Subject: Re: [REGRESSION] mainline/master: Apalis iMX6 no longer boots
> > 
> > On Thu, Jul 16, 2026 at 02:09:19PM -0300, Leonardo Costa wrote:
> > > On Thu, Jul 16, 2026 at 02:15:42AM +0000, Hongxing Zhu (OSS) wrote:
> > > > Hi Leonardo,
> > > >
> > > > Would you be able to test this patch on your affected boards? Your
> > > > testing would help expedite the merge process and ensure the fix
> > > > resolves the boot issue you're experiencing.
> > > >
> > > > Best Regards
> > > > Richard Zhu
> > >
> > > Hi Richard,
> > >
> > > Sorry for taking long to respond, I was caught up with something. I
> > > tested the patch and it solved the issue. I sent a Tested-by tag there.
> > > Thanks for looking into this!
> > >
> > > Best Regards
> > > Leonardo
> > 
> > Hi Richard,
> > 
> > That patch might have introduced/exposed a second regression where PCI
> > devices are not linked properly during the initialization. Sorry for not catching
> > this before, as I didn't have any device connected during the previous test.
> Hi Leonardo:
> Sorry to hear about that.
> I did test commit 7678e81498e2 with one Intel NIC (82574L) connected, and I've
> double-checked today based on v7.2-rc7. The PCIe link can be set up properly
> on the i.MX6Q Sabresd board in my testing.
> 
> Here are the logs:
> root@imx6qpdlsolox:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network Connection
> root@imx6qpdlsolox:~# uname -a
> Linux imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l GNU/Linux
> root@imx6qpdlsolox:~# dmesg | grep pci
> [    0.256138] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
> [    0.256307] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
> [    0.256339] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
> [    0.256434] imx6q-pcie 1ffc000.pcie: config reg[1] 0x01f00000 == cpu 0x01f00000
> [    0.458388] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
> [    0.458492] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
> [    0.555294] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
> [    0.555783] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
> ...
> 
> The following endpoint devices also yielded the same results.
> root@imx6qpdlsolox:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)
> root@imx6qpdlsolox:~# uname -a
> Linux imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l GNU/Linux
> ...
> 
> root@imx6qpdlsolox:~# lspci
> 00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
> 01:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev 04)
> root@imx6qpdlsolox:~# uname -a
> Linux imx6qpdlsolox 7.2.0-rc7 #30 SMP Tue Aug 11 00:21:26 UTC 2026 armv7l GNU/Linux
> 
> Could you provide more details of your hardware setup (board, connected
> devices, PERST# present or not)?
> This may help us identify if there's a specific scenario that triggers the
> regression you're experiencing.

It's an apalis imx6, as reported already in this email thread.
The DT is in Linux, you can check
arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts every details
about PERST# and more.

This is the device connected:

00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01)
01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller (rev 02)

01:00.0 SATA controller: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller (rev 02) (prog-if 01 [AHCI 1.0])
	Subsystem: ASMedia Technology Inc. ASM1061/ASM1062 Serial ATA Controller
	Flags: bus master, fast devsel, latency 0, IRQ 308
	I/O ports at 1020 [size=8]
	I/O ports at 1030 [size=4]
	I/O ports at 1028 [size=8]
	I/O ports at 1034 [size=4]
	I/O ports at 1000 [size=32]
	Memory at 01100000 (32-bit, non-prefetchable) [size=512]
	Expansion ROM at 01200000 [virtual] [disabled] [size=64K]
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit-
	Capabilities: [78] Power Management version 3
	Capabilities: [80] Express Legacy Endpoint, IntMsgNum 0
	Capabilities: [100] Virtual Channel
	Kernel driver in use: ahci
	Kernel modules: ahci


These are some working logs from a 6.6.151 kernel

[    0.233058] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 ranges:
[    0.233112] imx6q-pcie 1ffc000.pcie:       IO 0x0001f80000..0x0001f8ffff -> 0x0000000000
[    0.233144] imx6q-pcie 1ffc000.pcie:      MEM 0x0001000000..0x0001efffff -> 0x0001000000
[    0.465779] imx6q-pcie 1ffc000.pcie: iATU: unroll F, 4 ob, 4 ib, align 64K, limit 4G
[    0.564230] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
[    0.564249] imx6q-pcie 1ffc000.pcie: Link: Only Gen1 is enabled
[    0.564259] imx6q-pcie 1ffc000.pcie: Link up, Gen1
[    0.564272] imx6q-pcie 1ffc000.pcie: PCIe Gen.1 x1 link up
[    0.564778] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.564795] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.564809] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.564821] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.564864] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    0.564886] pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
[    0.564905] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    0.564917] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.564931] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    0.564943] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    0.564957] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    0.565405] pci 0000:00:00.0: Limiting cfg_size to 512
[    0.565455] pci 0000:00:00.0: supports D1
[    0.565465] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    0.574310] pci 0000:01:00.0: [1b21:0612] type 00 class 0x010601
[    0.574458] pci 0000:01:00.0: BAR 0 [io  0x0000-0x0007]
[    0.574541] pci 0000:01:00.0: BAR 1 [io  0x0000-0x0003]
[    0.574616] pci 0000:01:00.0: BAR 2 [io  0x0000-0x0007]
[    0.574774] pci 0000:01:00.0: BAR 3 [io  0x0000-0x0003]
[    0.574854] pci 0000:01:00.0: BAR 4 [io  0x0000-0x001f]
[    0.574925] pci 0000:01:00.0: BAR 5 [mem 0x00000000-0x000001ff]
[    0.575001] pci 0000:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    0.575765] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0000:00:00.0 (capable of 4.000 Gb/s with 5.0 GT/s PCIe x1 link)
[    0.576808] pci 0000:00:00.0: BAR 0 [mem 0x01000000-0x010fffff]: assigned
[    0.576860] pci 0000:00:00.0: bridge window [mem 0x01100000-0x011fffff]: assigned
[    0.576895] pci 0000:00:00.0: bridge window [mem 0x01200000-0x012fffff pref]: assigned
[    0.576928] pci 0000:00:00.0: ROM [mem 0x01300000-0x0130ffff pref]: assigned
[    0.576958] pci 0000:00:00.0: bridge window [io  0x1000-0x1fff]: assigned
[    0.577000] pci 0000:01:00.0: ROM [mem 0x01200000-0x0120ffff pref]: assigned
[    0.577033] pci 0000:01:00.0: BAR 5 [mem 0x01100000-0x011001ff]: assigned
[    0.577087] pci 0000:01:00.0: BAR 4 [io  0x1000-0x101f]: assigned
[    0.577212] pci 0000:01:00.0: BAR 0 [io  0x1020-0x1027]: assigned
[    0.577273] pci 0000:01:00.0: BAR 2 [io  0x1028-0x102f]: assigned
[    0.577326] pci 0000:01:00.0: BAR 1 [io  0x1030-0x1033]: assigned
[    0.577377] pci 0000:01:00.0: BAR 3 [io  0x1034-0x1037]: assigned
[    0.577429] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    0.577460] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    0.577491] pci 0000:00:00.0:   bridge window [mem 0x01100000-0x011fffff]
[    0.577520] pci 0000:00:00.0:   bridge window [mem 0x01200000-0x012fffff pref]
[    0.579109] pcieport 0000:00:00.0: PME: Signaling with IRQ 291
[    0.580323] pcieport 0000:00:00.0: AER: enabled with IRQ 291

