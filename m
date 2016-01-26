Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46572 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966008AbcAZOeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jan 2016 09:34:24 -0500
Date: Tue, 26 Jan 2016 08:34:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
Message-ID: <20160126143418.GA9279@localhost>
References: <1453804310-12946-1-git-send-email-jacek.lawrynowicz@intel.com>
 <1453809557.60902.58.camel@infradead.org>
 <36D38C1F74839847A52A484C31F3E51A6213B1EF@irsmsx105.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36D38C1F74839847A52A484C31F3E51A6213B1EF@irsmsx105.ger.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 26, 2016 at 12:04:47PM +0000, Lawrynowicz, Jacek wrote:
> > -----Original Message-----
> > From: David Woodhouse [mailto:dwmw2@infradead.org]
> > Sent: Tuesday, January 26, 2016 12:59 PM
> > To: Lawrynowicz, Jacek <jacek.lawrynowicz@intel.com>; linux-
> > pci@vger.kernel.org
> > Cc: bhelgaas@google.com; alex.williamson@redhat.com; jroedel@suse.de
> > Subject: Re: [PATCH v2 1/2] pci: Add support for multiple DMA aliases
> > 
> > On Tue, 2016-01-26 at 11:31 +0100, Jacek Lawrynowicz wrote:
> > >
> > > +bool pci_dma_alias_is_enabled(struct pci_dev *dev, u8 devfn)
> > > +{
> > > +       return dev->dma_alias_mask &&
> > > +              test_bit(devfn, dev->dma_alias_mask);
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_dma_alias_is_enabled);
> > 
> > Why export this?
> 
> So it can be used in drivers/iommu/iommu.c in get_pci_alias_group().
> Bjorn didn't want dma_alias_mask to be used there directly.

Declaring pci_dma_alias_is_enabled() in include/linux/pci.h is
sufficient to allow drivers/iommu/iommu.c to use it.  The
EXPORT_SYMBOL_GPL() is not needed.

Bjorn
