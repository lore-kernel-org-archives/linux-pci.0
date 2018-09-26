Return-Path: <SRS0=XSei=MI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFAFC43382
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1FE2089D
	for <linux-pci@archiver.kernel.org>; Wed, 26 Sep 2018 12:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1FE2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeIZSo0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:44:26 -0400
Received: from mx.socionext.com ([202.248.49.38]:27106 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIZSo0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 14:44:26 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Sep 2018 21:31:37 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 5189B6006C;
        Wed, 26 Sep 2018 21:31:37 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 26 Sep 2018 21:31:37 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id EB2734039A;
        Wed, 26 Sep 2018 21:31:36 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.132.48])
        by yuzu.css.socionext.com (Postfix) with ESMTP id A9CA5120417;
        Wed, 26 Sep 2018 21:31:36 +0900 (JST)
Date:   Wed, 26 Sep 2018 21:31:36 +0900
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH v2 2/2] PCI: controller: dwc: add UniPhier PCIe host controller support
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
In-Reply-To: <b869b273-e681-0b8c-52f5-6e02f9de5485@synopsys.com>
References: <20180925161417.GA30943@e107981-ln.cambridge.arm.com> <b869b273-e681-0b8c-52f5-6e02f9de5485@synopsys.com>
Message-Id: <20180926213135.A4B4.4A936039@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.70 [ja]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo, Gustavo,

Thank you for reviewing.

On Tue, 25 Sep 2018 18:53:01 +0100
Gustavo Pimentel <gustavo.pimentel@synopsys.com> wrote:

> On 25/09/2018 17:14, Lorenzo Pieralisi wrote:
> > [+Gustavo, please have a look at INTX/MSI management]
> > 
> > On Thu, Sep 06, 2018 at 06:40:32PM +0900, Kunihiko Hayashi wrote:
> >> This introduces specific glue layer for UniPhier platform to support
> >> PCIe host controller that is based on the DesignWare PCIe core, and
> >> this driver supports Root Complex (host) mode.
> > 
> > Please read this thread and apply it to next versions:
> > 
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dpci-26m-3D150905742808166-26w-3D2&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=H8UNDDUGQnQnqfWr4CBios689dJcjxu4qeTTRGulLmU&s=CgcXc_2LThyOpW-4bCriJNo9H1lzROEdy_cG9p-Y5hU&e=

I also found this thread in previous linux-pci, and I think it's helpful for me.
I'll check it carefully.

> > 
> > [...]
> > 
> >> +static int uniphier_pcie_link_up(struct dw_pcie *pci)
> >> +{
> >> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> >> +	u32 val, mask;
> >> +
> >> +	val = readl(priv->base + PCL_STATUS_LINK);
> >> +	mask = PCL_RDLH_LINK_UP | PCL_XMLH_LINK_UP;
> >> +
> >> +	return (val & mask) == mask;
> >> +}
> >> +
> >> +static int uniphier_pcie_establish_link(struct dw_pcie *pci)
> >> +{
> >> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> >> +	int ret;
> >> +
> >> +	if (dw_pcie_link_up(pci))
> >> +		return 0;
> >> +
> >> +	uniphier_pcie_ltssm_enable(priv);
> >> +
> >> +	ret = dw_pcie_wait_for_link(pci);
> >> +	if (ret == -ETIMEDOUT) {
> >> +		dev_warn(pci->dev, "Link not up\n");
> >> +		ret = 0;
> > 
> > So if the link is not up we warn, return and all is fine ?

Although I was not sure about driver's behavior if the link isn't up,
since the driver can't do anything after that,
so it seems suitable to return -ETIMEOUT and fail to probe.

> > 
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void uniphier_pcie_stop_link(struct dw_pcie *pci)
> >> +{
> >> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> >> +
> >> +	uniphier_pcie_ltssm_disable(priv);
> >> +}
> >> +
> >> +static int uniphier_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> >> +				  irq_hw_number_t hwirq)
> >> +{
> >> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
> >> +	irq_set_chip_data(irq, domain->host_data);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct irq_domain_ops uniphier_intx_domain_ops = {
> >> +	.map = uniphier_pcie_intx_map,
> >> +};
> > 
> > I looped in Gustavo since this is not how I expect INTX management
> > should be done. I do not think there is a DWC INTX generic layer
> > but I think drivers/pci/controller/dwc/pci-keystone-dw.c is how
> > it has to be done.
> > 
> >> +
> >> +static int uniphier_pcie_init_irq_domain(struct pcie_port *pp)
> >> +{
> >> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> >> +	struct device_node *np = pci->dev->of_node;
> >> +	struct device_node *np_intc = of_get_next_child(np, NULL);
> >> +
> >> +	if (!np_intc) {
> >> +		dev_err(pci->dev, "Failed to get child node\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	priv->irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
> >> +						 &uniphier_intx_domain_ops,
> >> +						 pp);
> >> +	if (!priv->irq_domain) {
> >> +		dev_err(pci->dev, "Failed to get INTx domain\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
> >> +{
> >> +	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
> >> +	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
> >> +}
> >> +
> >> +static void uniphier_pcie_irq_disable(struct uniphier_pcie_priv *priv)
> >> +{
> >> +	writel(0, priv->base + PCL_RCV_INT);
> >> +	writel(0, priv->base + PCL_RCV_INTX);
> >> +}
> > 
> >> +
> >> +static irqreturn_t uniphier_pcie_irq_handler(int irq, void *arg)
> > 
> > This should not be an IRQ handler (and we should not use
> > devm_request_irq() for the multiplexed IRQ line), it is a chained
> > interrupt controller configuration and should be managed by an IRQ
> > chain, again the way keystone does it seems reasonable to me.

I see. I'll try to refer to keystone driver as an example for chained interrupt
management.

> > 
> >> +{
> >> +	struct uniphier_pcie_priv *priv = arg;
> >> +	struct dw_pcie *pci = &priv->pci;
> >> +	u32 val;
> >> +
> >> +	/* INT for debug */
> >> +	val = readl(priv->base + PCL_RCV_INT);
> >> +
> >> +	if (val & PCL_CFG_BW_MGT_STATUS)
> >> +		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> >> +	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
> >> +		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> >> +	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> >> +		dev_dbg(pci->dev, "Root Error\n");
> >> +	if (val & PCL_CFG_PME_MSI_STATUS)
> >> +		dev_dbg(pci->dev, "PME Interrupt\n");
> >> +
> >> +	writel(val, priv->base + PCL_RCV_INT);
> >> +
> >> +	/* INTx */
> >> +	val = readl(priv->base + PCL_RCV_INTX);
> >> +
> >> +	if (val & PCL_RADM_INTA_STATUS)
> >> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 0));
> >> +	if (val & PCL_RADM_INTB_STATUS)
> >> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 1));
> >> +	if (val & PCL_RADM_INTC_STATUS)
> >> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 2));
> >> +	if (val & PCL_RADM_INTD_STATUS)
> >> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 3));
> > 
> > Nit: Do you really need 4 if statements to handle INTX ?

