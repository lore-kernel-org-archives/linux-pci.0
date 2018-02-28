Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-38-jean-philippe.brucker@arm.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <1e76c66c-952e-71bd-d831-d3a1ded9559c@codeaurora.org>
Date: Tue, 27 Feb 2018 20:26:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-38-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 catalin.marinas@arm.com, xuzaibo@huawei.com, jonathan.cameron@huawei.com,
 will.deacon@arm.com, yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
 ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org, bharatku@xilinx.com,
 rfranz@cavium.com, lenb@kernel.org, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com,
 bhelgaas@google.com, shunyong.yang@hxt-semitech.com, dwmw2@infradead.org,
 liubo95@huawei.com, rjw@rjwysocki.net, jcrouse@codeaurora.org,
 robdclark@gmail.com, hanjun.guo@linaro.org, sudeep.holla@arm.com,
 robin.murphy@arm.com, christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> Add two new ioctl for VFIO containers. VFIO_IOMMU_BIND_PROCESS creates a
> bond between a container and a process address space, identified by a
> device-specific ID named PASID. This allows the device to target DMA
> transactions at the process virtual addresses without a need for mapping
> and unmapping buffers explicitly in the IOMMU. The process page tables are
> shared with the IOMMU, and mechanisms such as PCI ATS/PRI are used to
> handle faults. VFIO_IOMMU_UNBIND_PROCESS removes a bond created with
> VFIO_IOMMU_BIND_PROCESS.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 399 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  76 ++++++++
>  2 files changed, 475 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e30e29ae4819..cac066f0026b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -30,6 +30,7 @@
>  #include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
> +#include <linux/ptrace.h>
>  #include <linux/rbtree.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
> @@ -60,6 +61,7 @@ MODULE_PARM_DESC(disable_hugepages,
>  
>  struct vfio_iommu {
>  	struct list_head	domain_list;
> +	struct list_head	mm_list;
>  	struct vfio_domain	*external_domain; /* domain for external user */
>  	struct mutex		lock;
>  	struct rb_root		dma_list;
> @@ -90,6 +92,15 @@ struct vfio_dma {
>  struct vfio_group {
>  	struct iommu_group	*iommu_group;
>  	struct list_head	next;
> +	bool			sva_enabled;
> +};
> +
> +struct vfio_mm {
> +#define VFIO_PASID_INVALID	(-1)
> +	spinlock_t		lock;
> +	int			pasid;
> +	struct mm_struct	*mm;
> +	struct list_head	next;
>  };
>  
>  /*
> @@ -1117,6 +1128,157 @@ static int vfio_iommu_replay(struct vfio_iommu *iommu,
>  	return 0;
>  }
>  
> +static int vfio_iommu_mm_exit(struct device *dev, int pasid, void *data)
> +{
> +	struct vfio_mm *vfio_mm = data;
> +
> +	/*
> +	 * The mm_exit callback cannot block, so we can't take the iommu mutex
> +	 * and remove this vfio_mm from the list. Hopefully the SVA code will
> +	 * relax its locking requirement in the future.
> +	 *
> +	 * We mostly care about attach_group, which will attempt to replay all
> +	 * binds in this container. Ensure that it doesn't touch this defunct mm
> +	 * struct, by clearing the pointer. The structure will be freed when the
> +	 * group is removed from the container.
> +	 */
> +	spin_lock(&vfio_mm->lock);
> +	vfio_mm->mm = NULL;
> +	spin_unlock(&vfio_mm->lock);
> +
> +	return 0;
> +}
> +
> +static int vfio_iommu_sva_init(struct device *dev, void *data)
> +{

data is not getting used.

> +
> +	int ret;
> +
> +	ret = iommu_sva_device_init(dev, IOMMU_SVA_FEAT_PASID |
> +				    IOMMU_SVA_FEAT_IOPF, 0);
> +	if (ret)
> +		return ret;
> +
> +	return iommu_register_mm_exit_handler(dev, vfio_iommu_mm_exit);
> +}
> +
> +static int vfio_iommu_sva_shutdown(struct device *dev, void *data)
> +{
> +	iommu_sva_device_shutdown(dev);
> +	iommu_unregister_mm_exit_handler(dev);
> +
> +	return 0;
> +}
> +
> +static int vfio_iommu_bind_group(struct vfio_iommu *iommu,
> +				 struct vfio_group *group,
> +				 struct vfio_mm *vfio_mm)
> +{
> +	int ret;
> +	int pasid;
> +
> +	if (!group->sva_enabled) {
> +		ret = iommu_group_for_each_dev(group->iommu_group, NULL,
> +					       vfio_iommu_sva_init);
> +		if (ret)
> +			return ret;
> +
> +		group->sva_enabled = true;
> +	}
> +
> +	ret = iommu_sva_bind_group(group->iommu_group, vfio_mm->mm, &pasid,
> +				   IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF,
> +				   vfio_mm);
> +	if (ret)
> +		return ret;

don't you need to clean up the work done by vfio_iommu_sva_init() here.

> +
> +	if (WARN_ON(vfio_mm->pasid != VFIO_PASID_INVALID && pasid !=
> +		    vfio_mm->pasid))
> +		return -EFAULT;
> +
> +	vfio_mm->pasid = pasid;
> +
> +	return 0;
> +}
> +
> +static void vfio_iommu_unbind_group(struct vfio_group *group,
> +				    struct vfio_mm *vfio_mm)
> +{
> +	iommu_sva_unbind_group(group->iommu_group, vfio_mm->pasid);
> +}
> +
> +static void vfio_iommu_unbind(struct vfio_iommu *iommu,
> +			      struct vfio_mm *vfio_mm)
> +{
> +	struct vfio_group *group;
> +	struct vfio_domain *domain;
> +
> +	list_for_each_entry(domain, &iommu->domain_list, next)
> +		list_for_each_entry(group, &domain->group_list, next)
> +			vfio_iommu_unbind_group(group, vfio_mm);
> +}
> +
> +static bool vfio_mm_get(struct vfio_mm *vfio_mm)
> +{
> +	bool ret;
> +
> +	spin_lock(&vfio_mm->lock);
> +	ret = vfio_mm->mm && mmget_not_zero(vfio_mm->mm);
> +	spin_unlock(&vfio_mm->lock);
> +
> +	return ret;
> +}
> +
> +static void vfio_mm_put(struct vfio_mm *vfio_mm)
> +{
> +	mmput(vfio_mm->mm);
> +}
> +
> +static int vfio_iommu_replay_bind(struct vfio_iommu *iommu, struct vfio_group *group)
> +{
> +	int ret = 0;
> +	struct vfio_mm *vfio_mm;
> +
> +	list_for_each_entry(vfio_mm, &iommu->mm_list, next) {
> +		/*
> +		 * Ensure mm doesn't exit while we're binding it to the new
> +		 * group.
> +		 */
> +		if (!vfio_mm_get(vfio_mm))
> +			continue;
> +		ret = vfio_iommu_bind_group(iommu, group, vfio_mm);
> +		vfio_mm_put(vfio_mm);
> +
> +		if (ret)
> +			goto out_unbind;
> +	}
> +
> +	return 0;
> +
> +out_unbind:
> +	list_for_each_entry_continue_reverse(vfio_mm, &iommu->mm_list, next) {
> +		if (!vfio_mm_get(vfio_mm))
> +			continue;
> +		iommu_sva_unbind_group(group->iommu_group, vfio_mm->pasid);
> +		vfio_mm_put(vfio_mm);
> +	}
> +
> +	return ret;
> +}
> +
> +static void vfio_iommu_free_all_mm(struct vfio_iommu *iommu)
> +{
> +	struct vfio_mm *vfio_mm, *tmp;
> +
> +	/*
> +	 * No need for unbind() here. Since all groups are detached from this
> +	 * iommu, bonds have been removed.
> +	 */
> +	list_for_each_entry_safe(vfio_mm, tmp, &iommu->mm_list, next)
> +		kfree(vfio_mm);
> +	INIT_LIST_HEAD(&iommu->mm_list);
> +}
> +
>  /*
>   * We change our unmap behavior slightly depending on whether the IOMMU
>   * supports fine-grained superpages.  IOMMUs like AMD-Vi will use a superpage
> @@ -1301,6 +1463,15 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		    d->prot == domain->prot) {
>  			iommu_detach_group(domain->domain, iommu_group);
>  			if (!iommu_attach_group(d->domain, iommu_group)) {
> +				if (vfio_iommu_replay_bind(iommu, group)) {
> +					iommu_detach_group(d->domain, iommu_group);
> +					ret = iommu_attach_group(domain->domain,
> +								 iommu_group);
> +					if (ret)
> +						goto out_domain;
> +					continue;
> +				}
> +
>  				list_add(&group->next, &d->group_list);
>  				iommu_domain_free(domain->domain);
>  				kfree(domain);
> @@ -1321,6 +1492,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_detach;
>  
> +	ret = vfio_iommu_replay_bind(iommu, group);
> +	if (ret)
> +		goto out_detach;
> +
>  	if (resv_msi) {
>  		ret = iommu_get_msi_cookie(domain->domain, resv_msi_base);
>  		if (ret)
> @@ -1426,6 +1601,11 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  			continue;
>  
>  		iommu_detach_group(domain->domain, iommu_group);
> +		if (group->sva_enabled) {
> +			iommu_group_for_each_dev(iommu_group, NULL,
> +						 vfio_iommu_sva_shutdown);
> +			group->sva_enabled = false;
> +		}
>  		list_del(&group->next);
>  		kfree(group);
>  		/*
> @@ -1441,6 +1621,7 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  					vfio_iommu_unmap_unpin_all(iommu);
>  				else
>  					vfio_iommu_unmap_unpin_reaccount(iommu);
> +				vfio_iommu_free_all_mm(iommu);
>  			}
>  			iommu_domain_free(domain->domain);
>  			list_del(&domain->next);
> @@ -1475,6 +1656,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>  	}
>  
>  	INIT_LIST_HEAD(&iommu->domain_list);
> +	INIT_LIST_HEAD(&iommu->mm_list);
>  	iommu->dma_list = RB_ROOT;
>  	mutex_init(&iommu->lock);
>  	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
> @@ -1509,6 +1691,7 @@ static void vfio_iommu_type1_release(void *iommu_data)
>  		kfree(iommu->external_domain);
>  	}
>  
> +	vfio_iommu_free_all_mm(iommu);
>  	vfio_iommu_unmap_unpin_all(iommu);
>  
>  	list_for_each_entry_safe(domain, domain_tmp,
> @@ -1537,6 +1720,184 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>  	return ret;
>  }
>  
> +static struct mm_struct *vfio_iommu_get_mm_by_vpid(pid_t vpid)
> +{
> +	struct mm_struct *mm;
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	task = find_task_by_vpid(vpid);
> +	if (task)
> +		get_task_struct(task);
> +	rcu_read_unlock();
> +	if (!task)
> +		return ERR_PTR(-ESRCH);
> +
> +	/* Ensure that current has RW access on the mm */
> +	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +	put_task_struct(task);
> +
> +	if (!mm)
> +		return ERR_PTR(-ESRCH);
> +
> +	return mm;
> +}
> +
> +static long vfio_iommu_type1_bind_process(struct vfio_iommu *iommu,
> +					  void __user *arg,
> +					  struct vfio_iommu_type1_bind *bind)
> +{
> +	struct vfio_iommu_type1_bind_process params;
> +	struct vfio_domain *domain;
> +	struct vfio_group *group;
> +	struct vfio_mm *vfio_mm;
> +	struct mm_struct *mm;
> +	unsigned long minsz;
> +	int ret = 0;
> +
> +	minsz = sizeof(*bind) + sizeof(params);
> +	if (bind->argsz < minsz)
> +		return -EINVAL;
> +
> +	arg += sizeof(*bind);
> +	if (copy_from_user(&params, arg, sizeof(params)))
> +		return -EFAULT;
> +
> +	if (params.flags & ~VFIO_IOMMU_BIND_PID)
> +		return -EINVAL;
> +
> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
> +		if (IS_ERR(mm))
> +			return PTR_ERR(mm);
> +	} else {
> +		mm = get_task_mm(current);
> +		if (!mm)
> +			return -EINVAL;
> +	}

I think you can merge mm failure in both states.

> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_put_mm;
> +	}
> +
> +	list_for_each_entry(vfio_mm, &iommu->mm_list, next) {
> +		if (vfio_mm->mm != mm)
> +			continue;
> +
> +		params.pasid = vfio_mm->pasid;
> +
> +		ret = copy_to_user(arg, &params, sizeof(params)) ? -EFAULT : 0;
> +		goto out_put_mm;
> +	}
> +
> +	vfio_mm = kzalloc(sizeof(*vfio_mm), GFP_KERNEL);
> +	if (!vfio_mm) {
> +		ret = -ENOMEM;
> +		goto out_put_mm;
> +	}
> +
> +	vfio_mm->mm = mm;
> +	vfio_mm->pasid = VFIO_PASID_INVALID;
> +	spin_lock_init(&vfio_mm->lock);
> +
> +	list_for_each_entry(domain, &iommu->domain_list, next) {
> +		list_for_each_entry(group, &domain->group_list, next) {
> +			ret = vfio_iommu_bind_group(iommu, group, vfio_mm);
> +			if (ret)
> +				break;
> +		}
> +		if (ret)
> +			break;
> +	}
> +
> +	if (ret) {
> +		/* Undo all binds that already succeeded */
> +		list_for_each_entry_continue_reverse(group, &domain->group_list,
> +						     next)
> +			vfio_iommu_unbind_group(group, vfio_mm);
> +		list_for_each_entry_continue_reverse(domain, &iommu->domain_list,
> +						     next)
> +			list_for_each_entry(group, &domain->group_list, next)
> +				vfio_iommu_unbind_group(group, vfio_mm);
> +		kfree(vfio_mm);
> +	} else {
> +		list_add(&vfio_mm->next, &iommu->mm_list);
> +
> +		params.pasid = vfio_mm->pasid;
> +		ret = copy_to_user(arg, &params, sizeof(params)) ? -EFAULT : 0;
> +		if (ret) {
> +			vfio_iommu_unbind(iommu, vfio_mm);
> +			kfree(vfio_mm);
> +		}
> +	}
> +
> +out_put_mm:
> +	mutex_unlock(&iommu->lock);
> +	mmput(mm);
> +
> +	return ret;
> +}
> +
> +static long vfio_iommu_type1_unbind_process(struct vfio_iommu *iommu,
> +					    void __user *arg,
> +					    struct vfio_iommu_type1_bind *bind)
> +{
> +	int ret = -EINVAL;
> +	unsigned long minsz;
> +	struct mm_struct *mm;
> +	struct vfio_mm *vfio_mm;
> +	struct vfio_iommu_type1_bind_process params;
> +
> +	minsz = sizeof(*bind) + sizeof(params);
> +	if (bind->argsz < minsz)
> +		return -EINVAL;
> +
> +	arg += sizeof(*bind);
> +	if (copy_from_user(&params, arg, sizeof(params)))
> +		return -EFAULT;
> +
> +	if (params.flags & ~VFIO_IOMMU_BIND_PID)
> +		return -EINVAL;
> +
> +	/*
> +	 * We can't simply unbind a foreign process by PASID, because the
> +	 * process might have died and the PASID might have been reallocated to
> +	 * another process. Instead we need to fetch that process mm by PID
> +	 * again to make sure we remove the right vfio_mm. In addition, holding
> +	 * the mm guarantees that mm_users isn't dropped while we unbind and the
> +	 * exit_mm handler doesn't fire. While not strictly necessary, not
> +	 * having to care about that race simplifies everyone's life.
> +	 */
> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
> +		if (IS_ERR(mm))
> +			return PTR_ERR(mm);
> +	} else {
> +		mm = get_task_mm(current);
> +		if (!mm)
> +			return -EINVAL;
> +	}
> +

I think you can merge mm failure in both states.

> +	ret = -ESRCH;
> +	mutex_lock(&iommu->lock);
> +	list_for_each_entry(vfio_mm, &iommu->mm_list, next) {
> +		if (vfio_mm->mm != mm)
> +			continue;
> +

these loops look wierd 
1. for loops + break 
2. for loops + goto

how about closing the for loop here. and then return here if not vfio_mm
not found.


> +		vfio_iommu_unbind(iommu, vfio_mm);
> +		list_del(&vfio_mm->next);
> +		kfree(vfio_mm);
> +		ret = 0;
> +		break;
> +	}
> +	mutex_unlock(&iommu->lock);
> +	mmput(mm);
> +
> +	return ret;
> +}
> +

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
