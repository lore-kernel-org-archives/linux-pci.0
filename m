Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:36857 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933958Ab3HHIQf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2013 04:16:35 -0400
Date: Thu, 8 Aug 2013 10:16:27 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
Subject: Re: [PATCHv7 07/13] irqdomain: add function to find a MSI
 irq_domain
Message-ID: <20130808101627.065ec95a@skate>
In-Reply-To: <1375914665.12551.5.camel@pasglop>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
	<1375908620.9300.3.camel@pasglop>
	<20130808000443.17f57875@skate>
	<1375914665.12551.5.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Benjamin Herrenschmidt,

On Thu, 08 Aug 2013 08:31:05 +1000, Benjamin Herrenschmidt wrote:

>  - I still don't like it. I find that it's looking more and more like
> over engineering. I don't like having any kind of infrastructure
> relationship between MSI stuff and irqdomain, ie, a PCI/PCIe specific
> construct and a generic interrupt remapper.

This is *exactly* the opposite of what Grant Likely said in:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187083.html
[PATCHv5 05/11] of: pci: add registry of MSI chips

Grant said:

"""
Actually, I'm going to disagree on this one and say NAK. I don't think
it is a good idea to create a completely separate registry of msi_chips
for binding to dt nodes. I think it would be better to include the
msi_chip pointer directly into the irq_domain which has to be there
anyway. It then becomes another feature for irq controllers if it can
support doing MSI.
"""

So Grant is completely in favor of a strong relationship between MSI
stuff and irqdomain.

> Trying to use irqdomain for HW number allocation seems to be pushing it
> where it wasn't designed to go. Are those interrupts really different
> domains ? Do they have separate number spaces, separate DT encodings and
> overall characteristics ?

This is also *exactly* the opoosite of what Grant Likely said in:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175430.html
[PATCH v2 4/8] irqchip: armada-370-xp: implement MSI support

He was replying to the patch that did a bitmap based allocation scheme,
within the IRQ controller driver, for MSI interrupts. And Grant said:

"""
This looks like something that the irq_domain should handle for you.
It would be good to have a variant of irq_create_mapping() that keeps
track of available hwirqs, allocates a free one, and maps it all with
one function call. I can see that being useful by other MSI interrupt
controllers and would eliminate needing to open-code it above.
"""

> What's wrong with the bitmap allocator in the PIC driver ? It's simple,
> and does the job just fine. If anything, take it from powerpc and sparc
> and move it to generic. It's already a "generic" (ie shared)
> infrastructure in powerpc.

See above. Grant said to *NOT* implement a bitmap allocator. He even
said it would be useful for other MSI interrupt controllers, and that
ultimately they should be migrated to not use the bitmap allocator that
you're talking about, but instead rely on irqdomain based allocations.

> That series makes me feel nervous, it feels like a hack. I really don't
> like creating that relationship between msi_chip and irqdomain. In fact,
> I think it makes it harder to understand what's happening in the code
> and following things.

Please see above, you're going completely backwards to what Grant
Likely was saying.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
