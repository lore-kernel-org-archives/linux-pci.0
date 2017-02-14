Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53456 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbdBNNyC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2017 08:54:02 -0500
Subject: Re: RFC on No ACS Support and SMMUv3 Support
To: Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
 <20170213160652.7c141eb1@t450s.home>
 <2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
 <20170213184643.2d2bdce7@t450s.home>
 <546869d0-d05c-9550-86d5-276bc7a3c284@codeaurora.org>
 <20170214123605.GA25144@arm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        iommu@lists.linux-foundation.org,
        Vikram Sethi <vikrams@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <c7516332-259a-a807-91b1-7bcaebec1b43@codeaurora.org>
Date: Tue, 14 Feb 2017 08:53:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170214123605.GA25144@arm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/14/2017 7:36 AM, Will Deacon wrote:
> On Mon, Feb 13, 2017 at 08:54:04PM -0500, Sinan Kaya wrote:
>> On 2/13/2017 8:46 PM, Alex Williamson wrote:
>>>> My first goal is to support virtual function passthrough for device's that are directly
>>>> connected. This will be possible with the quirk I proposed and it will be the most
>>>> secure solution. It can certainly be generalized for other systems.
>>> Why is this anything more than a quirk for the affected PCIe root port
>>> vendor:device IDs and use of pci_device_group() to evaluate the rest of
>>> the topology, as appears is already done?  Clearly a blanket exception
>>> for the platform wouldn't necessarily be correct if a user could plugin
>>> a device that adds a PCIe switch.
>>
>> I was going to go this direction first. I wanted to check with everybody to see
>> if there are other/better alternatives possible via either changing 
>> pci_device_group or changing the smmuv3 driver.
> 
> Just to echo what Alex has been saying, I really don't think we should
> support this type of system by quirking the topology code in the SMMU
> driver. The SMMU isn't at fault here; the problems are all upstream of that.
> Legitimising non-ACS machines in the SMMU driver gives little incentive for
> people to build systems correctly and undermines the security guarantees
> that the SMMU (and VFIO) are trying to provide.
> 
> I appreciate that I/O virtualisation on arm64 has been a learning curve for
> everybody involved, but that's not an excuse for moving the goalposts when
> it comes to device isolation.
> 
> Will
> 

Thanks to everyone for feedback. I'll follow the quirk path as requested. 
I'll be posting the patch soon.


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
