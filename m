Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50162 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966835Ab3HILnO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 07:43:14 -0400
Date: Fri, 9 Aug 2013 07:42:51 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>,
	Rob Herring <rob.herring@calxeda.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv8 04/10] of: pci: add registry of MSI chips
Message-ID: <20130809114251.GQ8204@titan.lakedaemon.net>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376027346.32100.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376027346.32100.8.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thomas,

On Fri, Aug 09, 2013 at 03:49:06PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> > 
> > +#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> > +int of_pci_msi_chip_add(struct msi_chip *chip);
> > +void of_pci_msi_chip_remove(struct msi_chip *chip);
> > +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node
> > *of_node);
> > +#else
> > +static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return
> > -EINVAL; }
> > +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
> 
> Missing a ; at the end of the above line... breaks the build of
> CONFIG_PCI_MSI is not set.

If this is the same error Randy reported yesterday from -next, I'll just
fix it up when I pull it in.

thx,

Jason.
