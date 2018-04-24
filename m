Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750757AbeDXRu0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Apr 2018 13:50:26 -0400
Date: Tue, 24 Apr 2018 11:50:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: Add pci_bus_specific_read_dev_vendor_id() to
 workaround PCI switch specific issues prior to accessing newly added
 endpoint
Message-ID: <20180424115025.4a3136bc@w520.home>
In-Reply-To: <16461819-82a1-8122-4a30-842f9a078988@oracle.com>
References: <7e9f5905-34c5-f24c-8b13-df36b8bf3621@oracle.com>
        <16461819-82a1-8122-4a30-842f9a078988@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 24 Apr 2018 10:53:08 -0400
James Puthukattukaran <james.puthukattukaran@oracle.com> wrote:

> This patch provides a framework in which it would be possible to implement
> bus specific quirks prior to accessing an endpoint device beneath that bus.
> The routine, pci_bus_specific_read_dev_vendor_id, can be called prior to
> accessing the end point device itself in order to workaround potential issues
> with the parent device (switch). If there is nothing specific to be done for
> a particular switch device, it falls through to check for the endpoint device
> i.e pci_bus_generic_read_dev_vendor_id().
> 
> Signed-off: James Puthukattukaran <james.puthukattukaran@oracle.com>
            ^ -by

> ---
>  drivers/pci/pci.h    |  2 ++
>  drivers/pci/probe.c  | 19 ++++++++++++++++++-
>  drivers/pci/quirks.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 023f7cf..39ea6ee 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -225,6 +225,8 @@ enum pci_bar_type {
>  int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  				int crs_timeout);
> +int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn,
> +				u32 *pl, int crs_timeout);
>  int pci_setup_device(struct pci_dev *dev);
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		    struct resource *res, unsigned int reg);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac91b6f..d8bf71b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2097,7 +2097,7 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
>  	return true;
>  }
>  
> -bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  				int timeout)
>  {
>  	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> @@ -2113,6 +2113,23 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  
>  	return true;
>  }
> +
> +
> +bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +					int timeout)
> +{
> +	int ret;
> +
> +	/* An opportunity to implement something specific for this device.
> +	 * For ex, impelement a quirk prior to even accessing the device

s/impelement/implement/

Otherwise,

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> +	 */
> +	ret = pci_bus_specific_read_dev_vendor_id(bus, devfn, l, timeout);
> +	if (ret >= 0)
> +		return (ret >= 0);
> +
> +	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
> +}
> +
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
>  /*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1..c32c5ec 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4741,3 +4741,44 @@ static void quirk_gpu_hda(struct pci_dev *hda)
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> +
> +
> +static const struct pci_bus_specific_quirk{
> +	u16 vendor;
> +	u16 device;
> +	int (*bus_quirk)(struct pci_bus *bus, int devfn, u32 *l, int timeout);
> +} pci_bus_specific_quirks[] = {
> +	{0}
> +};
> +
> +/*
> + * This routine provides the ability to implement a bus specific quirk
> + * prior to doing config accesses to the endpoint device itself. For ex, there
> + * could be HW problems with the switch above the endpoint that causes issues
> + * when accessing the endpoint device. Such workarounds "specific" to the
> + * parent could be implemented prior or subsequent to accesses to the
> + * endpoint itself
> + *
> + */
> +int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +					int timeout)
> +{
> +	const struct pci_bus_specific_quirk *i;
> +	struct pci_dev *dev;
> +
> +	if (!bus || !bus->self)
> +		return -ENOTTY;
> +
> +	dev = bus->self;
> +
> +	/* Implement any quirks in the "bus" (switch, for ex) that causes
> +	 * issues in accessing the endpoint
> +	 */
> +	for (i = pci_bus_specific_quirks; i->bus_quirk; i++) {
> +		if ((i->vendor == dev->vendor ||
> +		     i->vendor == (u16)PCI_ANY_ID) &&
> +		    (i->device == dev->device || i->device == (u16)PCI_ANY_ID))
> +			return(i->bus_quirk(bus, devfn, l, timeout));
> +	}
> +	return -ENOTTY;
> +}
