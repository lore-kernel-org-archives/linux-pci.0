Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39572 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754497AbdFWJmN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2017 05:42:13 -0400
Date: Fri, 23 Jun 2017 11:41:41 +0200
From: Simon Horman <horms@verge.net.au>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen2: make of_device_ids const
Message-ID: <20170623094141.GB24191@verge.net.au>
References: <99e5ddc3b23962b22740dc93113d178f6f98df2f.1498210098.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <99e5ddc3b23962b22740dc93113d178f6f98df2f.1498210098.git.arvind.yadav.cs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 23, 2017 at 02:59:52PM +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>


> ---
>  drivers/pci/host/pci-rcar-gen2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
> index 8534859..6f87968 100644
> --- a/drivers/pci/host/pci-rcar-gen2.c
> +++ b/drivers/pci/host/pci-rcar-gen2.c
> @@ -429,7 +429,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct of_device_id rcar_pci_of_match[] = {
> +static const struct of_device_id rcar_pci_of_match[] = {
>  	{ .compatible = "renesas,pci-r8a7790", },
>  	{ .compatible = "renesas,pci-r8a7791", },
>  	{ .compatible = "renesas,pci-r8a7794", },
> -- 
> 1.9.1
> 
