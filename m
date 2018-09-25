Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2133AC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC37520896
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="T8U+3bwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC37520896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeIZAE4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:04:56 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:32892 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeIZAEz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Sep 2018 20:04:55 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 0729724E0691;
        Tue, 25 Sep 2018 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1537898177; bh=HCDt2a3ViBDBxeNCmJgU7BbEbYL3iynnCfbVDmImMdY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=T8U+3bwdFqW6JAr46rzJT0a++nvn/YWl7e4q8vjOceOAfqtLgIsS1uShnTYCD9r5t
         O3lcv0JuoqYUV29uRmpjwmoSxyTAzQ1FjPL2BxblR80gaQ26bQ6yYPzbSvLZba5Fv7
         Wh/ZJfnsNyqA4nzlvmf0nVmW599RssLwJ1MM0l8BePeNIQf7ciHojZDqbPZMl+9xsF
         IvTrE5mwDm043fz0/oe1V8pJmJr1y25LFmw0QOpJBDtP8i1VQOsdskWFVL8SB+owjT
         9hDT0ZHhnTtqwBq4g/zxanpEiB3KcczUW5Mb8W+pjgR79A9sLwYJanS+ao88HVpJHG
         UsFvLUJd5Gapg==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id B813F580A;
        Tue, 25 Sep 2018 10:56:16 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 25 Sep 2018 10:56:16 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 25 Sep 2018 19:56:13 +0200
