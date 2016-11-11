Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965175AbcKKVVn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 16:21:43 -0500
Date: Fri, 11 Nov 2016 15:21:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        rfi@lists.rocketboards.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: altera: Use builtin_platform_driver to
 simplify the code
Message-ID: <20161111212121.GG9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1473510661-25029-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473510661-25029-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 10, 2016 at 12:31:01PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Use the builtin_platform_driver() macro to make the code simpler.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to pci/host-altera for v4.10, thanks!

> ---
>  drivers/pci/host/pcie-altera.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
> index 48f2736..ea33e8f 100644
> --- a/drivers/pci/host/pcie-altera.c
> +++ b/drivers/pci/host/pcie-altera.c
> @@ -581,8 +581,4 @@ static struct platform_driver altera_pcie_driver = {
>  	},
>  };
>  
> -static int altera_pcie_init(void)
> -{
> -	return platform_driver_register(&altera_pcie_driver);
> -}
> -device_initcall(altera_pcie_init);
> +builtin_platform_driver(altera_pcie_driver);
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
