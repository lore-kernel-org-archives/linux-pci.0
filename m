Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41316 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbeECNFE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 May 2018 09:05:04 -0400
Subject: Re: [PATCH 2/2] PCI: mediatek: Using chained IRQ to setup IRQ handle
To: Honghui Zhang <honghui.zhang@mediatek.com>
Cc: lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com,
        yt.shen@mediatek.com, sean.wang@mediatek.com,
        xinping.qian@mediatek.com
References: <1524201910-22836-1-git-send-email-honghui.zhang@mediatek.com>
 <1524201910-22836-3-git-send-email-honghui.zhang@mediatek.com>
 <a2f7e70a-fdef-d925-8838-be3051c2e96d@arm.com>
 <1525254064.22948.11.camel@mhfsdcap03>
 <e04ea8b1-731f-e72b-8944-5c067e1a04da@arm.com>
 <1525340514.22948.25.camel@mhfsdcap03>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <7efd1486-9f65-a647-5ab0-9a97b10c2ec7@arm.com>
Date: Thu, 3 May 2018 14:05:00 +0100
MIME-Version: 1.0
In-Reply-To: <1525340514.22948.25.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/05/18 10:41, Honghui Zhang wrote:
> On Wed, 2018-05-02 at 11:09 +0100, Marc Zyngier wrote:
>> On 02/05/18 10:41, Honghui Zhang wrote:
>>> On Mon, 2018-04-30 at 12:03 +0100, Marc Zyngier wrote:
>>>> Hi Zhang,
>>>>
>>>> On 20/04/18 06:25, honghui.zhang@mediatek.com wrote:
>>>>> From: Honghui Zhang <honghui.zhang@mediatek.com>
>>>>>
>>>>> Using irq_chip solution to setup IRQs for the consistent with IRQ framework.
>>>>>
>>>>> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
>>>>> ---
>>>>>  drivers/pci/host/pcie-mediatek.c | 192 +++++++++++++++++++++------------------
>>>>>  1 file changed, 105 insertions(+), 87 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
>>>>> index c3dc549..1d9c6f1 100644
>>>>> --- a/drivers/pci/host/pcie-mediatek.c
>>>>> +++ b/drivers/pci/host/pcie-mediatek.c
>>>>> @@ -11,8 +11,10 @@
>>>>>  #include <linux/delay.h>
>>>>>  #include <linux/iopoll.h>
>>>>>  #include <linux/irq.h>
>>>>> +#include <linux/irqchip/chained_irq.h>
>>>>>  #include <linux/irqdomain.h>
>>>>>  #include <linux/kernel.h>
>>>>> +#include <linux/msi.h>
>>>>>  #include <linux/of_address.h>
>>>>>  #include <linux/of_pci.h>
>>>>>  #include <linux/of_platform.h>
>>>>> @@ -130,14 +132,12 @@ struct mtk_pcie_port;
>>>>>  /**
>>>>>   * struct mtk_pcie_soc - differentiate between host generations
>>>>>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
>>>>> - * @has_msi: whether this host supports MSI interrupts or not
>>>>>   * @ops: pointer to configuration access functions
>>>>>   * @startup: pointer to controller setting functions
>>>>>   * @setup_irq: pointer to initialize IRQ functions
>>>>>   */
>>>>>  struct mtk_pcie_soc {
>>>>>  	bool need_fix_class_id;
>>>>> -	bool has_msi;
>>>>>  	struct pci_ops *ops;
>>>>>  	int (*startup)(struct mtk_pcie_port *port);
>>>>>  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
>>>>> @@ -161,7 +161,9 @@ struct mtk_pcie_soc {
>>>>>   * @lane: lane count
>>>>>   * @slot: port slot
>>>>>   * @irq_domain: legacy INTx IRQ domain
>>>>> + * @inner_domain: inner IRQ domain
>>>>>   * @msi_domain: MSI IRQ domain
>>>>> + * @lock: protect the msi_irq_in_use bitmap
>>>>>   * @msi_irq_in_use: bit map for assigned MSI IRQ
>>>>>   */
>>>>>  struct mtk_pcie_port {
>>>>> @@ -179,7 +181,9 @@ struct mtk_pcie_port {
>>>>>  	u32 lane;
>>>>>  	u32 slot;
>>>>>  	struct irq_domain *irq_domain;
>>>>> +	struct irq_domain *inner_domain;
>>>>>  	struct irq_domain *msi_domain;
>>>>> +	struct mutex lock;
>>>>>  	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
>>>>>  };
>>>>>  
>>>>> @@ -446,103 +450,122 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>> -static int mtk_pcie_msi_alloc(struct mtk_pcie_port *port)
>>>>> +static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>>>>>  {
>>>>> -	int msi;
>>>>> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
>>>>> +	phys_addr_t addr;
>>>>>  
>>>>> -	msi = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
>>>>> -	if (msi < MTK_MSI_IRQS_NUM)
>>>>> -		set_bit(msi, port->msi_irq_in_use);
>>>>> -	else
>>>>> -		return -ENOSPC;
>>>>> +	/* MT2712/MT7622 only support 32-bit MSI addresses */
>>>>> +	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
>>>>> +	msg->address_hi = 0;
>>>>> +	msg->address_lo = lower_32_bits(addr);
>>>>>  
>>>>> -	return msi;
>>>>> +	msg->data = data->hwirq;
>>>>> +
>>>>> +	dev_dbg(port->pcie->dev, "msi#%d address_hi %#x address_lo %#x\n",
>>>>> +		(int)data->hwirq, msg->address_hi, msg->address_lo);
>>>>>  }
>>>>>  
>>>>> -static void mtk_pcie_msi_free(struct mtk_pcie_port *port, unsigned long hwirq)
>>>>> +static int mtk_msi_set_affinity(struct irq_data *irq_data,
>>>>> +				   const struct cpumask *mask, bool force)
>>>>>  {
>>>>> -	clear_bit(hwirq, port->msi_irq_in_use);
>>>>> +	return -EINVAL;
>>>>>  }
>>>>>  
>>>>> -static int mtk_pcie_msi_setup_irq(struct msi_controller *chip,
>>>>> -				  struct pci_dev *pdev, struct msi_desc *desc)
>>>>> -{
>>>>> -	struct mtk_pcie_port *port;
>>>>> -	struct msi_msg msg;
>>>>> -	unsigned int irq;
>>>>> -	int hwirq;
>>>>> -	phys_addr_t msg_addr;
>>>>> +static struct irq_chip mtk_msi_bottom_irq_chip = {
>>>>> +	.name			= "MTK MSI",
>>>>> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
>>>>> +	.irq_set_affinity	= mtk_msi_set_affinity,
>>>>> +	.irq_mask		= pci_msi_mask_irq,
>>>>> +	.irq_unmask	= pci_msi_unmask_irq,
>>>>> +};
>>>>>  
>>>>> -	port = mtk_pcie_find_port(pdev->bus, pdev->devfn);
>>>>> -	if (!port)
>>>>> -		return -EINVAL;
>>>>> +static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>>> +				     unsigned int nr_irqs, void *args)
>>>>> +{
>>>>> +	struct mtk_pcie_port *port = domain->host_data;
>>>>> +	unsigned long bit;
>>>>>  
>>>>> -	hwirq = mtk_pcie_msi_alloc(port);
>>>>> -	if (hwirq < 0)
>>>>> -		return hwirq;
>>>>> +	WARN_ON(nr_irqs != 1);
>>>>> +	mutex_lock(&port->lock);
>>>>>  
>>>>> -	irq = irq_create_mapping(port->msi_domain, hwirq);
>>>>> -	if (!irq) {
>>>>> -		mtk_pcie_msi_free(port, hwirq);
>>>>> -		return -EINVAL;
>>>>> +	bit = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
>>>>> +	if (bit >= MTK_MSI_IRQS_NUM) {
>>>>> +		mutex_unlock(&port->lock);
>>>>> +		return -ENOSPC;
>>>>>  	}
>>>>>  
>>>>> -	chip->dev = &pdev->dev;
>>>>> -
>>>>> -	irq_set_msi_desc(irq, desc);
>>>>> +	__set_bit(bit, port->msi_irq_in_use);
>>>>>  
>>>>> -	/* MT2712/MT7622 only support 32-bit MSI addresses */
>>>>> -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
>>>>> -	msg.address_hi = 0;
>>>>> -	msg.address_lo = lower_32_bits(msg_addr);
>>>>> -	msg.data = hwirq;
>>>>> +	mutex_unlock(&port->lock);
>>>>>  
>>>>> -	pci_write_msi_msg(irq, &msg);
>>>>> +	irq_domain_set_info(domain, virq, bit, &mtk_msi_bottom_irq_chip,
>>>>> +			    domain->host_data, handle_simple_irq,
>>>>
>>>> Why don't you handle the interrupt as an edge interrupt
>>>> (handle_edge_irq)? That's what it really is, and the fact that you use
>>>> "handle_simple_irq" makes me think that wou're papering over some other
>>>> issue (see below).
>>>
>>> Hi, Marc,
>>>
>>> Thanks very much for your comments.
>>>
>>> I guess the MSI irq is more like a level IRQ instead of edge IRQ.
>>> When a MSI IRQ arrived, the corresponding bit of MSI status register
>>> will be asserted and stay asserted until it's been cleared by software.
>>
>> There is some confusion here. The MSI itself is always edge-triggered.
>> That's by definition, and you cannot change it. The interrupt that is
>> used to signal that MSIs are pending (the multiplexing interrupt) can
>> itself be level triggered (and goes low once all the MSIs have been
>> acknowledged).
> 
> Hi, Marc, thanks for your comments.
> 
> Yes, PCIe SPEC have defined that the MSI must be edge trigged. But I'm
> not sure whether the HW design needed to following some edge irq
> standard. 


Given that the device is writing to the MSI doorbell, this can only be
an edge (one way to look at it is that you cannot "unwrite" something,
so you can't drop the level).

> In our design, when there's MSI irq trigged(which may is edge
> trigged in hw implemented), the corresponding msi irq status bits will
> be asserted until it's been cleared by software. It's more like that the
> HW IP have translate the edge irq to level status. Do you think using
> handle_level_irq or handle_simple_irq(which most of the pci host driver
> now doing) is acceptable in this case?

This is how it is supposed to work:

Device --edge--> MSI-controller --level--> primary controller

When you're handling the MSI, it has to be edge. When handling the
interrupt between the MSI controller and the main irqchip, this is level.

At the moment, you have handle that first interrupt as level, which is
wrong.

> BTW, I'm still struggling in trying the handle_edge_irq solution. Seems
> that I could not get the msi index in irq_ack callback from
> irq_data->hwirq, the hwirq was set by pci_msi_domain_calc_hwirq() which
> I'm still try to figure out the proper routine in my driver.

That's because you've plugged it in the wrong irqchip. Your top-level
irqchip (the one backing the PCI domain) must be implemented with
irq_chip_ack_parent, and you them implement the ack logic in the
HW-specific irqchip.

	M.
-- 
Jazz is not dead. It just smells funny...
