Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16724 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S967741Ab3HINot (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 09:44:49 -0400
Date: Fri, 9 Aug 2013 09:44:27 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv8 04/10] of: pci: add registry of MSI chips
Message-ID: <20130809134427.GC25111@titan.lakedaemon.net>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376027346.32100.8.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376027346.32100.8.camel@pasglop>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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
> 
> > +static inline struct msi_chip *
> > +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return
> > NULL };
> > +#endif
> > +
> >  #endif

Reproduced, fixed and builds clean !CONFIG_OF and !CONFIG_PCI_MSI with:

---------------->8----------------
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 29631eb..9f69507 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -19,10 +19,11 @@ int of_pci_msi_chip_add(struct msi_chip *chip);
 void of_pci_msi_chip_remove(struct msi_chip *chip);
 struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node *of_node);
 #else
-static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return -EINVAL; }
-static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
+static inline int
+of_pci_msi_chip_add(struct msi_chip *chip) { return -EINVAL; };
+static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { };
 static inline struct msi_chip *
-of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL };
+of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL; };
 #endif
 
 #endif
