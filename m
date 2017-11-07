Return-Path: <SRS0=HO5T=CF=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=HO5T=CF=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ruben Guerra Marin' <ruben.guerra.marin@axon.tv>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: Michal Simek <michal.simek@xilinx.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "soren.brinkmann@xilinx.com"
	<soren.brinkmann@xilinx.com>, "bharat.kumar.gogada@xilinx.com"
	<bharat.kumar.gogada@xilinx.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: Performance issues writing to PCIe in a Zynq
Date: Tue, 7 Nov 2017 12:19:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00B3AB2@AcuExch.aculab.com>
References: <1509636637116.27702@axon.tv>
 <eca01e58-3da1-d5c4-00f7-71dd6a926870@xilinx.com>
 <20171103135457.GA8457@bhelgaas-glaptop.roam.corp.google.com>
 <1509958288489.45871@axon.tv>,<20171106173549.GB31930@bhelgaas-glaptop.roam.corp.google.com>
 <1510045454475.74232@axon.tv>
In-Reply-To: <1510045454475.74232@axon.tv>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Ruben Guerra Marin
> Sent: 07 November 2017 09:04
> > Which PCI host bridge driver are you using?
> Indeed I am using drivers/pci/host/pcie-xilinx.c
>=20
> > Can you do any profiling to figure out where the time is going?
> So I did some profiling on the mcap application, and traced the bottlenec=
k in a write call to
> pciutils. I added some debug to pciutils and could trace it that the bott=
leneck is in a function
> called pwrite, which pretty much does this:
>=20
> syscall(SYS_pwrite, fd, buf, size, where);
>=20
> until now this is the last part I could trace it to.

Are you doing one pwrite() for each 32-bit word?
If you are trying to write a large fpga image you'll need to use
a single system call.
I'd suspect that needs a special driver....

I'd also check that the driver size isn't doing single word copy_from_user(=
).
That can be completely horrid in recent kernels because of userspace copy
hardening.

	David
