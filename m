Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64654 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758146Ab3HIO1t (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2013 10:27:49 -0400
Date: Fri, 9 Aug 2013 10:27:24 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@arm.linux.org.uk>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv8 04/10] of: pci: add registry of MSI chips
Message-ID: <20130809142724.GD25111@titan.lakedaemon.net>
References: <1376000268-18397-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376000268-18397-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <1376027346.32100.8.camel@pasglop>
 <20130809134427.GC25111@titan.lakedaemon.net>
 <20130809141806.GA15973@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130809141806.GA15973@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 09, 2013 at 04:18:07PM +0200, Thierry Reding wrote:
> On Fri, Aug 09, 2013 at 09:44:27AM -0400, Jason Cooper wrote:
> > On Fri, Aug 09, 2013 at 03:49:06PM +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2013-08-09 at 00:17 +0200, Thomas Petazzoni wrote:
> > > > 
> > > > +#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> > > > +int of_pci_msi_chip_add(struct msi_chip *chip);
> > > > +void of_pci_msi_chip_remove(struct msi_chip *chip);
> > > > +struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node
> > > > *of_node);
> > > > +#else
> > > > +static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return
> > > > -EINVAL; }
> > > > +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
> > > 
> > > Missing a ; at the end of the above line... breaks the build of
> > > CONFIG_PCI_MSI is not set.
> > > 
> > > > +static inline struct msi_chip *
> > > > +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return
> > > > NULL };
> > > > +#endif
> > > > +
> > > >  #endif
> > 
> > Reproduced, fixed and builds clean !CONFIG_OF and !CONFIG_PCI_MSI with:
> > 
> > ---------------->8----------------
> > diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> > index 29631eb..9f69507 100644
> > --- a/include/linux/of_pci.h
> > +++ b/include/linux/of_pci.h
> > @@ -19,10 +19,11 @@ int of_pci_msi_chip_add(struct msi_chip *chip);
> >  void of_pci_msi_chip_remove(struct msi_chip *chip);
> >  struct msi_chip *of_pci_find_msi_chip_by_node(struct device_node *of_node);
> >  #else
> > -static inline int of_pci_msi_chip_add(struct msi_chip *chip) { return -EINVAL; }
> > -static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { }
> > +static inline int
> > +of_pci_msi_chip_add(struct msi_chip *chip) { return -EINVAL; };
> > +static inline void of_pci_msi_chip_remove(struct msi_chip *chip) { };
> >  static inline struct msi_chip *
> > -of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL };
> > +of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL; };
> >  #endif
> >  
> >  #endif
> 
> So why do we need a semi-colon after a closing brace? I can understand
> how the missing semi-colon after NULL would cause the compiler to flag
> an error, but all the other changes look unnecessary to me.

You're correct, I sent this a little too hastily.  I thought Ben knew
something I didn't (see above), but the error was only where you
indicated.  I'm revising my fix to just append the semi-colon after the
NULL.

thx,

Jason.
