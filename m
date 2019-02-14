Return-Path: <SRS0=m7pK=QV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80137C43381
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 10:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526F62229F
	for <linux-pci@archiver.kernel.org>; Thu, 14 Feb 2019 10:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfBNKbq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:31:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388126AbfBNKbq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Feb 2019 05:31:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E89F1EBD;
        Thu, 14 Feb 2019 02:31:45 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E92823F575;
        Thu, 14 Feb 2019 02:31:43 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:31:38 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Murali Karicheri <m-karicheri2@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com
Subject: Re: [PATCH v3 3/9] PCI: keystone: Use hwirq to get the legacy IRQ
 number offset
Message-ID: <20190214103138.GA24593@e107981-ln.cambridge.arm.com>
References: <20190213132629.24790-1-kishon@ti.com>
 <20190213132629.24790-4-kishon@ti.com>
 <20190213165739.GE2280@e107981-ln.cambridge.arm.com>
 <8028b0e2-ac32-4e36-c87d-6f4818f34301@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8028b0e2-ac32-4e36-c87d-6f4818f34301@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[CC'ed MarcZ]

On Thu, Feb 14, 2019 at 10:27:19AM +0530, Kishon Vijay Abraham I wrote:
> Hi Lorenzo,
> 
> On 13/02/19 10:27 PM, Lorenzo Pieralisi wrote:
> > On Wed, Feb 13, 2019 at 06:56:23PM +0530, Kishon Vijay Abraham I wrote:
> >> ks_pcie_legacy_irq_handler() uses 'virq' to get the IRQ number offset.
> >> This offset is used to get the correct IRQ_STATUS register
> >> corresponding to the IRQ line that raised the interrupt.
> >> There is no guarantee that 'virq' assigned for consecutive hardware
> >> IRQ will be contiguous. And this might get us an incorrect IRQ number
> >> offset.
> >>
> >> Fix it here by using 'hwirq' to get the IRQ number offset.
> >>
> >> Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  drivers/pci/controller/dwc/pci-keystone.c | 17 +++++++++++++----
> >>  1 file changed, 13 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> >> index e8b1d8eca78e..d35ac712a9f8 100644
> >> --- a/drivers/pci/controller/dwc/pci-keystone.c
> >> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> >> @@ -87,7 +87,7 @@ struct keystone_pcie {
> >>  	struct dw_pcie		*pci;
> >>  	/* PCI Device ID */
> >>  	u32			device_id;
> >> -	int			legacy_host_irqs[PCI_NUM_INTX];
> >> +	int			legacy_host_irq;
> >>  	struct			device_node *legacy_intc_np;
> >>  
> >>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
> >> @@ -582,11 +582,11 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
> >>   */
> >>  static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
> >>  {
> >> -	unsigned int irq = irq_desc_get_irq(desc);
> >> +	unsigned int irq = desc->irq_data.hwirq;
> >>  	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
> >>  	struct dw_pcie *pci = ks_pcie->pci;
> >>  	struct device *dev = pci->dev;
> >> -	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
> >> +	u32 irq_offset = irq - ks_pcie->legacy_host_irq;
> > 
> > I think you should use the plain hwirq number (that if I understand
> > correctly range in [0,3]) and drop legacy_host_irq.
> 
> The hwirq is [80, 83] for Keystone. We store legacy_host_irq (for Keystone it
> is 80) to get the correct offset in the range [0, 3].

IIUC the _parent_ hw_irq number should be what you need here, Marc (if
he has time) can correct me if I am wrong (or what I am suggesting is
a violation of IRQ domain bstraction usage).

> > 
> > See below.
> > 
> >>  	struct irq_chip *chip = irq_desc_get_chip(desc);
> >>  
> >>  	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
> >> @@ -657,6 +657,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >>  	struct device_node *np = ks_pcie->np;
> >>  	struct device_node *intc_np;
> >>  	int irq_count, irq, ret, i;
> >> +	struct irq_data *irq_data;
> >>  
> >>  	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
> >>  	if (!intc_np) {
> >> @@ -677,7 +678,15 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
> >>  			ret = -EINVAL;
> >>  			goto err;
> >>  		}
> >> -		ks_pcie->legacy_host_irqs[i] = irq;
> >> +
> >> +		if (!ks_pcie->legacy_host_irq) {
> >> +			irq_data = irq_get_irq_data(irq);
> >> +			if (!irq_data) {
> >> +				ret = -EINVAL;
> >> +				goto err;
> >> +			}
> >> +			ks_pcie->legacy_host_irq = irq_data->hwirq;
> > 
> > This depends on DT property ordering and may well be wrong. On top
> > of that as I said above I do not think it is even needed.
> 
> right, it depends on the ordering of the entries in the "interrupts" property.
> Right now we have something like below
> 
>                                interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>,
>                                         <GIC_SPI 49 IRQ_TYPE_EDGE_RISING>,
>                                         <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>,
>                                         <GIC_SPI 51 IRQ_TYPE_EDGE_RISING>;
> 
> And changing the order will make legacy_host_irq store the wrong hwirq. With
> this patch we solve the problem of assuming virq to be contiguous for
> contiguous hwirq however we do expect the hwirqs to be populated in the DT in
> the correct order.
> 
> Ordering entries within a property is also followed in other
> properties like "reg" where the drivers use platform_get_resource with
> index as argument. I'm not sure if there's a way to get rid of the
> ordering requirement in DT for the "interrupts" property.

I am not sure there is an ordering requirement in place but hopefully we
should not need it, see above.

The 1:1 relationship between GIC-IRQ<->PCI-host-bridge-controller-IRQ is
what the kernel IRQ domain abstraction is there to implement, so a
reverse look-up should be feasible without adding anything else, lest
we duplicate IRQ domain data structures.

Thanks,
Lorenzo
