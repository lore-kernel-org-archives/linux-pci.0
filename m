Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 6 Mar 2017 11:14:51 +0000
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC PATCH 00/30] Add PCIe SVM support to ARM SMMUv3
Message-ID: <20170306111451.GA28804@e106794-lin.localdomain>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <A2975661238FB949B60364EF0F2C2574390186B8@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C2574390186B8@shsmsx102.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Sinan Kaya <okaya@qti.qualcomm.com>,
 Will Deacon <will.deacon@arm.com>, Harv Abdulhamid <harba@qti.qualcomm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Yi,

On 06/03/17 08:20, Liu, Yi L wrote:
> 
> 
>> -----Original Message-----
>> From: iommu-bounces@lists.linux-foundation.org [mailto:iommu-
>> bounces@lists.linux-foundation.org] On Behalf Of Jean-Philippe Brucker
>> Sent: Tuesday, February 28, 2017 3:54 AM
>> Cc: Shanker Donthineni <shankerd@qti.qualcomm.com>; kvm@vger.kernel.org;
>> Catalin Marinas <catalin.marinas@arm.com>; Sinan Kaya
>> <okaya@qti.qualcomm.com>; Will Deacon <will.deacon@arm.com>;
>> iommu@lists.linux-foundation.org; Harv Abdulhamid <harba@qti.qualcomm.com>;
>> linux-pci@vger.kernel.org; Bjorn Helgaas <bhelgaas@google.com>; David
>> Woodhouse <dwmw2@infradead.org>; linux-arm-kernel@lists.infradead.org; Nate
>> Watterson <nwatters@qti.qualcomm.com>
>> Subject: [RFC PATCH 00/30] Add PCIe SVM support to ARM SMMUv3
>>
>> Hi,
>>
>> This series adds support for PCI ATS, PRI and PASID extensions to the
>> SMMUv3 driver. In systems that support it, it is now possible for some high-end
>> devices to perform DMA into process address spaces. Page tables are shared
>> between MMU and SMMU; page faults from devices are recoverable and handled by
>> the mm subsystem.
>>
>> We propose an extension to the IOMMU API that unifies existing SVM
>> implementations (AMD, Intel and ARM) in patches 22 and 24. Nothing is set in stone,
>> the goal is to start discussions and find an intersection between implementations.
>>
>> We also propose a VFIO interface in patches 29 and 30, that allows userspace device
>> drivers to make use of SVM. It would also serve as example implementation for
>> other device drivers.
>>
>> Overview of the patches:
>>
>> * 1 and 2 prepare the SMMUv3 structures for ATS,
>> * 3 to 5 enable ATS for devices that support it.
>> * 6 to 10 prepare the SMMUv3 structures for PASID and PRI. Patch 9,
>>   in particular, provides details on the structure requirements.
>> * 11 introduces an interface for sharing ASIDs on ARM64,
>> * 12 to 17 add more infrastructure for sharing page tables,
>> * 18 and 19 add minor helpers to PCI,
>> * 20 enables PASID in devices that support it,
> 
> Jean, supposedly, you will introduce a PASID management mechanism in
> SMMU v3 driver. Here I have a question about PASID management on ARM.
> Will there be a system wide PASID table? Or there is equivalent implementation.

Yes the SMMUv3 driver allocates and manages PASIDs. In this series I
implemented one PASID table for each device (for simplicity), but as
explained in my reply on patch 22, I'd like to introduce a PASID table
for each IOMMU domain in the next version.

Thanks,
Jean-Philippe

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
