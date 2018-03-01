Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH 03/37] iommu/sva: Manage process address spaces
To: Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: mark.rutland@arm.com, ilias.apalodimas@linaro.org,
        catalin.marinas@arm.com, xuzaibo@huawei.com, will.deacon@arm.com,
        okaya@codeaurora.org, ashok.raj@intel.com, bharatku@xilinx.com,
        rfranz@cavium.com, lenb@kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com, shunyong.yang@hxt-semitech.com,
        dwmw2@infradead.org, rjw@rjwysocki.net, sudeep.holla@arm.com
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <5A97A324.9050605@linux.intel.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cd4d7a98-e45e-7066-345f-52d8eef926a2@amd.com>
Date: Thu, 1 Mar 2018 09:04:58 +0100
MIME-Version: 1.0
In-Reply-To: <5A97A324.9050605@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am 01.03.2018 um 07:52 schrieb Lu Baolu:
> Hi Jean,
>
> On 02/13/2018 02:33 AM, Jean-Philippe Brucker wrote:
>> [SNIP]
>> +	pasid = idr_alloc_cyclic(&iommu_pasid_idr, io_mm, dev_param->min_pasid,
>> +				 dev_param->max_pasid + 1, GFP_ATOMIC);
> Can the pasid management code be moved into a common library?
> PASID is not stick to SVA. An IOMMU model device could be designed
> to use PASID for second level translation (classical DMA translation)
> as well.

Yeah, we have the same problem on amdgpu.

We assign PASIDs to clients even when IOMMU isn't present in the system 
just because we need it for debugging.

E.g. when the hardware detects that some shader program is doing 
something nasty we get the PASID in the interrupt and could for example 
use it to inform the client about the fault.

Regards,
Christian.

>
> Best regards,
> Lu Baolu

