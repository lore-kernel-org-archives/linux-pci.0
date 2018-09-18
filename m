Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([104.237.132.123]:33108 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbeIRXtx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Sep 2018 19:49:53 -0400
Subject: Re: Explicit IOVA management from a PCIe endpoint driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <3e9950c5-4986-6b0d-74c8-97014530c132@wwwdotorg.org>
 <a0d97ebd-c77e-400a-29cd-9524e9f47dbc@arm.com>
From: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <52dc4d4b-b521-17a5-dc93-e2992e481083@wwwdotorg.org>
Date: Tue, 18 Sep 2018 12:16:03 -0600
MIME-Version: 1.0
In-Reply-To: <a0d97ebd-c77e-400a-29cd-9524e9f47dbc@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/18/2018 04:59 AM, Robin Murphy wrote:
> Hi Stephen,
> 
> On 17/09/18 22:36, Stephen Warren wrote:
>> Joerg, Christoph, Marek, Robin,
>>
>> I believe that the driver for our PCIe endpoint controller hardware 
>> will need to explicitly manage its IOVA space more than current APIs 
>> allow. I'd like to discuss how to make that possible.
...
>> One final note:
>>
>> The memory controller can translate accesses to a small region of DRAM 
>> address space into accesses to an interrupt generation module. This 
>> allows devices attached to the PCIe bus to generate interrupts to 
>> software running on the system with the PCIe endpoint controller. Thus 
>> I deliberately described API 3 above as mapping a specific physical 
>> address into IOVA space, as opposed to mapping an existing DRAM 
>> allocation into IOVA space, in order to allow mapping this interrupt 
>> generation address space into IOVA space. If we needed separate APIs 
>> to map physical addresses vs. DRAM allocations into IOVA space, that 
>> would likely be fine too.
> 
> If that's the standard DesignWare MSI dingaling, then all you should 
> need to do is ensure you IOVA is reserved in your allocator (if it can 
> be entirely outside the EP BAR, even better) - AFAIK the writes get 
> completely intercepted such that they never go out to the SMMU side at 
> all, and thus no actual mapping is even needed.

Unfortunately it's not. We have some custom hardware module (that 
already existed for other purposes, such as interaction/synchronization 
between various graphics modules) that we will slightly repurpose as a 
plain interrupt generator for PCIe endpoint use-cases.

>> Does this API proposal sound reasonable?
> 
> Indeed, as I say apart from using streaming DMA for coherency management 
> (which I think could be added in pretty much orthogonally later), this 
> sounds like something you could plumb into the endpoint framework right 
> now with no dependent changes elsewhere.

Great. I'll take a look at Oza's code and see about getting this 
implemented.

Thanks.
