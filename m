Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:54273 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab3KTN5M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2013 08:57:12 -0500
From: Marek Vasut <marex@denx.de>
To: =?iso-8859-1?q?Bj=F8rn_Erik_Nilsen?= <ben@datarespons.no>
Subject: Re: Kernel oops from pci_disable_msi
Date: Wed, 20 Nov 2013 14:57:09 +0100
Cc: Jingoo Han <jg1.han@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"'Pratyush Anand'" <pratyush.anand@gmail.com>,
	"'Kishon Vijay Abraham I'" <kishon@ti.com>,
	"'Mohit KUMAR DCG'" <Mohit.KUMAR@st.com>,
	"'Ajay KHANDELWAL'" <ajay.khandelwal@st.com>,
	"'Tim Harvey'" <tharvey@gateworks.com>,
	Eric Nelson <Eric.Nelson@boundarydevices.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>
References: <528a1bb6.6a88700a.28c9.ffff824aSMTPIN_ADDED_MISSING@mx.google.com> <201311201302.57210.marex@denx.de> <cmu-lmtpd-23243-1384949805-3@frontend1.mail.m-online.net>
In-Reply-To: <cmu-lmtpd-23243-1384949805-3@frontend1.mail.m-online.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311201457.09154.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjørn Erik Nilsen,

