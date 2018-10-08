Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A8DC00449
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 05:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457F72087D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 05:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m1sedH1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457F72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeJHM5V (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:57:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43432 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbeJHM5V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Oct 2018 08:57:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w985kNKD067111;
        Mon, 8 Oct 2018 00:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538977583;
        bh=Lw/yh9UCBDROG0Ho5iAoZlwJtzZTokR3W4e4Rv0YYDY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=m1sedH1wjT1exdyOQ86MdKREY40DHUTSEzOoiom7favdpgVKkhfii0+u3xPvZeSBE
         IhDcx5a5wHglGGsFqsfxtFG2/SzcrYGvjxV6gasCI1kpcAkbpFGC5IhMtHn+QpZKUL
         tpe+JlN0eu9Sm7rdmyWKGc5qbaLWj1joFrzcRVgM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w985kM9C021973;
        Mon, 8 Oct 2018 00:46:22 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 00:46:22 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 00:46:22 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w985kGvx000722;
        Mon, 8 Oct 2018 00:46:17 -0500
Subject: Re: [PATCH v2 2/2] PCI: controller: dwc: add UniPhier PCIe host
 controller support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
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
 <bb081d21-7c03-0357-4294-7e92d95d838c@arm.com>
 <20180928154350.GC24460@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <dbb43a92-b5c0-0d26-3db0-3dbbccb12b98@ti.com>
Date:   Mon, 8 Oct 2018 11:15:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928154350.GC24460@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Friday 28 September 2018 09:13 PM, Lorenzo Pieralisi wrote:
> On Fri, Sep 28, 2018 at 02:17:16PM +0100, Marc Zyngier wrote:
>> On 28/09/18 12:06, Lorenzo Pieralisi wrote:
>>> [+Murali, Marc]
>>>
>>> On Thu, Sep 27, 2018 at 04:44:26PM +0900, Kunihiko Hayashi wrote:
>>>> Hi Lorenzo, Gustavo,
>>>>
>>>> On Wed, 26 Sep 2018 21:31:36 +0900 <hayashi.kunihiko@socionext.com> wrote:
>>>>
>>>>> Hi Lorenzo, Gustavo,
>>>>>
>>>>> Thank you for reviewing.
>>>>>
>>>>> On Tue, 25 Sep 2018 18:53:01 +0100
>>>>> Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:
>>>>>
>>>>>> On 25/09/2018 17:14, Lorenzo Pieralisi wrote:
>>>>>>> [+Gustavo, please have a look at INTX/MSI management]
>>>>>>>
>>>>>>> On Thu, Sep 06, 2018 at 06:40:32PM +0900, Kunihiko Hayashi wrote:
>>>>>>>> This introduces specific glue layer for UniPhier platform to support
>>>>>>>> PCIe host controller that is based on the DesignWare PCIe core, and
>>>>>>>> this driver supports Root Complex (host) mode.
>>>>>>>
>>>>>>> Please read this thread and apply it to next versions:
>>>>>>>
>>>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dpci-26m-3D150905742808166-26w-3D2&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=H8UNDDUGQnQnqfWr4CBios689dJcjxu4qeTTRGulLmU&s=CgcXc_2LThyOpW-4bCriJNo9H1lzROEdy_cG9p-Y5hU&e=
>>>>>
>>>>> I also found this thread in previous linux-pci, and I think it's helpful for me.
>>>>> I'll check it carefully.
>>>>
>>>> [snip]
>>>>
>>>>>>>> +	ret = devm_request_irq(dev, pp->irq, uniphier_pcie_irq_handler,
>>>>>>>> +			       IRQF_SHARED, "pcie", priv);
>>>>>>>
>>>>>>> This is wrong, you should set-up a chained IRQ for INTX.
>>>>>>>
>>>>>>> I *think* that
>>>>>>>
>>>>>>> ks_pcie_setup_interrupts()
>>>>>>>
>>>>>>> is a good example to start with but I wonder whether it is worth
>>>>>>> generalizing the INTX approach to designware as a whole as it was
>>>>>>> done for MSIs.
>>>>>>>
>>>>>>> Thoughts ?
>>>>>>
>>>>>> From what I understood this is for legacy IRQ, right?
>>>>>
>>>>> Yes. For legacy IRQ.
>>>>>
>>>>>> Like you (Lorenzo) said there is 2 drivers (pci-keystone-dw.c and pci-dra7xx.c)
>>>>>> that uses it and can be use as a template for handling this type of interrupts.
>>>>>>
>>>>>> We can try to pass some kind of generic INTX function to the DesignWare host
>>>>>> library to handling this, but this will require some help from keystone and
>>>>>> dra7xx maintainers, since my setup doesn't have legacy IRQ HW support.
>>>>>
>>>>> Now I think it's difficult to make a template for INTX function,
>>>>> and at first, I'll try to re-write this part with reference to pci-keystone-dw.c.
>>>>
>>>> I understand that there are 2 types of interrupt and the drivers.
>>>>
>>>> One like pci-keystone-dw.c is:
>>>>
>>>>  - there are 4 interrupts for legacy,
>>>>  - invoke handlers for each interrupt, and handle the interrupt,
>>>>  - call irq_set_chained_handler_and_data() to make a chain of the interrupts
>>>>   when initializing
>>>>
>>>> The other like pci-dra7xx.c is:
>>>>
>>>>  - there is 1 IRQ for legacy as a parent,
>>>>  - check an interrupt factor register, and handle the interrupt correspond
>>>>    to the factor,
>>>>  - call request_irq() for the parent IRQ and irq_domain_add_linear() for
>>>>    the factor when initializing
>>>>
>>>> The pcie-uniphier.c is the same type as the latter (like pci-dra7xx.c).
>>>>
>>>> However, in pci-dra7xx.c, MSI and legacy IRQ share the same interrupt number,
>>>> so the same handler is called and the handler divides these IRQs.
>>>> (found in dra7xx_pcie_msi_irq_handler())
>>>>
>>>> In pcie-uniphier.c, MSI and legacy IRQ are independent.
>>>> Therefore it's necessary to prepare the handler for the legacy IRQ.
>>>>
>>>> I think that it's difficult to apply the way of pci-keystone-dw.c, and
>>>> uniphier_pcie_irq_handler() and calling devm_request_irq() are still
>>>> necessary to handle legacy IRQ.
>>>
>>> I do not think it is difficult, the difference is that keystone has
>>> 1 GIC irq line allocated per legacy IRQ, your set-up has one for
>>> all INTX.
>>>
>>> *However*, I would like some clarifications from Murali on this code
>>> in drivers/pci/controller/dwc/pci-keystone.c:
>>>
>>> static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
>>> {
>>> 	unsigned int irq = irq_desc_get_irq(desc);
>>> 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
>>> 	struct dw_pcie *pci = ks_pcie->pci;
>>> 	struct device *dev = pci->dev;
>>> 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
>>>
>>> Here the IRQ numbers are virtual IRQs, is it correct to consider
>>> the virq numbers as sequential values ? The "offset" is used to
>>> handle the PCI controller interrupt registers, so it must be a value
>>> between 0-3 IIUC.
>>
>> There is absolutely no reason why virtual interrupt numbers should be
>> contiguous. Shake the allocator hard enough, and you'll see gaps appearing.
>>
>> In general, the only thing that makes sense is to compute this offset based
>> on the hwirq which is HW-specific.
> 
> That was my understanding and why I asked, which means that keystone
> code can break (unless I read it wrong) and Murali will send me a fix as
> soon as possible please to get it right (and Kunihiko will base his
> code on this discussion).

I had cleaned up legacy interrupt handling in keystone driver [1] which was
also required for TI's AM654 Platform.

But I guess the same issue will occur in MSI interrupt handling. I'll fix that
up in the next version. Btw can you review [2] so that I can fix any other
comments that you may have.

Thanks
Kishon

[1] -> https://lore.kernel.org/patchwork/patch/989541/
[2] => https://lore.kernel.org/patchwork/cover/989487/
> 
> Lorenzo
> 
> 
