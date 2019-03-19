Return-Path: <SRS0=xwy5=RW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A5C43381
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 10:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E78B20857
	for <linux-pci@archiver.kernel.org>; Tue, 19 Mar 2019 10:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PILy4IVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCSKxl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:53:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50688 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSKxl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Mar 2019 06:53:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JArTXG017309;
        Tue, 19 Mar 2019 05:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552992809;
        bh=jlNB/oTUxrIzdMuH32UtO1AnML6udR7Rq99ZKfqok94=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PILy4IVLJbUjXVLNPAgDrt5dydqXD0+kftBYfq4C8WVNUXviqSPX2vhmBhquejUte
         HQilx+fFTsz/+1tY3JHZI33vbNPQzMizwGS2BY9u5D8R2eh45a2rBQkLTwdmrX56Ys
         Z/B5oP9e0d9Na57NoxfX74gm24BzfuC2V7odWD3k=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JArTsE030097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 05:53:29 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 05:53:28 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 05:53:28 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JArPEx026205;
        Tue, 19 Mar 2019 05:53:26 -0500
Subject: Re: [PATCH v4 3/9] PCI: keystone: Convert to using hierarchy domain
 for legacy interrupts
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190221101518.22604-1-kishon@ti.com>
 <20190221101518.22604-4-kishon@ti.com>
 <20190221162413.GA5815@e107981-ln.cambridge.arm.com>
 <20190223121143.14c1f150@why.wild-wind.fr.eu.org>
 <4c55487d-213f-f5f5-6d67-93a417d2a0d7@ti.com>
 <867eda28qh.wl-marc.zyngier@arm.com>
 <73780998-919e-1a1c-7b8d-0bf8e33df015@ti.com>
 <20190318111635.7eab3a97@why.wild-wind.fr.eu.org>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <737e20d6-b389-522e-7e04-a381601fb128@ti.com>
