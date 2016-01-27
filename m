Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63343 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967217AbcA0UBY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 27 Jan 2016 15:01:24 -0500
Date: Wed, 27 Jan 2016 21:01:14 +0100
From: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	alex.williamson@redhat.com, dwmw2@infradead.org, jroedel@suse.de
Subject: Re: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
Message-ID: <20160127200113.GA15468@jlawryno-MOBL1>
References: <1453825639.26652.45.camel@redhat.com>
 <1453828335-111522-1-git-send-email-jacek.lawrynowicz@intel.com>
 <20160126233100.GC26726@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160126233100.GC26726@localhost>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 05:31:00PM -0600, Bjorn Helgaas wrote:
> Hi Jacek,
> 
> When you post updated versions, please post the whole series with a
> new version number.  I think there are three postings of [v2 1/2], and
> I think they're different.  In any case, it's hard for me to keep them
> straight.

OK, should I also create a new thread for each new version?

> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 0e3b009..93a89ed 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -660,8 +660,8 @@ static struct iommu_group *get_pci_function_alias_group(struct pci_dev *pdev,
> >  }
> >  
> >  /*
> > - * Look for aliases to or from the given device for exisiting groups.  The
> > - * dma_alias_devfn only supports aliases on the same bus, therefore the search
> > + * Look for aliases to or from the given device for exisiting groups. DMA
> 
> s/exisiting/existing/  (Not your change, but might as well fix the
> typo since you're touching the line anyway.)

Sure

> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 602eb42..cd38767 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -4568,6 +4568,33 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
> >  	return 0;
> >  }
> >  
> > +/**
> > + * pci_enable_dma_alias - Allows to set multiple devfn aliases for given device
> > + * @dev: the PCI device for which alias is added
> > + * @devfn: alias slot and function
> > + *
> > + * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> > + * It should be called early, preferably as PCI fixup header quirk.
> > + */
> > +void pci_enable_dma_alias(struct pci_dev *dev, u8 devfn)
> 
> I kind of liked "pci_add_dma_alias()."  "Enable" suggests that we can
> turn them on and off, which isn't really the case here.

OK, I was going for enable/is_enabled but you are right that enable
suggest that alias can be disabled.

Jacek

