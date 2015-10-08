Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37718 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbbJHX7z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2015 19:59:55 -0400
Subject: Re: what code generates this message?
To: Chuck Tuffli <ctuffli@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <CAKAYmMKumZTG9e_PzBtW1Jbo+0EvHVtY_XyFiZ=jnBVstkA-dw@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <56170378.7000406@infradead.org>
Date: Thu, 8 Oct 2015 16:59:52 -0700
MIME-Version: 1.0
In-Reply-To: <CAKAYmMKumZTG9e_PzBtW1Jbo+0EvHVtY_XyFiZ=jnBVstkA-dw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/08/15 16:30, Chuck Tuffli wrote:
> As part of trying to understand a hardware issue, I'm trying to track
> down the kernel code which prints:
> 
> [ 1077.119096] pcieport 0000:00:02.0: PCI bridge to [bus 02-02]
> [ 1077.119098] pcieport 0000:00:02.0:   bridge window [io  disabled]
> [ 1077.119101] pcieport 0000:00:02.0:   bridge window [mem disabled]
> [ 1077.119104] pcieport 0000:00:02.0:   bridge window [mem pref disabled]
> 
> to the system log / dmesg. Grep'ing the kernel source for strings such
> as "PCI bridge to" or "bridge window" hasn't turned up any candidates.
> Can someone point me in the right direction? TIA.

drivers/pci/setup-bus.c: (I'm looking in 4.3-rc4):

static void __pci_setup_bridge(struct pci_bus *bus, unsigned long type)
{
	struct pci_dev *bridge = bus->self;

	dev_info(&bridge->dev, "PCI bridge to %pR\n",
		 &bus->busn_res);

	if (type & IORESOURCE_IO)
		pci_setup_bridge_io(bridge);

	if (type & IORESOURCE_MEM)
		pci_setup_bridge_mmio(bridge);

	if (type & IORESOURCE_PREFETCH)
		pci_setup_bridge_mmio_pref(bridge);

	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
}


Each of the calls to pci_setup_bridge_{io,mmio,mmio_pref}() prints a "bridge window"
line.


-- 
~Randy
