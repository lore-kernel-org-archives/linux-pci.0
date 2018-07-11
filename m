Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33966 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbeGKLfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Jul 2018 07:35:24 -0400
Date: Wed, 11 Jul 2018 12:33:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: wangbinghui@hisilicon.com, bhelgaas@google.com, robh+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        suzhuangluan@hisilicon.com, andy.shevchenko@gmail.com,
        kongfei@hisilicon.com, chenyao11@huawei.com
Subject: Re: [PATCH v7 1/1] PCI: kirin: Add MSI support
Message-ID: <20180711113323.GA17546@red-moon>
References: <20180711080946.14942-1-songxiaowei@hisilicon.com>
 <20180711080946.14942-2-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711080946.14942-2-songxiaowei@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2018 at 04:09:46PM +0800, Xiaowei Song wrote:
> Add support for MSI
> 
> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Yao Chen <chenyao11@huawei.com>
> ---
>  drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Applied to pci/dwc for v4.19, thanks.

Lorenzo

> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index d2970a009eb5..5352e0c3be82 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -430,6 +430,9 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  {
>  	kirin_pcie_establish_link(pp);
>  
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		dw_pcie_msi_init(pp);
> +
>  	return 0;
>  }
>  
> @@ -445,9 +448,34 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>  	.host_init = kirin_pcie_host_init,
>  };
>  
> +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> +				struct platform_device *pdev)
> +{
> +	int irq;
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev,
> +				"failed to get MSI IRQ (%d)\n", irq);
> +			return irq;
> +		}
> +
> +		pci->pp.msi_irq = irq;
> +	}
> +
> +	return 0;
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
> 2.11.GIT
> 
