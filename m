Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752364AbcLGUgL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 15:36:11 -0500
Date: Wed, 7 Dec 2016 14:36:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geliang Tang <geliangtang@gmail.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: spear: use builtin_platform_driver
Message-ID: <20161207203606.GE22129@bhelgaas-glaptop.roam.corp.google.com>
References: <fad445bc8162cd07a298b25a18614773c86ec227.1479912870.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fad445bc8162cd07a298b25a18614773c86ec227.1479912870.git.geliangtang@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 10:55:07PM +0800, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Applied to pci/host-spear for v4.10, thanks!

> ---
>  drivers/pci/host/pcie-spear13xx.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 3cf197b..dafe8b8 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -296,8 +296,4 @@ static struct platform_driver spear13xx_pcie_driver = {
>  	},
>  };
>  
> -static int __init spear13xx_pcie_init(void)
> -{
> -	return platform_driver_register(&spear13xx_pcie_driver);
> -}
> -device_initcall(spear13xx_pcie_init);
> +builtin_platform_driver(spear13xx_pcie_driver);
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