Received: from [10.107.25.102] (10.107.25.102) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 25 Sep 2018 19:56:13 +0200
Subject: Re: [PATCH v2 2/2] PCI: controller: dwc: add UniPhier PCIe host
 controller support
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
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
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
References: <1536226832-5089-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1536226832-5089-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20180925161417.GA30943@e107981-ln.cambridge.arm.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <b869b273-e681-0b8c-52f5-6e02f9de5485@synopsys.com>
Date:   Tue, 25 Sep 2018 18:53:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925161417.GA30943@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.102]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/09/2018 17:14, Lorenzo Pieralisi wrote:
> [+Gustavo, please have a look at INTX/MSI management]
> 
> On Thu, Sep 06, 2018 at 06:40:32PM +0900, Kunihiko Hayashi wrote:
>> This introduces specific glue layer for UniPhier platform to support
>> PCIe host controller that is based on the DesignWare PCIe core, and
>> this driver supports Root Complex (host) mode.
> 
> Please read this thread and apply it to next versions:
> 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__marc.info_-3Fl-3Dlinux-2Dpci-26m-3D150905742808166-26w-3D2&d=DwIBAg&c=DPL6_X_6JkXFx7AXWqB0tg&r=bkWxpLoW-f-E3EdiDCCa0_h0PicsViasSlvIpzZvPxs&m=H8UNDDUGQnQnqfWr4CBios689dJcjxu4qeTTRGulLmU&s=CgcXc_2LThyOpW-4bCriJNo9H1lzROEdy_cG9p-Y5hU&e=
> 
> [...]
> 
>> +static int uniphier_pcie_link_up(struct dw_pcie *pci)
>> +{
>> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>> +	u32 val, mask;
>> +
>> +	val = readl(priv->base + PCL_STATUS_LINK);
>> +	mask = PCL_RDLH_LINK_UP | PCL_XMLH_LINK_UP;
>> +
>> +	return (val & mask) == mask;
>> +}
>> +
>> +static int uniphier_pcie_establish_link(struct dw_pcie *pci)
>> +{
>> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>> +	int ret;
>> +
>> +	if (dw_pcie_link_up(pci))
>> +		return 0;
>> +
>> +	uniphier_pcie_ltssm_enable(priv);
>> +
>> +	ret = dw_pcie_wait_for_link(pci);
>> +	if (ret == -ETIMEDOUT) {
>> +		dev_warn(pci->dev, "Link not up\n");
>> +		ret = 0;
> 
> So if the link is not up we warn, return and all is fine ?
> 
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void uniphier_pcie_stop_link(struct dw_pcie *pci)
>> +{
>> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>> +
>> +	uniphier_pcie_ltssm_disable(priv);
>> +}
>> +
>> +static int uniphier_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
>> +				  irq_hw_number_t hwirq)
>> +{
>> +	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
>> +	irq_set_chip_data(irq, domain->host_data);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops uniphier_intx_domain_ops = {
>> +	.map = uniphier_pcie_intx_map,
>> +};
> 
> I looped in Gustavo since this is not how I expect INTX management
> should be done. I do not think there is a DWC INTX generic layer
> but I think drivers/pci/controller/dwc/pci-keystone-dw.c is how
> it has to be done.
> 
>> +
>> +static int uniphier_pcie_init_irq_domain(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>> +	struct device_node *np = pci->dev->of_node;
>> +	struct device_node *np_intc = of_get_next_child(np, NULL);
>> +
>> +	if (!np_intc) {
>> +		dev_err(pci->dev, "Failed to get child node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	priv->irq_domain = irq_domain_add_linear(np_intc, PCI_NUM_INTX,
>> +						 &uniphier_intx_domain_ops,
>> +						 pp);
>> +	if (!priv->irq_domain) {
>> +		dev_err(pci->dev, "Failed to get INTx domain\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>> +{
>> +	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
>> +	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>> +}
>> +
>> +static void uniphier_pcie_irq_disable(struct uniphier_pcie_priv *priv)
>> +{
>> +	writel(0, priv->base + PCL_RCV_INT);
>> +	writel(0, priv->base + PCL_RCV_INTX);
>> +}
> 
>> +
>> +static irqreturn_t uniphier_pcie_irq_handler(int irq, void *arg)
> 
> This should not be an IRQ handler (and we should not use
> devm_request_irq() for the multiplexed IRQ line), it is a chained
> interrupt controller configuration and should be managed by an IRQ
> chain, again the way keystone does it seems reasonable to me.
> 
>> +{
>> +	struct uniphier_pcie_priv *priv = arg;
>> +	struct dw_pcie *pci = &priv->pci;
>> +	u32 val;
>> +
>> +	/* INT for debug */
>> +	val = readl(priv->base + PCL_RCV_INT);
>> +
>> +	if (val & PCL_CFG_BW_MGT_STATUS)
>> +		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
>> +	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>> +		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
>> +	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>> +		dev_dbg(pci->dev, "Root Error\n");
>> +	if (val & PCL_CFG_PME_MSI_STATUS)
>> +		dev_dbg(pci->dev, "PME Interrupt\n");
>> +
>> +	writel(val, priv->base + PCL_RCV_INT);
>> +
>> +	/* INTx */
>> +	val = readl(priv->base + PCL_RCV_INTX);
>> +
>> +	if (val & PCL_RADM_INTA_STATUS)
>> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 0));
>> +	if (val & PCL_RADM_INTB_STATUS)
>> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 1));
>> +	if (val & PCL_RADM_INTC_STATUS)
>> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 2));
>> +	if (val & PCL_RADM_INTD_STATUS)
>> +		generic_handle_irq(irq_find_mapping(priv->irq_domain, 3));
> 
> Nit: Do you really need 4 if statements to handle INTX ?
> 
>> +
>> +	writel(val, priv->base + PCL_RCV_INTX);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static irqreturn_t uniphier_pcie_msi_irq_handler(int irq, void *arg)
>> +{
>> +	struct pcie_port *pp = arg;
>> +
>> +	return dw_handle_msi_irq(pp);
>> +}
> 
> This IRQ handler must be removed, the MSI irq is handled by dwc core.
> 
>> +static int uniphier_pcie_host_init(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	int ret;
>> +
>> +	dw_pcie_setup_rc(pp);
>> +	ret = uniphier_pcie_establish_link(pci);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		dw_pcie_msi_init(pp);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
>> +	.host_init = uniphier_pcie_host_init,
>> +};
>> +
>> +static int uniphier_add_pcie_port(struct uniphier_pcie_priv *priv,
>> +				  struct platform_device *pdev)
>> +{
>> +	struct dw_pcie *pci = &priv->pci;
>> +	struct pcie_port *pp = &pci->pp;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	pp->root_bus_nr = -1;
> 
> Useless initialization, remove it.
> 
> (ie dw_pcie_host_init() initializes root_bus_nr for you).
> 
>> +	pp->ops = &uniphier_pcie_host_ops;
>> +
>> +	pp->irq = platform_get_irq_byname(pdev, "intx");
>> +	if (pp->irq < 0) {
>> +		dev_err(dev, "Failed to get intx irq\n");
>> +		return pp->irq;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, pp->irq, uniphier_pcie_irq_handler,
>> +			       IRQF_SHARED, "pcie", priv);
> 
> This is wrong, you should set-up a chained IRQ for INTX.
> 
> I *think* that
> 
> ks_pcie_setup_interrupts()
> 
> is a good example to start with but I wonder whether it is worth
> generalizing the INTX approach to designware as a whole as it was
> done for MSIs.
> 
> Thoughts ?

From what I understood this is for legacy IRQ, right?
Like you (Lorenzo) said there is 2 drivers (pci-keystone-dw.c and pci-dra7xx.c)
that uses it and can be use as a template for handling this type of interrupts.

We can try to pass some kind of generic INTX function to the DesignWare host
library to handling this, but this will require some help from keystone and
dra7xx maintainers, since my setup doesn't have legacy IRQ HW support.

> 
>> +	if (ret) {
>> +		dev_err(dev, "Failed to request irq %d\n", pp->irq);
>> +		return ret;
>> +	}
>> +
>> +	ret = uniphier_pcie_init_irq_domain(pp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
>> +		if (pp->msi_irq < 0)
>> +			return pp->msi_irq;
>> +
>> +		ret = devm_request_irq(dev, pp->msi_irq,
>> +				       uniphier_pcie_msi_irq_handler,
>> +				       IRQF_SHARED, "pcie-msi", pp);
> 
> No. With MSI management in DWC core all you need to do is initializing
> pp->msi_irq.
> 
> Lorenzo
> 
>> +		if (ret) {
>> +			dev_err(dev, "failed to request msi_irq %d\n",
>> +				pp->msi_irq);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to initialize host (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int uniphier_pcie_host_enable(struct uniphier_pcie_priv *priv)
>> +{
>> +	int ret;
>> +
>> +	ret = clk_prepare_enable(priv->clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = reset_control_deassert(priv->rst);
>> +	if (ret)
>> +		goto out_clk_disable;
>> +
>> +	uniphier_pcie_init_rc(priv);
>> +
>> +	ret = phy_init(priv->phy);
>> +	if (ret)
>> +		goto out_rst_assert;
>> +
>> +	ret = uniphier_pcie_wait_rc(priv);
>> +	if (ret)
>> +		goto out_phy_exit;
>> +
>> +	uniphier_pcie_irq_enable(priv);
>> +
>> +	return 0;
>> +
>> +out_phy_exit:
>> +	phy_exit(priv->phy);
>> +out_rst_assert:
>> +	reset_control_assert(priv->rst);
>> +out_clk_disable:
>> +	clk_disable_unprepare(priv->clk);
>> +
>> +	return ret;
>> +}
>> +
>> +static void uniphier_pcie_host_disable(struct uniphier_pcie_priv *priv)
>> +{
>> +	uniphier_pcie_irq_disable(priv);
>> +	phy_exit(priv->phy);
>> +	reset_control_assert(priv->rst);
>> +	clk_disable_unprepare(priv->clk);
>> +}
>> +
>> +static const struct dw_pcie_ops dw_pcie_ops = {
>> +	.start_link = uniphier_pcie_establish_link,
>> +	.stop_link = uniphier_pcie_stop_link,
>> +	.link_up = uniphier_pcie_link_up,
>> +};
>> +
>> +static int uniphier_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct uniphier_pcie_priv *priv;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->pci.dev = dev;
>> +	priv->pci.ops = &dw_pcie_ops;
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>> +	priv->pci.dbi_base = devm_pci_remap_cfg_resource(dev, res);
>> +	if (IS_ERR(priv->pci.dbi_base))
>> +		return PTR_ERR(priv->pci.dbi_base);
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
>> +	priv->base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(priv->base))
>> +		return PTR_ERR(priv->base);
>> +
>> +	priv->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(priv->clk))
>> +		return PTR_ERR(priv->clk);
>> +
>> +	priv->rst = devm_reset_control_get_shared(dev, NULL);
>> +	if (IS_ERR(priv->rst))
>> +		return PTR_ERR(priv->rst);
>> +
>> +	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
>> +	if (IS_ERR(priv->phy))
>> +		return PTR_ERR(priv->phy);
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	ret = uniphier_pcie_host_enable(priv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return uniphier_add_pcie_port(priv, pdev);
>> +}
>> +
>> +static int uniphier_pcie_remove(struct platform_device *pdev)
>> +{
>> +	struct uniphier_pcie_priv *priv = platform_get_drvdata(pdev);
>> +
>> +	uniphier_pcie_host_disable(priv);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id uniphier_pcie_match[] = {
>> +	{ .compatible = "socionext,uniphier-pcie", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, uniphier_pcie_match);
>> +
>> +static struct platform_driver uniphier_pcie_driver = {
>> +	.probe  = uniphier_pcie_probe,
>> +	.remove = uniphier_pcie_remove,
>> +	.driver = {
>> +		.name = "uniphier-pcie",
>> +		.of_match_table = uniphier_pcie_match,
>> +	},
>> +};
>> +builtin_platform_driver(uniphier_pcie_driver);
>> +
>> +MODULE_AUTHOR("Kunihiko Hayashi <hayashi.kunihiko@socionext.com>");
>> +MODULE_DESCRIPTION("UniPhier PCIe host controller driver");
>> +MODULE_LICENSE("GPL v2");
>> -- 
>> 2.7.4
>>
> 

