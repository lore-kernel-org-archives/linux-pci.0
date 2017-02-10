Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbdBJVqO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 16:46:14 -0500
Date: Fri, 10 Feb 2017 15:46:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Wenrui Li <wenrui.li@rock-chips.com>
Subject: Re: [PATCH] PCI: rockchip: fix error path to free resource
Message-ID: <20170210214611.GP29169@bhelgaas-glaptop.roam.corp.google.com>
References: <1486709522-160491-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486709522-160491-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 02:52:02PM +0800, Shawn Lin wrote:
> rockchip_pcie_probe calls of_pci_get_host_bridge_resources to
> parse resource from DT but it's caller's job to free it advised
> by this API. So let's fix the error patch to free it by calling
> pci_free_resource_list.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/host-rockchip for v4.11, thanks, Shawn!

> ---
> 
>  drivers/pci/host/pcie-rockchip.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> index ff43a7e..c0b3b65 100644
> --- a/drivers/pci/host/pcie-rockchip.c
> +++ b/drivers/pci/host/pcie-rockchip.c
> @@ -1343,7 +1343,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	err = devm_request_pci_bus_resources(dev, &res);
>  	if (err)
> -		goto err_vpcie;
> +		goto err_free_res;
>  
>  	/* Get the I/O and memory ranges from DT */
>  	resource_list_for_each_entry(win, &res) {
> @@ -1376,19 +1376,19 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	err = rockchip_cfg_atu(rockchip);
>  	if (err)
> -		goto err_vpcie;
> +		goto err_free_res;
>  
>  	rockchip->msg_region = devm_ioremap(rockchip->dev,
>  					    rockchip->msg_bus_addr, SZ_1M);
>  	if (!rockchip->msg_region) {
>  		err = -ENOMEM;
> -		goto err_vpcie;
> +		goto err_free_res;
>  	}
>  
>  	bus = pci_scan_root_bus(&pdev->dev, 0, &rockchip_pcie_ops, rockchip, &res);
>  	if (!bus) {
>  		err = -ENOMEM;
> -		goto err_vpcie;
> +		goto err_free_res;
>  	}
>  
>  	pci_bus_size_bridges(bus);
> @@ -1399,6 +1399,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	pci_bus_add_devices(bus);
>  	return err;
>  
> +err_free_res:
> +	pci_free_resource_list(&res);
>  err_vpcie:
>  	if (!IS_ERR(rockchip->vpcie3v3))
>  		regulator_disable(rockchip->vpcie3v3);
> -- 
> 1.9.1
> 
> 
