Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763811AbcINWQ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Sep 2016 18:16:59 -0400
Date: Wed, 14 Sep 2016 17:16:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
        Aaron Durbin <adurbin@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Add pci_find_resource()
Message-ID: <20160914221654.GG16581@localhost>
References: <CAJZ5v0gRm++9zcAtXc1jYKsrg=tw2K3Wd=kQRS=RbRxXRDj8yA@mail.gmail.com>
 <20160913121942.80356-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160913121942.80356-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 03:19:41PM +0300, Mika Westerberg wrote:
> Add a new helper function pci_find_resource() that can be used to find out
> whether a given resource (for example from a child device) is contained
> within given PCI device's standard resources.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I think the ACPI part of this series is more interesting than the PCI
part, so I propose that Rafael merge the series if he likes it.

> ---
>  drivers/pci/pci.c   | 27 +++++++++++++++++++++++++++
>  include/linux/pci.h |  4 ++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aab9d5115a5f..491f879f34cb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -480,6 +480,33 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>  EXPORT_SYMBOL(pci_find_parent_resource);
>  
>  /**
> + * pci_find_resource - Return matching PCI device resource
> + * @dev: PCI device to query
> + * @res: Resource to look for
> + *
> + * Goes over standard PCI resources (BARs) and checks if the given resource
> + * is partially or fully contained in any of them. In that case the
> + * matching resource is returned, %NULL otherwise.
> + */
> +struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
> +{
> +	int i;
> +
> +	if (!res)
> +		return NULL;

I agree that this test for !res is unnecessary.

> +
> +	for (i = 0; i < PCI_ROM_RESOURCE; i++) {
> +		struct resource *r = &dev->resource[i];
> +
> +		if (r->start && resource_contains(r, res))
> +			return r;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(pci_find_resource);
> +
> +/**
>   * pci_find_pcie_root_port - return PCIe Root Port
>   * @dev: PCI device to query
>   *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ab835965669..a917d4b20554 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1126,6 +1126,7 @@ void pdev_enable_device(struct pci_dev *);
>  int pci_enable_resources(struct pci_dev *, int mask);
>  void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
>  		    int (*)(const struct pci_dev *, u8, u8));
> +struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res);
>  #define HAVE_PCI_REQ_REGIONS	2
>  int __must_check pci_request_regions(struct pci_dev *, const char *);
>  int __must_check pci_request_regions_exclusive(struct pci_dev *, const char *);
> @@ -1542,6 +1543,9 @@ static inline int pci_enable_wake(struct pci_dev *dev, pci_power_t state,
>  				  int enable)
>  { return 0; }
>  
> +static inline struct resource *pci_find_resource(struct pci_dev *dev,
> +						 struct resource *res)
> +{ return NULL; }
>  static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
>  { return -EIO; }
>  static inline void pci_release_regions(struct pci_dev *dev) { }
> -- 
> 2.9.3
> 
