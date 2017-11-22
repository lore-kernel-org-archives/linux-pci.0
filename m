Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
To: Bob Liu <liubo95@huawei.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <588ad6f0-e78a-63de-e27a-3da4de4ab2ab@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <42f815ee-2a9a-ac49-2392-5c03c1d4c809@arm.com>
Date: Wed, 22 Nov 2017 13:04:22 +0000
MIME-Version: 1.0
In-Reply-To: <588ad6f0-e78a-63de-e27a-3da4de4ab2ab@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>,
 "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "ashok.raj@intel.com" <ashok.raj@intel.com>,
 "tn@semihalf.com" <tn@semihalf.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "rfranz@cavium.com" <rfranz@cavium.com>, "lenb@kernel.org" <lenb@kernel.org>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "robdclark@gmail.com" <robdclark@gmail.com>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 22/11/17 03:15, Bob Liu wrote:
> Hey Jean,
> 
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> IOMMU drivers need a way to bind Linux processes to devices. This is used
>> for Shared Virtual Memory (SVM), where devices support paging. In that
>> mode, DMA can directly target virtual addresses of a process.
>>
>> Introduce boilerplate code for allocating process structures and binding
>> them to devices. Four operations are added to IOMMU drivers:
>>
>> * process_alloc, process_free: to create an iommu_process structure and
>>   perform architecture-specific operations required to grab the process
>>   (for instance on ARM SMMU, pin down the CPU ASID). There is a single
>>   iommu_process structure per Linux process.
>>
> 
> I'm a bit confused here.
> The original meaning of iommu_domain is a virtual addrspace defined by a set of io page table.
> (fix me if I misunderstood).

iommu_domain can also be seen as a logical partition of devices that share
the same address spaces (the concept comes from AMD and Intel IOMMU
domains, I believe). Without PASIDs it was a single address space, with
PASIDs it can have multiple address spaces.

> Then what's the meaning of iommu_domain and iommu_process after introducing iommu_process?
> Could you consider document these concepts? 

iommu_process is used to keep track of Linux process address spaces. I'll
rename it to io_mm in next version, to make it clear that it doesn't
represent a Linux task but an mm_struct instead. However the
implementation stays pretty much identical. A domain can be associated to
multiple io_mm, and an io_mm can be associated to multiple domains.

In the IOMMU architectures I know, PASID is implemented like this. You
have the device tables (stream tables on SMMU), pointing to PASID tables
(context descriptor tables on SMMU). In the following diagram,

                    .->+--------+
                   / 0 |        |------ io_pgtable
                  /    +--------+
                 /   1 |        |------ io_mm->mm X
    +--------+  /      +--------+
  0 |      A |-'     2 |        |-.
    +--------+         +--------+  \
  1 |        |       3 |        |   \
    +--------+         +--------+    -- io_mm->mm Y
  2 |      B |--.     PASID tables  /
    +--------+   \                 |
  3 |      B |----+--->+--------+  |
    +--------+   /   0 |        |- | -- io_pgtable
  4 |      B |--'      +--------+  |
    +--------+       1 |        |  |
  Device tables        +--------+  |
                     2 |        |--'
                       +--------+
                     3 |        |------ io_mm->priv io_pgtable
                       +--------+
                      PASID tables

* Device 0 (e.g. PCI 0000:00:00.0) is in domain A.
* Devices 2, 3 and 4 are in domain B.
* Domain A has the top set of PASID tables.
* Domain B has the bottom set of PASID tables.

* Domain A is bound to process address space X.
  -> Device 0 can access X with PASID 1.
* Both domains A and B are bound to process address space Y.
  -> Devices 0, 2, 3 and 4 can access Y with PASID 2

* PASID 0 is special on Arm SMMU (with S1DSS=0b10). It will always be
  reserved for classic DMA map/unmap. Even for hypothetical devices that
  don't support non-pasid transactions, I'd like to keep this convention.
  It should be quite useful for device drivers to have PASID 0 available
  with DMA map/unmap.

* When introducing "private" PASID address spaces (that many are asking
  for), which are backed by a set of io-pgtable and map/unmap ops, I
  suppose they would reuse the io_mm structure. In this example PASID 3 is
  associated to a private address space and not backed by an mm. Since the
  PASID space is global, PASID 3 won't be available for any other domain.

Does this clarify the current design, or is it just more confusing?

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
