Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbcLGUjJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 15:39:09 -0500
Date: Wed, 7 Dec 2016 14:32:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geliang Tang <geliangtang@gmail.com>
Cc: Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: altera: use builtin_platform_driver
Message-ID: <20161207203204.GD22129@bhelgaas-glaptop.roam.corp.google.com>
References: <b12dde3b7465f3bba35ab7a9226b464f30f27412.1479912709.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b12dde3b7465f3bba35ab7a9226b464f30f27412.1479912709.git.geliangtang@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 23, 2016 at 10:52:22PM +0800, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thanks, Geliang.  I already applied an identical patch from Wei Yongjun
that will appear in v4.10.

> ---
>  drivers/pci/host/pcie-altera.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index b0ac4df..eefcb38 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -641,8 +641,4 @@ static struct platform_driver altera_pcie_driver = {
>  	},
>  };
>  
> -static int altera_pcie_init(void)
> -{
> -	return platform_driver_register(&altera_pcie_driver);
> -}
> -device_initcall(altera_pcie_init);
> +builtin_platform_driver(altera_pcie_driver);
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
