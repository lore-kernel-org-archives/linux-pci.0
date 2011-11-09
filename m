Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mtv-iport-4.cisco.com ([173.36.130.15]:42422 "EHLO
	mtv-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab1KIE0l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2011 23:26:41 -0500
Date: Tue, 08 Nov 2011 20:17:09 -0800
Subject: Re: [RFC PATCH] vfio: VFIO Driver core framework
From: Aaron Fabbri <aafabbri@cisco.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	<chrisw@sous-sol.org>, <aik@au1.ibm.com>, <pmac@au1.ibm.com>,
	<dwg@au1.ibm.com>, <joerg.roedel@amd.com>, <agraf@suse.de>,
	<benve@cisco.com>, <B08248@freescale.com>, <B07421@freescale.com>,
	<avi@redhat.com>, <konrad.wilk@oracle.com>, <kvm@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <iommu@lists.linux-foundation.org>,
	<linux-pci@vger.kernel.org>
Message-ID: <CADF3EC5.12356%aafabbri@cisco.com>
In-Reply-To: <20111103195452.21259.93021.stgit@bling.home>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm going to send out chunks of comments as I go over this stuff.  Below
I've covered the documentation file and vfio_iommu.c.  More comments coming
soon...

On 11/3/11 1:12 PM, "Alex Williamson" <alex.williamson@redhat.com> wrote:

> VFIO provides a secure, IOMMU based interface for user space
> drivers, including device assignment to virtual machines.
> This provides the base management of IOMMU groups, devices,
> and IOMMU objects.  See Documentation/vfio.txt included in
> this patch for user and kernel API description.
> 
> Note, this implements the new API discussed at KVM Forum
> 2011, as represented by the drvier version 0.2.  It's hoped
> that this provides a modular enough interface to support PCI
> and non-PCI userspace drivers across various architectures
> and IOMMU implementations.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
<snip>
> +
> +Groups, Devices, IOMMUs, oh my
> +-----------------------------------------------------------------------------
> --
> +
> +A fundamental component of VFIO is the notion of IOMMU groups.  IOMMUs
> +can't always distinguish transactions from each individual device in
> +the system.  Sometimes this is because of the IOMMU design, such as with
> +PEs, other times it's caused by the I/O topology, for instance a

Can you define this acronym the first time you use it, i.e.

+ PEs (partitionable endpoints), ...

> +PCIe-to-PCI bridge masking all devices behind it.  We call the sets of
> +devices created by these restictions IOMMU groups (or just "groups" for

restrictions

> +this document).
> +
> +The IOMMU cannot distiguish transactions between the individual devices

distinguish

> +within the group, therefore the group is the basic unit of ownership for
> +a userspace process.  Because of this, groups are also the primary
> +interface to both devices and IOMMU domains in VFIO.
> +
<snip>
> +file descriptor referencing the same internal IOMMU object from either
> +X or Y).  Merged groups can be dissolved either explictly with UNMERGE

explicitly

<snip>
> +
> +Device tree devices also invlude ioctls for further defining the

include

<snip>
> diff --git a/drivers/vfio/vfio_iommu.c b/drivers/vfio/vfio_iommu.c
> new file mode 100644
> index 0000000..029dae3
> --- /dev/null
> +++ b/drivers/vfio/vfio_iommu.c
<snip>
> +static struct dma_map_page *vfio_find_dma(struct vfio_iommu *iommu,
> +                      dma_addr_t start, size_t size)
> +{
> +    struct list_head *pos;
> +    struct dma_map_page *mlp;
> +
> +    list_for_each(pos, &iommu->dm_list) {
> +        mlp = list_entry(pos, struct dma_map_page, list);
> +        if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> +                   start, size))
> +            return mlp;
> +    }
> +    return NULL;
> +}
> +

This function below should be static.

