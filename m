Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeC3Wrl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Mar 2018 18:47:41 -0400
Date: Fri, 30 Mar 2018 17:47:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: always define the of_node helpers
Message-ID: <20180330224738.GG9322@bhelgaas-glaptop.roam.corp.google.com>
References: <20180318125806.12364-1-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180318125806.12364-1-bjorn@mork.no>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 18, 2018 at 01:58:06PM +0100, Bjørn Mork wrote:
> Simply move these inline functions outside the ifdef instead of duplicating
> them as stubs in the !OF case.  The struct device of_node field does not
> depend on OF.
> 
> This also fixes the missing stubbed pci_bus_to_OF_node().
> 
> Signed-off-by: Bjørn Mork <bjorn@mork.no>

Applied to pci/misc for v4.17, thanks!

> ---
> I noticed this as a missing pci_bus_to_OF_node stub. But adding a
> stub which does pretty much the same as the real thing didn't make much
> sense to me.  Same goes for the existing pci_device_to_OF_node stub,
> which is why I replace that too.
> 
> 
>  include/linux/pci.h | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 024a1beda008..d0396da9160e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2182,24 +2182,11 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>  /* Arch may override this (weak) */
>  struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus);
>  
> -static inline struct device_node *
> -pci_device_to_OF_node(const struct pci_dev *pdev)
> -{
> -	return pdev ? pdev->dev.of_node : NULL;
> -}
> -
> -static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
> -{
> -	return bus ? bus->dev.of_node : NULL;
> -}
> -
>  #else	/* CONFIG_OF */
>  static inline void pci_set_of_node(struct pci_dev *dev) { }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
>  static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
> -static inline struct device_node *
> -pci_device_to_OF_node(const struct pci_dev *pdev) { return NULL; }
>  static inline struct irq_domain *
>  pci_host_bridge_of_msi_domain(struct pci_bus *bus) { return NULL; }
>  static inline int pci_parse_request_of_pci_ranges(struct device *dev,
> @@ -2210,6 +2197,17 @@ static inline int pci_parse_request_of_pci_ranges(struct device *dev,
>  }
>  #endif  /* CONFIG_OF */
>  
> +static inline struct device_node *
> +pci_device_to_OF_node(const struct pci_dev *pdev)
> +{
> +	return pdev ? pdev->dev.of_node : NULL;
> +}
> +
> +static inline struct device_node *pci_bus_to_OF_node(struct pci_bus *bus)
> +{
> +	return bus ? bus->dev.of_node : NULL;
> +}
> +
>  #ifdef CONFIG_ACPI
>  struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>  
> -- 
> 2.11.0
> 
