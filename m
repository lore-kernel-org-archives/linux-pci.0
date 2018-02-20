Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 20 Feb 2018 11:26:48 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
Message-ID: <5789fb21-dd4b-85a3-e5fc-7212a01fecc7@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-38-jean-philippe.brucker@arm.com>
 <20180216123329.10f6dc23@w520.home>
MIME-Version: 1.0
In-Reply-To: <20180216123329.10f6dc23@w520.home>
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
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 16/02/18 19:33, Alex Williamson wrote:
[...]
>> +static int vfio_iommu_sva_init(struct device *dev, void *data)
>> +{
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
> 
> Typically the order would be reverse of the setup, is it correct this
> way?

I don't think it matters either way, but ABBA order would be nicer.
Registering mm_exit handler before sva_device_init is probably best.

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
> 
> Seems were at an unknown state here, do we need to undo any that
> succeeded?

I think we do. However following the discussion on patch 2/37 it seems
we should limit SVA to singular groups for the moment, disallowing it if
the group has more than one device. Handling compound groups is
complicated and hopefully not needed by SVA systems. So I'd like to
change the logic here and ensure group_for_each_dev only calls sva_init
once.

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
> 
> I don't understand how this works for a process that has exited, the
> mm_exit function gets called to clear vfio_mm.mm, the above may or may
> not work (could be new ptrace'able process with same pid), but it won't
> match the mm below, so is the vfio_mm that mm_exit zapped forever stuck
> in this list until the container is destroyed?

Yes, it's not nice. mm_exit() is called with a spinlock held, so it
can't take the iommu->lock and modify mm_list.
vfio_iommu_type1_unbind_process() could do a bit of garbage collection
and remove all defunct vfio_mm, if they're not held by any iommu_bond
anymore.

But I think iommu_notifier_release (patch 5/37) can actually release the
lock temporarily if it's careful about concurrent list modifications
(and takes a ref to the given bond), in which case we can remove this
mm_exit() constraint and simplify the VFIO patch.

[...]
>> +/*
>> + * Only mode supported at the moment is VFIO_IOMMU_BIND_PROCESS, which takes
>> + * vfio_iommu_type1_bind_process in data.
>> + */
>> +struct vfio_iommu_type1_bind {
>> +	__u32	argsz;
>> +	__u32	mode;
> 
> s/mode/flags/
> 
>> +#define VFIO_IOMMU_BIND_PROCESS		(1 << 0)
>> +	__u8	data[];
>> +};
> 
> I'm not convinced having a separate vfio_iommu_type1_bind_process
> struct is necessary.  It seems like we always expect to return a pasid,
> only the pid is optional, but that could be handled by a single
> structure with a flag bit to indicate a pid bind is requested.

We were planning to reuse VFIO_IOMMU_BIND for PASID table binding as
well. So vfio_iommu_type1_bind::flags would either be
VFIO_IOMMU_BIND_PROCESS or VFIO_IOMMU_BIND_PASID_TABLE, and
vfio_iommu_type1_bind::data is an union of vfio_iommu_type1_bind_process
and vfio_iommu_type1_bind_pasid_table

https://patchwork.kernel.org/patch/9701025/

> 
>> +
>> +/*
>> + * VFIO_IOMMU_BIND - _IOWR(VFIO_TYPE, VFIO_BASE + 22, struct vfio_iommu_bind)
> 
> vfio_iommu_type1_bind

Thanks,
Jean


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
