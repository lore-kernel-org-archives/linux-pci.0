Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758149Ab1KKTFP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 11 Nov 2011 14:05:15 -0500
Message-ID: <1321034647.2682.98.camel@bling.home>
Subject: RE: [RFC PATCH] vfio: VFIO Driver core framework
From: Alex Williamson <alex.williamson@redhat.com>
To: "Christian Benvenuti (benve)" <benve@cisco.com>
Cc: chrisw@sous-sol.org, aik@au1.ibm.com, pmac@au1.ibm.com,
	dwg@au1.ibm.com, joerg.roedel@amd.com, agraf@suse.de,
	"Aaron Fabbri (aafabbri)" <aafabbri@cisco.com>,
	B08248@freescale.com, B07421@freescale.com, avi@redhat.com,
	konrad.wilk@oracle.com, kvm@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Date: Fri, 11 Nov 2011 11:04:07 -0700
In-Reply-To: <184D23435BECB444AB6B9D4630C8EC8302D5FE38@XMB-RCD-303.cisco.com>
References: <20111103195452.21259.93021.stgit@bling.home>
	 <184D23435BECB444AB6B9D4630C8EC8302D5FE38@XMB-RCD-303.cisco.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2011-11-09 at 18:57 -0600, Christian Benvenuti (benve) wrote:
> Here are few minor comments on vfio_iommu.c ...

Sorry, I've been poking sticks at trying to figure out a clean way to
solve the force vfio driver attach problem.

> > diff --git a/drivers/vfio/vfio_iommu.c b/drivers/vfio/vfio_iommu.c
> > new file mode 100644
> > index 0000000..029dae3
> > --- /dev/null
> > +++ b/drivers/vfio/vfio_iommu.c
<snip>
> > +
> > +#include "vfio_private.h"
> 
> Doesn't the 'dma_'  prefix belong to the generic DMA code?

Sure, we could these more vfio-centric.

