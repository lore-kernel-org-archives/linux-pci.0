Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:47396 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756343AbdCUKxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2017 06:53:11 -0400
Subject: Re: Help: MSI DWC connecting with a MSIx Endpoint
To: Marc Zyngier <marc.zyngier@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <85bfa77f-6cd0-a669-c940-7fa7d9fb17a3@synopsys.com>
 <28a4e429-a2d2-8f28-e4fc-8eebae0b3367@arm.com>
 <4ade12d6-1887-4093-ee43-2101ca2986e0@synopsys.com>
 <9eec7e57-456e-fc98-91d9-bd5a32c347af@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <1c752760-d5ca-9702-fe60-b8eeda627c7e@synopsys.com>
Date: Tue, 21 Mar 2017 10:42:59 +0000
MIME-Version: 1.0
In-Reply-To: <9eec7e57-456e-fc98-91d9-bd5a32c347af@arm.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Às 10:41 AM de 3/21/2017, Marc Zyngier escreveu:
> On 21/03/17 10:27, Joao Pinto wrote:
>>
>> Hi Mark,
>>
>> Às 6:16 PM de 3/20/2017, Marc Zyngier escreveu:
>>> Hi Joao,
>>>
>>> On 20/03/17 17:30, Joao Pinto wrote:
>>>> Hi Mark,
>>>>
>>>> I am facing a challenge in a setup I must bring up that is composed by a
>>>> Synopsys Root Complex connected to a MSIx-only Endpoint from Mellanox.
>>>> The endpoint probe fails because it is not capable of enabling msix.
>>>>
>>>> In order to get more info about it, I added some debug messages to the msix
>>>> enable process and got the following:
>>>>
>>>> MSIX DBG[mlx5_enable_msix]: Num. EQs: 256
>>>> MSIX DBG[mlx5_enable_msix]: Num. Vectors: 4
>>>> MSIX DBG[mlx5_enable_msix]: Min. Num. Vectors: 4
>>>> MSIX DBG[mlx5_enable_msix]: Num. Online CPUs: 1
>>>> MSIX DBG[mlx5_enable_msix]: MLX5_EQ_VEC_COMP_BASE: 3
>>>> MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 0
>>>> MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 1
>>>> MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 2
>>>> MSIX DBG[mlx5_enable_msix]: Filling msix array... entry = 3
>>>> MSIX DBG[mlx5_enable_msix]: Enabling PCI MSIX Range
>>>> MSIX DBG[__pci_enable_msix_range]: Enabling MSIX [Nvec: 4, Affinity: 0]
>>>> MSIX DBG[__pci_enable_msix]: NVec: 4
>>>> MSIX DBG[__pci_enable_msix]: Num. Entries: 64
>>>> MSIX DBG[__pci_enable_msix]: Checking invalid entries
>>>> MSIX DBG[msix_capability_init]: Ensure MSI is disable
>>>> MSIX DBG[msix_capability_init]: Getting MSIX Capability
>>>> MSIX DBG[msix_capability_init]: Mapping MSIX Capability Region
>>>> MSIX DBG[msix_capability_init]: Setup Entries
>>>> MSIX DBG[msix_setup_entries]: Configuring MSIX entry 0
>>>> MSIX DBG[msix_setup_entries]: Configuring MSIX entry 1
>>>> MSIX DBG[msix_setup_entries]: Configuring MSIX entry 2
>>>> MSIX DBG[msix_setup_entries]: Configuring MSIX entry 3
>>>> MSIX DBG[msix_capability_init]: Setup IRQS
>>>> MSIX DBG[pci_msi_setup_msi_irqs]: Inside!
>>>> MSIX DBG[arch_setup_msi_irqs]: Inside!
>>>> MSIX DBG[msix_capability_init]: Failed pci_msi_setup_msi_irqs
>>>> MSIX DBG[mlx5_enable_msix]: Enabling PCI MSIX Range, result: -22
>>>> mlx5_core 0000:01:00.0: enable msix failed
>>>>
>>>> The conclusion I came up was that the msix setup in the endpoint fails because
>>>> in the pcie-designware-host.c we are rejecting msix as you can see here:
>>>>
>>>> /* MSI-X interrupts are not supported */
>>>> if (type == PCI_CAP_ID_MSIX)
>>>>         return -EINVAL;
>>>>
>>>> Did you ever came across this problem?
>>>
>>> I don't have access to any system using this IP, unfortunately. This
>>> looks like an arbitrary limitation of the host controller driver, as
>>> there isn't much difference between MSI and MSI-X at the MSI controller
>>> level, other than the reduced number of interrupts.
>>>
>>> Unfortunately, this driver seems to rely on rather old APIs, and could
>>> use some care and attention. I'm pretty sure that converting this driver
>>> to the generic MSI API would solve this problem entirely, but I'm afraid
>>> I don't have the bandwidth to do so.
>>
>> I volunteer to do it, no problem, but I will need some guidance and examples.
>> Could you give me some hints to get started?
> 
> A very simple example using the current API is pcie-altera-msi.c (some
> others are much more intricate), and should give you a good picture of
> how PCI/MSI, generic MSI and MSI controllers interact.
> 
> Start with understanding how the various layers interact via their own
> IRQ domains, and implement their own IRQ chip. Happy to answer questions
> (I'm sure you'll have some).
> 
> Thanks,
> 
> 	M.
> 

Thanks for the guidance Marc!

Joao
