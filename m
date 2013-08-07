Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45729 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757485Ab3HGWcP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Aug 2013 18:32:15 -0400
Message-ID: <1375914665.12551.5.camel@pasglop>
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
Date: Thu, 08 Aug 2013 08:31:05 +1000
In-Reply-To: <20130808000443.17f57875@skate>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375908620.9300.3.camel@pasglop> <20130808000443.17f57875@skate>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-08-08 at 00:04 +0200, Thomas Petazzoni wrote:
> Again, this has been discussed at lengths in the previous iterations,
> for which I already gave you all the links, as you requested in a
> private e-mail. It'd be great if this discussion was read seriously,
> because I really have the feeling we are restarting from zero on this
> whole MSI thing...

Well, two things here:

 - You don't need my ack since I am not the maintainer of the irqdomain
code anymore, Grant is :-)

 - I still don't like it. I find that it's looking more and more like
over engineering. I don't like having any kind of infrastructure
relationship between MSI stuff and irqdomain, ie, a PCI/PCIe specific
construct and a generic interrupt remapper.

Trying to use irqdomain for HW number allocation seems to be pushing it
where it wasn't designed to go. Are those interrupts really different
domains ? Do they have separate number spaces, separate DT encodings and
overall characteristics ?

What's wrong with the bitmap allocator in the PIC driver ? It's simple,
and does the job just fine. If anything, take it from powerpc and sparc
and move it to generic. It's already a "generic" (ie shared)
infrastructure in powerpc.

Let's ask somebody of well known taste ... Thomas ! :-) (Yes, you tglx,
I know you are lurking ...). What do you reckon ?

That series makes me feel nervous, it feels like a hack. I really don't
like creating that relationship between msi_chip and irqdomain. In fact,
I think it makes it harder to understand what's happening in the code
and following things.

It's a LOT clearer to me to have an irq domain for the PIC and an
explicit bitmap allocation for MSIs, I see where things come from, I can
follow the code path etc... much more easily.

I suspect we have a case of over-abstracting happening here. This is a
dangerous illness and can be contagious :-)

Cheers,
Ben.