I found an example to use for_each_set_bit() in pci-dra7xx.c.
I'll replace it.

> > 
> >> +
> >> +	writel(val, priv->base + PCL_RCV_INTX);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static irqreturn_t uniphier_pcie_msi_irq_handler(int irq, void *arg)
> >> +{
> >> +	struct pcie_port *pp = arg;
> >> +
> >> +	return dw_handle_msi_irq(pp);
> >> +}
> > 
> > This IRQ handler must be removed, the MSI irq is handled by dwc core.

I see. I'll remove it.

> > 
> >> +static int uniphier_pcie_host_init(struct pcie_port *pp)
> >> +{
> >> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >> +	int ret;
> >> +
> >> +	dw_pcie_setup_rc(pp);
> >> +	ret = uniphier_pcie_establish_link(pci);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> >> +		dw_pcie_msi_init(pp);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
> >> +	.host_init = uniphier_pcie_host_init,
> >> +};
> >> +
> >> +static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
> >> +				  struct platform_device *pdev)
> >> +{
> >> +	struct dw_pcie *pci = &priv->pci;
> >> +	struct pcie_port *pp = &pci->pp;
> >> +	struct device *dev = &pdev->dev;
> >> +	int ret;
> >> +
> >> +	pp->root_bus_nr = -1;
> > 
> > Useless initialization, remove it.
> > 
> > (ie dw_pcie_host_init() initializes root_bus_nr for you).

I found it. This will be removed.

> > 
> >> +	pp->ops = &uniphier_pcie_host_ops;
> >> +
> >> +	pp->irq = platform_get_irq_byname(pdev, "intx");
> >> +	if (pp->irq < 0) {
> >> +		dev_err(dev, "Failed to get intx irq\n");
> >> +		return pp->irq;
> >> +	}
> >> +
> >> +	ret = devm_request_irq(dev, pp->irq, uniphier_pcie_irq_handler,
> >> +			       IRQF_SHARED, "pcie", priv);
> > 
> > This is wrong, you should set-up a chained IRQ for INTX.
> > 
> > I *think* that
> > 
> > ks_pcie_setup_interrupts()
> > 
> > is a good example to start with but I wonder whether it is worth
> > generalizing the INTX approach to designware as a whole as it was
> > done for MSIs.
> > 
> > Thoughts ?
> 
> From what I understood this is for legacy IRQ, right?

Yes. For legacy IRQ.

> Like you (Lorenzo) said there is 2 drivers (pci-keystone-dw.c and pci-dra7xx.c)
> that uses it and can be use as a template for handling this type of interrupts.
> 
> We can try to pass some kind of generic INTX function to the DesignWare host
> library to handling this, but this will require some help from keystone and
> dra7xx maintainers, since my setup doesn't have legacy IRQ HW support.

Now I think it's difficult to make a template for INTX function,
and at first, I'll try to re-write this part with reference to pci-keystone-dw.c.

> 
> > 
> >> +	if (ret) {
> >> +		dev_err(dev, "Failed to request irq %d\n", pp->irq);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = uniphier_pcie_init_irq_domain(pp);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> >> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> >> +		if (pp->msi_irq < 0)
> >> +			return pp->msi_irq;
> >> +
> >> +		ret = devm_request_irq(dev, pp->msi_irq,
> >> +				       uniphier_pcie_msi_irq_handler,
> >> +				       IRQF_SHARED, "pcie-msi", pp);
> > 
> > No. With MSI management in DWC core all you need to do is initializing
> > pp->msi_irq.

Okay, it isn't necessary to call devm_request_irq() here no longer.

Thank you,

---
Best Regards,
Kunihiko Hayashi


