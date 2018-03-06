Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932243AbeCFAKH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 19:10:07 -0500
Date: Mon, 5 Mar 2018 18:10:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: Move declaration of of_irq_parse_and_map_pci
 under OF_IRQ
Message-ID: <20180306001004.GB33706@bhelgaas-glaptop.roam.corp.google.com>
References: <1520292150-15699-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520292150-15699-1-git-send-email-linux@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 05, 2018 at 03:22:30PM -0800, Guenter Roeck wrote:
> Since commit 4670d610d5923 ("PCI: Move OF-related PCI functions into
> PCI core"), sparc:allmodconfig fails to build with the following error.
> 
> pcie-cadence-host.c:(.text+0x4c4):
> 	undefined reference to `of_irq_parse_and_map_pci'
> pcie-cadence-host.c:(.text+0x4c8):
> 	undefined reference to `of_irq_parse_and_map_pci'
> 
> of_irq_parse_and_map_pci is now only available if OF_IRQ is enabled.
> Make its declaration and its dummy function dependent on OF_IRQ
> to solve the problem.
> 
> Fixes: 4670d610d5923 ("PCI: Move OF-related PCI functions into PCI core")
> Cc: Rob Herring <robh@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to for-linus for v4.16, thanks!

> ---
> v2: Added Rob's Ack
>     Sent to linux-pci mailing list per Rob's request
> 
>  include/linux/of_pci.h | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
> index 88865e0ebf4d..091033a6b836 100644
> --- a/include/linux/of_pci.h
> +++ b/include/linux/of_pci.h
> @@ -13,7 +13,6 @@ struct device_node;
>  struct device_node *of_pci_find_child_device(struct device_node *parent,
>  					     unsigned int devfn);
>  int of_pci_get_devfn(struct device_node *np);
> -int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
>  int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>  int of_get_pci_domain_nr(struct device_node *node);
>  int of_pci_get_max_link_speed(struct device_node *node);
> @@ -34,12 +33,6 @@ static inline int of_pci_get_devfn(struct device_node *np)
>  }
>  
>  static inline int
> -of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
> -{
> -	return 0;
> -}
> -
> -static inline int
>  of_pci_parse_bus_range(struct device_node *node, struct resource *res)
>  {
>  	return -EINVAL;
> @@ -67,6 +60,16 @@ of_pci_get_max_link_speed(struct device_node *node)
>  static inline void of_pci_check_probe_only(void) { }
>  #endif
>  
> +#if IS_ENABLED(CONFIG_OF_IRQ)
> +int of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin);
> +#else
> +static inline int
> +of_irq_parse_and_map_pci(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #if defined(CONFIG_OF_ADDRESS)
>  int of_pci_get_host_bridge_resources(struct device_node *dev,
>  			unsigned char busno, unsigned char bus_max,
> -- 
> 2.7.4
> 
