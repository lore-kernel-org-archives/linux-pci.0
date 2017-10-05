Return-Path: <SRS0=fxcv=BE=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=fxcv=BE=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Thu, 5 Oct 2017 21:35:12 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Jason
 Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>,
 Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>,
 linux-arm-kernel@lists.infradead.org, Antoine Tenart
 <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@free-electrons.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 0/7] PCI: aardvark: improve compatibility with PCI
 devices
Message-ID: <20171005213512.5cdcd879@windsurf.lan>
In-Reply-To: <20171005181615.GU25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
	<20171005175310.3c2dde95@windsurf.lan>
	<20171005181615.GU25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 5 Oct 2017 13:16:17 -0500, Bjorn Helgaas wrote:

> The general rule is that after the merge window, I merge fixes to
> things we put in during the merge window, as well as important
> regression fixes.  Most bug fixes will be queued for the next merge
> window.  I'll need some guidance on classifying these.
> 
> I think the map_irq/swizzle_irq patch should definitely be in v4.14.
> (It looks a lot like these:
> 
>   1ee4d93d5037 PCI: xilinx-nwl: Move to struct pci_host_bridge IRQ mapping functions
>   5a3dc3c1f694 PCI: rockchip: Move to struct pci_host_bridge IRQ mapping functions
>   c62e98bdaa70 PCI: xgene: Move to struct pci_host_bridge IRQ mapping functions
>   6ab380957838 PCI: altera: Drop pci_fixup_irqs()
>   cf60374de8f6 PCI: versatile: Drop pci_fixup_irqs()
>   6982a068aa5f PCI: generic: Drop pci_fixup_irqs()
>   f7c2e69b65fe PCI: faraday: Drop pci_fixup_irqs()
>   60eca198b1ea PCI: designware: Drop pci_fixup_irqs()
>   64bcd00a7ef5 PCI: iproc: Drop pci_fixup_irqs()
>   29db991902ec PCI: rcar: Drop pci_fixup_irqs()
>   cc2eaaef63df PCI: xilinx: Drop pci_fixup_irqs()
>   dd5fcce2a7f9 PCI: tegra: Drop pci_fixup_irqs()
> 
> and I'm obsessive enough to use one of those subject lines to tie this
> patch together with those.)

Fine, I'll adjust the commit title to be "PCI: aardvark: Move to struct
pci_host_bridge IRQ mapping functions". I also find it nice when commit
titles are very consistent, so I can only agree with your obsessiveness
on this!

> Most of the rest look like they've been there since the driver was
> first merged, so they would *probably* go in the v4.15 queue.

I agree that the other patches do not fix regressions but bugs. So it's
really up to you as to what you consider a "fix". The Aardvark driver
in its current form leaves a lot of PCIe devices unusable, and we get
bug reports about this. But admittedly, such PCIe devices have never
worked with Aardvark.

> Sorry for the delay; mostly just lack of time.  I used to work pretty
> strictly first-in, first-out, but the native host bridge drivers
> consume a disproportionate share of my time compared with the generic
> code that benefits everybody, so I'm trying to figure out how to
> prioritize generic changes.  Obviously I need a solution that gives
> *some* time to the native drivers.

No problem. I do understand that reviewing all of those native drivers
takes a significant amount of time.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
