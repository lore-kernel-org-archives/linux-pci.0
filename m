Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [RFCv2 PATCH 14/36] iommu/arm-smmu-v3: Add support for
 Substream IDs
Date: Thu, 2 Nov 2017 12:49:32 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838454887@FRAEML521-MBX.china.huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-15-jean-philippe.brucker@arm.com>
In-Reply-To: <20171006133203.22803-15-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "xieyisheng \(A\)" <xieyisheng1@huawei.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "Leizhen \(ThunderTown\)" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "liubo \(CU\)" <liubo95@huawei.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org]
> On Behalf Of Jean-Philippe Brucker
> Sent: Friday, October 06, 2017 2:32 PM
> To: linux-arm-kernel@lists.infradead.org; linux-pci@vger.kernel.org; linux-
> acpi@vger.kernel.org; devicetree@vger.kernel.org; iommu@lists.linux-
> foundation.org
> Cc: mark.rutland@arm.com; xieyisheng (A) <xieyisheng1@huawei.com>;
> Gabriele Paoloni <gabriele.paoloni@huawei.com>; catalin.marinas@arm.com;
> will.deacon@arm.com; okaya@codeaurora.org; yi.l.liu@intel.com;
> lorenzo.pieralisi@arm.com; ashok.raj@intel.com; tn@semihalf.com;
> joro@8bytes.org; rfranz@cavium.com; lenb@kernel.org;
> jacob.jun.pan@linux.intel.com; alex.williamson@redhat.com;
> robh+dt@kernel.org; Leizhen (ThunderTown) <thunder.leizhen@huawei.com>;
> bhelgaas@google.com; dwmw2@infradead.org; liubo (CU)
> <liubo95@huawei.com>; rjw@rjwysocki.net; robdclark@gmail.com;
> hanjun.guo@linaro.org; sudeep.holla@arm.com; robin.murphy@arm.com;
> nwatters@codeaurora.org
> Subject: [RFCv2 PATCH 14/36] iommu/arm-smmu-v3: Add support for
> Substream IDs
> 
> At the moment, the SMMUv3 driver offers only one stage-1 or stage-2
> address space to each device. SMMUv3 allows to associate multiple address
> spaces per device. In addition to the Stream ID (SID), that identifies a
> device, we can now have Substream IDs (SSID) identifying an address space.
> In PCIe lingo, SID is called Requester ID (RID) and SSID is called Process
> Address-Space ID (PASID).

We had a go with this series on HiSIlicon D05 platform which doesn't have
support for ssids/ATS/PRI, to make sure it generally works.

But observed the below crash on boot,

[   16.009084] WARNING: CPU: 59 PID: 391 at mm/page_alloc.c:3883 __alloc_pages_nodemask+0x19c/0xc48
[   16.026797] Modules linked in:
[   16.032944] CPU: 59 PID: 391 Comm: kworker/59:1 Not tainted 4.14.0-rc1-159539-ge42aca3 #236
[...]
[   16.068206] Workqueue: events deferred_probe_work_func
[   16.078557] task: ffff8017d38a0000 task.stack: ffff00000b198000
[   16.090486] PC is at __alloc_pages_nodemask+0x19c/0xc48
[   16.101013] LR is at __alloc_pages_nodemask+0xe0/0xc48
[   16.469220] [<ffff000008186b94>] __alloc_pages_nodemask+0x19c/0xc48
[   16.481854] [<ffff0000081d65b0>] alloc_pages_current+0x80/0xcc
[   16.493607] [<ffff000008182be8>] __get_free_pages+0xc/0x38
[   16.504661] [<ffff0000083c4d58>] swiotlb_alloc_coherent+0x64/0x190
[   16.517117] [<ffff00000809824c>] __dma_alloc+0x110/0x204
[   16.527820] [<ffff00000858e850>] dmam_alloc_coherent+0x88/0xf0
[   16.539575] [<ffff000008568884>] arm_smmu_domain_finalise_s1+0x60/0x248
[   16.552909] [<ffff00000856c104>] arm_smmu_attach_dev+0x264/0x300
[   16.565013] [<ffff00000855d40c>] __iommu_attach_device+0x48/0x5c
[   16.577117] [<ffff00000855e698>] iommu_group_add_device+0x144/0x3a4
[   16.589746] [<ffff00000855ed18>] iommu_group_get_for_dev+0x70/0xf8
[   16.602201] [<ffff00000856a314>] arm_smmu_add_device+0x1a4/0x418
[   16.614308] [<ffff00000849dfcc>] iort_iommu_configure+0xf0/0x16c
[   16.626416] [<ffff000008468c50>] acpi_dma_configure+0x30/0x70
[   16.637994] [<ffff00000858f00c>] dma_configure+0xa8/0xd4
[   16.648695] [<ffff00000857706c>] driver_probe_device+0x1a4/0x2dc
[   16.673081] [<ffff0000085752c8>] bus_for_each_drv+0x54/0x94
[   16.684307] [<ffff000008576db0>] __device_attach+0xc4/0x12c
[   16.695533] [<ffff000008577350>] device_initial_probe+0x10/0x18
[   16.707462] [<ffff0000085762b4>] bus_probe_device+0x90/0x98

After a bit of debug it looks like on platforms where ssid is not supported,
s1_cfg.num_contexts is set to zero and it eventually results in this crash 
in,
arm_smmu_domain_finalise_s1() -->arm_smmu_alloc_cd_tables()-->
arm_smmu_alloc_cd_leaf_table() as num_leaf_entries is zero.

With the below fix, it works on D05 now,

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 8ad90e2..51f5821 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2433,7 +2433,10 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
                        domain->min_pasid = 1;
                        domain->max_pasid = master->num_ssids - 1;
                        smmu_domain->s1_cfg.num_contexts = master->num_ssids;
+               } else {
+                       smmu_domain->s1_cfg.num_contexts = 1;
                }
+
                smmu_domain->s1_cfg.can_stall = master->ste.can_stall;
                break;
        case ARM_SMMU_DOMAIN_NESTED:


I am not sure this is right place do this. Please take a look.

Thanks,
Shameer


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
