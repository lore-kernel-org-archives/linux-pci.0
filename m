Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 28 Feb 2018 16:25:37 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Sinan Kaya <okaya@codeaurora.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
Message-ID: <e428976f-c381-309a-be57-264fea5c9b18@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-38-jean-philippe.brucker@arm.com>
 <1e76c66c-952e-71bd-d831-d3a1ded9559c@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1e76c66c-952e-71bd-d831-d3a1ded9559c@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 28/02/18 01:26, Sinan Kaya wrote:
[...]
>> +static int vfio_iommu_sva_init(struct device *dev, void *data)
>> +{
> 
> data is not getting used.

That's the pointer passed to "iommu_group_for_each_dev", NULL at the
moment. Next version of this patch will keep some state in data to
ensure one device per group.

>> +
>> +	int ret;
>> +
>> +	ret = iommu_sva_device_init(dev, IOMMU_SVA_FEAT_PASID |
>> +				    IOMMU_SVA_FEAT_IOPF, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return iommu_register_mm_exit_handler(dev, vfio_iommu_mm_exit);
>> +}
>> +
>> +static int vfio_iommu_sva_shutdown(struct device *dev, void *data)
>> +{
>> +	iommu_sva_device_shutdown(dev);
>> +	iommu_unregister_mm_exit_handler(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int vfio_iommu_bind_group(struct vfio_iommu *iommu,
>> +				 struct vfio_group *group,
>> +				 struct vfio_mm *vfio_mm)
>> +{
>> +	int ret;
>> +	int pasid;
>> +
>> +	if (!group->sva_enabled) {
>> +		ret = iommu_group_for_each_dev(group->iommu_group, NULL,
>> +					       vfio_iommu_sva_init);
>> +		if (ret)
>> +			return ret;
>> +
>> +		group->sva_enabled = true;
>> +	}
>> +
>> +	ret = iommu_sva_bind_group(group->iommu_group, vfio_mm->mm, &pasid,
>> +				   IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF,
>> +				   vfio_mm);
>> +	if (ret)
>> +		return ret;
> 
> don't you need to clean up the work done by vfio_iommu_sva_init() here.

Yes I suppose we can, if we enabled during this bind

[...]
>> +static long vfio_iommu_type1_bind_process(struct vfio_iommu *iommu,
>> +					  void __user *arg,
>> +					  struct vfio_iommu_type1_bind *bind)
>> +{
>> +	struct vfio_iommu_type1_bind_process params;
>> +	struct vfio_domain *domain;
>> +	struct vfio_group *group;
>> +	struct vfio_mm *vfio_mm;
>> +	struct mm_struct *mm;
>> +	unsigned long minsz;
>> +	int ret = 0;
>> +
>> +	minsz = sizeof(*bind) + sizeof(params);
>> +	if (bind->argsz < minsz)
>> +		return -EINVAL;
>> +
>> +	arg += sizeof(*bind);
>> +	if (copy_from_user(&params, arg, sizeof(params)))
>> +		return -EFAULT;
>> +
>> +	if (params.flags & ~VFIO_IOMMU_BIND_PID)
>> +		return -EINVAL;
>> +
>> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
>> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
>> +		if (IS_ERR(mm))
>> +			return PTR_ERR(mm);
>> +	} else {
>> +		mm = get_task_mm(current);
>> +		if (!mm)
>> +			return -EINVAL;
>> +	}
> 
> I think you can merge mm failure in both states.

Yes, I think vfio_iommu_get_mm_by_vpid could return NULL instead of an
error pointer, and we can throw -ESRCH in all cases (the existing
get_task_mm() failure in this driver does return -ESRCH, so it would be
consistent.)

[...]
>> +	/*
>> +	 * We can't simply unbind a foreign process by PASID, because the
>> +	 * process might have died and the PASID might have been reallocated to
>> +	 * another process. Instead we need to fetch that process mm by PID
>> +	 * again to make sure we remove the right vfio_mm. In addition, holding
>> +	 * the mm guarantees that mm_users isn't dropped while we unbind and the
>> +	 * exit_mm handler doesn't fire. While not strictly necessary, not
>> +	 * having to care about that race simplifies everyone's life.
>> +	 */
>> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
>> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
>> +		if (IS_ERR(mm))
>> +			return PTR_ERR(mm);
>> +	} else {
>> +		mm = get_task_mm(current);
>> +		if (!mm)
>> +			return -EINVAL;
>> +	}
>> +
> 
> I think you can merge mm failure in both states.

ok

>> +	ret = -ESRCH;
>> +	mutex_lock(&iommu->lock);
>> +	list_for_each_entry(vfio_mm, &iommu->mm_list, next) {
>> +		if (vfio_mm->mm != mm)
>> +			continue;
>> +
> 
> these loops look wierd 
> 1. for loops + break 
> 2. for loops + goto
> 
> how about closing the for loop here. and then return here if not vfio_mm
> not found.

ok

>> +		vfio_iommu_unbind(iommu, vfio_mm);
>> +		list_del(&vfio_mm->next);
>> +		kfree(vfio_mm);
>> +		ret = 0;
>> +		break;
>> +	}
>> +	mutex_unlock(&iommu->lock);
>> +	mmput(mm);
>> +
>> +	return ret;
>> +}
>> +
> 

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