> > +struct dma_map_page {
> > +	struct list_head	list;
> > +	dma_addr_t		daddr;
> > +	unsigned long		vaddr;
> > +	int			npage;
> > +	int			rdwr;
> > +};
> > +
> > +/*
> > + * This code handles mapping and unmapping of user data buffers
> > + * into DMA'ble space using the IOMMU
> > + */
> > +
> > +#define NPAGE_TO_SIZE(npage)	((size_t)(npage) << PAGE_SHIFT)
> > +
> > +struct vwork {
> > +	struct mm_struct	*mm;
> > +	int			npage;
> > +	struct work_struct	work;
> > +};
> > +
> > +/* delayed decrement for locked_vm */
> > +static void vfio_lock_acct_bg(struct work_struct *work)
> > +{
> > +	struct vwork *vwork = container_of(work, struct vwork, work);
> > +	struct mm_struct *mm;
> > +
> > +	mm = vwork->mm;
> > +	down_write(&mm->mmap_sem);
> > +	mm->locked_vm += vwork->npage;
> > +	up_write(&mm->mmap_sem);
> > +	mmput(mm);		/* unref mm */
> > +	kfree(vwork);
> > +}
> > +
> > +static void vfio_lock_acct(int npage)
> > +{
> > +	struct vwork *vwork;
> > +	struct mm_struct *mm;
> > +
> > +	if (!current->mm) {
> > +		/* process exited */
> > +		return;
> > +	}
> > +	if (down_write_trylock(&current->mm->mmap_sem)) {
> > +		current->mm->locked_vm += npage;
> > +		up_write(&current->mm->mmap_sem);
> > +		return;
> > +	}
> > +	/*
> > +	 * Couldn't get mmap_sem lock, so must setup to decrement
>                                                       ^^^^^^^^^
> 
> Increment?

Yep

<snip>
> > +int vfio_remove_dma_overlap(struct vfio_iommu *iommu, dma_addr_t
> > start,
> > +			    size_t size, struct dma_map_page *mlp)
> > +{
> > +	struct dma_map_page *split;
> > +	int npage_lo, npage_hi;
> > +
> > +	/* Existing dma region is completely covered, unmap all */
> 
> This works. However, given how vfio_dma_map_dm implements the merging
> logic, I think it is impossible to have
> 
>     (start < mlp->daddr &&
>      start + size > mlp->daddr + NPAGE_TO_SIZE(mlp->npage))

It's quite possible.  This allows userspace to create a sparse mapping,
then blow it all away with a single unmap from 0 to ~0.

> > +	if (start <= mlp->daddr &&
> > +	    start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> > +		vfio_dma_unmap(iommu, mlp->daddr, mlp->npage, mlp->rdwr);
> > +		list_del(&mlp->list);
> > +		npage_lo = mlp->npage;
> > +		kfree(mlp);
> > +		return npage_lo;
> > +	}
> > +
> > +	/* Overlap low address of existing range */
> 
> Same as above (ie, '<' is impossible)

existing:   |<--- A --->|      |<--- B --->|
unmap:                |<--- C --->|

Maybe not good practice from userspace, but we shouldn't count on
userspace to be well behaved.

> > +	if (start <= mlp->daddr) {
> > +		size_t overlap;
> > +
> > +		overlap = start + size - mlp->daddr;
> > +		npage_lo = overlap >> PAGE_SHIFT;
> > +		npage_hi = mlp->npage - npage_lo;
> > +
> > +		vfio_dma_unmap(iommu, mlp->daddr, npage_lo, mlp->rdwr);
> > +		mlp->daddr += overlap;
> > +		mlp->vaddr += overlap;
> > +		mlp->npage -= npage_lo;
> > +		return npage_lo;
> > +	}
> 
> Same as above (ie, '>' is impossible).

Same example as above.

> > +	/* Overlap high address of existing range */
> > +	if (start + size >= mlp->daddr + NPAGE_TO_SIZE(mlp->npage)) {
> > +		size_t overlap;
> > +
> > +		overlap = mlp->daddr + NPAGE_TO_SIZE(mlp->npage) - start;
> > +		npage_hi = overlap >> PAGE_SHIFT;
> > +		npage_lo = mlp->npage - npage_hi;
> > +
> > +		vfio_dma_unmap(iommu, start, npage_hi, mlp->rdwr);
> > +		mlp->npage -= npage_hi;
> > +		return npage_hi;
> > +	}
<snip>
> > +int vfio_dma_map_dm(struct vfio_iommu *iommu, struct vfio_dma_map
> > *dmp)
> > +{
> > +	int npage;
> > +	struct dma_map_page *mlp, *mmlp = NULL;
> > +	dma_addr_t daddr = dmp->dmaaddr;
> > +	unsigned long locked, lock_limit, vaddr = dmp->vaddr;
> > +	size_t size = dmp->size;
> > +	int ret = 0, rdwr = dmp->flags & VFIO_DMA_MAP_FLAG_WRITE;
> > +
> > +	if (vaddr & (PAGE_SIZE-1))
> > +		return -EINVAL;
> > +	if (daddr & (PAGE_SIZE-1))
> > +		return -EINVAL;
> > +	if (size & (PAGE_SIZE-1))
> > +		return -EINVAL;
> > +
> > +	npage = size >> PAGE_SHIFT;
> > +	if (!npage)
> > +		return -EINVAL;
> > +
> > +	if (!iommu)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&iommu->dgate);
> > +
> > +	if (vfio_find_dma(iommu, daddr, size)) {
> > +		ret = -EBUSY;
> > +		goto out_lock;
> > +	}
> > +
> > +	/* account for locked pages */
> > +	locked = current->mm->locked_vm + npage;
> > +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> > +		printk(KERN_WARNING "%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
> > +			__func__, rlimit(RLIMIT_MEMLOCK));
> > +		ret = -ENOMEM;
> > +		goto out_lock;
> > +	}
> > +
> > +	ret = vfio_dma_map(iommu, daddr, vaddr, npage, rdwr);
> > +	if (ret)
> > +		goto out_lock;
> > +
> > +	/* Check if we abut a region below */
> 
> Is !daddr possible?

