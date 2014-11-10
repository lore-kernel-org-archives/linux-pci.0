Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:52374 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaKJGiB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Nov 2014 01:38:01 -0500
Received: by mail-oi0-f50.google.com with SMTP id v63so4887888oia.23
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2014 22:38:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001601cff961$232f2570$698d7050$%han@samsung.com>
References: <001401cff95e$ec061f60$c4125e20$%han@samsung.com>
	<001601cff961$232f2570$698d7050$%han@samsung.com>
Date: Mon, 10 Nov 2014 12:08:00 +0530
Message-ID: <CAKohpom7pABuYxk8Us=MZQeB0pdnNxJW8_CgEBw4enHeYTp-ig@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: spear: Add spear13xx before add_pcie_port/pcie_init
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jingoo Han <jg1.han@samsung.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit Kumar <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 6 November 2014 06:59, Jingoo Han <jg1.han@samsung.com> wrote:
> The add_pcie_port/pcie_init functions are SPEAr13xx-specific.
> Add spear13xx prefix to avoid collision in global name space.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Change since v1:
> - Remove 'exynos' typo from the commit message.

Its better now, sorry for earlier reply.

>
>  drivers/pci/host/pcie-spear13xx.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 85f594e..63f869f 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -269,7 +269,8 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
>         .host_init = spear13xx_pcie_host_init,
>  };
>
> -static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
> +static int spear13xx_add_pcie_port(struct pcie_port *pp,
> +                                  struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         int ret;
> @@ -352,7 +353,7 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
>         if (of_property_read_bool(np, "st,pcie-is-gen1"))
>                 spear13xx_pcie->is_gen1 = true;
>
> -       ret = add_pcie_port(pp, pdev);
> +       ret = spear13xx_add_pcie_port(pp, pdev);
>         if (ret < 0)
>                 goto fail_clk;
>
> @@ -382,11 +383,11 @@ static struct platform_driver spear13xx_pcie_driver __initdata = {
>
>  /* SPEAr13xx PCIe driver does not allow module unload */
>
> -static int __init pcie_init(void)
> +static int __init spear13xx_pcie_init(void)
>  {
>         return platform_driver_register(&spear13xx_pcie_driver);
>  }
> -module_init(pcie_init);
> +module_init(spear13xx_pcie_init);
>
>  MODULE_DESCRIPTION("ST Microelectronics SPEAr13xx PCIe host controller driver");
>  MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
