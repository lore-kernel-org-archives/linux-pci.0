Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 27 Feb 2017 20:54:11 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 30/30] vfio: Allow to bind foreign task
Message-ID: <20170227205411.1abca59a@t450s.home>
In-Reply-To: <20170227195441.5170-31-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-31-jean-philippe.brucker@arm.com>
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

On Mon, 27 Feb 2017 19:54:41 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Let the process that owns the device create an address space bond on
> behalf of another process. We add a pid argument to the BIND_TASK ioctl,
> allowing the caller to bind a foreign task. The expected program flow in
> this case is:
> 
> * Process A creates the VFIO context and initializes the device.
> * Process B asks A to bind its address space.
> * Process A issues an ioctl to the VFIO device fd with BIND_TASK(pid).
>   It may communicate the given PASID back to process B or keep track of it
>   internally.
> * Process B asks A to perform transactions on its virtual address.
> * Process A launches transaction tagged with the given PASID.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/vfio.c       | 35 +++++++++++++++++++++++++++++++++--
>  include/uapi/linux/vfio.h | 15 +++++++++++++++
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index c4505d8f4c61..ecc5d07e3dbb 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/ptrace.h>
>  #include <linux/rwsem.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -1660,7 +1661,7 @@ static long vfio_svm_ioctl(struct vfio_device *device, unsigned int cmd,
>  	struct vfio_device_svm svm;
>  	struct vfio_task *vfio_task;
>  
> -	minsz = offsetofend(struct vfio_device_svm, pasid);
> +	minsz = offsetofend(struct vfio_device_svm, pid);


This is only the minsz if flags includes VFIO_SVM_PID, right?
Otherwise this isn't a backward compatible change (granted you're
proposing both in the same series), userspace built against 29/30
won't work against 30/30.

>  
>  	if (copy_from_user(&svm, (void __user *)arg, minsz))
>  		return -EFAULT;
> @@ -1669,9 +1670,39 @@ static long vfio_svm_ioctl(struct vfio_device *device, unsigned int cmd,
>  		return -EINVAL;
>  
>  	if (cmd == VFIO_DEVICE_BIND_TASK) {
> -		struct task_struct *task = current;
> +		struct mm_struct *mm;
> +		struct task_struct *task;
> +
> +		if (svm.flags & ~VFIO_SVM_PID)
> +			return -EINVAL;

29/30 never validated flags, so theoretically userspace compiled
against 29/30 could have put anything in flags and it would have
worked, no longer the case here.

> +
> +		if (svm.flags & VFIO_SVM_PID) {
> +			rcu_read_lock();
> +			task = find_task_by_vpid(svm.pid);
> +			if (task)
> +				get_task_struct(task);
> +			rcu_read_unlock();
> +			if (!task)
> +				return -ESRCH;
> +
> +			/*
> +			 * Ensure process has RW access on the task's mm
> +			 * FIXME:
> +			 * - I think this ought to be in the IOMMU API
> +			 * - I'm assuming permission is never revoked during the
> +			 *   task's lifetime. Might be mistaken.
> +			 */
> +			mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +			if (!mm || IS_ERR(mm))
> +				return IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +			mmput(mm);
> +		} else {
> +			get_task_struct(current);
> +			task = current;
> +		}
>  
>  		ret = iommu_bind_task(device->dev, task, &svm.pasid, 0, NULL);
> +		put_task_struct(task);
>  		if (ret)
>  			return ret;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 3fe4197a5ea0..41ae8a231d42 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -415,7 +415,9 @@ struct vfio_device_svm {
>  	__u32	flags;
>  #define VFIO_SVM_PASID_RELEASE_FLUSHED	(1 << 0)
>  #define VFIO_SVM_PASID_RELEASE_CLEAN	(1 << 1)
> +#define VFIO_SVM_PID			(1 << 2)
>  	__u32	pasid;
> +	__u32	pid;
>  };
>  /*
>   * VFIO_DEVICE_BIND_TASK - _IOWR(VFIO_TYPE, VFIO_BASE + 22,
> @@ -432,6 +434,19 @@ struct vfio_device_svm {
>   * On success, VFIO writes a Process Address Space ID (PASID) into @pasid. This
>   * ID is unique to a device.
>   *
> + * VFIO_SVM_PID: bind task @pid instead of current task. The shared address
> + *        space identified by @pasid is that of task identified by @pid.
> + *
> + *        Given that the caller owns the device, setting this flag grants the
> + *        caller read and write permissions on the entire address space of
> + *        foreign task described by @pid. Therefore, permission to perform the
> + *        bind operation on a foreign process is governed by the ptrace access
> + *        mode PTRACE_MODE_ATTACH_REALCREDS check. See man ptrace(2) for more
> + *        information.
> + *
> + *        If the VFIO_SVM_PID flag is not set, @pid is unused and it is the
> + *        current task that is bound to the device.
> + *
>   * The bond between device and process must be removed with
>   * VFIO_DEVICE_UNBIND_TASK before exiting.
>   *

BTW, nice commit logs throughout this series, I probably need to read
through them a few more times to really digest it all.  AIUI, the VFIO
support here is really only useful for basic userspace drivers, I don't
see how we could take advantage of it for a VM use case where the guest
manages the PASID space for a domain.  Perhaps it hasn't spent enough
cycles bouncing around in my head yet.  Thanks,

Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
