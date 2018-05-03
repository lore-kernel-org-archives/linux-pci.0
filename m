Return-Path: <SRS0=3O2m=HW=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=3O2m=HW=codeaurora.org=okaya@kernel.org>
Subject: Re: [RFC/RFT] Add noats flag to boot parameters
To: Joerg Roedel <joro@8bytes.org>
Cc: Gil Kupfer <gilkup@gmail.com>, dwmw2@infradead.org, bhelgaas@google.com,
 iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, nadav.amit@gmail.com,
 Gil Kupfer <gilkup@cs.technion.ac.il>, Will Deacon <will.deacon@arm.com>,
 Bjorn Helgaas <helgaas@kernel.org>
References: <1525025808-2365-1-git-send-email-gilkup@cs.technion.ac.il>
 <20180503133459.waawna3ebtu3udn6@8bytes.org>
 <359d736a-a7ac-f0e4-f4db-dc7bb506481c@codeaurora.org>
 <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <5cf699f1-90c1-5ad8-07fe-a65042395d05@codeaurora.org>
Date: Thu, 3 May 2018 10:23:02 -0400
MIME-Version: 1.0
In-Reply-To: <20180503135920.o2rdh3exai7qmkvu@8bytes.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

+Bjorn,

On 5/3/2018 9:59 AM, Joerg Roedel wrote:
> On Thu, May 03, 2018 at 09:46:34AM -0400, Sinan Kaya wrote:
>> I also like the idea in general.
>> Minor nit..
>>
>> Shouldn't this be an iommu parameter rather than a PCI kernel command line parameter?
>> We now have an iommu.passthrough argument that prevents page translation.
>>
>> Doesn't this fit into the same category especially when it is the IOMMU drivers that
>> call ATS functions for enablement not the PCI drivers.
> 
> ATS is a bit of a grey area between PCI and IOMMU, but since ATS is
> PCI-specific and the code to enable/disable it is in PCI as well, I
> think the parameter makes sense for PCI too.
> 

OK. Bjorn was interested in having a command line driven feature enables in driver/pci
directory with bitmasks for each optional PCI spec capability rather than noXYZ feature.

This would allow us to troubleshoot code breakage as well as the platform bring up to
turn off all optional features.

Sounds like this would be a good match for that work.


> 
> 	Joerg
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
