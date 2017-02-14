Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:23904
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752921AbdBNMKe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 Feb 2017 07:10:34 -0500
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: RFC on No ACS Support and SMMUv3 Support
To: Sinan Kaya <okaya@codeaurora.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <2944ff12-d5c0-179a-7c07-fbbafcd022da@codeaurora.org>
 <20170213160652.7c141eb1@t450s.home>
 <2d199a00-a66a-e96c-b0c4-9dd4459d2589@codeaurora.org>
 <20170213184643.2d2bdce7@t450s.home>
 <546869d0-d05c-9550-86d5-276bc7a3c284@codeaurora.org>
CC: Vikram Sethi <vikrams@codeaurora.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, <nd@arm.com>
Message-ID: <56c15010-c009-81e5-95d3-a6f50469223e@arm.com>
Date: Tue, 14 Feb 2017 12:10:27 +0000
MIME-Version: 1.0
In-Reply-To: <546869d0-d05c-9550-86d5-276bc7a3c284@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/02/17 01:54, Sinan Kaya wrote:
> On 2/13/2017 8:46 PM, Alex Williamson wrote:
>>> My first goal is to support virtual function passthrough for device's that are directly
>>> connected. This will be possible with the quirk I proposed and it will be the most
>>> secure solution. It can certainly be generalized for other systems.
>> Why is this anything more than a quirk for the affected PCIe root port
>> vendor:device IDs and use of pci_device_group() to evaluate the rest of
>> the topology, as appears is already done?  Clearly a blanket exception
>> for the platform wouldn't necessarily be correct if a user could plugin
>> a device that adds a PCIe switch.
> 
> I was going to go this direction first. I wanted to check with everybody to see
> if there are other/better alternatives possible via either changing 
> pci_device_group or changing the smmuv3 driver.

I second Alex's opinion here. The SMMU driver is absolutely not the
appropriate place to address this - it's a PCI issue that needs to be
solved in the PCI domain. To flip things around, regardless of VFIO,
overriding group allocation may just plain break some devices - if you
plug in, say, some USB 2.0 card with an OHCI/EHCI pair on two different
functions, assigning them to different groups such that they get
different domains and can't hand off valid DMA addresses to each other
is liable to go downhill very quickly.

Robin.

>>> My second goal is extend the code such that ACS validation is up to the customer via 
>>> pci=noacs kernel command line for instance. This will let the customer choose what he
>>> really wants rather than kernel trying to be smart and protective. By passing pci=noacs
>>> parameter, customer acknowledges the risks this command line carries.
>> Be prepared that this will need to taint the kernel since we make
>> assertions with drivers like vfio to provide secure, isolated user
>> access to devices and we can't make that statement if the user has
>> bypassed ACS enforcement.  There is absolutely no way that such an
>> option would not be severely abused.  In fact, I tried adding such an
>> option with the pcie_acs_override= patch[1], Bjorn rejected it and I'm
>> thankful that he did.  I don't think this is a good idea, sometimes the
>> kernel does need to be smarter than the user to protect them from
>> themselves.  Any easy bypass also lets hardware vendors ignore the
>> issue longer.  Thanks,
> 
> Bjorn, any inputs?
> 
>>
>> Alex
>>
>> [1] https://lkml.org/lkml/2013/5/30/513
>>
> 
> 

(apologies if a disclaimer appears below; SMTP problems...)
