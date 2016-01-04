Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:37230 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbcADUW5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jan 2016 15:22:57 -0500
Date: Tue, 5 Jan 2016 07:22:54 +1100
From: Simon Horman <horms@verge.net.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: provide of_pci_get_host_bridge_resources helper
Message-ID: <20160104202253.GA12748@verge.net.au>
References: <8759253.sZisGJ6Km3@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8759253.sZisGJ6Km3@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 18, 2015 at 04:02:41PM +0100, Arnd Bergmann wrote:
> The pcie-rcar driver can be built for any ARM platform (for COMPILE_TEST)
> including those without CONFIG_OF enabled, and that results in a compile-time
> error:
> 
> drivers/pci/host/pcie-rcar.c: In function 'rcar_pcie_parse_request_of_pci_ranges':
> drivers/pci/host/pcie-rcar.c:939:8: error: implicit declaration of function 'of_pci_get_host_bridge_resources' [-Werror=implicit-function-declaration]
>   err = of_pci_get_host_bridge_resources(np, 0, 0xff, &pci->resources, &iobase);
> 
> In order to allow compile-testing on all platforms, this adds a
> of_pci_get_host_bridge_resources() helper stub function that gets
> used when CONFIG_OF_ADDRESS is disabled. This mirrors what we do for
> other OF-specific functions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5d2917d469fa ("PCI: rcar: Convert to DT resource parsing API")

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 2c51ee78b1c0..874d68f50a40 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -59,6 +59,14 @@ static inline void of_pci_check_probe_only(void) { }
>  int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			unsigned char busno, unsigned char bus_max,
>  			struct list_head *resources, resource_size_t *io_base);
> +#else
> +static inline
> +int of_pci_get_host_bridge_resources(struct device_node *dev,
> +			unsigned char busno, unsigned char bus_max,
> +			struct list_head *resources, resource_size_t *io_base)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  #if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
> 
