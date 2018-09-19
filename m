Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42105 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeITCsF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 22:48:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id l9-v6so3266982pff.9
        for <linux-pci@vger.kernel.org>; Wed, 19 Sep 2018 14:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180919185341.31298-1-natechancellor@gmail.com>
In-Reply-To: <20180919185341.31298-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 19 Sep 2018 14:08:08 -0700
Message-ID: <CAKwvOdkeM3sj8M-LzTQd9M9-sM_K6n6FTz=TrNHd-3xPwg_VNw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: kirin: Fix section mismatch warning
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 19, 2018 at 11:55 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> WARNING: vmlinux.o(.text+0x4758cc): Section mismatch in reference from
> the function kirin_pcie_probe() to the function
> .init.text:kirin_add_pcie_port()
> The function kirin_pcie_probe() references
> the function __init kirin_add_pcie_port().
> This is often because kirin_pcie_probe lacks a __init
> annotation or the annotation of kirin_add_pcie_port is wrong.
>
> Add the __init annotation to both kirin_pcie_probe and
> kirin_pcie_add_msi then use builtin_platform_driver_probe
> instead of builtin_platform_driver + .probe to avoid a section
> mismatch warning with kirin_pcie_driver.
>
> Fixes: fc5165db245a ("PCI: kirin: Add HiSilicon Kirin SoC PCIe controller driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> Instead of removing the annotation on kirin_add_pcie_port, add it to
> kirin_pcie_add_msi and kirin_pcie_probe. To avoid a warning with this
> configuration, use builtin_platform_driver_probe.
>
>  drivers/pci/controller/dwc/pcie-kirin.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 5352e0c3be82..f64fed12de51 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -448,8 +448,8 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>         .host_init = kirin_pcie_host_init,
>  };
>
> -static int kirin_pcie_add_msi(struct dw_pcie *pci,
> -                               struct platform_device *pdev)
> +static int __init kirin_pcie_add_msi(struct dw_pcie *pci,
> +                                    struct platform_device *pdev)
>  {
>         int irq;
>
> @@ -481,7 +481,7 @@ static int __init kirin_add_pcie_port(struct dw_pcie *pci,
>         return dw_pcie_host_init(&pci->pp);
>  }
>
> -static int kirin_pcie_probe(struct platform_device *pdev)
> +static int __init kirin_pcie_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct kirin_pcie *kirin_pcie;
> @@ -533,11 +533,10 @@ static const struct of_device_id kirin_pcie_match[] = {
>  };
>
>  static struct platform_driver kirin_pcie_driver = {
> -       .probe                  = kirin_pcie_probe,
>         .driver                 = {
>                 .name                   = "kirin-pcie",
>                 .of_match_table = kirin_pcie_match,
>                 .suppress_bind_attrs = true,
>         },
>  };
> -builtin_platform_driver(kirin_pcie_driver);
> +builtin_platform_driver_probe(kirin_pcie_driver, kirin_pcie_probe);

It would be good to get additional review from someone who knows more
about driver callback lifecycles, but I think this is the correct fix.
Thanks Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
