Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:29647 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab1KNW7S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 14 Nov 2011 17:59:18 -0500
Message-ID: <1321311540.17169.122.camel@bling.home>
Subject: RE: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: "Christian Benvenuti (benve)" <benve@cisco.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	"Aaron Fabbri (aafabbri)" <aafabbri@cisco.com>,
	B08248@freescale.com, B07421@freescale.com, avi@redhat.com,
	konrad.wilk@oracle.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Date: Mon, 14 Nov 2011 15:59:00 -0700
In-Reply-To: <184D23435BECB444AB6B9D4630C8EC8302D603A9@XMB-RCD-303.cisco.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <184D23435BECB444AB6B9D4630C8EC8302D5FE38@XMB-RCD-303.cisco.com>
	 <1321034647.2682.98.camel@bling.home>
	 <184D23435BECB444AB6B9D4630C8EC8302D603A9@XMB-RCD-303.cisco.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2011-11-11 at 16:22 -0600, Christian Benvenuti (benve) wrote:
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Friday, November 11, 2011 10:04 AM
> > To: Christian Benvenuti (benve)
> > Cc: chrisw@sous-sol.org; aik@au1.ibm.com; pmac@au1.ibm.com;
> > dwg@au1.ibm.com; joerg.roedel@amd.com; agraf@suse.de; Aaron Fabbri
> > (aafabbri); B08248@freescale.com; B07421@freescale.com; avi@redhat.com;
> > konrad.wilk@oracle.com; kvm@vger.kernel.org; qemu-devel@nongnu.org;
> > iommu@lists.linux-foundation.org; linux-pci@vger.kernel.org
> > Subject: RE: [RFC PATCH] vfio: VFIO Driver core framework
> > 
> > On Wed, 2011-11-09 at 18:57 -0600, Christian Benvenuti (benve) wrote:
> > > Here are few minor comments on vfio_iommu.c ...
> > 
> > Sorry, I've been poking sticks at trying to figure out a clean way to
> > solve the force vfio driver attach problem.
> 
> Attach o detach?

Attach.  For the case when a new device appears that belongs to a group
that already in use.  I'll probably add a claim() operation to the
vfio_device_ops that tells the driver to grab it.  I was hoping for pci
this would just add it to the dynamic ids, but that hits device lock
problems.

> > > > diff --git a/drivers/vfio/vfio_iommu.c b/drivers/vfio/vfio_iommu.c
> > > > new file mode 100644
> > > > index 0000000..029dae3
> > > > --- /dev/null
> > > > +++ b/drivers/vfio/vfio_iommu.c
> > <snip>
> > > > +
> > > > +#include "vfio_private.h"
> > >
> > > Doesn't the 'dma_'  prefix belong to the generic DMA code?
> > 
> > Sure, we could these more vfio-centric.
> 
> Like vfio_dma_map_page?

Something like that, though _page doesn't seem appropriate as it tracks
a region.

