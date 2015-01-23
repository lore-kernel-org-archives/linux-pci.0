Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59447 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbAWVvD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jan 2015 16:51:03 -0500
Received: by mail-ob0-f174.google.com with SMTP id gq1so8540552obb.5
        for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2015 13:51:02 -0800 (PST)
Date: Fri, 23 Jan 2015 15:50:58 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, aacraid@adaptec.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: quirks: DMA alias quirk for Adaptec 3405
Message-ID: <20150123215058.GM29776@google.com>
References: <20150113182605.15479.9020.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150113182605.15479.9020.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 13, 2015 at 11:26:50AM -0700, Alex Williamson wrote:
> As noted in the added comment, this device is actually an Intel 80333
> I/O processor where the exposed device at 0e.0 is actually the address
> translation unit of the I/O processor and a hidden, private device at
> 01.0 masters the DMA for the device.  In order to enable the IOMMU, we
> therefore need to create a fixed alias between the exposed and hidden
> devfn.
> 
> Scenarios like this are potentially likely for any device incorporating
> this I/O processor, so this little bit of abstraction with the fixed
> alias table should make future additions trivial.

This sounds like the result of some serious debugging :)  Do you have a
pointer to a bugzilla or some email discussion?  I'd like to make the fix
discoverable starting with a failure symptom.

> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Cc: Adaptec OEM Raid Solutions <aacraid@adaptec.com>
> ---
> 
>  drivers/pci/quirks.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ed6f89b..19bdb17 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3528,6 +3528,43 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_JMICRON,
>  			 quirk_dma_func1_alias);
>  
>  /*
> + * Some devices DMA with the wrong devfn, not just the wrong function.
> + * quirk_fixed_dma_alias() uses this table to create fixed aliass, where
> + * the alias is "fixed" and independent of the device devfn.
> + *
> + * For example, the Adaptec 3405 is a PCIe card making use of an Intel 80333
> + * I/O processor.  To software, this appears as a straightforward PCIe-to-PCI/X
> + * bridge with a single device on the subordinate bus.  In reality, the exposed
> + * device at 0e.0 is the Address Translation Unit (ATU) of the controller that
> + * provides a bridge to the internal bus of the I/O processor.  The controller
> + * supports private devices, which can be hidden from PCI config space.  In the
> + * case of the Adaptec 3405, a private device at 01.0 appears to be the DMA
> + * engine, which therefore needs to become a DMA alias for the device.
> + */
> +static const struct pci_device_id fixed_dma_alias_tbl[] = {
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADAPTEC2, 0x0285,
> +			 PCI_VENDOR_ID_ADAPTEC2, 0x02bb), /* Adaptec 3405 */
> +	  .driver_data = PCI_DEVFN(1, 0) },
> +	{ 0 }
> +};
> +
> +static void quirk_fixed_dma_alias(struct pci_dev *dev)
> +{
> +	const struct pci_device_id *id;
> +
> +	id = pci_match_id(fixed_dma_alias_tbl, dev);
> +	if (id) {
> +		dev->dma_alias_devfn = id->driver_data;
> +		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> +			 PCI_SLOT(dev->dma_alias_devfn),
> +			 PCI_FUNC(dev->dma_alias_devfn));
> +	}
> +}
> +
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);
> +
> +/*
>   * A few PCIe-to-PCI bridges fail to expose a PCIe capability, resulting in
>   * using the wrong DMA alias for the device.  Some of these devices can be
>   * used as either forward or reverse bridges, so we need to test whether the
> 
