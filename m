Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751231AbeEQRq0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 May 2018 13:46:26 -0400
Date: Thu, 17 May 2018 18:46:19 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: wangbinghui@hisilicon.com, bhelgaas@google.com, xuwei5@huawei.com,
        robh+dt@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitrysh@google.com,
        andy.shevchenko@gmail.com, guodong.xu@linaro.org,
        suzhuangluan@hisilicon.com, kongfei@hisilicon.com,
        chenyao11@huawei.com
Subject: Re: [PATCH v4] PCI: kirin: Add MSI support
Message-ID: <20180517174619.GA4056@e107981-ln.cambridge.arm.com>
References: <20180516012159.44081-1-songxiaowei@hisilicon.com>
 <20180516012159.44081-2-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180516012159.44081-2-songxiaowei@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 16, 2018 at 09:21:59AM +0800, Xiaowei Song wrote:
> From: Yao Chen <chenyao11@huawei.com>
> 
> Add support for MSI.
> 
> Signed-off-by: Yao Chen <chenyao11@huawei.com>
> Cc: Xiaowei Song <songxiaowei@hisilicon.com>
> ---
>  drivers/pci/dwc/pcie-kirin.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index d2970a0..00ca4e5 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -426,9 +426,28 @@ static int kirin_pcie_establish_link(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static irqreturn_t kirin_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct pcie_port *pp = arg;
> +
> +	return dw_handle_msi_irq(pp);
> +}

You do not need an IRQ handler, the IRQ is handled already in the
dwc driver following Gustavo's rework.

https://patchwork.ozlabs.org/patch/882017/

> +static void kirin_pcie_msi_init(struct pcie_port *pp)
> +{
> +	dw_pcie_msi_init(pp);
> +}
> +
> +static void kirin_pcie_enable_interrupts(struct pcie_port *pp)
> +{
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		kirin_pcie_msi_init(pp);
> +}

Why do you need two functons ?

> +
>  static int kirin_pcie_host_init(struct pcie_port *pp)
>  {
>  	kirin_pcie_establish_link(pp);
> +	kirin_pcie_enable_interrupts(pp);
>  
>  	return 0;
>  }
> @@ -445,9 +464,41 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>  	.host_init = kirin_pcie_host_init,
>  };
>  
> +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> +				struct platform_device *pdev)
> +{
> +	int ret = 0;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		ret = platform_get_irq(pdev, 0);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "failed to get MSI IRQ (%d)\n",
> +				pci->pp.msi_irq);
> +			return ret;
> +		}
> +
> +		pci->pp.msi_irq = ret;
> +
> +		ret = devm_request_irq(&pdev->dev, pci->pp.msi_irq,
> +					   kirin_pcie_msi_irq_handler,
> +					   IRQF_SHARED | IRQF_NO_THREAD,
> +					   "kirin_pcie_msi", &pci->pp);
> +		if (ret)
> +			dev_err(&pdev->dev, "failed to request MSI IRQ %d\n",
> +				pci->pp.msi_irq);

This is wrong. If msi_irq is set, the dwc driver will handle the MSI and
you must not request the IRQ in the platform driver, see above for
the link to Gustavo's work.

Lorenzo

> +	}
> +	return ret;
> +}
> +
>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>  				      struct platform_device *pdev)
>  {
> +	int ret;
> +
> +	ret = kirin_pcie_add_msi(pci, pdev);
> +	if (ret)
> +		return ret;
> +
>  	pci->pp.ops = &kirin_pcie_host_ops;
>  
>  	return dw_pcie_host_init(&pci->pp);
> -- 
> 2.7.3
> 
