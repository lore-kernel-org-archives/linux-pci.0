Return-Path: <SRS0=fxcv=BE=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=fxcv=BE=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Thu, 5 Oct 2017 21:25:54 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Jason
 Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>,
 Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>,
 linux-arm-kernel@lists.infradead.org, Antoine Tenart
 <antoine.tenart@free-electrons.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@free-electrons.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: aardvark: define IRQ related hooks in
 pci_host_bridge
Message-ID: <20171005212554.31c5b3a1@windsurf.lan>
In-Reply-To: <20171005175547.GT25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
	<20170928125838.11887-8-thomas.petazzoni@free-electrons.com>
	<20171005175547.GT25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 5 Oct 2017 12:55:47 -0500, Bjorn Helgaas wrote:

> On Thu, Sep 28, 2017 at 02:58:38PM +0200, Thomas Petazzoni wrote:
> > Commit 769b461fc0c0 ("arm64: PCI: Drop DT IRQ allocation from
> > pcibios_alloc_irq()") was assuming all PCI host controller drivers had
> > been converted to use ->map_irq(), but that wasn't the case:
> > pci-aardvark had not been converted. Due to this, it broke the support
> > for legacy PCI interrupts when using the pci-aardvark driver (used on
> > Marvell Armada 3720 platforms).  
> 
> Lorenzo is pretty thorough, but maybe pci-aardvark.c got overlooked.
> Cc'ing him just to make sure there's nothing deeper than that.

I talked about this issue with Lorenzo on IRC and then briefly in real
life at Linux Plumbers, and I'm pretty sure he agreed that it was just
due to the Aardvark driver having been overlooked.

But I'll let him confirm.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
