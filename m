Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 27 Feb 2017 20:54:09 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Message-ID: <20170227205409.14f0e2c7@t450s.home>
In-Reply-To: <20170227195441.5170-30-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
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

On Mon, 27 Feb 2017 19:54:40 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Add two new ioctl for VFIO devices. VFIO_DEVICE_BIND_TASK creates a bond
> between a device and a process address space, identified by a
> device-specific ID named PASID. This allows the device to target DMA
> transactions at the process virtual addresses without a need for mapping
> and unmapping buffers explicitly in the IOMMU. The process page tables are
> shared with the IOMMU, and mechanisms such as PCI ATS/PRI may be used to
> handle faults. VFIO_DEVICE_UNBIND_TASK removed a bond identified by a
> PASID.
> 
> Also add a capability flag in device info to detect whether the system and
> the device support SVM.
> 
> Users need to specify the state of a PASID when unbinding, with flags
> VFIO_PASID_RELEASE_FLUSHED and VFIO_PASID_RELEASE_CLEAN. Even for PCI,
> PASID invalidation is specific to each device and only partially covered
> by the specification:
> 
> * Device must have an implementation-defined mechanism for stopping the
>   use of a PASID. When this mechanism finishes, the device has stopped
>   issuing transactions for this PASID and all transactions for this PASID
>   have been flushed to the IOMMU.
> 
> * Device may either wait for all outstanding PRI requests for this PASID
>   to finish, or issue a Stop Marker message, a barrier that separates PRI
>   requests affecting this instance of the PASID from PRI requests
>   affecting the next instance. In the first case, we say that the PASID is
>   "clean", in the second case it is "flushed" (and the IOMMU has to wait
>   for the Stop Marker before reassigning the PASID.)
> 
> We expect similar distinctions for platform devices. Ideally there should
> be a callback for each PCI device, allowing the IOMMU to ask the device to
> stop using a PASID. When the callback returns, the PASID is either flushed
> or clean and the return value tells which.
> 
> For the moment I don't know how to implement this callback for PCI, so if
> the user forgets to call unbind with either "clean" or "flushed", the
> PASID is never reused. For platform devices, it might be simpler to
> implement since we could associate an invalidate_pasid callback to a DT
> compatible string, as is currently done for reset.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |  24 ++++++++++
>  drivers/vfio/vfio.c         | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h   |  55 +++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 324c52e3a1a4..3d7733f94891 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -22,6 +22,7 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -623,6 +624,26 @@ int vfio_pci_register_dev_region(struct vfio_pci_device *vdev,
>  	return 0;
>  }
>  
> +static bool vfio_pci_supports_svm(struct vfio_pci_device *vdev)
> +{
> +	struct pci_dev *pdev = vdev->pdev;
> +
> +	if (!pdev->ats_enabled)
> +		return false;
> +
> +	if (!pdev->pasid_enabled || pci_max_pasids(pdev) <= 1)
> +		return false;
> +
> +	if (!pdev->pri_enabled)
> +		return false;
> +
> +	/*
> +	 * If the IOMMU driver enabled all of these, then it supports PCI SVM
> +	 * for this device.
> +	 */
> +	return true;
> +}
> +
>  static long vfio_pci_ioctl(void *device_data,
>  			   unsigned int cmd, unsigned long arg)
>  {
> @@ -642,6 +663,9 @@ static long vfio_pci_ioctl(void *device_data,
>  
>  		info.flags = VFIO_DEVICE_FLAGS_PCI;
>  
> +		if (vfio_pci_supports_svm(vdev))
> +			info.flags |= VFIO_DEVICE_FLAGS_SVM;
> +
>  		if (vdev->reset_works)
>  			info.flags |= VFIO_DEVICE_FLAGS_RESET;
>  
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 609f4f982c74..c4505d8f4c61 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -97,6 +97,14 @@ struct vfio_device {
>  	struct vfio_group		*group;
>  	struct list_head		group_next;
>  	void				*device_data;
> +
> +	struct mutex			tasks_lock;
> +	struct list_head		tasks;
> +};
> +
> +struct vfio_task {
> +	int				pasid;
> +	struct list_head		list;
>  };
>  
>  #ifdef CONFIG_VFIO_NOIOMMU
> @@ -520,6 +528,9 @@ struct vfio_device *vfio_group_create_device(struct vfio_group *group,
>  	device->device_data = device_data;
>  	dev_set_drvdata(dev, device);
>  
> +	mutex_init(&device->tasks_lock);
> +	INIT_LIST_HEAD(&device->tasks);
> +
>  	/* No need to get group_lock, caller has group reference */
>  	vfio_group_get(group);
>  
> @@ -532,6 +543,8 @@ struct vfio_device *vfio_group_create_device(struct vfio_group *group,
>  
>  static void vfio_device_release(struct kref *kref)
>  {
> +	int ret;
> +	struct vfio_task *tmp, *task;
>  	struct vfio_device *device = container_of(kref,
>  						  struct vfio_device, kref);
>  	struct vfio_group *group = device->group;
> @@ -539,6 +552,22 @@ static void vfio_device_release(struct kref *kref)
>  	list_del(&device->group_next);
>  	mutex_unlock(&group->device_lock);
>  
> +	mutex_lock(&device->tasks_lock);
> +	list_for_each_entry_safe(task, tmp, &device->tasks, list) {
> +		/*
> +		 * This might leak the PASID, since the IOMMU won't know
> +		 * if it is safe to reuse.
> +		 */
> +		ret = iommu_unbind_task(device->dev, task->pasid, 0);
> +		if (ret)
> +			dev_warn(device->dev, "failed to unbind PASID %u\n",
> +				 task->pasid);
> +
> +		list_del(&task->list);
> +		kfree(task);
> +	}
> +	mutex_unlock(&device->tasks_lock);
> +
>  	dev_set_drvdata(device->dev, NULL);
>  
>  	kfree(device);
> @@ -1622,6 +1651,75 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
>  	return 0;
>  }
>  
> +static long vfio_svm_ioctl(struct vfio_device *device, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	int ret;
> +	unsigned long minsz;
> +
> +	struct vfio_device_svm svm;
> +	struct vfio_task *vfio_task;
> +
> +	minsz = offsetofend(struct vfio_device_svm, pasid);
> +
> +	if (copy_from_user(&svm, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (svm.argsz < minsz)
> +		return -EINVAL;
> +
> +	if (cmd == VFIO_DEVICE_BIND_TASK) {
> +		struct task_struct *task = current;

Seems like SVM should be in the name of these ioctls.

svm.flags needs to be validated here or else we lose the field for
future use... you add this in the next patch, but see compatibility
comment there.

> +
> +		ret = iommu_bind_task(device->dev, task, &svm.pasid, 0, NULL);
> +		if (ret)
> +			return ret;

vfio-pci advertises the device feature, but vfio intercepts the ioctl
and attempts to handle it regardless of device support.

We also need to be careful of using, or even referencing iommu_ops
without regard to the device or IOMMU backend.  SPAPR doesn't fully
implement IOMMU API, vfio-noiommu devices don't have iommu_ops, mdev
devices don't either.  I agree with your comments in the cover letter,
it's not entirely clear that the device fd is the right place to host
this.

> +
> +		vfio_task = kzalloc(sizeof(*vfio_task), GFP_KERNEL);
> +		if (!vfio_task) {
> +			iommu_unbind_task(device->dev, svm.pasid,
> +					  IOMMU_PASID_CLEAN);
> +			return -ENOMEM;
> +		}
> +
> +		vfio_task->pasid = svm.pasid;
> +
> +		mutex_lock(&device->tasks_lock);
> +		list_add(&vfio_task->list, &device->tasks);
> +		mutex_unlock(&device->tasks_lock);
> +
> +	} else {
> +		int flags = 0;
> +
> +		if (svm.flags & ~(VFIO_SVM_PASID_RELEASE_FLUSHED |
> +				  VFIO_SVM_PASID_RELEASE_CLEAN))
> +			return -EINVAL;
> +
> +		if (svm.flags & VFIO_SVM_PASID_RELEASE_FLUSHED)
> +			flags = IOMMU_PASID_FLUSHED;
> +		else if (svm.flags & VFIO_SVM_PASID_RELEASE_CLEAN)
> +			flags = IOMMU_PASID_CLEAN;
> +
> +		mutex_lock(&device->tasks_lock);
> +		list_for_each_entry(vfio_task, &device->tasks, list) {
> +			if (vfio_task->pasid != svm.pasid)
> +				continue;
> +
> +			ret = iommu_unbind_task(device->dev, svm.pasid, flags);
> +			if (ret)
> +				dev_warn(device->dev, "failed to unbind PASID %u\n",
> +					 vfio_task->pasid);
> +
> +			list_del(&vfio_task->list);
> +			kfree(vfio_task);
> +			break;
> +		}
> +		mutex_unlock(&device->tasks_lock);
> +	}
> +
> +	return copy_to_user((void __user *)arg, &svm, minsz) ? -EFAULT : 0;
> +}
> +
>  static long vfio_device_fops_unl_ioctl(struct file *filep,
>  				       unsigned int cmd, unsigned long arg)
>  {
> @@ -1630,6 +1728,12 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
>  	if (unlikely(!device->ops->ioctl))
>  		return -EINVAL;
>  
> +	switch (cmd) {
> +	case VFIO_DEVICE_BIND_TASK:
> +	case VFIO_DEVICE_UNBIND_TASK:
> +		return vfio_svm_ioctl(device, cmd, arg);
> +	}
> +
>  	return device->ops->ioctl(device->device_data, cmd, arg);
>  }
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 519eff362c1c..3fe4197a5ea0 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -198,6 +198,7 @@ struct vfio_device_info {
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
>  #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
>  #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
> +#define VFIO_DEVICE_FLAGS_SVM	(1 << 4)	/* Device supports bind/unbind */

We could also define one of the bits in vfio_device_svm.flags to be
"probe" (ie. no-op, return success).  Using an SVM flag follows the
model we used for RESET support, but I'm not convinced that's a great
model to follow.

>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };
> @@ -409,6 +410,60 @@ struct vfio_irq_set {
>   */
>  #define VFIO_DEVICE_RESET		_IO(VFIO_TYPE, VFIO_BASE + 11)
>  
> +struct vfio_device_svm {
> +	__u32	argsz;
> +	__u32	flags;
> +#define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
> +#define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> +	__u32	pasid;
> +};
> +/*
> + * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> + *                               struct vfio_device_svm)
> + *
> + * Share a process' virtual address space with the device.
> + *
> + * This feature creates a new address space for the device, which is not
> + * affected by VFIO_IOMMU_MAP/UNMAP_DMA. Instead, the device can tag its DMA
> + * traffic with the given @pasid to perform transactions on the associated
> + * virtual address space. Mapping and unmapping of buffers is performed by
> + * standard functions such as mmap and malloc.
> + *
> + * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
> + * ID is unique to a device.
> + *
> + * The bond between device and process must be removed with
> + * VFIO_DEVICE_UNBIND_TASK before exiting.

I'm not sure I understand this since we do a pass of unbinds on
release.  Certainly we can't rely on the user for cleanup.

> + *
> + * On fork, the child inherits the device fd and can use the bonds setup by its
> + * parent. Consequently, the child has R/W access on the address spaces bound by
> + * its parent. After an execv, the device fd is closed and the child doesn't
> + * have access to the address space anymore.
> + *
> + * Availability of this feature depends on the device, its bus, the underlying
> + * IOMMU and the CPU architecture. All of these are guaranteed when the device
> + * has VFIO_DEVICE_FLAGS_SVM flag set.
> + *
> + * returns: 0 on success, -errno on failure.
> + */
> +#define VFIO_DEVICE_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> +
> +/*
> + * VFIO_DEVICE_UNBIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 23,
> + *                                 struct vfio_device_svm)
> + *
> + * Unbind address space identified by @pasid from device. Device must have
> + * stopped issuing any DMA transaction for the PASID and flushed any reference
> + * to this PASID upstream. Some IOMMUs need to know when a PASID is safe to
> + * reuse, in which case one of the following must be present in @flags
> + *
> + * VFIO_PASID_RELEASE_FLUSHED: the PASID is safe to reassign after the IOMMU
> + *       receives an invalidation message from the device.
> + *
> + * VFIO_PASID_RELEASE_CLEAN: the PASID is safe to reassign immediately.
> + */
> +#define VFIO_DEVICE_UNBIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 23)
> +
>  /*
>   * The VFIO-PCI bus driver makes use of the following fixed region and
>   * IRQ index mapping.  Unimplemented regions return a size of zero.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
