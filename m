Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Message-ID: <1527732336.9842.3.camel@mtkswgap22>
Subject: Re: [PATCH] PCI: mediatek: Add system pm support for MT2712
From: Ryder Lee <ryder.lee@mediatek.com>
To: <honghui.zhang@mediatek.com>
Date: Thu, 31 May 2018 10:05:36 +0800
In-Reply-To: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, lorenzo.pieralisi@arm.com, marc.zyngier@arm.com,
 linux-pci@vger.kernel.org, sean.wang@mediatek.com, xinping.qian@mediatek.com,
 linux-kernel@vger.kernel.org, yt.shen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, yong.wu@mediatek.com, bhelgaas@google.com,
 yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2018-05-30 at 10:35 +0800, honghui.zhang@mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> The MTCMOS of PCIe Host for MT2712 will be off when system suspend, and all
> the internel control register will be reset after system resume. The PCIe
> link should be re-established and the related control register values should
> be re-set after system resume.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> CC: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/host/pcie-mediatek.c | 82 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
> index dabf1086..60f98d92 100644
> --- a/drivers/pci/host/pcie-mediatek.c
> +++ b/drivers/pci/host/pcie-mediatek.c
> @@ -132,12 +132,14 @@ struct mtk_pcie_port;
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
> @@ -1179,12 +1181,91 @@ static int mtk_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct mtk_pcie *pcie;
> +	struct mtk_pcie_port *port;
> +	const struct mtk_pcie_soc *soc;
> +
> +	pdev = to_platform_device(dev);
> +	pcie = platform_get_drvdata(pdev);

How about this -
struct mtk_pcie *pcie = dev_get_drvdata(dev);

> +	soc = pcie->soc;
> +	if (!soc->pm_support)
> +		return 0;
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		clk_disable_unprepare(port->ahb_ck);
> +		clk_disable_unprepare(port->sys_ck);
> +		phy_power_off(port->phy);
> +	}
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> +{
> +	struct platform_device *pdev;
> +	struct mtk_pcie *pcie;
> +	struct mtk_pcie_port *port;
> +	const struct mtk_pcie_soc *soc;
> +	int ret;
> +
> +	pdev = to_platform_device(dev);
> +	pcie = platform_get_drvdata(pdev);

struct mtk_pcie *pcie = dev_get_drvdata(dev);

> +	soc = pcie->soc;
> +	if (!soc->pm_support)
> +		return 0;
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		ret = phy_power_on(port->phy);
> +		if (ret) {
> +			dev_err(dev, "could not power on phy\n");
> +			return ret;
> +		}
> +		ret = clk_prepare_enable(port->sys_ck);
> +		if (ret) {
> +			dev_err(dev, "enable sys clock error\n");
> +			phy_power_off(port->phy);
> +			return ret;
> +		}
> +
> +		ret = clk_prepare_enable(port->ahb_ck);
> +		if (ret) {
> +			dev_err(dev, "enable ahb clock error\n");
> +			phy_power_off(port->phy);
> +			clk_disable_unprepare(port->sys_ck);
> +			return ret;
> +		}
> +
> +		ret = soc->startup(port);
> +		if (ret) {
> +			dev_err(dev, "pcie linkup failed\n");
> +			phy_power_off(port->phy);
> +			clk_disable_unprepare(port->sys_ck);
> +			clk_disable_unprepare(port->ahb_ck);
> +			return ret;
> +		}
> +
> +		if (IS_ENABLED(CONFIG_PCI_MSI))
> +			mtk_pcie_enable_msi(port);
> +	}
> +
> +	return 0;
> +}
> +




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
