Return-Path: <SRS0=FAy1=FY=codeaurora.org=okaya@kernel.org>
Return-Path: <SRS0=FAy1=FY=codeaurora.org=okaya@kernel.org>
Subject: Re: RFC on Kdump and PCIe on ARM64
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Will Deacon <will.deacon@arm.com>, Linux PCI <linux-pci@vger.kernel.org>,
 linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
 Nate Watterson <nwatters@codeaurora.org>,
 "shankerd@codeaurora.org" <shankerd@codeaurora.org>,
 Vikram Sethi <vikrams@codeaurora.org>, "Goel, Sameer"
 <sgoel@codeaurora.org>, kexec@lists.infradead.org,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
References: <c5c2d8d2-0384-442a-7bc6-8929457b8447@codeaurora.org>
 <20180301190552.GK13722@bhelgaas-glaptop.roam.corp.google.com>
 <2b2de17c-8527-e49b-2ef2-2a3d1801e4f9@codeaurora.org>
 <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <feeab007-951d-7743-70e6-122486feddf7@codeaurora.org>
Date: Fri, 2 Mar 2018 09:20:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180302000303.GD74737@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 3/1/2018 7:03 PM, Bjorn Helgaas wrote:
>> 3. The last one is adapter gets into fuzzy state due to not coming
>> out of clean state in the second time init and being rejected by
>> SMMUv3 multiple times.
>>
>> [   16.093441] pci 0000:01:00.0: aer_status: 0x00040000, aer_mask: 0x00000000
>> [   16.099356] pci 0000:01:00.0: Malformed TLP
>> [   16.103522] pci 0000:01:00.0: aer_layer=Transaction Layer, aer_agent=Receiver ID
>> [   16.110900] pci 0000:01:00.0: aer_uncor_severity: 0x00062011
>> [   16.116543] pci 0000:01:00.0:   TLP Header: 0a00a000 00008100 01010100 00000000
> I'm not clear on this.  I don't remember what an IOMMU fault looks
> like to an Endpoint.  Are you saying that if an Endpoint sees too many
> of those faults, it gets into this "fuzzy state" (whatever that is :))?
> Is this a hardware defect?  Do we care (this is a kdump kernel, after
> all)?  If we do care, can we fix the device by resetting it?

fuzzy=funky=funny=wierd

Regardless of what we do in the IOMMU driver, I think we still have to reset
the endpoint in order to have a clean initialization.

I'm not sure if all endpoint drivers can recover an adapter from a live state.

I wasn't expecting to see a Malformed TLP error. I was guessing that this was
caused by SMMU giving a CA or UR to the endpoint or having a live adapter
in the middle of driver initialization. 

I think we do care about the adapter coming up properly otherwise how would
you collect the dumps from the system?

I was expecting to come through the network interface and download it from
the target.

That's why, I was suggesting FLR/PM reset etc. when we know that we are
booting a kdump kernel.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
