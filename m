Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750885AbdH3Vlm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Aug 2017 17:41:42 -0400
Date: Wed, 30 Aug 2017 16:41:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] vmd: Remove IRQ affinity
Message-ID: <20170830214139.GY8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1504109704-17033-1-git-send-email-keith.busch@intel.com>
 <20170830164020.GC18250@bhelgaas-glaptop.roam.corp.google.com>
 <20170830202340.GA17331@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170830202340.GA17331@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 30, 2017 at 04:23:40PM -0400, Keith Busch wrote:
> On Wed, Aug 30, 2017 at 09:40:20AM -0700, Bjorn Helgaas wrote:
> > [+cc Christoph]
> > 
> > On Wed, Aug 30, 2017 at 12:15:04PM -0400, Keith Busch wrote:
> > > VMD hardware has to share its vectors among child devices in its PCI
> > > domain so we should allocate as many as possible rather than just ones
> > > that can be affinitized.
> > 
> > I don't understand this changelog.  It suggests that
> > pci_alloc_irq_vectors() will allocate more vectors than
> > pci_alloc_irq_vectors_affinity() would.
> > 
> > But my understanding was that pci_alloc_irq_vectors_affinity() does have
> > anything to do with the number of vectors allocated, but that it only
> > provided more fine-grained control of affinity.
> > 
> >   commit 402723ad5c62
> >   Author: Christoph Hellwig <hch@lst.de>
> >   Date:   Tue Nov 8 17:15:05 2016 -0800
> > 
> >     PCI/MSI: Provide pci_alloc_irq_vectors_affinity()
> >     
> >     This is a variant of pci_alloc_irq_vectors() that allows passing a struct
> >     irq_affinity to provide fine-grained IRQ affinity control.
> >     
> >     For now this means being able to exclude vectors at the beginning or end of
> >     the MSI vector space, but it could also be used for any other quirks needed
> >     in the future (e.g. more vectors than CPUs, or excluding CPUs from the
> >     spreading).
> > 
> > So IIUC, this patch does not change the number of vectors allocated.  It
> > does remove PCI_IRQ_AFFINITY, which I suppose means all the vectors target
> > the same CPU instead of being spread across CPUs.
> 
> VMD has to divvy interrupt vectors up among potentially many devices,
> so we want to always get the maximum vectors possible.
> 
> By default, PCI_IRQ_AFFINITY flag will have 'nvecs' capped by
> irq_calc_affinity_vectors, which is the number of present CPUs and
> potentially lower than the available vectors.

Mmmm, OK.  I guess there's a hint in the changelog above, but it
wasn't obvious from the pci_alloc_irq_vectors_affinity() comment that
it caps to the number of CPUs.  

> We could use the struct irq_affinity to define pre/post vectors to be
> excluded from affinity consideration so that we can get more vectors
> than CPUs, but it would be weird to have some of these general purpose
> vectors affinity set by the kernel and others set by the user.

I added some breadcrumbs to the changelog about this connection
between affinity and limiting the number of IRQs.  Did I get this
right?

This is on pci/host-vmd for v4.14.


commit be85af02e1b00d49cd678d8f2ea6f391bdbaca19
Author: Keith Busch <keith.busch@intel.com>
Date:   Wed Aug 30 12:15:04 2017 -0400

    PCI: vmd: Remove IRQ affinity so we can allocate more IRQs
    
    VMD hardware has to share its vectors among child devices in its PCI
    domain so we should allocate as many as possible rather than just ones
    that can be affinitized.
    
    pci_alloc_irq_vectors_affinity() limits the number of affinitized IRQs to
    the number of present CPUs (see irq_calc_affinity_vectors()).  But we'd
    prefer to have more vectors, even if they aren't distributed across the
    CPUs, so use pci_alloc_irq_vectors() instead.
    
    Reported-by: Brad Goodman <Bradley.Goodman@dell.com>
    Signed-off-by: Keith Busch <keith.busch@intel.com>
    [bhelgaas: add irq_calc_affinity_vectors() reference to changelog]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
index 4fe1756af010..509893bc3e63 100644
--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -671,14 +671,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	struct vmd_dev *vmd;
 	int i, err;
 
-	/*
-	 * The first vector is reserved for special use, so start affinity at
-	 * the second vector
-	 */
-	struct irq_affinity affd = {
-		.pre_vectors = 1,
-	};
-
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
 
@@ -704,8 +696,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
-					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
+	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
+					PCI_IRQ_MSIX);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
