Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:18436 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbbKZFOi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2015 00:14:38 -0500
Subject: Re: [PATCH v2 4/5] PCI: iproc: Add iProc PCIe MSI support
To: Marc Zyngier <marc.zyngier@arm.com>
References: <1448406294-732-1-git-send-email-rjui@broadcom.com>
 <1448406294-732-5-git-send-email-rjui@broadcom.com>
 <20151125173627.41b1a526@arm.com> <565665E8.1080702@broadcom.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	<linux-kernel@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-pci@vger.kernel.org>
From: Ray Jui <rjui@broadcom.com>
Message-ID: <5656953C.7050602@broadcom.com>
Date: Wed, 25 Nov 2015 21:14:36 -0800
MIME-Version: 1.0
In-Reply-To: <565665E8.1080702@broadcom.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marc,

On 11/25/2015 5:52 PM, Ray Jui wrote:
> Hi Marc,
>
[...]
>>> +    /* reserve memory for MSI posted writes */
>>> +    msi->msi_cpu = dma_alloc_coherent(pcie->dev,
>>> +                      msi->nr_msi_region * MSI_MEM_REGION_SIZE,
>>> +                      &msi->msi_dma, GFP_KERNEL);
>>
>> Same here. Also, what is the exact purpose of that memory? You have a
>> coherent mapping with the CPU, but you never read from it. So what's
>> the point?
>>
>
> Yeah I guess I can change this back to kmalloc since coherent memory is
> a scarce resource, and the CPU does not need to access the memory, so
> there's no cache issue.
>
> I know I have not answered the first part of your question. Let me do
> some experiments first and I'll get back to you on that, :)
>

I did some experiment with the msi_dma here. It looks like it can be any 
address as long as it's 4K aligned (i.e., can be from the device address 
range instead of the RAM address range). The MSI message data actually 
goes to the memory allocated for the event queue (makes sense...), and 
never made it to the MSI page memory allocated here. Our arch doc is 
just confusing....:(

I saw your comment on the other email thread with Xilinx MSI. I'll set 
the address to the base address of the iProc PCIe controller (which is 
always 4K aligned).

[...]
>>
>> Thanks,
>>
>>     M.
>>
>
> Thanks, Marc!
>
> Ray

Thanks again!

Ray
