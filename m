Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:49489 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932888AbaKMQpa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Nov 2014 11:45:30 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so797543pad.17
        for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2014 08:45:29 -0800 (PST)
Date: Thu, 13 Nov 2014 09:45:25 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-pci@vger.kernel.org, 'Mohit Kumar' <mohit.kumar@st.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>,
	'Pratyush Anand' <pratyush.anand@st.com>
Subject: Re: [PATCH V2] PCI: spear: Add spear13xx before
 add_pcie_port/pcie_init
Message-ID: <20141113164525.GC5064@google.com>
References: <001401cff95e$ec061f60$c4125e20$%han@samsung.com>
 <001601cff961$232f2570$698d7050$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001601cff961$232f2570$698d7050$%han@samsung.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 06, 2014 at 10:29:41AM +0900, Jingoo Han wrote:
> The add_pcie_port/pcie_init functions are SPEAr13xx-specific.
> Add spear13xx prefix to avoid collision in global name space.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied with Viresh's ack to pci/host-spear for v3.19, thanks!

> ---
> Change since v1:
> - Remove 'exynos' typo from the commit message.
> 
>  drivers/pci/host/pcie-spear13xx.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 85f594e..63f869f 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -269,7 +269,8 @@ static struct pcie_host_ops spear13xx_pcie_host_ops = {
>  	.host_init = spear13xx_pcie_host_init,
>  };
>  
> -static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
> +static int spear13xx_add_pcie_port(struct pcie_port *pp,
> +				   struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	int ret;
> @@ -352,7 +353,7 @@ static int __init spear13xx_pcie_probe(struct platform_device *pdev)
>  	if (of_property_read_bool(np, "st,pcie-is-gen1"))
>  		spear13xx_pcie->is_gen1 = true;
>  
> -	ret = add_pcie_port(pp, pdev);
> +	ret = spear13xx_add_pcie_port(pp, pdev);
>  	if (ret < 0)
>  		goto fail_clk;
>  
> @@ -382,11 +383,11 @@ static struct platform_driver spear13xx_pcie_driver __initdata = {
>  
>  /* SPEAr13xx PCIe driver does not allow module unload */
>  
> -static int __init pcie_init(void)
> +static int __init spear13xx_pcie_init(void)
>  {
>  	return platform_driver_register(&spear13xx_pcie_driver);
>  }
> -module_init(pcie_init);
> +module_init(spear13xx_pcie_init);
>  
>  MODULE_DESCRIPTION("ST Microelectronics SPEAr13xx PCIe host controller driver");
>  MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
> -- 
> 1.7.9.5
> 
> 