> On Wed, 2013-11-20 at 13:02 +0100, Marek Vasut wrote:
> > Dear Bjørn Erik Nilsen,
> > 
> > > On Wed, 2013-11-20 at 11:30 +0100, Marek Vasut wrote:
> > > > Hi Bjørn Erik Nilsen,
> > > > 
> > > > > On Tue, 2013-11-19 at 23:01 +0100, Marek Vasut wrote:
> > > > > > Dear Bjørn Erik Nilsen,
> > > > > > 
> > > > > > > On Tue, 2013-11-19 at 12:39 +0100, Bjørn Erik Nilsen wrote:
> > > > > > > > On Tue, 2013-11-19 at 12:24 +0100, Marek Vasut wrote:
> > > > > > > > > Dear Jingoo Han,
> > > > > > > > > 
> > > > > > > > > > On Tuesday, November 19, 2013 6:03 AM, Bjorn Helgaas wrote:
> > > > > > > > > > > On Mon, Nov 18, 2013 at 2:01 PM, Bjorn Helgaas
> > > > > > > > > > > <bhelgaas@google.com>
> > > > > > 
> > > > > > wrote:
> > > > > > > > > > >> On Mon, Nov 18, 2013 at 6:53 AM, Bjørn Erik Nilsen
> > > > > > > > > > >> <ben@datarespons.no>
> > > > > > > > > 
> > > > > > > > > wrote:
> > > > > > > > > > >>> I just hit an kernel oops related to PCI (in
> > > > > > > > > > >>> dw_msi_teardown_irq()/clear_irq() (pcie-designware))
> > > > > > > > > > >>> 
> > > > > > > > > > >>> Linux version 3.12.0-next-20131105 (bnilsen@bnilsen)
> > > > > > > > > > >>> (gcc version 4.7.2 (GCC) )
> > > > > > > > > > >>> 
> > > > > > > > > > >>> Problem seem to be dereferencing a null pointer
> > > > > > > > > > >>> returned from irq_desc_get_msi_desc(desc) (see
> > > > > > > > > > >>> attached backtrace).
> > > > > > > > > > >> 
> > > > > > > > > > >> Included oops inline for ease of viewing/searching.
> > > > > > > > > > >> Jingooo, I assume you'll investigate this.  Let me
> > > > > > > > > > >> know if otherwise.
> > > > > > > > > > 
> > > > > > > > > > (+cc Marek Vasut, Pratyush Anand, Kishon Vijay Abraham I,
> > > > > > > > > > 
> > > > > > > > > >        Mohit KUMAR DCG, Ajay KHANDELWAL, Tim Harvey)
> > > > > > > > > > 
> > > > > > > > > > Sorry, I will not investigate this.
> > > > > > > > > > 
> > > > > > > > > > Bjørn Erik Nilsen,
> > > > > > > > > > 
> > > > > > > > > > Would you let us know the ARM platform and LAN card?
> > > > > > > > > > If you let us know them, one of these pcie-designware
> > > > > > > > > > related people would reproduce and look at the issue.
> > > > > > > > > > 
> > > > > > > > > > Best regards,
> > > > > > > > > > Jingoo Han
> > > > > > > > > > 
> > > > > > > > > > >> Unable to handle kernel NULL pointer dereference at
> > > > > > > > > > >> virtual address 00000020 pgd = 80004000
> > > > > > > > > > >> [00000020] *pgd=00000000
> > > > > > > > > > >> Internal error: Oops: 17 [#1] SMP ARM
> > > > > > > > > > >> Modules linked in: sxdma(O)
> > > > > > > > > > >> CPU: 1 PID: 569 Comm: i2cipc.B3 Tainted: G           O
> > > > > > > > > > >> 3.12.0-next-20131105 #8 task: 9efcb600 ti: 9ec8c000
> > > > > > > > > > >> task.ti: 9ec8c000 PC is at
> > > > > > > > > > >> dw_msi_teardown_irq+0x40/0x118
> > > > > > > > > 
> > > > > > > > > see drivers/pci/host/pcie-designware.c :
> > > > > > > > > 
> > > > > > > > > 336 static void dw_msi_teardown_irq(struct msi_chip *chip,
> > > > > > > > > unsigned int irq) 337 {
> > > > > > > > > 338         clear_irq(irq);
> > > > > > > > > 339 }
> > > > > > > > > 
> > > > > > > > > So, add such a print before the clear_irq() call:
> > > > > > > > > 
> > > > > > > > > pr_err("%i %i\n", chip != NULL, irq);
> > > > > > > > > 
> > > > > > > > > And let us know the result please.
> > > > > > > > 
> > > > > > > > Here's what I get:
> > > > > > > > 
> > > > > > > > 1 391
> > > > > > > > 1 392
> > > > > > > 
> > > > > > > Also worth to mention is that I trigger this behavior by
> > > > > > > removing the device:
> > > > > > > 
> > > > > > > echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
> > > > > > 
> > > > > > Just for completeness, is this pure next or something else, like
> > > > > > the boundarydevices's kernel ?
> > > > > 
> > > > > It's a boundary device kernel (boundary-imx_3.12.0):
> > > > > 
> > > > > https://github.com/boundarydevices/linux-imx6/tree/boundary-imx_3.1
> > > > > 2.0
> > > > 
> > > > OK, thanks. Jingoo, can you please try if this also happens on
> > > > Exynos?
> > > 
> > > Sorry, I need to clarify the steps leading to the oops. It's actually
> > > not removing the device itself which is the trigger point. The kernel
> > > module (sxdma) registers a PCI driver and creates a char device
> > > (/dev/sxdma). When this device is opened pci_enable_msi is called, and
> > > when it is closed sxdma_dev_release is called (which in turn calls
> > > pci_disable_msi as shown in the bt).
> > 
> > Uh, what's this 'sxdma' ?
> 
> It's the driver for the PCI device:
> 
> 01:00.0 Memory controller: Barco Graphics NV Device ba01 (rev 01)
> 	Flags: bus master, fast devsel, latency 0, IRQ 155
> 	Memory at 01000000 (32-bit, non-prefetchable) [size=2M]
> 	Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
> 	Capabilities: [78] Power Management version 3
> 	Capabilities: [80] Express Endpoint, MSI 00
> 	Capabilities: [100] Virtual Channel
> 	Capabilities: [200] Vendor Specific Information: ID=1172 Rev=0 Len=044
> <?>
> 	Kernel driver in use: sxdma

Sure, I just cannot find such driver anywhere in the kernel tree for some 
reason.
