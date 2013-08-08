Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55336 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933746Ab3HHIkC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Aug 2013 04:40:02 -0400
Message-ID: <1375951106.12551.28.camel@pasglop>
Subject: Re: [PATCHv7 07/13] irqdomain: add function to find a MSI irq_domain
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 08 Aug 2013 18:38:26 +1000
In-Reply-To: <20130808101627.065ec95a@skate>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375908620.9300.3.camel@pasglop> <20130808000443.17f57875@skate>
	 <1375914665.12551.5.camel@pasglop> <20130808101627.065ec95a@skate>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-08-08 at 10:16 +0200, Thomas Petazzoni wrote:

> This is *exactly* the opposite of what Grant Likely said in:

Grant and I tend to disagree from time to time :-)

> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187083.html
> [PATCHv5 05/11] of: pci: add registry of MSI chips
> 
> Grant said:
> 
> """
> Actually, I'm going to disagree on this one and say NAK. I don't think
> it is a good idea to create a completely separate registry of msi_chips
> for binding to dt nodes. I think it would be better to include the
> msi_chip pointer directly into the irq_domain which has to be there
> anyway. It then becomes another feature for irq controllers if it can
> support doing MSI.
> """
> 
> So Grant is completely in favor of a strong relationship between MSI
> stuff and irqdomain.

And I disagree. If you consider msi_chip purely as a mechanism for
binding dt-nodes, then he *might* have some kind of argument but I think
that's the wrong approach.

msi-chip looks like the right low level abstraction for providing
different hooks for different MSI HW implementations that may exist in
an architecture, and in fact as such it's welcome. We currently have
arch specific function pointers we could then easily replace.

However this has always been my cardinal rule with the DT stuff from the
ground up on powerpc: Such a mechanism must be independent from and
orthogonal to the device-tree.

For example the generic irq_chip is orthogonal to irq remapping via
irq_domain. It's possible to instanciate irq_chips without device nodes,
and with a completely different firmware representation (ACPI ?). It
should be the same with msi-chip.

> > Trying to use irqdomain for HW number allocation seems to be pushing it
> > where it wasn't designed to go. Are those interrupts really different
> > domains ? Do they have separate number spaces, separate DT encodings and
> > overall characteristics ?
> 
> This is also *exactly* the opoosite of what Grant Likely said in:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175430.html
> [PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support
> 
> He was replying to the patch that did a bitmap based allocation scheme,
> within the IRQ controller driver, for MSI interrupts. And Grant said:
>
> """
> This looks like something that the irq_domain should handle for you.
> It would be good to have a variant of irq_create_mapping() that keeps
> track of available hwirqs, allocates a free one, and maps it all with
> one function call. I can see that being useful by other MSI interrupt
> controllers and would eliminate needing to open-code it above.
> """

Now, having some kind of HW allocator within the irq domain is actually
not completely idiotic I suppose since it somewhat keeps track of the HW
interrupts, but it's pushing beyond its original design, and even if
that was to be something we would allow, I would *still* keep it
separate from msi-chip.

A given msi-chip implementation may use that irq-domain provided
facility if it exist, indeed, but I don't want a strong tie between the
two.

> > What's wrong with the bitmap allocator in the PIC driver ? It's simple,
> > and does the job just fine. If anything, take it from powerpc and sparc
> > and move it to generic. It's already a "generic" (ie shared)
> > infrastructure in powerpc.
> 
> See above. Grant said to *NOT* implement a bitmap allocator. He even
> said it would be useful for other MSI interrupt controllers, and that
> ultimately they should be migrated to not use the bitmap allocator that
> you're talking about, but instead rely on irqdomain based allocations.

And that ends up into a bloody cathedral instead of nicely separated and
individually useful small components. I actually disagree with Grant
pretty strongly on that.

> > That series makes me feel nervous, it feels like a hack. I really don't
> > like creating that relationship between msi_chip and irqdomain. In fact,
> > I think it makes it harder to understand what's happening in the code
> > and following things.
> 
> Please see above, you're going completely backwards to what Grant
> Likely was saying.

Or Grant is going completely backward from what I've always wanted that
stuff to be... I've been too busy to monitor closely and frankly, I'm
also too busy to actively do so now either.

I suggest we bring in the opinion of Thomas Gleixner. I trust his sense
of taste and will bow if he says that I'm full of shit.

Cheers,
Ben.

> Best regards,
> 
> Thomas


