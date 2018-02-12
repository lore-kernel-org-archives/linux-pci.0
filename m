Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751386AbeBLSPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Feb 2018 13:15:33 -0500
Subject: Re: [PATCH v6 1/9] PCI: dwc: Add IRQ chained API support
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "minghuan.Lian@freescale.com" <minghuan.Lian@freescale.com>,
        "mingkai.hu@freescale.com" <mingkai.hu@freescale.com>,
        "tie-fei.zang@freescale.com" <tie-fei.zang@freescale.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>,
        "svarbanov@mm-sol.com" <svarbanov@mm-sol.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <cover.1516984229.git.gustavo.pimentel@synopsys.com>
 <8bcba39f181deae0b799f9fcd436fb67fe3b0533.1516984229.git.gustavo.pimentel@synopsys.com>
 <04d3d5b6-9199-218d-476f-c77d04b8d2e7@arm.com>
 <5b495bf6-4989-6a24-872c-638a2b078c9f@synopsys.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <7491cb59-04f0-866f-2f0f-7fe80e590d3b@arm.com>
Date: Mon, 12 Feb 2018 18:15:27 +0000
MIME-Version: 1.0
In-Reply-To: <5b495bf6-4989-6a24-872c-638a2b078c9f@synopsys.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/02/18 17:58, Gustavo Pimentel wrote:
> Hi Marc,
> 
> On 09/02/2018 11:10, Marc Zyngier wrote:
>> Hi Gustavo,
>>
>> On 26/01/18 16:35, Gustavo Pimentel wrote:
>>> Adds a IRQ chained API to pcie-designware, that aims to replace the current
>>> IRQ domain hierarchy API implemented.
>>>
>>> Although the IRQ domain hierarchy API is still available, pcie-designware
>>> will use now the IRQ chained API.
>>
>> I'm a bit thrown by this comment, as I don't think it reflects the
>> reality of the code.
>>
>> What you have here is a domain hierarchy (generic PCI MSI layer and HW
>> specific domain), *and* a multiplexer (chained interrupt) that funnels
>> all your MSIs into a single parent interrupt. What you're moving away
>> from is the msi_controller API.
>>
>> This has no impact on the code, but it helps to use the correct terminology.
>>
> 
> Ok, I'll fix the terminology and descriptions.
> 
>>>
>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>> Tested-by: Niklas Cassel <niklas.cassel@axis.com>
>>> ---
>>> Change v1->v2:
>>> - num_vectors is now not configurable by the Device Tree. Now it is 32 by
>>> default and can be overridden by any specific SoC driver.
>>> Change v2->v3:
>>> - Nothing changed, just to follow the patch set version.
>>> Change v3->v4:
>>> - Moved Kishon's fixes (PCI end point error and a dra7xx warning) from
>>> v3-0007 patch file to here.
>>> - Undo the change of the function signature to be more coherent with the
>>> host mode specific functions (Thanks Kishon).
>>> - Refactor the added functions in order to used host_data so that getting
>>> pp again back from pci could be avoided. (Thanks Kishon)
>>> - Changed summary line to match the drivers/PCI convention and changelog to
>>> maintain the consistency (thanks Bjorn).
>>> Change v4->v5:
>>> - Implemented Kishon MSI multiple messages fix (thanks Kishon).
>>> Change v5->v6:
>>> - Fixed rebase problem detected by Niklas (thanks Niklas).
>>>
>>>  drivers/pci/dwc/pcie-designware-host.c | 296 +++++++++++++++++++++++++++++----
>>>  drivers/pci/dwc/pcie-designware.h      |  18 ++
>>>  2 files changed, 286 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
>>> index bf558df..f7b2bce 100644
>>> --- a/drivers/pci/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/dwc/pcie-designware-host.c
>>> @@ -11,6 +11,7 @@
>>>   * published by the Free Software Foundation.
>>>   */
>>>  
>>> +#include <linux/irqchip/chained_irq.h>
>>>  #include <linux/irqdomain.h>
>>>  #include <linux/of_address.h>
>>>  #include <linux/of_pci.h>
>>> @@ -53,6 +54,36 @@ static struct irq_chip dw_msi_irq_chip = {
>>>  	.irq_unmask = pci_msi_unmask_irq,
>>>  };
>>>  
>>> +static void dw_msi_ack_irq(struct irq_data *d)
>>> +{
>>> +	irq_chip_ack_parent(d);
>>> +}
>>> +
>>> +static void dw_msi_mask_irq(struct irq_data *d)
>>> +{
>>> +	pci_msi_mask_irq(d);
>>> +	irq_chip_mask_parent(d);
>>> +}
>>> +
>>> +static void dw_msi_unmask_irq(struct irq_data *d)
>>> +{
>>> +	pci_msi_unmask_irq(d);
>>> +	irq_chip_unmask_parent(d);
>>> +}
>>> +
>>> +static struct irq_chip dw_pcie_msi_irq_chip = {
>>> +	.name = "PCI-MSI",
>>> +	.irq_ack = dw_msi_ack_irq,
>>> +	.irq_mask = dw_msi_mask_irq,
>>> +	.irq_unmask = dw_msi_unmask_irq,
>>> +};
>>> +
>>> +static struct msi_domain_info dw_pcie_msi_domain_info = {
>>> +	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>> +		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
>>> +	.chip	= &dw_pcie_msi_irq_chip,
>>> +};
>>> +
>>>  /* MSI int handler */
>>>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>>  {
>>> @@ -81,6 +112,196 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>>>  	return ret;
>>>  }
>>>  
>>> +/* Chained MSI interrupt service routine */
>>> +static void dw_chained_msi_isr(struct irq_desc *desc)
>>> +{
>>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>>> +	struct pcie_port *pp;
>>> +
>>> +	chained_irq_enter(chip, desc);
>>> +
>>> +	pp = irq_desc_get_handler_data(desc);
>>> +	dw_handle_msi_irq(pp);
>>> +
>>> +	chained_irq_exit(chip, desc);
>>> +}
>>
>> Nit: once you're done with the msi_controller stuff (in patch #8), it'd
>> be good to move dw_handle_msi_irq() inside this function, as the
>> irqreturn_t return type doesn't make much sense any more.
> 
> Hum, I like your suggestion, however there's two drivers (HiSilicon STB and ST
> Microelectronics SPEAr13xx) that uses directly the dw_handle_msi_irq function. I
> would suggested to this "cleanup" in another patch series, just for keep this
> patch simple, if you don't mind.

/me rolls eyes. Holy crap, I didn't notice that. This is terrifying. OK,
let's put that on the list of "things that should not be", and let's
focus on your series.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
