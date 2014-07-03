Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45064 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbaGCWxw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Jul 2014 18:53:52 -0400
Message-ID: <1404428017.29546.177.camel@pasglop>
Subject: Re: [PATCH 1/2] PCI: Make resetting secondary bus logic common
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 Jul 2014 08:53:37 +1000
In-Reply-To: <20140703224704.GA25980@google.com>
References: <1403162565-26835-1-git-send-email-gwshan@linux.vnet.ibm.com>
	 <20140703224704.GA25980@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2014-07-03 at 16:47 -0600, Bjorn Helgaas wrote:
> On Thu, Jun 19, 2014 at 05:22:44PM +1000, Gavin Shan wrote:
> > Commit d92a208d086 ("powerpc/pci: Mask linkDown on resetting PCI bus")
> > implemented same logic (resetting PCI secondary bus by bridge's config
> > register PCI_BRIDGE_CTL_BUS_RESET) in PCI core and arch-dependent
> > code. In order to avoid the duplicate implementation introduced by the
> > commit, the patch puts the logic into pci_reset_secondary_bus().
> > 
> > That commit also missed declaring newly introduced weak function
> > pcibios_reset_secondary_bus() in linux/include/pci.h. The patch fixes
> > it.
> > 
> > Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> I applied both of these to pci/virtualization for v3.17.  Ben, if you'd
> rather apply the powerpc one [1], let me know and I'll drop that one.

I'm happy for you to keep it. If for some reason I want it too we can
both carry it, it shouldn't hurt significantly at merge time.

Cheers,
Ben.

> Bjorn
> 
> [1] http://patchwork.ozlabs.org/patch/361802/
> 
> > ---
> >  drivers/pci/pci.c   | 7 ++++++-
> >  include/linux/pci.h | 2 ++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 63a54a3..758f1d8 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3193,7 +3193,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
> >  	return 0;
> >  }
> >  
> > -void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> > +void pci_reset_secondary_bus(struct pci_dev *dev)
> >  {
> >  	u16 ctrl;
> >  
> > @@ -3219,6 +3219,11 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> >  	ssleep(1);
> >  }
> >  
> > +void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> > +{
> > +	pci_reset_secondary_bus(dev);
> > +}
> > +
> >  /**
> >   * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
> >   * @dev: Bridge device
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 466bcd1..340529d 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -978,6 +978,8 @@ int pci_try_reset_slot(struct pci_slot *slot);
> >  int pci_probe_reset_bus(struct pci_bus *bus);
> >  int pci_reset_bus(struct pci_bus *bus);
> >  int pci_try_reset_bus(struct pci_bus *bus);
> > +void pci_reset_secondary_bus(struct pci_dev *dev);
> > +void pcibios_reset_secondary_bus(struct pci_dev *dev);
> >  void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
> >  void pci_update_resource(struct pci_dev *dev, int resno);
> >  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
> > -- 
> > 1.8.3.2
> > 


