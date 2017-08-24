Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753433AbdHXQCs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Aug 2017 12:02:48 -0400
Date: Thu, 24 Aug 2017 11:02:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Scott Bauer <scott.bauer@intel.com>,
        David Fugate <david.fugate@intel.com>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 4/4] iommu: Prevent VMD child devices from being
 remapping targets
Message-ID: <20170824160245.GC31858@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817181014.1257-1-jonathan.derrick@intel.com>
 <20170817181014.1257-5-jonathan.derrick@intel.com>
 <20170818160433.GN28977@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170818160433.GN28977@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 18, 2017 at 11:04:33AM -0500, Bjorn Helgaas wrote:
> [+cc Robin]
> 
> This series looks fine to me as far as PCI is concerned, and I'd be
> happy to take it via my tree given an ack from David for this IOMMU
> piece.  Alternatively, you can add my
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> to the other patches if you want to take it via another tree.
> 
> Robin raised a question about basically this same patch the first time
> around.  Not sure whether there's still an objection there.

Ping, David, any thoughts on this patch?

> On Thu, Aug 17, 2017 at 12:10:14PM -0600, Jon Derrick wrote:
> > VMD child devices must use the VMD endpoint's ID as the requester.
> > Because of this, there needs to be a way to link the parent VMD
> > endpoint's iommu group and associated mappings to the VMD child devices
> > such that attaching and detaching child devices modify the endpoint's
> > mappings, while preventing early detaching on a singular device removal
> > or unbinding.
> > 
> > The reassignment of individual VMD child devices devices to VMs is
> > outside the scope of VMD, but may be implemented in the future. For now
> > it is best to prevent any such attempts.
> > 
> > This patch prevents VMD child devices from returning an IOMMU, which
> > prevents it from exposing an iommu_group sysfs directories and allowing
> > subsequent binding by userspace-access drivers such as VFIO.
> > 
> > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 687f18f..94353a6e 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -901,6 +901,11 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
> >  		struct pci_dev *pf_pdev;
> >  
> >  		pdev = to_pci_dev(dev);
> > +
> > +		/* VMD child devices currently cannot be handled individually */
> > +		if (is_vmd(pdev->bus))
> > +			return NULL;
> > +
> >  		/* VFs aren't listed in scope tables; we need to look up
> >  		 * the PF instead to find the IOMMU. */
> >  		pf_pdev = pci_physfn(pdev);
> > -- 
> > 2.9.4
> > 
