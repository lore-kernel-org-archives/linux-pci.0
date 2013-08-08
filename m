Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:50695 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934077Ab3HHI4R (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 8 Aug 2013 04:56:17 -0400
Message-ID: <1375952089.12551.40.camel@pasglop>
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
Date: Thu, 08 Aug 2013 18:54:49 +1000
In-Reply-To: <1375951106.12551.28.camel@pasglop>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375908620.9300.3.camel@pasglop> <20130808000443.17f57875@skate>
	 <1375914665.12551.5.camel@pasglop> <20130808101627.065ec95a@skate>
	 <1375951106.12551.28.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-08-08 at 18:38 +1000, Benjamin Herrenschmidt wrote:
> For example the generic irq_chip is orthogonal to irq remapping via
> irq_domain. It's possible to instanciate irq_chips without device nodes,
> and with a completely different firmware representation (ACPI ?). It
> should be the same with msi-chip.

In fact, to a large extent, the original irq_domain was also orthogonal
to the device-tree ...

I did add the ability to match a device-node with an irq domain but that
has always been just an optional addition, it was possible (and should
still be though I haven't looked in a while) to create irq domains
completely independently of the device-tree.

Now there is one thing that might sway me ... if you can show me (sorry
don't have the bandwidth to look in details and scrutinize the patch)
that overall, having the msi_chip in the domain as an optional facility
does indeed overall make the code *much* smaller than keeping them
separate, and for more than just your use case.

One reason I don't like the allocator being in irq domain is that it
really only is useful for a subset of the different types of domains
around.

For example, on power server, I have a unique domain accross the fabric
(irqs are special powerbus messages that are encoded in a 24 bit number),
but each "source" (a PCI host bridge for example) gets a subset of that
domain, typically a fixed range.

So your allocator would only be useful to that case if:

  - It can be used to allocate within specific boundaries

  - It works with radix based domains

This is just an example... I don't like bolting a facility (allocation)
in a lawyer originally designed to do something else (mapping) unless
that facility is directly useful to the vast majority of the users of the
layer in question.

In fact, there is an argument to be made to provide a generic bitmap
allocator specialized for MSIs. MSIs have quirks ... alignment constraints
for multiple MSI-non-X for example, which might potentially benefit in
having an allocator with some smarts to limit fragmentation. That sort
of things....

Cheers,
Ben.


