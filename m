Return-Path: <SRS0=JYfi=M4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088D9C04EBD
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BE82089E
	for <linux-pci@archiver.kernel.org>; Tue, 16 Oct 2018 17:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98BE82089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbeJQA6X (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:58:23 -0400
Received: from foss.arm.com ([217.140.101.70]:39904 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeJQA6X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 20:58:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7912E341;
        Tue, 16 Oct 2018 10:07:01 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (unknown [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DD7B3F71C;
        Tue, 16 Oct 2018 10:06:59 -0700 (PDT)
Date:   Tue, 16 Oct 2018 18:06:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/19] PCI: keystone: Cleanup PHY handling
Message-ID: <20181016170656.GD16390@e107981-ln.cambridge.arm.com>
References: <20181015130721.5535-1-kishon@ti.com>
 <20181015130721.5535-12-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015130721.5535-12-kishon@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 15, 2018 at 06:37:13PM +0530, Kishon Vijay Abraham I wrote:
> Cleanup PHY handling by using devm_phy_optional_get to get PHYs if
> the PHYs are optional, creating a device link between the PHY device
> and the controller device and disable PHY on error cases here.
> Also invoke phy_reset() as part of initializing PHY.

Hi Kishon,

it is a bit of nitpicking, I know it is annoying but when I read "Also"
in commit logs there is almost certainly a reason to split the patch
into logical standalone entities, this one looks like one.

Every patch must be a self-contained change that, in case we have to
revert it, must not affect other patches.

There are some more patches in the series that would benefit from
splitting so I kindly ask you to go through them and repost, we
should still be able to hit v4.20.

Thanks,
Lorenzo

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 126 +++++++++++++++++++---
>  1 file changed, 110 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index e22328f89c84..bf37609ad75b 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -105,6 +105,9 @@ struct keystone_pcie {
>  
>  	int			num_msi_host_irqs;
>  	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
> +	int			num_lanes;
> +	struct phy		**phy;
> +	struct device_link	**link;
>  	struct			device_node *msi_intc_np;
>  	struct irq_domain	*legacy_irq_domain;
>  	struct device_node	*np;
> @@ -880,22 +883,61 @@ static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
>  	.link_up = ks_pcie_link_up,
>  };
>  
> -static int __exit ks_pcie_remove(struct platform_device *pdev)
> +static void ks_pcie_disable_phy(struct keystone_pcie *ks_pcie)
>  {
> -	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> +	int num_lanes = ks_pcie->num_lanes;
>  
> -	clk_disable_unprepare(ks_pcie->clk);
> +	while (num_lanes--) {
> +		phy_power_off(ks_pcie->phy[num_lanes]);
> +		phy_exit(ks_pcie->phy[num_lanes]);
> +	}
> +}
> +
> +static int ks_pcie_enable_phy(struct keystone_pcie *ks_pcie)
> +{
> +	int i;
> +	int ret;
> +	int num_lanes = ks_pcie->num_lanes;
> +
> +	for (i = 0; i < num_lanes; i++) {
> +		ret = phy_reset(ks_pcie->phy[i]);
> +		if (ret < 0)
> +			goto err_phy;
> +
> +		ret = phy_init(ks_pcie->phy[i]);
> +		if (ret < 0)
> +			goto err_phy;
> +
> +		ret = phy_power_on(ks_pcie->phy[i]);
> +		if (ret < 0) {
> +			phy_exit(ks_pcie->phy[i]);
> +			goto err_phy;
> +		}
> +	}
>  
>  	return 0;
> +
> +err_phy:
> +	while (--i >= 0) {
> +		phy_power_off(ks_pcie->phy[i]);
> +		phy_exit(ks_pcie->phy[i]);
> +	}
> +
> +	return ret;
>  }
>  
>  static int __init ks_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct dw_pcie *pci;
>  	struct keystone_pcie *ks_pcie;
> -	struct phy *phy;
> +	struct device_link **link;
> +	struct phy **phy;
> +	u32 num_lanes;
> +	char name[10];
>  	int ret;
> +	int i;
>  
>  	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
>  	if (!ks_pcie)
> @@ -908,29 +950,59 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &ks_pcie_dw_pcie_ops;
>  
> -	ks_pcie->pci = pci;
> +	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
> +	if (ret)
> +		num_lanes = 1;
>  
> -	/* initialize SerDes Phy if present */
> -	phy = devm_phy_get(dev, "pcie-phy");
> -	if (PTR_ERR_OR_ZERO(phy) == -EPROBE_DEFER)
> -		return PTR_ERR(phy);
> +	phy = devm_kzalloc(dev, sizeof(*phy) * num_lanes, GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
>  
> -	if (!IS_ERR_OR_NULL(phy)) {
> -		ret = phy_init(phy);
> -		if (ret < 0)
> -			return ret;
> +	link = devm_kzalloc(dev, sizeof(*link) * num_lanes, GFP_KERNEL);
> +	if (!link)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_lanes; i++) {
> +		snprintf(name, sizeof(name), "pcie-phy%d", i);
> +		phy[i] = devm_phy_optional_get(dev, name);
> +		if (IS_ERR(phy[i])) {
> +			ret = PTR_ERR(phy[i]);
> +			goto err_link;
> +		}
> +
> +		if (!phy[i])
> +			continue;
> +
> +		link[i] = device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
> +		if (!link[i]) {
> +			ret = -EINVAL;
> +			goto err_link;
> +		}
> +	}
> +
> +	ks_pcie->np = np;
> +	ks_pcie->pci = pci;
> +	ks_pcie->link = link;
> +	ks_pcie->num_lanes = num_lanes;
> +	ks_pcie->phy = phy;
> +
> +	ret = ks_pcie_enable_phy(ks_pcie);
> +	if (ret) {
> +		dev_err(dev, "failed to enable phy\n");
> +		goto err_link;
>  	}
>  
> -	ks_pcie->np = dev->of_node;
>  	platform_set_drvdata(pdev, ks_pcie);
>  	ks_pcie->clk = devm_clk_get(dev, "pcie");
>  	if (IS_ERR(ks_pcie->clk)) {
>  		dev_err(dev, "Failed to get pcie rc clock\n");
> -		return PTR_ERR(ks_pcie->clk);
> +		ret = PTR_ERR(ks_pcie->clk);
> +		goto err_phy;
>  	}
> +
>  	ret = clk_prepare_enable(ks_pcie->clk);
>  	if (ret)
> -		return ret;
> +		goto err_phy;
>  
>  	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
>  	if (ret < 0)
> @@ -940,9 +1012,31 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  fail_clk:
>  	clk_disable_unprepare(ks_pcie->clk);
>  
> +err_phy:
> +	ks_pcie_disable_phy(ks_pcie);
> +
> +err_link:
> +	while (--i >= 0 && link[i])
> +		device_link_del(link[i]);
> +
>  	return ret;
>  }
>  
> +static int __exit ks_pcie_remove(struct platform_device *pdev)
> +{
> +	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
> +	struct device_link **link = ks_pcie->link;
> +	int num_lanes = ks_pcie->num_lanes;
> +
> +	clk_disable_unprepare(ks_pcie->clk);
> +	ks_pcie_disable_phy(ks_pcie);
> +
> +	while (num_lanes--)
> +		device_link_del(link[num_lanes]);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver ks_pcie_driver __refdata = {
>  	.probe  = ks_pcie_probe,
>  	.remove = __exit_p(ks_pcie_remove),
> -- 
> 2.17.1
> 