Date:   Tue, 19 Mar 2019 16:22:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318111635.7eab3a97@why.wild-wind.fr.eu.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 18/03/19 4:46 PM, Marc Zyngier wrote:
> On Mon, 18 Mar 2019 11:03:07 +0530
> Kishon Vijay Abraham I <kishon@ti.com> wrote:
> 
>> Hi Marc,
>>
>> On 07/03/19 5:32 PM, Marc Zyngier wrote:
>>> On Thu, 07 Mar 2019 09:12:30 +0000,
>>> Kishon Vijay Abraham I <kishon@ti.com> wrote:  
>>>>
>>>> Hi,
>>>>
>>>> On 23/02/19 5:41 PM, Marc Zyngier wrote:  
>>>>> On Thu, 21 Feb 2019 16:24:14 +0000
>>>>> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
>>>>>  
>>>>>> On Thu, Feb 21, 2019 at 03:45:12PM +0530, Kishon Vijay Abraham I wrote:  
>>>>>>> K2G provides separate IRQ lines for each of the four legacy interrupts.
>>>>>>> Model this using hierarchy domain instead of linear domain with chained
>>>>>>> IRQ handler.
>>>>>>>
>>>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>>>> ---
>>>>>>>  drivers/pci/controller/dwc/pci-keystone.c | 205 +++++++++++++---------
>>>>>>>  1 file changed, 118 insertions(+), 87 deletions(-)    
>>>>>>
>>>>>> Hi Kishon,
>>>>>>
>>>>>> I CC'ed Marc because you are actually re-writing an interrupt controller
>>>>>> driver so I would be happier to merge this refactoring if Marc can have
>>>>>> a look and he is satisfied with it - more so because most of the code can
>>>>>> be reused by other host bridge drivers with similar behaviour.  
>>>>>
>>>>> Cheers Lorenzo.
>>>>>
>>>>> It doesn't look too bad, but there is a couple of points I'd like to see
>>>>> clarified. Comments below.
>>>>>  
>>>>>>
>>>>>> I will have a look too, unfortunately it is becoming a bit tight for
>>>>>> v5.1 but let's see how it goes.
>>>>>>
>>>>>> Thanks,
>>>>>> Lorenzo
>>>>>>  
>>>>>>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>>>>>>> index 47f0dcf638f2..7f1648453f54 100644
>>>>>>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>>>>>>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>>>>>>> @@ -61,6 +61,7 @@
>>>>>>>  
>>>>>>>  #define IRQ_STATUS(n)			(0x184 + ((n) << 4))
>>>>>>>  #define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
>>>>>>> +#define IRQ_ENABLE_CLR(n)		(0x18C + ((n) << 4))
>>>>>>>  #define INTx_EN				BIT(0)
>>>>>>>  
>>>>>>>  #define ERR_IRQ_STATUS			0x1c4
>>>>>>> @@ -87,7 +88,6 @@ struct keystone_pcie {
>>>>>>>  	struct dw_pcie		*pci;
>>>>>>>  	/* PCI Device ID */
>>>>>>>  	u32			device_id;
>>>>>>> -	int			legacy_host_irqs[PCI_NUM_INTX];
>>>>>>>  	struct			device_node *legacy_intc_np;
>>>>>>>  
>>>>>>>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
>>>>>>> @@ -96,7 +96,6 @@ struct keystone_pcie {
>>>>>>>  	struct phy		**phy;
>>>>>>>  	struct device_link	**link;
>>>>>>>  	struct			device_node *msi_intc_np;
>>>>>>> -	struct irq_domain	*legacy_irq_domain;
>>>>>>>  	struct device_node	*np;
>>>>>>>  
>>>>>>>  	int error_irq;
>>>>>>> @@ -199,26 +198,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
>>>>>>>  	return dw_pcie_allocate_domains(pp);
>>>>>>>  }
>>>>>>>  
>>>>>>> -static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
>>>>>>> -				      int offset)
>>>>>>> -{
>>>>>>> -	struct dw_pcie *pci = ks_pcie->pci;
>>>>>>> -	struct device *dev = pci->dev;
>>>>>>> -	u32 pending;
>>>>>>> -	int virq;
>>>>>>> -
>>>>>>> -	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
>>>>>>> -
>>>>>>> -	if (BIT(0) & pending) {
>>>>>>> -		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
>>>>>>> -		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
>>>>>>> -		generic_handle_irq(virq);
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	/* EOI the INTx interrupt */
>>>>>>> -	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
>>>>>>> -}
>>>>>>> -
>>>>>>>  static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
>>>>>>>  {
>>>>>>>  	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
>>>>>>> @@ -256,39 +235,117 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
>>>>>>>  	return IRQ_HANDLED;
>>>>>>>  }
>>>>>>>  
>>>>>>> -static void ks_pcie_ack_legacy_irq(struct irq_data *d)
>>>>>>> +void ks_pcie_irq_eoi(struct irq_data *data)
>>>>>>>  {
>>>>>>> +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
>>>>>>> +	irq_hw_number_t hwirq = data->hwirq;
>>>>>>> +
>>>>>>> +	ks_pcie_app_writel(ks_pcie, IRQ_EOI, hwirq);
>>>>>>> +	irq_chip_eoi_parent(data);
>>>>>>>  }
>>>>>>>  
>>>>>>> -static void ks_pcie_mask_legacy_irq(struct irq_data *d)
>>>>>>> +void ks_pcie_irq_enable(struct irq_data *data)
>>>>>>>  {
>>>>>>> +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
>>>>>>> +	irq_hw_number_t hwirq = data->hwirq;
>>>>>>> +
>>>>>>> +	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(hwirq), INTx_EN);
>>>>>>> +	irq_chip_enable_parent(data);
>>>>>>>  }
>>>>>>>  
>>>>>>> -static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
>>>>>>> +void ks_pcie_irq_disable(struct irq_data *data)
>>>>>>>  {
>>>>>>> +	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
>>>>>>> +	irq_hw_number_t hwirq = data->hwirq;
>>>>>>> +
>>>>>>> +	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_CLR(hwirq), INTx_EN);
>>>>>>> +	irq_chip_disable_parent(data);
>>>>>>>  }
>>>>>>>  
>>>>>>>  static struct irq_chip ks_pcie_legacy_irq_chip = {
>>>>>>> -	.name = "Keystone-PCI-Legacy-IRQ",
>>>>>>> -	.irq_ack = ks_pcie_ack_legacy_irq,
>>>>>>> -	.irq_mask = ks_pcie_mask_legacy_irq,
>>>>>>> -	.irq_unmask = ks_pcie_unmask_legacy_irq,
>>>>>>> +	.name			= "Keystone-PCI-Legacy-IRQ",
>>>>>>> +	.irq_enable		= ks_pcie_irq_enable,
>>>>>>> +	.irq_disable		= ks_pcie_irq_disable,
>>>>>>> +	.irq_eoi		= ks_pcie_irq_eoi,
>>>>>>> +	.irq_mask		= irq_chip_mask_parent,
>>>>>>> +	.irq_unmask		= irq_chip_unmask_parent,
>>>>>>> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
>>>>>>> +	.irq_set_type		= irq_chip_set_type_parent,
>>>>>>> +	.irq_set_affinity	= irq_chip_set_affinity_parent,
>>>>>>>  };
>>>>>>>  
>>>>>>> -static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
>>>>>>> -				       unsigned int irq,
>>>>>>> -				       irq_hw_number_t hw_irq)
>>>>>>> +static int ks_pcie_legacy_irq_domain_alloc(struct irq_domain *domain,
>>>>>>> +					   unsigned int virq,
>>>>>>> +					   unsigned int nr_irqs, void *data)
>>>>>>>  {
>>>>>>> -	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
>>>>>>> -				 handle_level_irq);
>>>>>>> -	irq_set_chip_data(irq, d->host_data);
>>>>>>> +	struct keystone_pcie *ks_pcie = domain->host_data;
>>>>>>> +	struct device_node *np = ks_pcie->legacy_intc_np;
>>>>>>> +	struct irq_fwspec parent_fwspec, *fwspec = data;
>>>>>>> +	struct of_phandle_args out_irq;
>>>>>>> +	int ret, i;
>>>>>>> +
>>>>>>> +	if (nr_irqs != 1)
>>>>>>> +		return -EINVAL;
>>>>>>> +
>>>>>>> +	ret = of_irq_parse_one(np, fwspec->param[0], &out_irq);
>>>>>>> +	if (ret < 0) {
>>>>>>> +		pr_err("Failed to parse interrupt node\n");
>>>>>>> +		return ret;
>>>>>>> +	}  
>>>>>
>>>>> What it this trying to do? Fishing out the interrupts from DT based on
>>>>> the legacy pin? This looks at best obscure. I wonder why you don't do
>>>>> that at probe time instead. Anyway, this requires documenting.  
>>>>
>>>> The device-tree of PCIe node looks something like below.
>>>>
>>>> interrupt-map = <0 0 0 1 &pcie_intc0 0 IRQ_TYPE_EDGE_RISING>, /* INT A */
>>>> 		<0 0 0 2 &pcie_intc0 1 IRQ_TYPE_EDGE_RISING>, /* INT B */
>>>> 		<0 0 0 3 &pcie_intc0 2 IRQ_TYPE_EDGE_RISING>, /* INT C */
>>>> 		<0 0 0 4 &pcie_intc0 3 IRQ_TYPE_EDGE_RISING>; /* INT D */
>>>> pcie_intc0: legacy-interrupt-controller {
>>>> 	interrupt-controller;
>>>> 	#interrupt-cells = <2>;
>>>> 	interrupt-parent = <&gic>;
>>>> 	interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
>>>> 		     <GIC_SPI 49 IRQ_TYPE_EDGE_RISING>,
>>>> 		     <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>,
>>>> 		     <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>;
>>>> };
>>>>
>>>> INTA corresponds to HWIRQ '0' of the hierarchy irq domain we create in this
>>>> driver which in turn corresponds to GIC_SPI '48' of GIC.
>>>>
>>>> We could create an array of parent_fwspec for each of the four interrupt lines
>>>> in legacy-interrupt-controller during probe and use it directly here while
>>>> invoking irq_domain_alloc_irqs_parent. I think you want me to do that instead
>>>> of using of_irq_parse_one here?  
>>>
>>> Up to you. I don't mind either way, but it is the lack of
>>> documentation that annoys me the most here.  
>>
>> Okay, I'll add a comment before invoking of_irq_parse_one.
>>>
>>> The more worrying part is that you are using an EDGE signalling in
>>> these bindings, and that's wrong. PCI legacy interrupts are level,
>>> always.  
>>
>> Agreed. But the HW uses pulse signal whenever it sees an Assert_Intx message.
> 
> I'm not convinced... See below.
> 
>>>
>>> [...]
>>>   
>>>>> From the DT binding:
>>>>>
>>>>> pcie_intc: Interrupt controller device node for Legacy IRQ chip
>>>>>         interrupt-cells: should be set to 1
>>>>>
>>>>> So why do we have 2 cells here?  
>>>>
>>>> With '1' cells, it's not possible to specify irq trigger type. DT
>>>> binding has to be fixed. I'll fix this in the next revision of the
>>>> patch series.  
>>>
>>> As I said above, this is wrong. Legacy interrupts are always level, by
>>> definition. Why are you making them edge-triggered
>>>   
>>>>>  
>>>>>>> +
>>>>>>> +		if (fwspec->param[0] >= PCI_NUM_INTX)
>>>>>>> +			return -EINVAL;  
>>>>>
>>>>> Most of the OF code assumes that the pin number describing the legacy
>>>>> interrupt is 1-based, while you obviously treat it as 0-based. How does
>>>>> it work?  
>>>>
>>>> INTA corresponds to '0' of the hierarchy interrupt domain (using
>>>> interrupt-map).  
>>>
>>> I'm not disputing this. It is more that the DT code does number the
>>> pin from 1, if memory serves well. Can you please verify this (see
>>> of_irq_parse_pci).  
>>
>> Yes it does number from '1'. However I use interrupt-map property to map from
>> legacy interrupt pin to a interrupt number of the legacy interrupt controller
>> which starts from '0'.
> 
> If you've verified that it actually works, fine bby me.
> 
>>>   
>>>>>  
>>>>>>> +
>>>>>>> +		*hwirq = fwspec->param[0];
>>>>>>> +		*type = fwspec->param[1];  
>>>>>
>>>>> As far as I remember, PCI legacy interrupts are level triggered, so
>>>>> there should be no need to advertise the trigger (which is consistent
>>>>> with the way the binding is written).  
>>>>
>>>> It is pulse triggered at subsystem level. Quoting the TRM
>>>> "The interrupt request signal at the PCIe SS boundary is a pulse signal that is
>>>> triggered each time an assert interrupt message is received." The PCIe
>>>> subsystem also has a level signal (interrupt pending signal) but the interrupt
>>>> request signal is the one that is connected to GIC.  
>>>
>>> This looks completely wrong. MSIs are always edge, and legacy always
>>> level, end of story. If your HW is any different, then it doesn't seem
>>> to be compliant with PCI.  
>>
>> Agree that Legacy interrupts ought to be level-triggered. I checked this with
>> HW team and I've copy-pasted the response.
>>
>> "The legacy interrupts from the PCIe controller are still level. The PCIe
>> controller will hold the legacy interrupt lines high until a de-assert message
>> is sent back. The pulse interrupt is only to send the interrupt from the PCIe
>> sub-system to the SoC interrupt controller. This should not impact the
>> operation of the legacy interrupt on the PCIe side."
>>
>> Looks like the interrupts are propagated multiple levels and only the last
>> level to the interrupt controller is pulse.
> 
> Let's take an example: My device (let's assume a network controller of
> some sort) generates an interrupt. Level is high, and you observe an
> edge. The driver handles the interrupt, but due to a race, the line
> stays high (the device has received a new packet).
> 
> How is a *new* edge generated? The line never transited to low, and we
> have more packet to process. With a level triggered interrupt, you just
> take the interrupt again. With an edge interrupt, you need to actively
> resample the level and retrigger the interrupt. How is this done?

There might be an actual issue in the HW while converting from level to edge
where new edge interrupt might not be generated in the case you just mentioned.
I am checking this with HW folks.

Since this might take time, I'll remove this patch and resend only the MSI
cleanup in order to make progress.

Thanks
Kishon
