Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41037 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932387Ab3HGUyC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 7 Aug 2013 16:54:02 -0400
Message-ID: <1375908620.9300.3.camel@pasglop>
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
Date: Thu, 08 Aug 2013 06:50:20 +1000
In-Reply-To: <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
	 <1375867954-2320-8-git-send-email-thomas.petazzoni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-08-07 at 11:32 +0200, Thomas Petazzoni wrote:
> Now that an irq_domain can be associated to a msi_chip structure, a
> given PCIe driver will want to find this irq_domain, based on the
> Device Tree node of the interrupt controller, as pointed by the
> 'msi-controller' DT property.

I still don't quite understand why you have to do all that.

> However, since on those platforms a single piece of hardware,
> represented by a single DT node can provide both a "normal" IRQ domain
> and a MSI-type IRQ domain, we need separate lookup functions to
> distinguish them.

At least on power we have cases where an mpic does both MSIs and LSIs,
we have the XICS that happily mixes both in a single large domain,
etc... and never needed any of that.

I don't quite understand what problem that stuff is trying to solve
really. Are you trying to avoid having an added MSI bitmap allocator for
the MSI side of the PIC and use the irq domain stuff both as your virq
and your hwirq allocator ?

> This patch makes irq_find_host() find only non-MSI-type IRQ domains,
> and introduces irq_find_msi_host() to find only MSI-type IRQ
> domains. It does so by factorizing the irq_find_host() logic into
> __irq_find_host().


