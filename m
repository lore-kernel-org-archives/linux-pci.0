Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BEEC43441
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 10:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364C92086A
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 10:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 364C92086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJLSWQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:22:16 -0400
Received: from mx.socionext.com ([202.248.49.38]:47639 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeJLSWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 14:22:16 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 12 Oct 2018 19:50:24 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 7C48618023A;
        Fri, 12 Oct 2018 19:50:24 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 12 Oct 2018 19:50:24 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 379994031A;
        Fri, 12 Oct 2018 19:50:24 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id DEC5C120424;
        Fri, 12 Oct 2018 19:50:23 +0900 (JST)
Date:   Fri, 12 Oct 2018 19:50:23 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 2/2] PCI: controller: dwc: add UniPhier PCIe host controller support
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Masahiro Yamada" <yamada.masahiro@socionext.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>
In-Reply-To: <20181008143215.GA9596@e107981-ln.cambridge.arm.com>
References: <dbb43a92-b5c0-0d26-3db0-3dbbccb12b98@ti.com> <20181008143215.GA9596@e107981-ln.cambridge.arm.com>
Message-Id: <20181012195022.CA43.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Kishon,

On Mon, 8 Oct 2018 15:32:16 +0100 <lorenzo.pieralisi@arm.com> wrote:

> On Mon, Oct 08, 2018 at 11:15:59AM +0530, Kishon Vijay Abraham I wrote:
> > Hi Lorenzo,
> > 
> > On Friday 28 September 2018 09:13 PM, Lorenzo Pieralisi wrote:
> > > On Fri, Sep 28, 2018 at 02:17:16PM +0100, Marc Zyngier wrote:
> > >> On 28/09/18 12:06, Lorenzo Pieralisi wrote:
> > >>> [+Murali, Marc]
> > >>>
> > >>> On Thu, Sep 27, 2018 at 04:44:26PM +0900, Kunihiko Hayashi wrote:
> > >>>> Hi Lorenzo, Gustavo,
> > >>>>
> > >>>> On Wed, 26 Sep 2018 21:31:36 +0900 <hayashi.kunihiko@socionext.com> wrote:
> > >>>>
> > >>>>> Hi Lorenzo, Gustavo,
> > >>>>>
> > >>>>> Thank you for reviewing.
> > >>>>>
> > >>>>> On Tue, 25 Sep 2018 18:53:01 +0100
> > >>>>> Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:
> > >>>>>
> > >>>>>> On 25/09/2018 17:14, Lorenzo Pieralisi wrote:
> > >>>>>>> [+Gustavo, please have a look at INTX/MSI management]
> > >>>>>>>
> > >>>>>>> On Thu, Sep 06, 2018 at 06:40:32PM +0900, Kunihiko Hayashi wrote:
> > >>>>>>>> This introduces specific glue layer for UniPhier platform to support
> > >>>>>>>> PCIe host controller that is based on the DesignWare PCIe core, and
> > >>>>>>>> this driver supports Root Complex (host) mode.
> > >>>>>>>
> > >>>>>>> Please read this thread and apply it to next versions:
> > >>>>>>>
> > >>>>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dpci-26m-3D150905742808166-26w-3D2&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=H8UNDDUGQnQnqfWr4CBios689dJcjxu4qeTTRGulLmU&s=CgcXc_2LThyOpW-4bCriJNo9H1lzROEdy_cG9p-Y5hU&e=
> > >>>>>
> > >>>>> I also found this thread in previous linux-pci, and I think it's helpful for me.
> > >>>>> I'll check it carefully.
> > >>>>
> > >>>> [snip]
> > >>>>
> > >>>>>>>> +	ret = devm_request_irq(dev, pp->irq, uniphier_pcie_irq_handler,
> > >>>>>>>> +			       IRQF_SHARED, "pcie", priv);
> > >>>>>>>
> > >>>>>>> This is wrong, you should set-up a chained IRQ for INTX.
> > >>>>>>>
> > >>>>>>> I *think* that
> > >>>>>>>
> > >>>>>>> ks_pcie_setup_interrupts()
> > >>>>>>>
> > >>>>>>> is a good example to start with but I wonder whether it is worth
> > >>>>>>> generalizing the INTX approach to designware as a whole as it was
> > >>>>>>> done for MSIs.
> > >>>>>>>
> > >>>>>>> Thoughts ?
> > >>>>>>
> > >>>>>> From what I understood this is for legacy IRQ, right?
> > >>>>>
> > >>>>> Yes. For legacy IRQ.
> > >>>>>
> > >>>>>> Like you (Lorenzo) said there is 2 drivers (pci-keystone-dw.c and pci-dra7xx.c)
> > >>>>>> that uses it and can be use as a template for handling this type of interrupts.
> > >>>>>>
> > >>>>>> We can try to pass some kind of generic INTX function to the DesignWare host
> > >>>>>> library to handling this, but this will require some help from keystone and
> > >>>>>> dra7xx maintainers, since my setup doesn't have legacy IRQ HW support.
> > >>>>>
> > >>>>> Now I think it's difficult to make a template for INTX function,
> > >>>>> and at first, I'll try to re-write this part with reference to pci-keystone-dw.c.
> > >>>>
> > >>>> I understand that there are 2 types of interrupt and the drivers.
> > >>>>
> > >>>> One like pci-keystone-dw.c is:
> > >>>>
> > >>>>  - there are 4 interrupts for legacy,
> > >>>>  - invoke handlers for each interrupt, and handle the interrupt,
> > >>>>  - call irq_set_chained_handler_and_data() to make a chain of the interrupts
> > >>>>   when initializing
> > >>>>
> > >>>> The other like pci-dra7xx.c is:
> > >>>>
> > >>>>  - there is 1 IRQ for legacy as a parent,
> > >>>>  - check an interrupt factor register, and handle the interrupt correspond
> > >>>>    to the factor,
> > >>>>  - call request_irq() for the parent IRQ and irq_domain_add_linear() for
> > >>>>    the factor when initializing
> > >>>>
> > >>>> The pcie-uniphier.c is the same type as the latter (like pci-dra7xx.c).
> > >>>>
> > >>>> However, in pci-dra7xx.c, MSI and legacy IRQ share the same interrupt number,
> > >>>> so the same handler is called and the handler divides these IRQs.
> > >>>> (found in dra7xx_pcie_msi_irq_handler())
> > >>>>
> > >>>> In pcie-uniphier.c, MSI and legacy IRQ are independent.
> > >>>> Therefore it's necessary to prepare the handler for the legacy IRQ.
> > >>>>
> > >>>> I think that it's difficult to apply the way of pci-keystone-dw.c, and
> > >>>> uniphier_pcie_irq_handler() and calling devm_request_irq() are still
> > >>>> necessary to handle legacy IRQ.
> > >>>
> > >>> I do not think it is difficult, the difference is that keystone has
> > >>> 1 GIC irq line allocated per legacy IRQ, your set-up has one for
> > >>> all INTX.
> > >>>
> > >>> *However*, I would like some clarifications from Murali on this code
> > >>> in drivers/pci/controller/dwc/pci-keystone.c:
> > >>>
> > >>> static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> > >>> {
> > >>> 	unsigned int irq = irq_desc_get_irq(desc);
> > >>> 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> > >>> 	struct dw_pcie *pci = ks_pcie->pci;
> > >>> 	struct device *dev = pci->dev;
> > >>> 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> > >>>
> > >>> Here the IRQ numbers are virtual IRQs, is it correct to consider
> > >>> the virq numbers as sequential values ? The "offset" is used to
> > >>> handle the PCI controller interrupt registers, so it must be a value
> > >>> between 0-3 IIUC.
> > >>
> > >> There is absolutely no reason why virtual interrupt numbers should be
> > >> contiguous. Shake the allocator hard enough, and you'll see gaps appearing.
> > >>
> > >> In general, the only thing that makes sense is to compute this offset based
> > >> on the hwirq which is HW-specific.
> > > 
> > > That was my understanding and why I asked, which means that keystone
> > > code can break (unless I read it wrong) and Murali will send me a fix as
> > > soon as possible please to get it right (and Kunihiko will base his
> > > code on this discussion).
> > 
> > I had cleaned up legacy interrupt handling in keystone driver [1] which was
> > also required for TI's AM654 Platform.
> > 
> > But I guess the same issue will occur in MSI interrupt handling. I'll fix that
> > up in the next version. Btw can you review [2] so that I can fix any other
> > comments that you may have.
> 
> Hi Kishon,
> 
> yes I will, I am getting there (sorry for the delay), I don't think we
> can make it v4.20 material but let me first have a look, maybe we can
> split it up and simplify its merge.

Thank you for introducing RFC patches.
I saw the legacy interrupt part of them and I think that these became easier
to reference. Especially irq_domain_ops.map() will be the same.

Currently candidate pcie-uniphier driver and some ones are assuming to take
an interrupt from "interrupts" property because of using single interrupt.

	interrupt-name = "intx";
	interrupts = <xxx>;

However, keystone has 4 interrupts and Kishon's patch is assuming
to take it from the property in child "legacy-interrupt-controller" node.
Maybe latter is more general and I can apply it.

	legacy-interrupt-controller {
		interrupt-controller;
		#interrupt-cells = <1>;
		interrupt-parent = <&gic>;
		interrupts = <xxx>;
	};

I'll send v3 patch with reference to these RFC patches for now.

Thank you,

---
Best Regards,
Kunihiko Hayashi


