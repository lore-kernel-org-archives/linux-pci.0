Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42082 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbdLWMXg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Dec 2017 07:23:36 -0500
MIME-Version: 1.0
In-Reply-To: <1514026724-32962-1-git-send-email-xieyisheng1@huawei.com>
References: <1514026724-32962-1-git-send-email-xieyisheng1@huawei.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Dec 2017 10:23:34 -0200
Message-ID: <CAOMZO5AyC5wMgowLfwdA7fc8UNV9YORjdS09aUhekk01KYge0g@mail.gmail.com>
Subject: Re: [PATCH v3 08/27] PCI: replace devm_ioremap_nocache with devm_ioremap
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ysxie@foxmail.com, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Dec 23, 2017 at 8:58 AM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> Default ioremap is ioremap_nocache, so devm_ioremap has the same
> function with devm_ioremap_nocache, which can just be killed to
> save the size of devres.o
>
> This patch is to use use devm_ioremap instead of devm_ioremap_nocache,
> which should not have any function change but prepare for killing
> devm_ioremap_nocache.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/dwc/pci-dra7xx.c b/drivers/pci/dwc/pci-dra7xx.c
> index e77a4cee..3f3712a 100644
> --- a/drivers/pci/dwc/pci-dra7xx.c
> +++ b/drivers/pci/dwc/pci-dra7xx.c
> @@ -637,7 +637,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>         }
>
>         res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
> -       base = devm_ioremap_nocache(dev, res->start, resource_size(res));
> +       base = devm_ioremap(dev, res->start, resource_size(res));

You could also consider using devm_ioremap_resource(), which checks
whether the resource is NULL and it is a bit shorter:

base = devm_ioremap_resource(dev, res);
if (IS_ERR(base))
   return PTR_ERR(base);


>
> --
> 1.8.3.1
>
