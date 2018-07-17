Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbeGQRrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Jul 2018 13:47:24 -0400
Date: Tue, 17 Jul 2018 18:15:43 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: honghui.zhang@mediatek.com
Cc: marc.zyngier@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com,
        yt.shen@mediatek.com, sean.wang@mediatek.com, rjw@rjwysocki.net,
        khilman@kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH v3 3/4] PCI: mediatek: Add system pm support for MT2712
 and MT7622
Message-ID: <20180717171543.GA20991@red-moon>
References: <1530518264-6125-1-git-send-email-honghui.zhang@mediatek.com>
 <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530518264-6125-4-git-send-email-honghui.zhang@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+Rafael, Kevin, Ulf]

On Mon, Jul 02, 2018 at 03:57:43PM +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The MTCMOS of PCIe Host for MT2712 and MT7622 will be off when system
> suspend, and all the internal control register will be reset after system
> resume. The PCIe link should be re-established and the related control
> register values should be re-set after system resume.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 67 ++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 86918d4..175d7b6 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -134,12 +134,14 @@ struct mtk_pcie_port;
>  /**
>   * struct mtk_pcie_soc - differentiate between host generations
>   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> + * @pm_support: whether the host's MTCMOS will be off when suspend
>   * @ops: pointer to configuration access functions
>   * @startup: pointer to controller setting functions
>   * @setup_irq: pointer to initialize IRQ functions
>   */
>  struct mtk_pcie_soc {
>  	bool need_fix_class_id;
> +	bool pm_support;
>  	struct pci_ops *ops;
>  	int (*startup)(struct mtk_pcie_port *port);
>  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> @@ -1197,12 +1199,75 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> +	const struct mtk_pcie_soc *soc = pcie->soc;
> +	struct mtk_pcie_port *port;
> +
> +	if (!soc->pm_support)
> +		return 0;
> +
> +	if (list_empty(&pcie->ports))
> +		return 0;
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		clk_disable_unprepare(port->pipe_ck);
> +		clk_disable_unprepare(port->obff_ck);
> +		clk_disable_unprepare(port->axi_ck);
> +		clk_disable_unprepare(port->aux_ck);
> +		clk_disable_unprepare(port->ahb_ck);
> +		clk_disable_unprepare(port->sys_ck);
> +		phy_power_off(port->phy);
> +		phy_exit(port->phy);
> +	}
> +
> +	mtk_pcie_subsys_powerdown(pcie);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> +{
> +	struct mtk_pcie *pcie = dev_get_drvdata(dev);
> +	const struct mtk_pcie_soc *soc = pcie->soc;
> +	struct mtk_pcie_port *port, *tmp;
> +
> +	if (!soc->pm_support)
> +		return 0;
> +
> +	if (list_empty(&pcie->ports))
> +		return 0;
> +
> +	if (dev->pm_domain) {
> +		pm_runtime_enable(dev);
> +		pm_runtime_get_sync(dev);
> +	}

Are these runtime PM calls needed/abused here ?

Mind explaining the logic ?

There is certainly an asymmetry with the suspend callback which made me
suspicious, I am pretty certain Rafael/Kevin/Ulf can help me clarify so
that we can make progress with this patch.

Lorenzo

> +
> +	clk_prepare_enable(pcie->free_ck);
> +
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		mtk_pcie_enable_port(port);
> +
> +	/* In case of EP was removed while system suspend. */
> +	if (list_empty(&pcie->ports))
> +		mtk_pcie_subsys_powerdown(pcie);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> +				      mtk_pcie_resume_noirq)
> +};
> +
>  static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
>  	.ops = &mtk_pcie_ops,
>  	.startup = mtk_pcie_startup_port,
>  };
>  
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
> +	.pm_support = true,
>  	.ops = &mtk_pcie_ops_v2,
>  	.startup = mtk_pcie_startup_port_v2,
>  	.setup_irq = mtk_pcie_setup_irq,
> @@ -1210,6 +1275,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt2712 = {
>  
>  static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
>  	.need_fix_class_id = true,
> +	.pm_support = true,
>  	.ops = &mtk_pcie_ops_v2,
>  	.startup = mtk_pcie_startup_port_v2,
>  	.setup_irq = mtk_pcie_setup_irq,
> @@ -1229,6 +1295,7 @@ static struct platform_driver mtk_pcie_driver = {
>  		.name = "mtk-pcie",
>  		.of_match_table = mtk_pcie_ids,
>  		.suppress_bind_attrs = true,
> +		.pm = &mtk_pcie_pm_ops,
>  	},
>  };
>  builtin_platform_driver(mtk_pcie_driver);
> -- 
> 2.6.4
> 
