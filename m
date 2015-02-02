Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43283 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbbBBSUR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Feb 2015 13:20:17 -0500
Date: Mon, 2 Feb 2015 18:20:03 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andre Przywara <Andre.Przywara@arm.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix pcibios_update_irq misuse of irq number
Message-ID: <20150202182003.GH8656@n2100.arm.linux.org.uk>
References: <1422456683-797-1-git-send-email-marc.zyngier@arm.com>
 <20150202163344.GF8656@n2100.arm.linux.org.uk>
 <54CFBD11.3010004@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54CFBD11.3010004@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 02, 2015 at 06:08:17PM +0000, Marc Zyngier wrote:
> Hi Russell,
> 
> On 02/02/15 16:33, Russell King - ARM Linux wrote:
> > What your change would mean is that the IRQs currently being programmed
> >> = 16 would be programmed into with numbers with 16 removed from them.
> > This means that legacy stuff (eg on the Southbridge which really do signal
> > via the ISA IRQ controller) end up using the same number range as those
> > which take PCI specific IRQs.
> > 
> > This surely is not sane.
> 
> I suppose this is ebsa285? I must confess I don't see how to distinguish
> the two cases (the GIC case uses a purely virtual number, and the
> footbridge case uses something that seems to be physical).

Yep.

> A very easy fix would be to entirely contain this change within #ifdef
> CONFIG_IRQ_DOMAIN_HIERARCHY/#endif, but that doesn't fill me with
> confidence.
> 
> What I don't get is how the hwirq field is set in this case. It probably
> isn't very useful (as there is no domain lookup), so I would have hoped
> to see irq == hwirq. Obviously, this is not the case. What am I missing?

Well, it depends how this register is to be interpreted.  The PCI specs
say that it's used to communicate the interrupt line routing information
from POST to device drivers and operating systems.  "The value in this
register tells which input of the system interrupt controller(s) the
device's interrupt pin is connected to."  Note the plural there - which
imples that any per-interrupt controller numbering scheme is quite
certainly wrong.

It also implies that there is a known, shared numberspace between POST and
OS implementations on a platform which is used by PCI devices to describe
how the PCI interrupts are wired up.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
