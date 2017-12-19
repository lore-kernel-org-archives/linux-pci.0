Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35652 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdLSLj5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Dec 2017 06:39:57 -0500
Date: Tue, 19 Dec 2017 11:40:42 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar: Handle
 rcar_pcie_parse_request_of_pci_ranges() failures
Message-ID: <20171219114042.GB19911@red-moon>
References: <1512641720-4715-1-git-send-email-geert+renesas@glider.be>
 <1512641720-4715-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512641720-4715-3-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 07, 2017 at 11:15:20AM +0100, Geert Uytterhoeven wrote:
> rcar_pcie_parse_request_of_pci_ranges() can fail and return an error
> code, but this is not checked nor handled.
> 
> Fix this by adding the missing error handling.
> 
> Fixes: 5d2917d469faab72 ("PCI: rcar: Convert to DT resource parsing API")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/pci/host/pcie-rcar.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to pci/rcar for v4.16.

Thanks,
Lorenzo

> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 52ab3cb0a0bfe065..95ca4a1feba4b759 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1123,7 +1123,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&pcie->resources);
>  
> -	rcar_pcie_parse_request_of_pci_ranges(pcie);
> +	err = rcar_pcie_parse_request_of_pci_ranges(pcie);
> +	if (err)
> +		goto err_free_bridge;
>  
>  	err = rcar_pcie_get_resources(pcie);
>  	if (err < 0) {
> @@ -1178,6 +1180,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  
>  err_free_resource_list:
>  	pci_free_resource_list(&pcie->resources);
> +err_free_bridge:
>  	pci_free_host_bridge(bridge);
>  
>  	return err;
> -- 
> 2.7.4
> 
