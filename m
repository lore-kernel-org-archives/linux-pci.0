Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43772 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeGKH0V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2018 03:26:21 -0400
MIME-Version: 1.0
In-Reply-To: <20180711065724.128299-2-songxiaowei@hisilicon.com>
References: <20180711065724.128299-1-songxiaowei@hisilicon.com> <20180711065724.128299-2-songxiaowei@hisilicon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 11 Jul 2018 10:23:28 +0300
Message-ID: <CAHp75VfqGC5KNi4mCc3Q0bD0jXb4bkkdYFSv3LDQw5E=goc2Pg@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] PCI: kirin: Add MSI support
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

On Wed, Jul 11, 2018 at 9:57 AM, Xiaowei Song <songxiaowei@hisilicon.com> wrote:
> Add support for MSI

> +static int kirin_pcie_add_msi(struct dw_pcie *pci,
> +                               struct platform_device *pdev)
> +{
> +       int ret = 0;
> +
> +       if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +               ret = platform_get_irq(pdev, 0);
> +               if (ret < 0) {
> +                       dev_err(&pdev->dev,
> +                               "failed to get MSI IRQ (%d)\n", ret);
> +                       return ret;
> +               }
> +
> +               pci->pp.msi_irq = ret;
> +       }
> +
> +       return ret;
> +}

Like someone already noticed, is it really IRQ number you would like to return?

If you rewrite like

int irq;

if (IS_ENABLED(...)) {
 irq = ...
 if (irq < 0)
   return irq;

... = irq;

}

return 0;

It would be slightly more explicit what you do and what you return.

-- 
With Best Regards,
Andy Shevchenko
