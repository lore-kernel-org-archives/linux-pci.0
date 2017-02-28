Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 28 Feb 2017 15:17:46 +0000
From: Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Message-ID: <20170228151746.GA15153@e106794-lin.localdomain>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
 <20170227205409.14f0e2c7@t450s.home>
MIME-Version: 1.0
In-Reply-To: <20170227205409.14f0e2c7@t450s.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

Thanks for the feedback!

On Mon, Feb 27, 2017 at 08:54:09PM -0700, Alex Williamson wrote:
> On Mon, 27 Feb 2017 19:54:40 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
[...]
> >  
> > +static long vfio_svm_ioctl(struct vfio_device *device, unsigned int cmd,
> > +			   unsigned long arg)
> > +{
> > +	int ret;
> > +	unsigned long minsz;
> > +
> > +	struct vfio_device_svm svm;
> > +	struct vfio_task *vfio_task;
> > +
> > +	minsz = offsetofend(struct vfio_device_svm, pasid);
> > +
> > +	if (copy_from_user(&svm, (void __user *)arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (svm.argsz < minsz)
> > +		return -EINVAL;
> > +
> > +	if (cmd == VFIO_DEVICE_BIND_TASK) {
> > +		struct task_struct *task = current;
> 
> Seems like SVM should be in the name of these ioctls.
> 
> svm.flags needs to be validated here or else we lose the field for
> future use... you add this in the next patch, but see compatibility
> comment there.

Agreed, I'll be more careful with the flags.

> > +
> > +		ret = iommu_bind_task(device->dev, task, &svm.pasid, 0, NULL);
> > +		if (ret)
> > +			return ret;
> 
> vfio-pci advertises the device feature, but vfio intercepts the ioctl
> and attempts to handle it regardless of device support.
> 
> We also need to be careful of using, or even referencing iommu_ops
> without regard to the device or IOMMU backend.  SPAPR doesn't fully
> implement IOMMU API, vfio-noiommu devices don't have iommu_ops, mdev
> devices don't either.  I agree with your comments in the cover letter,
> it's not entirely clear that the device fd is the right place to host
> this.

Yes, and I like the idea of moving the ioctl into type1 IOMMU.
Something like VFIO_IOMMU_BIND_TASK (or perhaps VFIO_IOMMU_SVM_BIND?),
applied on the container instead of the device might be better. The
semantics are tricky to define though, both for VFIO and IOMMU, because
devices in a container or an IOMMU group might have different SVM
capabilities.

When this ioctl successfully returns with a PASID, two possibilities:
A. either it implies that all devices attached to the container are now
   able to perform DMA with this PASID,
B. or some devices in the container do not support SVM, but those that
   support it can all use the PASID. The user needs to inspect device
   flags individually to know which can support SVM. When user is a
   userspace device driver, it is familiar with the device it's driving
   and knows whether is supports SVM or not, but a VMM wouldn't.

After binding the container to the task and obtaining a PASID, user
wants to add a group to the container. So we need to replay the binding
on the new group, by telling the IOMMU to use that particular PASID. If
the device supports less PASID bits, I guess we should reject the
attach? If the device doesn't support SVM, for case A we should reject
the attach, for case B we accept it. Alternatively, we could simply
forbid to add groups to containers after a bind.

The problem is similar for adding devices to IOMMU groups. If a group is
bound to an address space, and a less capable device is added to the
group, we probably don't want to reject the device altogether, nor do we
want to unbind the PASID.

> > +
> > +		vfio_task = kzalloc(sizeof(*vfio_task), GFP_KERNEL);
> > +		if (!vfio_task) {
> > +			iommu_unbind_task(device->dev, svm.pasid,
> > +					  IOMMU_PASID_CLEAN);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		vfio_task->pasid = svm.pasid;
> > +
> > +		mutex_lock(&device->tasks_lock);
> > +		list_add(&vfio_task->list, &device->tasks);
> > +		mutex_unlock(&device->tasks_lock);
> > +
> > +	} else {
> > +		int flags = 0;
> > +
> > +		if (svm.flags & ~(VFIO_SVM_PASID_RELEASE_FLUSHED |
> > +				  VFIO_SVM_PASID_RELEASE_CLEAN))
> > +			return -EINVAL;
> > +
> > +		if (svm.flags & VFIO_SVM_PASID_RELEASE_FLUSHED)
> > +			flags = IOMMU_PASID_FLUSHED;
> > +		else if (svm.flags & VFIO_SVM_PASID_RELEASE_CLEAN)
> > +			flags = IOMMU_PASID_CLEAN;
> > +
> > +		mutex_lock(&device->tasks_lock);
> > +		list_for_each_entry(vfio_task, &device->tasks, list) {
> > +			if (vfio_task->pasid != svm.pasid)
> > +				continue;
> > +
> > +			ret = iommu_unbind_task(device->dev, svm.pasid, flags);
> > +			if (ret)
> > +				dev_warn(device->dev, "failed to unbind PASID %u\n",
> > +					 vfio_task->pasid);
> > +
> > +			list_del(&vfio_task->list);
> > +			kfree(vfio_task);
> > +			break;
> > +		}
> > +		mutex_unlock(&device->tasks_lock);
> > +	}
> > +
> > +	return copy_to_user((void __user *)arg, &svm, minsz) ? -EFAULT : 0;
> > +}
> > +
> >  static long vfio_device_fops_unl_ioctl(struct file *filep,
> >  				       unsigned int cmd, unsigned long arg)
> >  {
> > @@ -1630,6 +1728,12 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
> >  	if (unlikely(!device->ops->ioctl))
> >  		return -EINVAL;
> >  
> > +	switch (cmd) {
> > +	case VFIO_DEVICE_BIND_TASK:
> > +	case VFIO_DEVICE_UNBIND_TASK:
> > +		return vfio_svm_ioctl(device, cmd, arg);
> > +	}
> > +
> >  	return device->ops->ioctl(device->device_data, cmd, arg);
> >  }
> >  
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 519eff362c1c..3fe4197a5ea0 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -198,6 +198,7 @@ struct vfio_device_info {
> >  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
> >  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
> >  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> > +#define VFIO_DEVICE_FLAGS_SVM	(1 << 4)	/* Device supports bind/unbind */
> 
> We could also define one of the bits in vfio_device_svm.flags to be
> "probe" (ie. no-op, return success).  Using an SVM flag follows the
> model we used for RESET support, but I'm not convinced that's a great
> model to follow.
> 
> >  	__u32	num_regions;	/* Max region index + 1 */
> >  	__u32	num_irqs;	/* Max IRQ index + 1 */
> >  };
> > @@ -409,6 +410,60 @@ struct vfio_irq_set {
> >   */
> >  #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
> >  
> > +struct vfio_device_svm {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +#define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
> > +#define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> > +	__u32	pasid;
> > +};
> > +/*
> > + * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> > + *                               struct vfio_device_svm)
> > + *
> > + * Share a process' virtual address space with the device.
> > + *
> > + * This feature creates a new address space for the device, which is not
> > + * affected by VFIO_IOMMU_MAP/UNMAP_DMA. Instead, the device can tag its DMA
> > + * traffic with the given @pasid to perform transactions on the associated
> > + * virtual address space. Mapping and unmapping of buffers is performed by
> > + * standard functions such as mmap and malloc.
> > + *
> > + * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
> > + * ID is unique to a device.
> > + *
> > + * The bond between device and process must be removed with
> > + * VFIO_DEVICE_UNBIND_TASK before exiting.
> 
> I'm not sure I understand this since we do a pass of unbinds on
> release.  Certainly we can't rely on the user for cleanup.

We probably shouldn't rely on the user for cleanup, but we need its
assistance. My concern is about PASID state when unbinding. By letting
the user tell via flag "PASID_RELEASE_CLEAN" that it waited for
transactions to finish, we know that the PASID can be recycled and
reused for another task. Otherwise VFIO cannot guarantee on release that
the PASID is safe to reuse. If it did, a pending page fault in the IOMMU
or the downstream bus might hit the next address space that uses this
PASID.

So for the moment, if user doesn't explicitly call unbind with PASID
state flags, the SMMU driver considers that it isn't safe to reuse and
the PASID is never re-allocated.

We could get rid of this concern by having a PCI driver provide VFIO (or
rather the IOMMU driver) with a PASID invalidation callback.

Thanks,
Jean-Philippe

> > + *
> > + * On fork, the child inherits the device fd and can use the bonds setup by its
> > + * parent. Consequently, the child has R/W access on the address spaces bound by
> > + * its parent. After an execv, the device fd is closed and the child doesn't
> > + * have access to the address space anymore.
> > + *
> > + * Availability of this feature depends on the device, its bus, the underlying
> > + * IOMMU and the CPU architecture. All of these are guaranteed when the device
> > + * has VFIO_DEVICE_FLAGS_SVM flag set.
> > + *
> > + * returns: 0 on success, -errno on failure.
> > + */
> > +#define VFIO_DEVICE_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> > +
> > +/*
> > + * VFIO_DEVICE_UNBIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 23,
> > + *                                 struct vfio_device_svm)
> > + *
> > + * Unbind address space identified by @pasid from device. Device must have
> > + * stopped issuing any DMA transaction for the PASID and flushed any reference
> > + * to this PASID upstream. Some IOMMUs need to know when a PASID is safe to
> > + * reuse, in which case one of the following must be present in @flags
> > + *
> > + * VFIO_PASID_RELEASE_FLUSHED: the PASID is safe to reassign after the IOMMU
> > + *       receives an invalidation message from the device.
> > + *
> > + * VFIO_PASID_RELEASE_CLEAN: the PASID is safe to reassign immediately.
> > + */
> > +#define VFIO_DEVICE_UNBIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 23)
> > +
> >  /*
> >   * The VFIO-PCI bus driver makes use of the following fixed region and
> >   * IRQ index mapping.  Unimplemented regions return a size of zero.
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