> > 
> > > > +struct dma_map_page {
> > > > +	struct list_head	list;
> > > > +	dma_addr_t		daddr;
> > > > +	unsigned long		vaddr;
> > > > +	int			npage;
> > > > +	int			rdwr;
> > > > +};
> > > > +
> > > > +/*
> > > > + * This code handles mapping and unmapping of user data buffers
> > > > + * into DMA'ble space using the IOMMU
> > > > + */
> > > > +
> > > > +#define NPAGE_TO_SIZE(npage)	((size_t)(npage) << PAGE_SHIFT)
> > > > +
> > > > +struct vwork {
> > > > +	struct mm_struct	*mm;
> > > > +	int			npage;
> > > > +	struct work_struct	work;
> > > > +};
> > > > +
> > > > +/* delayed decrement for locked_vm */
> > > > +static void vfio_lock_acct_bg(struct work_struct *work)
> > > > +{
> > > > +	struct vwork *vwork = container_of(work, struct vwork, work);
> > > > +	struct mm_struct *mm;
> > > > +
> > > > +	mm = vwork->mm;
> > > > +	down_write(&mm->mmap_sem);
> > > > +	mm->locked_vm += vwork->npage;
> > > > +	up_write(&mm->mmap_sem);
> > > > +	mmput(mm);		/* unref mm */
> > > > +	kfree(vwork);
> > > > +}
> > > > +
> > > > +static void vfio_lock_acct(int npage)
> > > > +{
> > > > +	struct vwork *vwork;
> > > > +	struct mm_struct *mm;
> > > > +
> > > > +	if (!current->mm) {
> > > > +		/* process exited */
> > > > +		return;
> > > > +	}
> > > > +	if (down_write_trylock(&current->mm->mmap_sem)) {
> > > > +		current->mm->locked_vm += npage;
> > > > +		up_write(&current->mm->mmap_sem);
> > > > +		return;
> > > > +	}
> > > > +	/*
> > > > +	 * Couldn't get mmap_sem lock, so must setup to decrement
> > >                                                       ^^^^^^^^^
> > >
> > > Increment?
> > 
> > Yep

Actually, side note, this is increment/decrement depending on the sign
of the parameter.  So "update" may be more appropriate.  I think Tom
originally used increment in one place and decrement in another to show
it's dual use.

> > <snip>
> > > > +int vfio_remove_dma_overlap(struct vfio_iommu *iommu, dma_addr_t
> > > > start,
> > > > +			    size_t size, struct dma_map_page *mlp)
> > > > +{
> > > > +	struct dma_map_page *split;
> > > > +	int npage_lo, npage_hi;
> > > > +
> > > > +	/* Existing dma region is completely covered, unmap all */
> > >
> > > This works. However, given how vfio_dma_map_dm implements the merging
> > > logic, I think it is impossible to have
> > >
> > >     (start < mlp->daddr &&
> > >      start + size > mlp->daddr + NPAGE_TO_SIZE(mlp->npage))
> > 
> > It's quite possible.  This allows userspace to create a sparse mapping,
> > then blow it all away with a single unmap from 0 to ~0.
> 
> I would prefer the user to use exact ranges in the unmap operations
> because it would make it easier to detect bugs/leaks in the map/unmap
> logic used by the callers.
> My assumptions are that:
> 
> - the user always keeps track of the mappings

My qemu code plays a little on the loose side here, acting as a
passthrough for the internal memory client.  But even there, worst case
would probably be trying to unmap a non-existent entry, not unmapping a
sparse range.

> - the user either unmaps one specific mapping or 'all of them'.
>   The 'all of them' case would also take care of those cases where
>   the user does _not_ keep track of mappings and simply uses
>   the "unmap from 0 to ~0" each time.
> 
> Because of this you could still provide an exact map/unmap logic
> and allow such "unmap from 0 to ~0" by making the latter a special
> case.
> However, if we want to allow any arbitrary/inexact unmap request, then OK.

I can't think of any good reasons we shouldn't be more strict.  I think
it was primarily just convenient to hit all the corner cases since we
merge all the requests together for tracking and need to be able to
split them back apart.  It does feel a little awkward to have a 0/~0
special case though, but I don't think it's worth adding another ioctl
to handle it.

<snip>
> > > > +        if (cmd == VFIO_IOMMU_GET_FLAGS) {
> > > > +                u64 flags = VFIO_IOMMU_FLAGS_MAP_ANY;
> > > > +
> > > > +                ret = put_user(flags, (u64 __user *)arg);
> > > > +
> > > > +        } else if (cmd == VFIO_IOMMU_MAP_DMA) {
> > > > +		struct vfio_dma_map dm;
> > > > +
> > > > +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> > > > +			return -EFAULT;
> > >
> > > What does the "_dm" suffix stand for?
> > 
> > Inherited from Tom, but I figure _dma_map_dm = action(dma map),
> > object(dm), which is a vfio_Dma_Map.
> 
> OK. The reason why I asked is that '_dm' does not add anything to 'vfio_dma_map'.

Yep.  Thanks,

Alex


