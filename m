Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:33103 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbdEEPMP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 May 2017 11:12:15 -0400
Subject: Re: [RFC] pci: using new interrupt API to enable MSI and MSI-X
To: Marc Zyngier <marc.zyngier@arm.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>, <kishon@ti.com>,
        <bhelgaas@google.com>, <jingoohan1@gmail.com>
References: <806903036508ae5246084cbc3b796083d76f8917.1493992929.git.jpinto@synopsys.com>
 <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
CC: <linux-pci@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <ac31c607-ad4c-8032-9e11-603dc75dca47@synopsys.com>
Date: Fri, 5 May 2017 16:12:11 +0100
MIME-Version: 1.0
In-Reply-To: <58f3a6ca-a051-a7dc-805f-ee3eb0f3ac3b@arm.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Mark,

Às 3:57 PM de 5/5/2017, Marc Zyngier escreveu:
> Joao,
> 
> On 05/05/17 15:11, Joao Pinto wrote:
>> Hello,
>> I am currently adding the support for both MSI and MSI-x in pcie-designware and
>> I am now facing a dificulty.
>>
>> My test endpoint is a USB 3.1 MSI / MSI-X capable and I tested that with
>> the changes introduced by this patch we are able to enable MSI and MSI-X
>> in this endpoint (depends on the usage of the MSI_FLAG_PCI_MSIX flag).
>>
>> The problem I am facing now is that Intc for the USB 3.1 Endpoint is completely
>> bogus (524288) when it should be 1, and so I am not receiving any interrupts
>> from the endpoint.
> 
> It is not bogus at all. It is computed from the PCI requester ID in 
> pci_msi_domain_calc_hwirq. What you're seeing is the PCI/MDI domain 
> view of that interrupt, which is completely virtual.
> 
> The real thing happens in your own irqdomain, where the hwirq for IRQ46 
> is probably 1 (only you can know that). As for why it doesn't work, see 
> below:
> 

snip (...)

>  static struct irq_chip dw_msi_irq_chip = {
>  	.name = "PCI-MSI",
> -	.irq_enable = pci_msi_unmask_irq,
> -	.irq_disable = pci_msi_mask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> -	.irq_unmask = pci_msi_unmask_irq,
> +	.irq_mask = dw_msi_mask_irq,
> +	.irq_unmask = dw_msi_unmask_irq,
>  };
> 
> I haven't dug any further, but this should be fixed first.
> 
> Thanks,
> 
> 	M.
> 

Thanks for the help! I will check it out!

Joao