> +int vfio_remove_dma_overlap(struct vfio_iommu *iommu, dma_addr_t start,
> +                size_t size, struct dma_map_page *mlp)
> +{
> +    struct dma_map_page *split;
> +    int npage_lo, npage_hi;
> +
> +    /* Existing dma region is completely covered, unmap all */
> +    if (start <= mlp->daddr &&
> +        start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> +        vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> +        list_del(&mlp->list);
> +        npage_lo = mlp->npage;
> +        kfree(mlp);
> +        return npage_lo;
> +    }
> +
> +    /* Overlap low address of existing range */
> +    if (start <= mlp->daddr) {
> +        size_t overlap;
> +
> +        overlap = start + size - mlp->daddr;
> +        npage_lo = overlap >> PAGE_SHIFT;
> +        npage_hi = mlp->npage - npage_lo;

npage_hi not used.. Delete this line ^

> +
> +        vfio_dma_unmap(iommu, mlp->daddr, npage_lo, mlp->rdwr);
> +        mlp->daddr += overlap;
> +        mlp->vaddr += overlap;
> +        mlp->npage -= npage_lo;
> +        return npage_lo;
> +    }
> +
> +    /* Overlap high address of existing range */
> +    if (start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> +        size_t overlap;
> +
> +        overlap = mlp->daddr + NPAGE_TO_SIZE(mlp->npage) - start;
> +        npage_hi = overlap >> PAGE_SHIFT;
> +        npage_lo = mlp->npage - npage_hi;
> +
> +        vfio_dma_unmap(iommu, start, npage_hi, mlp->rdwr);
> +        mlp->npage -= npage_hi;
> +        return npage_hi;
> +    }
> +
> +    /* Split existing */
> +    npage_lo = (start - mlp->daddr) >> PAGE_SHIFT;
> +    npage_hi = mlp->npage - (size >> PAGE_SHIFT) - npage_lo;
> +
> +    split = kzalloc(sizeof *split, GFP_KERNEL);
> +    if (!split)
> +        return -ENOMEM;
> +
> +    vfio_dma_unmap(iommu, start, size >> PAGE_SHIFT, mlp->rdwr);
> +
> +    mlp->npage = npage_lo;
> +
> +    split->npage = npage_hi;
> +    split->daddr = start + size;
> +    split->vaddr = mlp->vaddr + NPAGE_TO_SIZE(npage_lo) + size;
> +    split->rdwr = mlp->rdwr;
> +    list_add(&split->list, &iommu->dm_list);
> +    return size >> PAGE_SHIFT;
> +}
> +

Function should be static.

> +int vfio_dma_unmap_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> +{
> +    int ret = 0;
> +    size_t npage = dmp->size >> PAGE_SHIFT;
> +    struct list_head *pos, *n;
> +
> +    if (dmp->dmaaddr & ~PAGE_MASK)
> +        return -EINVAL;
> +    if (dmp->size & ~PAGE_MASK)
> +        return -EINVAL;
> +
> +    mutex_lock(&iommu->dgate);
> +
> +    list_for_each_safe(pos, n, &iommu->dm_list) {
> +        struct dma_map_page *mlp;
> +
> +        mlp = list_entry(pos, struct dma_map_page, list);
> +        if (ranges_overlap(mlp->daddr, NPAGE_TO_SIZE(mlp->npage),
> +                   dmp->dmaaddr, dmp->size)) {
> +            ret = vfio_remove_dma_overlap(iommu, dmp->dmaaddr,
> +                              dmp->size, mlp);
> +            if (ret > 0)
> +                npage -= NPAGE_TO_SIZE(ret);

Why NPAGE_TO_SIZE here?

> +            if (ret < 0 || npage == 0)
> +                break;
> +        }
> +    }
> +    mutex_unlock(&iommu->dgate);
> +    return ret > 0 ? 0 : ret;
> +}
> +

Function should be static.

> +int vfio_dma_map_dm(struct vfio_iommu *iommu, struct vfio_dma_map *dmp)
> +{
> +    int npage;
> +    struct dma_map_page *mlp, *mmlp = NULL;
> +    dma_addr_t daddr = dmp->dmaaddr;

