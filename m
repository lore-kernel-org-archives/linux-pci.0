Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 35/37] iommu/arm-smmu-v3: Add support for PRI
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-36-jean-philippe.brucker@arm.com>
 <20180308172436.00006554@huawei.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <2c3c608c-266c-b01f-819f-0c04d3d282f6@arm.com>
Date: Wed, 14 Mar 2018 13:10:01 +0000
MIME-Version: 1.0
In-Reply-To: <20180308172436.00006554@huawei.com>
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
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>, Will Deacon <Will.Deacon@arm.com>,
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
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "liubo95@huawei.com" <liubo95@huawei.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "jcrouse@codeaurora.org" <jcrouse@codeaurora.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, Robin Murphy <Robin.Murphy@arm.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "nwatters@codeaurora.org" <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 08/03/18 16:24, Jonathan Cameron wrote:
> On Mon, 12 Feb 2018 18:33:50 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> For PCI devices that support it, enable the PRI capability and handle
>> PRI Page Requests with the generic fault handler.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> A couple of nitpicks.
> 
>> ---
>>  drivers/iommu/arm-smmu-v3.c | 174 ++++++++++++++++++++++++++++++--------------
>>  1 file changed, 119 insertions(+), 55 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
>> index 8d09615fab35..ace2f995b0c0 100644
>> --- a/drivers/iommu/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -271,6 +271,7 @@
>>  #define STRTAB_STE_1_S1COR_SHIFT	4
>>  #define STRTAB_STE_1_S1CSH_SHIFT	6
>>  
>> +#define STRTAB_STE_1_PPAR		(1UL << 18)
>>  #define STRTAB_STE_1_S1STALLD		(1UL << 27)
>>  
>>  #define STRTAB_STE_1_EATS_ABT		0UL
>> @@ -346,9 +347,9 @@
>>  #define CMDQ_PRI_1_GRPID_SHIFT		0
>>  #define CMDQ_PRI_1_GRPID_MASK		0x1ffUL
>>  #define CMDQ_PRI_1_RESP_SHIFT		12
>> -#define CMDQ_PRI_1_RESP_DENY		(0UL << CMDQ_PRI_1_RESP_SHIFT)
>> -#define CMDQ_PRI_1_RESP_FAIL		(1UL << CMDQ_PRI_1_RESP_SHIFT)
>> -#define CMDQ_PRI_1_RESP_SUCC		(2UL << CMDQ_PRI_1_RESP_SHIFT)
>> +#define CMDQ_PRI_1_RESP_FAILURE		(0UL << CMDQ_PRI_1_RESP_SHIFT)
>> +#define CMDQ_PRI_1_RESP_INVALID		(1UL << CMDQ_PRI_1_RESP_SHIFT)
>> +#define CMDQ_PRI_1_RESP_SUCCESS		(2UL << CMDQ_PRI_1_RESP_SHIFT)
> Mixing fixing up this naming with the rest of the patch does make things a
> little harder to read than they would have been if done as separate patches.
> Worth splitting?

ok

[...]
> 
> The function ordering gets a bit random as you add all the new ones,
> Might be better to keep each disable following each enable.

Agreed

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
