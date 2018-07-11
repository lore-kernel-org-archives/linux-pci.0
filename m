Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38304 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeGKJdr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2018 05:33:47 -0400
MIME-Version: 1.0
In-Reply-To: <20180711080946.14942-2-songxiaowei@hisilicon.com>
References: <20180711080946.14942-1-songxiaowei@hisilicon.com> <20180711080946.14942-2-songxiaowei@hisilicon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Jul 2018 12:30:21 +0300
Message-ID: <CAHp75VccZtHqpoeWhVa=D=tc_Dj5cX8SXg=vYowWJ_RAiKdiCQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] PCI: kirin: Add MSI support
To: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Wangbinghui <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Yao Chen <chenyao11@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 11, 2018 at 11:09 AM, Xiaowei Song
<songxiaowei@hisilicon.com> wrote:
> Add support for MSI
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Yao Chen <chenyao11@huawei.com>
> ---
>  drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/pci/dwc/pcie-kirin.c b/drivers/pci/dwc/pcie-kirin.c
> index d2970a009eb5..5352e0c3be82 100644
> --- a/drivers/pci/dwc/pcie-kirin.c
> +++ b/drivers/pci/dwc/pcie-kirin.c
> @@ -430,6 +430,9 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>  {
>         kirin_pcie_establish_link(pp);
>
> +       if (IS_ENABLED(CONFIG_PCI_MSI))
> +               dw_pcie_msi_init(pp);
> +
>         return 0;
>  }
>
> @@ -445,9 +448,34 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>         .host_init = kirin_pcie_host_init,
>  };
>
> +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> +                               struct platform_device *pdev)
> +{
> +       int irq;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               irq = platform_get_irq(pdev, 0);
> +               if (irq < 0) {
> +                       dev_err(&pdev->dev,
> +                               "failed to get MSI IRQ (%d)\n", irq);
> +                       return irq;
> +               }
> +
> +               pci->pp.msi_irq = irq;
> +       }
> +
> +       return 0;
> +}
> +
>  static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>                                       struct platform_device *pdev)
>  {
> +       int ret;
> +
> +       ret = kirin_pcie_add_msi(pci, pdev);
> +       if (ret)
> +               return ret;
> +
>         pci->pp.ops = &kirin_pcie_host_ops;
>
>         return dw_pcie_host_init(&pci->pp);
> --
> 2.11.GIT
>



-- 
With Best Regards,
Andy Shevchenko
