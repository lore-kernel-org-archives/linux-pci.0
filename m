Return-Path: <SRS0=2g0o=Q4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7123C4360F
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 09:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2BE214AF
	for <linux-pci@archiver.kernel.org>; Thu, 21 Feb 2019 09:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N53t8XcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBUJTl (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:19:41 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37724 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfBUJTk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Feb 2019 04:19:40 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1L9J1n8027496;
        Thu, 21 Feb 2019 03:19:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550740741;
        bh=GWODBLJzjtgkJjNQ3E5yOT43zFZmlg5iV7eUTgJwFac=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=N53t8XcCnmzxz0eO93yCfZ23uND4i/OZqa0IrZBXpz/8U9LQwwfBl/WT//14bJLKm
         Kxeky/86yPff8wcr/G7E2FhG4o6FkavxhYWxr3VDgc/pt7M10vcnpY8iR+59valgNy
         5+lMA3dYqYIp4j66h1anE2j3ATV2YtfbVQ7vsxCQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1L9J1W2080625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 03:19:01 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 03:19:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 03:19:00 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1L9Ivge029265;
        Thu, 21 Feb 2019 03:18:58 -0600
Subject: Re: [PATCH v3 3/9] PCI: keystone: Use hwirq to get the legacy IRQ
 number offset
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <marc.zyngier@arm.com>
References: <20190213132629.24790-1-kishon@ti.com>
 <20190213132629.24790-4-kishon@ti.com>
 <20190213165739.GE2280@e107981-ln.cambridge.arm.com>
 <8028b0e2-ac32-4e36-c87d-6f4818f34301@ti.com>
 <20190214103138.GA24593@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <96847567-91d7-ed0b-0711-f586d1cfd0e6@ti.com>
Date:   Thu, 21 Feb 2019 14:48:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214103138.GA24593@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 14/02/19 4:01 PM, Lorenzo Pieralisi wrote:
> [CC'ed MarcZ]
> 
> On Thu, Feb 14, 2019 at 10:27:19AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 13/02/19 10:27 PM, Lorenzo Pieralisi wrote:
>>> On Wed, Feb 13, 2019 at 06:56:23PM +0530, Kishon Vijay Abraham I wrote:
>>>> ks_pcie_legacy_irq_handler() uses 'virq' to get the IRQ number offset.
>>>> This offset is used to get the correct IRQ_STATUS register
>>>> corresponding to the IRQ line that raised the interrupt.
>>>> There is no guarantee that 'virq' assigned for consecutive hardware
>>>> IRQ will be contiguous. And this might get us an incorrect IRQ number
>>>> offset.
>>>>
>>>> Fix it here by using 'hwirq' to get the IRQ number offset.
>>>>
>>>> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++++++++----
>>>>  1 file changed, 13 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
>>>> index e8b1d8eca78e..d35ac712a9f8 100644
>>>> --- a/drivers/pci/controller/dwc/pci-keystone.c
>>>> +++ b/drivers/pci/controller/dwc/pci-keystone.c
>>>> @@ -87,7 +87,7 @@ struct keystone_pcie {
>>>>  	struct dw_pcie		*pci;
>>>>  	/* PCI Device ID */
>>>>  	u32			device_id;
>>>> -	int			legacy_host_irqs[PCI_NUM_INTX];
>>>> +	int			legacy_host_irq;
>>>>  	struct			device_node *legacy_intc_np;
>>>>  
>>>>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
>>>> @@ -582,11 +582,11 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
>>>>   */
>>>>  static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>>>  {
>>>> -	unsigned int irq = irq_desc_get_irq(desc);
>>>> +	unsigned int irq = desc->irq_data.hwirq;
>>>>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>>>>  	struct dw_pcie *pci = ks_pcie->pci;
>>>>  	struct device *dev = pci->dev;
>>>> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>>>> +	u32 irq_offset = irq - ks_pcie->legacy_host_irq;
>>>
>>> I think you should use the plain hwirq number (that if I understand
>>> correctly range in [0,3]) and drop legacy_host_irq.
>>
>> The hwirq is [80, 83] for Keystone. We store legacy_host_irq (for Keystone it
>> is 80) to get the correct offset in the range [0, 3].
> 
> IIUC the _parent_ hw_irq number should be what you need here, Marc (if
> he has time) can correct me if I am wrong (or what I am suggesting is
> a violation of IRQ domain bstraction usage).
> 
>>>
>>> See below.
>>>
>>>>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>>>>  
>>>>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
>>>> @@ -657,6 +657,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>>>  	struct device_node *np = ks_pcie->np;
>>>>  	struct device_node *intc_np;
>>>>  	int irq_count, irq, ret, i;
>>>> +	struct irq_data *irq_data;
>>>>  
>>>>  	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
>>>>  	if (!intc_np) {
>>>> @@ -677,7 +678,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
>>>>  			ret = -EINVAL;
>>>>  			goto err;
>>>>  		}
>>>> -		ks_pcie->legacy_host_irqs[i] = irq;
>>>> +
>>>> +		if (!ks_pcie->legacy_host_irq) {
>>>> +			irq_data = irq_get_irq_data(irq);
>>>> +			if (!irq_data) {
>>>> +				ret = -EINVAL;
>>>> +				goto err;
>>>> +			}
>>>> +			ks_pcie->legacy_host_irq = irq_data->hwirq;
>>>
>>> This depends on DT property ordering and may well be wrong. On top
>>> of that as I said above I do not think it is even needed.
>>
>> right, it depends on the ordering of the entries in the "interrupts" property.
>> Right now we have something like below
>>
>>                                interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
>>                                         <GIC_SPI 49 IRQ_TYPE_EDGE_RISING>,
>>                                         <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>,
>>                                         <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>;
>>
>> And changing the order will make legacy_host_irq store the wrong hwirq. With
>> this patch we solve the problem of assuming virq to be contiguous for
>> contiguous hwirq however we do expect the hwirqs to be populated in the DT in
>> the correct order.
>>
>> Ordering entries within a property is also followed in other
>> properties like "reg" where the drivers use platform_get_resource with
>> index as argument. I'm not sure if there's a way to get rid of the
>> ordering requirement in DT for the "interrupts" property.
> 
> I am not sure there is an ordering requirement in place but hopefully we
> should not need it, see above.
> 
> The 1:1 relationship between GIC-IRQ<->PCI-host-bridge-controller-IRQ is
> what the kernel IRQ domain abstraction is there to implement, so a
> reverse look-up should be feasible without adding anything else, lest
> we duplicate IRQ domain data structures.

I got legacy interrupt working using hierarchy domain. With that we don't need
to have chained irq handler here. I'll post v4 soon.

Thanks
Kishon
