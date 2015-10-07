Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59863 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352AbbJGXIv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Oct 2015 19:08:51 -0400
Date: Wed, 7 Oct 2015 18:08:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	David Daney <david.daney@cavium.com>,
	Matthew Minter <matt@masarand.com>
Subject: Re: [PATCH v4 1/5] PCI: Add pci_bus_fixup_irqs().
Message-ID: <20151007230847.GG27633@localhost>
References: <1443811443-18878-1-git-send-email-ddaney.cavm@gmail.com>
 <1443811443-18878-2-git-send-email-ddaney.cavm@gmail.com>
 <20151007194426.GF27633@localhost>
 <56157BC8.3070406@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56157BC8.3070406@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Matthew]

On Wed, Oct 07, 2015 at 01:08:40PM -0700, David Daney wrote:
> On 10/07/2015 12:44 PM, Bjorn Helgaas wrote:
> >Hi David,
> >
> >On Fri, Oct 02, 2015 at 11:43:59AM -0700, David Daney wrote:
> >>From: David Daney <david.daney@cavium.com>
> >>
> >>pci_bus_fixup_irqs() works like pci_fixup_irqs(), except it only does
> >>the fixups for devices on the specified bus.
> >>
> >>Follow-on patch will use the new function.
> >>
> >>Signed-off-by: David Daney <david.daney@cavium.com>
> >>---
> >>No change from v2.
> >>
> >>  drivers/pci/setup-irq.c | 30 ++++++++++++++++++++++++++++++
> >>  include/linux/pci.h     |  4 ++++
> >>  2 files changed, 34 insertions(+)
> >>
> >>diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> >>index 95c225b..189ad17 100644
> >>--- a/drivers/pci/setup-irq.c
> >>+++ b/drivers/pci/setup-irq.c
> >>@@ -66,3 +66,33 @@ void pci_fixup_irqs(u8 (*swizzle)(struct pci_dev *, u8 *),
> >>  		pdev_fixup_irq(dev, swizzle, map_irq);
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_fixup_irqs);
> >>+
> >>+struct pci_bus_fixup_cb_info {
> >>+	u8 (*swizzle)(struct pci_dev *, u8 *);
> >>+	int (*map_irq)(const struct pci_dev *, u8, u8);
> >>+};
> >>+
> >>+static int pci_bus_fixup_irq_cb(struct pci_dev *dev, void *arg)
> >>+{
> >>+	struct pci_bus_fixup_cb_info *info = arg;
> >>+
> >>+	pdev_fixup_irq(dev, info->swizzle, info->map_irq);
> >>+	return 0;
> >>+}
> >>+
> >>+/*
> >>+ * Fixup the irqs only for devices on the given bus using supplied
> >>+ * swizzle and map_irq function pointers
> >>+ */
> >>+void pci_bus_fixup_irqs(struct pci_bus *bus,
> >>+			u8 (*swizzle)(struct pci_dev *, u8 *),
> >>+			int (*map_irq)(const struct pci_dev *, u8, u8))
> >>+{
> >>+	struct pci_bus_fixup_cb_info info;
> >>+
> >>+	info.swizzle = swizzle;
> >>+	info.map_irq = map_irq;
> >>+	pci_walk_bus(bus, pci_bus_fixup_irq_cb, &info);
> >
> >I don't like the existing pci_fixup_irqs(), so by transitivity, I
> >don't like pci_bus_fixup_irqs() either.
> 
> We are in agreement with respect to this point.
> 
> > The problem is that in both
> >cases this is a one-time pass over the tree, so we don't handle
> >hot-added devices correctly.
> >
> >I think we need to get rid of pci_fixup_irqs() and somehow integrate
> >it into the pci_device_add() path, where it would be done once for
> >every device we enumerate.
> 
> I also agree with this point.
> 
> > If we did that, I don't think you would
> >need to add pci_bus_fixup_irqs(), would you?
> 
> Nope.
> 
> However, such a change is essentially untestable by me.  So, I
> didn't attempt it.   pci_fixup_irqs() is used by alpha, arm, m68k,
> mips, sh, sparc, tile, unicore32 and other things as well.  If the
> core pci_device_add() code were to suddenly start doing the fixup,
> there would be the potential to break all these things I cannot
> test.

Yep, that's certainly a risk.  I can't test all those arches either,
but I think it's a risk worth taking because the end result is more
maintainable.

Matthew Minter did some really nice work on this last year, but it got
stalled somehow.  I wonder if we can resurrect it?  It seems like it
was pretty close to being ready.  Here's a pointer to the last posting
I saw:

http://lkml.kernel.org/r/1412222866-21068-1-git-send-email-matt@masarand.com

Bjorn
