Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754629AbeEWQRR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 May 2018 12:17:17 -0400
Date: Wed, 23 May 2018 17:17:11 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: rcar: Rename
 rcar_pcie_parse_request_of_pci_ranges()
Message-ID: <20180523161711.GA8113@e107981-ln.cambridge.arm.com>
References: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180521131123.2009-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 21, 2018 at 03:11:20PM +0200, Marek Vasut wrote:
> The function name is just too confusing, rename it, no functional change.
> Rename the function to rcar_pcie_alloc_and_parse_pci_resource_list() as
> it's matching failpath function is pci_free_resource_list() so the names
> align much better and the new name also describes what the function does
> much better.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/host/pcie-rcar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Can you rebase this series against my pci/rcar branch please ?

I will merge it then, thanks.

Lorenzo

> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index e403c5206b24..dbc80e457f95 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1051,7 +1051,7 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>  	{},
>  };
>  
> -static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
> +static int rcar_pcie_alloc_and_parse_pci_resource_list(struct rcar_pcie *pci)
>  {
>  	int err;
>  	struct device *dev = pci->dev;
> @@ -1108,7 +1108,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&pcie->resources);
>  
> -	err = rcar_pcie_parse_request_of_pci_ranges(pcie);
> +	err = rcar_pcie_alloc_and_parse_pci_resource_list(pcie);
>  	if (err)
>  		goto err_free_bridge;
>  
> -- 
> 2.16.2
> 
