Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46834 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308AbbBIR1j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Feb 2015 12:27:39 -0500
Message-ID: <54D8EDC8.2060908@ti.com>
Date: Mon, 9 Feb 2015 12:26:32 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
	<devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <will.deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 0/7] PCI: get DMA configuration from parent device
References: <1423173179-10227-1-git-send-email-m-karicheri2@ti.com> <54D84456.8050509@amd.com>
In-Reply-To: <54D84456.8050509@amd.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 02/09/2015 12:23 AM, Suravee Suthikulpanit wrote:
> Sorry for delay response. I have also tested this on AMD Seattle 
> platform w/ PCI Generic Host Controller, and I can see that the PCI 
> endpoint devices are getting proper dma_map_ops as set in the host 
> bridge.
>
> <Tested-by>: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Suravee,

Thanks for testing this patch.

Murali
>
> Thanks,
> Suravee
>
> On 02/06/2015 05:52 AM, Murali Karicheri wrote:
>> This patch add an important capability to PCI driver on Keystone. I 
>> hope to
>> have this merged to the upstream branch so that it is available for 
>> v3.20.
>> Also would like thank everyone for the contribution.
>>
>> PCI devices on Keystone doesn't have correct dma_pfn_offset set. This 
>> patch
>> add capability to set the dma configuration such as dma-mask, 
>> dma_pfn_offset,
>> and dma ops etc using the information from DT. The prior RFCs and 
>> discussions
>> are available at [1] and [2] below.
>>
>> [2] : 
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg790244.html
>> [1] : http://www.gossamer-threads.com/lists/linux/kernel/2024591
>>
>> Change history:
>>     v6 - Rebased to v3.19-v7
>>        - Addressed some minor comments about node name and DT size 
>> validation.
>>        - Pulled out 8/8 of v5 and plan to send a patch for enhancing
>>          of_dma_configure() to use size to calculate dma mask.
>>        - Added Acks from reviewers.
>>     v5 - moved the dma_mask update in device from ARM specific API to
>>          of_dma_configure to allow this across other architecture as 
>> well
>>        - improved sanity check for DT dma-range size in 
>> of_dma_configure()
>>        - moved API to get parent bridge device to PCI (host-bridge.c)
>>     v4 - moved size adjustments in of_iommu_configure() to a separate 
>> patch
>>        - consistent node name comment from Rob
>>        - patch 6 added for dma_mask adjustment and iommu mapping size
>>          limiting.
>>     v3 - addressed comments to re-use of_dma_configure() for PCI
>>        - To help re-use, change of_iommu_configure() function argument
>>         - Move of_dma_configure to of/device.c
>>         - Limit the of_iommu_configure to non pci devices
>>     v2 - update size to coherent_dma_mask + 1 if dma-range info is 
>> missing
>>        - also check the np for null.
>>     v1 - updates based on the comments against initial RFC.
>>        - Added a helper function to get the OF node of the parent
>>        - Added an API in of_pci.c to update DMA configuration of the pci
>>          device.
>>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Acked-by: Murali Karicheri <m-karicheri2@ti.com>
>>
>> Murali Karicheri (7):
>>    of: iommu: add ptr to OF node arg to of_iommu_configure()
>>    of: move of_dma_configure() to device.c to help re-use
>>    of: fix size when dma-range is not used
>>    PCI: add helper functions pci_get[put]_host_bridge_device()
>>    of/pci: add of_pci_dma_configure() update dma configuration
>>    PCI: update dma configuration from DT
>>    arm: dma-mapping: limit iommu mapping size
>>
>>   arch/arm/mm/dma-mapping.c |    7 +++++
>>   drivers/iommu/of_iommu.c  |   10 ++++--
>>   drivers/of/device.c       |   74 
>> +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/of/of_pci.c       |   19 ++++++++++++
>>   drivers/of/platform.c     |   58 ++---------------------------------
>>   drivers/pci/host-bridge.c |   14 +++++++++
>>   drivers/pci/probe.c       |    2 ++
>>   include/linux/of_device.h |    2 ++
>>   include/linux/of_iommu.h  |    6 ++--
>>   include/linux/of_pci.h    |    5 +++
>>   include/linux/pci.h       |    3 ++
>>   11 files changed, 140 insertions(+), 60 deletions(-)
>>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments

