Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 14/36] iommu/arm-smmu-v3: Add support for Substream
 IDs
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-15-jean-philippe.brucker@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA838454887@FRAEML521-MBX.china.huawei.com>
 <20171102155152.GA11899@e106794-lin.localdomain>
 <5FC3163CFD30C246ABAA99954A238FA838454A9B@FRAEML521-MBX.china.huawei.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <37a82eaa-dc9d-af98-6cb8-941ca925b838@huawei.com>
Date: Fri, 3 Nov 2017 13:45:26 +0800
MIME-Version: 1.0
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838454A9B@FRAEML521-MBX.china.huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Will Deacon <Will.Deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "Leizhen \(ThunderTown\)" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Robin Murphy <Robin.Murphy@arm.com>, "liubo \(CU\)" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

On 2017/11/3 1:02, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Jean-Philippe Brucker [mailto:Jean-Philippe.Brucker@arm.com]
>> Sent: Thursday, November 02, 2017 3:52 PM
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: linux-arm-kernel@lists.infradead.org; linux-pci@vger.kernel.org; linux-
>> acpi@vger.kernel.org; devicetree@vger.kernel.org; iommu@lists.linux-
>> foundation.org; Mark Rutland <Mark.Rutland@arm.com>; xieyisheng (A)
>> <xieyisheng1@huawei.com>; Gabriele Paoloni
>> <gabriele.paoloni@huawei.com>; Catalin Marinas
>> <Catalin.Marinas@arm.com>; Will Deacon <Will.Deacon@arm.com>;
>> okaya@codeaurora.org; yi.l.liu@intel.com; Lorenzo Pieralisi
>> <Lorenzo.Pieralisi@arm.com>; ashok.raj@intel.com; tn@semihalf.com;
>> joro@8bytes.org; rfranz@cavium.com; lenb@kernel.org;
>> jacob.jun.pan@linux.intel.com; alex.williamson@redhat.com;
>> robh+dt@kernel.org; Leizhen (ThunderTown) <thunder.leizhen@huawei.com>;
>> bhelgaas@google.com; dwmw2@infradead.org; liubo (CU)
>> <liubo95@huawei.com>; rjw@rjwysocki.net; robdclark@gmail.com;
>> hanjun.guo@linaro.org; Sudeep Holla <Sudeep.Holla@arm.com>; Robin
>> Murphy <Robin.Murphy@arm.com>; nwatters@codeaurora.org; Linuxarm
>> <linuxarm@huawei.com>
>> Subject: Re: [RFCv2 PATCH 14/36] iommu/arm-smmu-v3: Add support for
>> Substream IDs
>>
>> Hi Shameer,
>>
>> On Thu, Nov 02, 2017 at 12:49:32PM +0000, Shameerali Kolothum Thodi wrote:
>>> We had a go with this series on HiSIlicon D05 platform which doesn't have
>>> support for ssids/ATS/PRI, to make sure it generally works.
>>>
>>> But observed the below crash on boot,
>>>
>>> [   16.009084] WARNING: CPU: 59 PID: 391 at mm/page_alloc.c:3883
>> __alloc_pages_nodemask+0x19c/0xc48
>>> [   16.026797] Modules linked in:
>>> [   16.032944] CPU: 59 PID: 391 Comm: kworker/59:1 Not tainted 4.14.0-rc1-
>> 159539-ge42aca3 #236
>>> [...]
>>> [   16.068206] Workqueue: events deferred_probe_work_func
>>> [   16.078557] task: ffff8017d38a0000 task.stack: ffff00000b198000
>>> [   16.090486] PC is at __alloc_pages_nodemask+0x19c/0xc48
>>> [   16.101013] LR is at __alloc_pages_nodemask+0xe0/0xc48
>>> [   16.469220] [<ffff000008186b94>] __alloc_pages_nodemask+0x19c/0xc48
>>> [   16.481854] [<ffff0000081d65b0>] alloc_pages_current+0x80/0xcc
>>> [   16.493607] [<ffff000008182be8>] __get_free_pages+0xc/0x38
>>> [   16.504661] [<ffff0000083c4d58>] swiotlb_alloc_coherent+0x64/0x190
>>> [   16.517117] [<ffff00000809824c>] __dma_alloc+0x110/0x204
>>> [   16.527820] [<ffff00000858e850>] dmam_alloc_coherent+0x88/0xf0
>>> [   16.539575] [<ffff000008568884>]
>> arm_smmu_domain_finalise_s1+0x60/0x248
>>> [   16.552909] [<ffff00000856c104>] arm_smmu_attach_dev+0x264/0x300
>>> [   16.565013] [<ffff00000855d40c>] __iommu_attach_device+0x48/0x5c
>>> [   16.577117] [<ffff00000855e698>] iommu_group_add_device+0x144/0x3a4
>>> [   16.589746] [<ffff00000855ed18>] iommu_group_get_for_dev+0x70/0xf8
>>> [   16.602201] [<ffff00000856a314>] arm_smmu_add_device+0x1a4/0x418
>>> [   16.614308] [<ffff00000849dfcc>] iort_iommu_configure+0xf0/0x16c
>>> [   16.626416] [<ffff000008468c50>] acpi_dma_configure+0x30/0x70
>>> [   16.637994] [<ffff00000858f00c>] dma_configure+0xa8/0xd4
>>> [   16.648695] [<ffff00000857706c>] driver_probe_device+0x1a4/0x2dc
>>> [   16.673081] [<ffff0000085752c8>] bus_for_each_drv+0x54/0x94
>>> [   16.684307] [<ffff000008576db0>] __device_attach+0xc4/0x12c
>>> [   16.695533] [<ffff000008577350>] device_initial_probe+0x10/0x18
>>> [   16.707462] [<ffff0000085762b4>] bus_probe_device+0x90/0x98
>>>
>>> After a bit of debug it looks like on platforms where ssid is not supported,
>>> s1_cfg.num_contexts is set to zero and it eventually results in this crash
>>> in,
>>> arm_smmu_domain_finalise_s1() -->arm_smmu_alloc_cd_tables()-->
>>> arm_smmu_alloc_cd_leaf_table() as num_leaf_entries is zero.
>>>
>>> With the below fix, it works on D05 now,
>>>
>>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>>> index 8ad90e2..51f5821 100644
>>> --- a/drivers/iommu/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm-smmu-v3.c
>>> @@ -2433,7 +2433,10 @@ static int arm_smmu_domain_finalise(struct
>> iommu_domain *domain,
>>>                         domain->min_pasid = 1;
>>>                         domain->max_pasid = master->num_ssids - 1;
>>>                         smmu_domain->s1_cfg.num_contexts = master->num_ssids;
>>> +               } else {
>>> +                       smmu_domain->s1_cfg.num_contexts = 1;
>>>                 }
>>> +
>>>                 smmu_domain->s1_cfg.can_stall = master->ste.can_stall;
>>>                 break;
>>>         case ARM_SMMU_DOMAIN_NESTED:
>>>
>>>
>>> I am not sure this is right place do this. Please take a look.
>>
>> Thanks for testing the series and reporting the bug. I added the
>> following patch to branch svm/current, does it work for you?
> 
> Yes, it does.
> 
> Thanks,
> Shameer
>  
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 42c8378624ed..edda466adc81 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -3169,9 +3169,7 @@ static int arm_smmu_add_device(struct device *dev)
>>                 }
>>         }
>>
>> -       if (smmu->ssid_bits)
>> -               master->num_ssids = 1 << min(smmu->ssid_bits,
>> -                                            fwspec->num_pasid_bits);
>> +       master->num_ssids = 1 << min(smmu->ssid_bits, fwspec-
>>> num_pasid_bits);

If fwspec->num_pasid_bits = 0, then master have _one_ num_ssids ?

It seems Shameerali's fix is better ?

>>
>>         if (fwspec->can_stall && smmu->features & ARM_SMMU_FEAT_STALLS) {
>>                 master->can_fault = true;
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
