Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:48709 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBA7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 May 2018 20:59:25 -0400
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/9] Add new helper to allocate irq domain for hosts
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1524817322-239028-1-git-send-email-shawn.lin@rock-chips.com>
 <20180430101940.GB32033@e107981-ln.cambridge.arm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <e83515e8-7eba-15ac-9cfa-4898b645d824@rock-chips.com>
Date: Wed, 2 May 2018 08:59:22 +0800
MIME-Version: 1.0
In-Reply-To: <20180430101940.GB32033@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 2018/4/30 18:19, Lorenzo Pieralisi wrote:
> On Fri, Apr 27, 2018 at 04:22:02PM +0800, Shawn Lin wrote:
>>
>> Hi Bjorn and Lorenzo,
>>
>> PCI drivers use highly similar code block to allocate irq domain which
>> leads to code duplication than expected. This patchset adds a new helper,
>> pci_alloc_intx_irqd(), to avoid that as much as possible. Just leave
>> pcie-rockchip out now as it's under re-construct and will add incremental
>> patch for it if this series looks ok and the pcie-rockchip ongoing patches
>> got merge.
> 
> Is this patch series v1 of:
> 
> https://patchwork.ozlabs.org/patch/906006/
> 
> ?

Yes.

> 
> Thanks,
> Lorenzo
> 
>>
>>
>>
>>
>> Shawn Lin (9):
>>    PCI: Add new helper for allocating irq domain for INTx
>>    PCI: dra7xx: Use pci_alloc_intx_irqd() helper to simplify the code
>>    PCI: keystone-dw: Use pci_alloc_intx_irqd() helper to get irq domain
>>      for INTx
>>    PCI: aardvark: Use pci_alloc_intx_irqd() helper to get irq domain for
>>      INTx
>>    PCI: faraday: Use pci_alloc_intx_irqd() helper to get irq domain for
>>      INTx
>>    PCI: altera: Use pci_alloc_intx_irqd() helper to get irq domain for
>>      INTx
>>    PCI: mediatek: Use pci_alloc_intx_irqd() helper to get irq domain for
>>      INTx
>>    PCI: xilinx-nwl: Use pci_alloc_intx_irqd() helper to get irq domain
>>      for INTx
>>    PCI: xilinx: Use pci_alloc_intx_irqd() helper to get irq domain for
>>      INTx
>>
>>   drivers/pci/dwc/pci-dra7xx.c       | 41 ++-------------------
>>   drivers/pci/dwc/pci-keystone-dw.c  | 12 +++----
>>   drivers/pci/host/pci-aardvark.c    | 24 +++----------
>>   drivers/pci/host/pci-ftpci100.c    | 15 +++-----
>>   drivers/pci/host/pcie-altera.c     | 38 +++-----------------
>>   drivers/pci/host/pcie-mediatek.c   | 29 ++-------------
>>   drivers/pci/host/pcie-xilinx-nwl.c | 21 +++--------
>>   drivers/pci/host/pcie-xilinx.c     | 43 ++--------------------
>>   include/linux/pci.h                | 74 ++++++++++++++++++++++++++++++++++++++
>>   9 files changed, 104 insertions(+), 193 deletions(-)
>>
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
