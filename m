Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:40282 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933666Ab3FSLmJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2013 07:42:09 -0400
Date: Wed, 19 Jun 2013 13:42:05 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>
Subject: Re: [PATCH v2 1/8] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130619134205.7fff88ea@skate>
In-Reply-To: <20130618224631.GB16134@google.com>
References: <1370536888-8871-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1370536888-8871-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<20130618224631.GB16134@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn Helgaas,

On Tue, 18 Jun 2013 16:46:31 -0600, Bjorn Helgaas wrote:

> > -#ifndef arch_msi_check_device
> > -int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)
> > +void __weak arch_teardown_msi_irq(unsigned int irq)
> 
> Please make a separate patch before this one for the conversion from the
> "#define arch_msi_check_device" strategy to the weak function.  I think
> it's a good idea to use a weak function rather than the #define, but we
> need to remove the #define from arch/powerpc/include/asm/pci.h at the same
> time.
> 
> I don't think these patches touch arch_setup_msi_irqs() or
> arch_teardown_msi_irqs(), but I'd like to do the same with them just so we
> consistently use the same strategy to solve the same problem.

Ok, I've tried to refactor all those MSI operations that can be
overriden on a per-architecture basis, it will be part of v3 to be sent
soon.


> > +struct msi_chip {
> > +	struct module *owner;
> 
> Can the MSI chip driver be a loadable module?  Does it need to be?

In the case of the Marvell SoC, the MSI logic is part of the IRQ
controller driver, so it's very unlikely that it can be built as a
module.

However, in the case of the Tegra PCIe hardware, the MSI logic is part
of the PCIe hardware itself. And the PCIe driver could potentially be
built as a module (even though some other implementations details in
the support of PCI on ARM currently prevents this, it should be
possible in theory). And since this code comes from Thierry Redding,
who was writing it with the Tegra PCIe in mind, it makes sense to
assume the MSI code could be built as a module.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
