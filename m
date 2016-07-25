Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33650 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbcGYRvK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 13:51:10 -0400
Date: Mon, 25 Jul 2016 12:51:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] pcie/dpc: Match any port type
Message-ID: <20160725175105.GF12484@localhost>
References: <1467821161-25458-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467821161-25458-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 06, 2016 at 10:06:00AM -0600, Keith Busch wrote:
> PCIe port type values are not flags, so OR'ing them is not
> correct. Previously the result was equivalent to PCIe downstream ports,
> so we were missing binding to DPC capable root ports. This patch changes
> the type to 'any' so we can bind to both port types. While this will
> cause the code to check upstream ports, the driver won't probe them
> since these are not DPC capable.
> 
> Reported-by: Alexander Antonov <alexanderx.v.antonov@intel.com>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied both to pci/dpc for v4.8, thanks!

> ---
>  drivers/pci/pcie/pcie-dpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
> index ab552f1..0b36525 100644
> --- a/drivers/pci/pcie/pcie-dpc.c
> +++ b/drivers/pci/pcie/pcie-dpc.c
> @@ -138,7 +138,7 @@ static void dpc_remove(struct pcie_device *dev)
>  
>  static struct pcie_port_service_driver dpcdriver = {
>  	.name		= "dpc",
> -	.port_type	= PCI_EXP_TYPE_ROOT_PORT | PCI_EXP_TYPE_DOWNSTREAM,
> +	.port_type	= PCIE_ANY_PORT,
>  	.service	= PCIE_PORT_SERVICE_DPC,
>  	.probe		= dpc_probe,
>  	.remove		= dpc_remove,
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