Sure, an IOVA of 0x0.  There's no region below if we start at zero.

> > +	if (daddr) {
> > +		mlp = vfio_find_dma(iommu, daddr - 1, 1);
> > +		if (mlp && mlp->rdwr == rdwr &&
> > +		    mlp->vaddr + NPAGE_TO_SIZE(mlp->npage) == vaddr) {
> > +
> > +			mlp->npage += npage;
> > +			daddr = mlp->daddr;
> > +			vaddr = mlp->vaddr;
> > +			npage = mlp->npage;
> > +			size = NPAGE_TO_SIZE(npage);
> > +
> > +			mmlp = mlp;
> > +		}
> > +	}
> 
> Is !(daddr + size) possible?

Same, there's no region above if this region goes to the top of the
address space, ie. 0xffffffff_fffff000 + 0x1000

Hmm, wonder if I'm missing a check for wrapping.

> > +	if (daddr + size) {
> > +		mlp = vfio_find_dma(iommu, daddr + size, 1);
> > +		if (mlp && mlp->rdwr == rdwr && mlp->vaddr == vaddr + size)
> > {
> > +
> > +			mlp->npage += npage;
> > +			mlp->daddr = daddr;
> > +			mlp->vaddr = vaddr;
> > +
> > +			/* If merged above and below, remove previously
> > +			 * merged entry.  New entry covers it.  */
> > +			if (mmlp) {
> > +				list_del(&mmlp->list);
> > +				kfree(mmlp);
> > +			}
> > +			mmlp = mlp;
> > +		}
> > +	}
> > +
> > +	if (!mmlp) {
> > +		mlp = kzalloc(sizeof *mlp, GFP_KERNEL);
> > +		if (!mlp) {
> > +			ret = -ENOMEM;
> > +			vfio_dma_unmap(iommu, daddr, npage, rdwr);
> > +			goto out_lock;
> > +		}
> > +
> > +		mlp->npage = npage;
> > +		mlp->daddr = daddr;
> > +		mlp->vaddr = vaddr;
> > +		mlp->rdwr = rdwr;
> > +		list_add(&mlp->list, &iommu->dm_list);
> > +	}
> > +
> > +out_lock:
> > +	mutex_unlock(&iommu->dgate);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_release(struct inode *inode, struct file *filep)
> > +{
> > +	struct vfio_iommu *iommu = filep->private_data;
> > +
> > +	vfio_release_iommu(iommu);
> > +	return 0;
> > +}
> > +
> > +static long vfio_iommu_unl_ioctl(struct file *filep,
> > +				 unsigned int cmd, unsigned long arg)
> > +{
> > +	struct vfio_iommu *iommu = filep->private_data;
> > +	int ret = -ENOSYS;
> 
> Any reason for not using "switch" ?

It got ugly in vfio_main, so I decided to be consistent w/ it in the
driver and use if/else here too.  I don't like the aesthetics of extra
{}s to declare variables within a switch, nor do I like declaring all
the variables for each case for the whole function.  Personal quirk.

> > +        if (cmd == VFIO_IOMMU_GET_FLAGS) {
> > +                u64 flags = VFIO_IOMMU_FLAGS_MAP_ANY;
> > +
> > +                ret = put_user(flags, (u64 __user *)arg);
> > +
> > +        } else if (cmd == VFIO_IOMMU_MAP_DMA) {
> > +		struct vfio_dma_map dm;
> > +
> > +		if (copy_from_user(&dm, (void __user *)arg, sizeof dm))
> > +			return -EFAULT;
> 
> What does the "_dm" suffix stand for?

Inherited from Tom, but I figure _dma_map_dm = action(dma map),
object(dm), which is a vfio_Dma_Map.

Thanks,

Alex

