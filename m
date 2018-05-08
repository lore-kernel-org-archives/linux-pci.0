Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56670 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752777AbeEHLXW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 May 2018 07:23:22 -0400
Date: Tue, 8 May 2018 12:23:15 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Reuse generic
 pci_parse_request_of_pci_ranges() function
Message-ID: <20180508112315.GA9920@e107981-ln.cambridge.arm.com>
References: <1524669685-8265-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524669685-8265-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2018 at 06:21:25PM +0300, Vladimir Zapolskiy wrote:
> The non-functional change removes a custom function to parse and
> allocate PCI resources in favour of pci_parse_request_of_pci_ranges().
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/pci/host/pcie-rcar.c | 42 +-----------------------------------------
>  1 file changed, 1 insertion(+), 41 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
> index 6ab28f29ac6a..66863b587380 100644
> --- a/drivers/pci/host/pcie-rcar.c
> +++ b/drivers/pci/host/pcie-rcar.c
> @@ -1063,44 +1063,6 @@ static const struct of_device_id rcar_pcie_of_match[] = {
>  	{},
>  };

Applied to pci/rcar for v4.18, thanks.

Lorenzo

> -static int rcar_pcie_parse_request_of_pci_ranges(struct rcar_pcie *pci)
> -{
> -	int err;
> -	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
> -	resource_size_t iobase;
> -	struct resource_entry *win, *tmp;
> -
> -	err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources,
> -					       &iobase);
> -	if (err)
> -		return err;
> -
> -	err = devm_request_pci_bus_resources(dev, &pci->resources);
> -	if (err)
> -		goto out_release_res;
> -
> -	resource_list_for_each_entry_safe(win, tmp, &pci->resources) {
> -		struct resource *res = win->res;
> -
> -		if (resource_type(res) == IORESOURCE_IO) {
> -			err = pci_remap_iospace(res, iobase);
> -			if (err) {
> -				dev_warn(dev, "error %d: failed to map resource %pR\n",
> -					 err, res);
> -
> -				resource_list_destroy_entry(win);
> -			}
> -		}
> -	}
> -
> -	return 0;
> -
> -out_release_res:
> -	pci_free_resource_list(&pci->resources);
> -	return err;
> -}
> -
>  static int rcar_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1118,9 +1080,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->dev = dev;
>  
> -	INIT_LIST_HEAD(&pcie->resources);
> -
> -	err = rcar_pcie_parse_request_of_pci_ranges(pcie);
> +	err = pci_parse_request_of_pci_ranges(dev, &pcie->resources, NULL);
>  	if (err)
>  		goto err_free_bridge;
>  
> -- 
> 2.8.1
> 
