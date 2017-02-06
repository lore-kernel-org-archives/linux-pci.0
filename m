Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbdBFWkq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Feb 2017 17:40:46 -0500
Date: Mon, 6 Feb 2017 16:40:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dongdong Liu <liudongdong3@huawei.com>
Cc: linux-pci@vger.kernel.org, wangzhou1@hisilicon.com,
        gabriele.paoloni@huawei.com, charles.chenxin@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH V3] PCI:hisi: Add DT almost ECAM support for HiSilicon
 Hip06/Hip07 host controllers
Message-ID: <20170206224041.GB27899@bhelgaas-glaptop.roam.corp.google.com>
References: <1486362304-56261-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486362304-56261-1-git-send-email-liudongdong3@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 06, 2017 at 02:25:04PM +0800, Dongdong Liu wrote:
> The PCIe controller in Hip06/Hip07 SoCs is not completely
> ECAM-compliant. It is non-ECAM only for the RC bus config space; for
> any other bus underneath the root bus it does support ECAM access.
> This is to add the almost ECAM support in DT way.
> 
> Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
> Reviewed-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>

Applied to pci/host-hisi for v4.11, thanks!

> -#if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
> +#if defined(CONFIG_PCI_HISI) || (defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS))
>  
>  static int hisi_pcie_acpi_rd_conf(struct pci_bus *bus, u32 devfn, int where,
>  				  int size, u32 *val)

These "_acpi_" accessors are now used for both the ACPI and the DT
model, and the accessors aren't ACPI-specific anyway.  So these are
slight misnomers.

> +static int hisi_pcie_platform_init(struct pci_config_window *cfg)
> +{
> +	struct device *dev = cfg->parent;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +	void __iomem *reg_base;
> +
> +	if (!dev->of_node)
> +		return -EINVAL;

What's the point of testing dev->of_node here?  There's no obvious
dependency on of_node in this code.  Could we just drop this test?

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(dev, "missing \"reg[1]\"property\n");
> +		return -EINVAL;
> +	}
> +
> +	reg_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!reg_base)
> +		return -ENOMEM;
> +
> +	cfg->priv = reg_base;
> +	return 0;
> +}
