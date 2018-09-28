Return-Path: <SRS0=ex/N=MK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9229DC43382
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1F02170E
	for <linux-pci@archiver.kernel.org>; Fri, 28 Sep 2018 13:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1F02170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeI1TlF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:41:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49514 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeI1TlF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Sep 2018 15:41:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64200ED1;
        Fri, 28 Sep 2018 06:17:20 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137F73F5D3;
        Fri, 28 Sep 2018 06:17:17 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] PCI: controller: dwc: add UniPhier PCIe host
 controller support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>
References: <b869b273-e681-0b8c-52f5-6e02f9de5485@synopsys.com>
 <20180926213135.A4B4.4A936039@socionext.com>
 <20180927164426.ECD6.4A936039@socionext.com>
 <20180928110640.GA18840@e107981-ln.cambridge.arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <bb081d21-7c03-0357-4294-7e92d95d838c@arm.com>
Date:   Fri, 28 Sep 2018 14:17:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928110640.GA18840@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 28/09/18 12:06, Lorenzo Pieralisi wrote:
> [+Murali, Marc]
> 
> On Thu, Sep 27, 2018 at 04:44:26PM +0900, Kunihiko Hayashi wrote:
>> Hi Lorenzo, Gustavo,
>>
>> On Wed, 26 Sep 2018 21:31:36 +0900 <hayashi.kunihiko@socionext.com> wrote:
>>
>>> Hi Lorenzo, Gustavo,
>>>
>>> Thank you for reviewing.
>>>
>>> On Tue, 25 Sep 2018 18:53:01 +0100
>>> Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:
>>>
>>>> On 25/09/2018 17:14, Lorenzo Pieralisi wrote:
>>>>> [+Gustavo, please have a look at INTX/MSI management]
>>>>>
>>>>> On Thu, Sep 06, 2018 at 06:40:32PM +0900, Kunihiko Hayashi wrote:
>>>>>> This introduces specific glue layer for UniPhier platform to support
>>>>>> PCIe host controller that is based on the DesignWare PCIe core, and
>>>>>> this driver supports Root Complex (host) mode.
>>>>>
>>>>> Please read this thread and apply it to next versions:
>>>>>
>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dpci-26m-3D150905742808166-26w-3D2&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=H8UNDDUGQnQnqfWr4CBios689dJcjxu4qeTTRGulLmU&s=CgcXc_2LThyOpW-4bCriJNo9H1lzROEdy_cG9p-Y5hU&e=
>>>
>>> I also found this thread in previous linux-pci, and I think it's helpful for me.
>>> I'll check it carefully.
>>
>> [snip]
>>
>>>>>> +	ret = devm_request_irq(dev, pp->irq, uniphier_pcie_irq_handler,
>>>>>> +			       IRQF_SHARED, "pcie", priv);
>>>>>
>>>>> This is wrong, you should set-up a chained IRQ for INTX.
>>>>>
>>>>> I *think* that
>>>>>
>>>>> ks_pcie_setup_interrupts()
>>>>>
>>>>> is a good example to start with but I wonder whether it is worth
>>>>> generalizing the INTX approach to designware as a whole as it was
>>>>> done for MSIs.
>>>>>
>>>>> Thoughts ?
>>>>
>>>>  From what I understood this is for legacy IRQ, right?
>>>
>>> Yes. For legacy IRQ.
>>>
>>>> Like you (Lorenzo) said there is 2 drivers (pci-keystone-dw.c and pci-dra7xx.c)
>>>> that uses it and can be use as a template for handling this type of interrupts.
>>>>
>>>> We can try to pass some kind of generic INTX function to the DesignWare host
>>>> library to handling this, but this will require some help from keystone and
>>>> dra7xx maintainers, since my setup doesn't have legacy IRQ HW support.
>>>
>>> Now I think it's difficult to make a template for INTX function,
>>> and at first, I'll try to re-write this part with reference to pci-keystone-dw.c.
>>
>> I understand that there are 2 types of interrupt and the drivers.
>>
>> One like pci-keystone-dw.c is:
>>
>>   - there are 4 interrupts for legacy,
>>   - invoke handlers for each interrupt, and handle the interrupt,
>>   - call irq_set_chained_handler_and_data() to make a chain of the interrupts
>>    when initializing
>>
>> The other like pci-dra7xx.c is:
>>
>>   - there is 1 IRQ for legacy as a parent,
>>   - check an interrupt factor register, and handle the interrupt correspond
>>     to the factor,
>>   - call request_irq() for the parent IRQ and irq_domain_add_linear() for
>>     the factor when initializing
>>
>> The pcie-uniphier.c is the same type as the latter (like pci-dra7xx.c).
>>
>> However, in pci-dra7xx.c, MSI and legacy IRQ share the same interrupt number,
>> so the same handler is called and the handler divides these IRQs.
>> (found in dra7xx_pcie_msi_irq_handler())
>>
>> In pcie-uniphier.c, MSI and legacy IRQ are independent.
>> Therefore it's necessary to prepare the handler for the legacy IRQ.
>>
>> I think that it's difficult to apply the way of pci-keystone-dw.c, and
>> uniphier_pcie_irq_handler() and calling devm_request_irq() are still
>> necessary to handle legacy IRQ.
> 
> I do not think it is difficult, the difference is that keystone has
> 1 GIC irq line allocated per legacy IRQ, your set-up has one for
> all INTX.
> 
> *However*, I would like some clarifications from Murali on this code
> in drivers/pci/controller/dwc/pci-keystone.c:
> 
> static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> {
> 	unsigned int irq = irq_desc_get_irq(desc);
> 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> 	struct dw_pcie *pci = ks_pcie->pci;
> 	struct device *dev = pci->dev;
> 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> 
> Here the IRQ numbers are virtual IRQs, is it correct to consider
> the virq numbers as sequential values ? The "offset" is used to
> handle the PCI controller interrupt registers, so it must be a value
> between 0-3 IIUC.

There is absolutely no reason why virtual interrupt numbers should be 
contiguous. Shake the allocator hard enough, and you'll see gaps appearing.

In general, the only thing that makes sense is to compute this offset 
based on the hwirq which is HW-specific.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
