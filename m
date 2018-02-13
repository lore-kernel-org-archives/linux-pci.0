Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH 01/37] iommu: Introduce Shared Virtual Addressing API
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-2-jean-philippe.brucker@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D191002823@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <b3c190e7-1a33-971e-b86c-a9725118ba05@arm.com>
Date: Tue, 13 Feb 2018 12:40:13 +0000
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191002823@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <Mark.Rutland@arm.com>,
 "bharatku@xilinx.com" <bharatku@xilinx.com>, "Raj,
 Ashok" <ashok.raj@intel.com>,
 "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "xuzaibo@huawei.com" <xuzaibo@huawei.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 Will Deacon <Will.Deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
 "okaya@codeaurora.org" <okaya@codeaurora.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
 "rfranz@cavium.com" <rfranz@cavium.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kevin,

Thanks for taking a look!

On 13/02/18 07:31, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Tuesday, February 13, 2018 2:33 AM
>>
>> Shared Virtual Addressing (SVA) provides a way for device drivers to bind
>> process address spaces to devices. This requires the IOMMU to support the
>> same page table format as CPUs, and requires the system to support I/O
> 
> "same" is a bit restrictive. "compatible" is better as you used in coverletter. :-)

Indeed

[..]
>> +config IOMMU_SVA
>> +	bool "Shared Virtual Addressing API for the IOMMU"
>> +	select IOMMU_API
>> +	help
>> +	  Enable process address space management for the IOMMU API. In
>> systems
>> +	  that support it, device drivers can bind process address spaces to
>> +	  devices and share their page tables using this API.
> 
> "their page table" is a bit confusing here.

Maybe this is sufficient:
"In systems that support it, drivers can share process address spaces with
their devices using this API."

[...]
>> +
>> +/**
>> + * iommu_sva_device_init() - Initialize Shared Virtual Addressing for a
>> device
>> + * @dev: the device
>> + * @features: bitmask of features that need to be initialized
>> + * @max_pasid: max PASID value supported by the device
>> + *
>> + * Users of the bind()/unbind() API must call this function to initialize all
>> + * features required for SVA.
>> + *
>> + * - If the device should support multiple address spaces (e.g. PCI PASID),
>> + *   IOMMU_SVA_FEAT_PASID must be requested.
> 
> I think it is by default assumed when using this API, based on definition of
> SVA. Can you elaborate the situation where this flag can be cleared?

When passing a device to userspace, you could also share its non-pasid
address space with the process. It requires a new domain type so is left
as a TODO in patch 2/37. I did get requests for this feature, though I
think it was mostly for prototyping. I guess I could remove the flag, and
reintroduce it as IOMMU_SVA_FEAT_NO_PASID later on.

>> + *
>> + *   By default the PASID allocated during bind() is limited by the IOMMU
>> + *   capacity, and by the device PASID width defined in the PCI capability or
>> in
>> + *   the firmware description. Setting @max_pasid to a non-zero value
>> smaller
>> + *   than this limit overrides it.
>> + *
>> + * - If the device should support I/O Page Faults (e.g. PCI PRI),
>> + *   IOMMU_SVA_FEAT_IOPF must be requested.
>> + *
>> + * The device should not be be performing any DMA while this function is
> 
> remove double "be"
> 
>> + * running.
> 
> "otherwise the behavior is undefined"

ok

[...]
>> +	ret = domain->ops->sva_device_init(dev, features, &min_pasid,
>> +					   &max_pasid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* FIXME: racy. Next version should have a mutex (same as fault
>> handler) */
>> +	dev_param->sva_features = features;
>> +	dev_param->min_pasid = min_pasid;
>> +	dev_param->max_pasid = max_pasid;
> 
> what's the point of min_pasid here?

Arm SMMUv3 uses entry 0 of the PASID table for the default (non-pasid)
context, so it needs to set min_pasid to 1. AMD IOMMU recently added a
similar feature (GIoSup), if I understood correctly.

Thanks,
Jean

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
