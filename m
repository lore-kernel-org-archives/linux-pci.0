Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC,20/30] iommu/arm-smmu-v3: Enable PCI PASID in masters
To: Sinan Kaya <okaya@codeaurora.org>
References: <20170227195441.5170-21-jean-philippe.brucker@arm.com>
 <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
Message-ID: <a5428875-6ff9-820a-498d-ae2602e8cc53@arm.com>
Date: Thu, 1 Jun 2017 13:30:37 +0100
MIME-Version: 1.0
In-Reply-To: <f18163da-30a6-a7d4-0a2c-bca4fc1b0fff@codeaurora.org>
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
 Alex Williamson <alex.williamson@redhat.com>,
 Harv Abdulhamid <harba@qti.qualcomm.com>, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On 31/05/17 15:10, Sinan Kaya wrote:
> Hi Jean-Philippe,
> 
> On 2/27/2017 2:54 PM, Jean-Philippe Brucker wrote:
>> Enable PASID for PCI devices that support it.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 63 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 499dc1cd07eb..37fd061405e9 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -730,6 +730,8 @@ struct arm_smmu_master_data {
>>  
>>  	struct arm_smmu_stream		*streams;
>>  	struct rb_root			contexts;
>> +
>> +	u32				avail_contexts;
>>  };
>>  
> 
> I know that you are doing some code restructuring. As I was looking at the amdkfd
> driver, I realized that there is quite a bit of PASID, ATS and PRI work here that
> can be plumbed into the framework you are building. 
>
> https://github.com/torvalds/linux/tree/master/drivers/gpu/drm/amd/amdkfd

Yes, the current plan is to create a PASID (SSID) allocator that could be
used by AMD, Intel, ARM, and other IOMMUs. Currently the kfd driver
allocates PASIDs, but this will be done by the IOMMU subsystem in the
future. Writing the generic allocator isn't on my schedule for the next
few months, though.

I'm trying to implement the next version of SMMU SVM with the following
principles in mind, and Intel are reworking their PASID allocator similarly.

* One PASID per task. Therefore bind(devA, task1) bind(devB, task1) will
return the same PASID. The PASID space is system-wide, just like ASIDs in ARM.

For ARM:

* PASID != ASID, because the PASID range depends on device capabilities,
while ASID range depends on the CPU. So PASID table might be smaller than
ASID range.

* PASID range and other SVM capabilities are capped by the weakest device
in an iommu_domain. This allows the SMMU driver to have a single context
table per domain. The downside is that if you attach the odd device that
doesn't support SVM to a domain before the first bind, then bind fails
(for any device in the domain). If you attach it after the first bind,
then the attach fails.

> I wanted to share this with if you were aware of this or not. Functions of interest
> are:
> 
> amd_iommu_init_device
> amd_iommu_free_device
> amd_iommu_bind_pasid
> amd_iommu_set_invalid_ppr_cb
> amd_iommu_unbind_pasid
> amd_iommu_device_info
> 

* amd_iommu_bind/unbind_pasid would be replaced by iommu_bind/unbind
* amd_iommu_set_invalid_ppr_cb/set_invalidate_ctx_cb would be replaced by
iommu_set_svm_ops.
* amd_iommu_init_device/amd_iommu_free_device would be performed
internally. init_device could be done by iommu_attach_dev, or by
iommu_bind lazily. free_device would be done by detach_dev.
* and_iommu_device_info may not be needed. Drivers can use iommu_bind to
check SVM capability (maybe with a dry-run flag like intel does).

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
