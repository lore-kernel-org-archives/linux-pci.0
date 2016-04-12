Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64685 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426AbcDLQVy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 12:21:54 -0400
From: "Lawrynowicz, Jacek" <jacek.lawrynowicz@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v4 0/6] PCI: Support multiple DMA aliases
Date: Tue, 12 Apr 2016 16:20:06 +0000
Message-ID: <36D38C1F74839847A52A484C31F3E51A621F51D8@irsmsx105.ger.corp.intel.com>
References: <20160224193926.7585.10833.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160412043828.GA11361@localhost>
In-Reply-To: <20160412043828.GA11361@localhost>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0042_01D194E7.EFE40770"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

------=_NextPart_000_0042_01D194E7.EFE40770
Content-Type: multipart/mixed;
	boundary="----=_NextPart_001_0043_01D194E7.EFE40770"


------=_NextPart_001_0043_01D194E7.EFE40770
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Great, thanks! I tested pci/ntb tree and it works but I had to add another PCI
ID.
Would it be a problem to add second PCI ID to the x200 quirk in this patch set?
I attached a patch with additional line.

Regards,
Jacek

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, April 12, 2016 6:38 AM
> To: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lawrynowicz, Jacek <jacek.lawrynowicz@intel.com>; linux-
> pci@vger.kernel.org; Alex Williamson <alex.williamson@redhat.com>; Joerg
> Roedel <jroedel@suse.de>; David Woodhouse <dwmw2@infradead.org>;
> iommu@lists.linux-foundation.org
> Subject: Re: [PATCH v4 0/6] PCI: Support multiple DMA aliases
> 
> On Wed, Feb 24, 2016 at 01:43:32PM -0600, Bjorn Helgaas wrote:
> > This is a revision of Jacek's v3 posting:
> > http://lkml.kernel.org/r/1454152012-46337-1-git-send-email-
> jacek.lawrynowicz@intel.com
> >
> > The changes from v3 are:
> >
> >   - Split into smaller patches for reviewability
> >   - Move printk when adding DMA alias
> >   - Change dma_alias_is_enabled() interface to take two pci_devs
> >   - Rename dma_alias_is_enabled() to indicate PCI context
> >
> > The only remaining thing I want to sort out is the dma_alias_is_enabled()
> > vs pci_for_each_dma_alias() question Alex raised.  I'll respond to the
> > relevant part of the patch in this series with my specific questions.
> >
> > ---
> >
> > Bjorn Helgaas (1):
> >       PCI: Rename dma_alias_is_enabled() to pci_devs_are_dma_aliases()
> >
> > Jacek Lawrynowicz (5):
> >       PCI: Add pci_add_dma_alias() to abstract implementation
> >       PCI: Move informational printk to pci_add_dma_alias()
> >       PCI: Add support for multiple DMA aliases
> >       pci: Add DMA alias quirk for mic_x200_dma
> >       PCI: Squash pci_dev_flags to remove holes
> 
> I applied this series to pci/ntb for v4.7.  It got a little confusing
> with v5 versions of a couple patches posted, and a couple issues Alex
> found, so here's the series as applied:
> 
> commit f0af9593372abfde34460aa1250e670cc535a7d8
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Feb 24 13:43:45 2016 -0600
> 
>     PCI: Add pci_add_dma_alias() to abstract implementation
> 
>     Add a pci_add_dma_alias() interface to encapsulate the details of adding
an
>     alias.  No functional change intended.
> 
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 25e0327..1162118 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4578,6 +4578,20 @@ int pci_set_vga_state(struct pci_dev *dev, bool
> decode,
>  	return 0;
>  }
> 
> +/**
> + * pci_add_dma_alias - Add a DMA devfn alias for a device
> + * @dev: the PCI device for which alias is added
> + * @devfn: alias slot and function
> + *
> + * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> + * It should be called early, preferably as PCI fixup header quirk.
> + */
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +{
> +	dev->dma_alias_devfn = devfn;
> +	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +}
> +
>  bool pci_device_is_present(struct pci_dev *pdev)
>  {
>  	u32 v;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 8e67802..e45a7a8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3610,10 +3610,8 @@ int pci_dev_specific_reset(struct pci_dev *dev, int
> probe)
> 
>  static void quirk_dma_func0_alias(struct pci_dev *dev)
>  {
> -	if (PCI_FUNC(dev->devfn) != 0) {
> -		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
> -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> -	}
> +	if (PCI_FUNC(dev->devfn) != 0)
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
>  }
> 
>  /*
> @@ -3626,10 +3624,8 @@
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476,
> quirk_dma_func0_alias);
> 
>  static void quirk_dma_func1_alias(struct pci_dev *dev)
>  {
> -	if (PCI_FUNC(dev->devfn) != 1) {
> -		dev->dma_alias_devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 1);
> -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> -	}
> +	if (PCI_FUNC(dev->devfn) != 1)
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
>  }
> 
>  /*
> @@ -3696,11 +3692,10 @@ static void quirk_fixed_dma_alias(struct pci_dev
> *dev)
> 
>  	id = pci_match_id(fixed_dma_alias_tbl, dev);
>  	if (id) {
> -		dev->dma_alias_devfn = id->driver_data;
> -		dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +		pci_add_dma_alias(dev, id->driver_data);
>  		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> -			 PCI_SLOT(dev->dma_alias_devfn),
> -			 PCI_FUNC(dev->dma_alias_devfn));
> +			 PCI_SLOT(id->driver_data),
> +			 PCI_FUNC(id->driver_data));
>  	}
>  }
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 004b813..7e70190 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1988,6 +1988,7 @@ static inline struct eeh_dev
> *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  }
>  #endif
> 
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
>  int pci_for_each_dma_alias(struct pci_dev *pdev,
>  			   int (*fn)(struct pci_dev *pdev,
>  				     u16 alias, void *data), void *data);
> 
> commit 48c830809ce6e143781172c03a9794cb66802b31
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Feb 24 13:43:54 2016 -0600
> 
>     PCI: Move informational printk to pci_add_dma_alias()
> 
>     One of the quirks that adds DMA aliases logs an informational message in
>     dmesg.  Move that to pci_add_dma_alias() so all users log the message
>     consistently.  No functional change intended (except extra message).
> 
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1162118..c82ebd0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4590,6 +4590,8 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
>  	dev->dma_alias_devfn = devfn;
>  	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +	dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> +		 PCI_SLOT(devfn), PCI_FUNC(devfn));
>  }
> 
>  bool pci_device_is_present(struct pci_dev *pdev)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index e45a7a8..7559e40 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3691,12 +3691,8 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
>  	const struct pci_device_id *id;
> 
>  	id = pci_match_id(fixed_dma_alias_tbl, dev);
> -	if (id) {
> +	if (id)
>  		pci_add_dma_alias(dev, id->driver_data);
> -		dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
> -			 PCI_SLOT(id->driver_data),
> -			 PCI_FUNC(id->driver_data));
> -	}
>  }
> 
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285,
> quirk_fixed_dma_alias);
> 
> commit 338c3149a221527e202ee26b1e35f76c965bb6c0
> Author: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> Date:   Thu Mar 3 15:38:02 2016 +0100
> 
>     PCI: Add support for multiple DMA aliases
> 
>     Solve IOMMU support issues with PCIe non-transparent bridges that use
>     Requester ID look-up tables (RID-LUT), e.g., the PEX8733.
> 
>     The NTB connects devices in two independent PCI domains.  Devices
separated
>     by the NTB are not able to discover each other.  A PCI packet being
>     forwared from one domain to another has to have its RID modified so it
>     appears on correct bus and completions are forwarded back to the original
>     domain through the NTB.  The RID is translated using a preprogrammed table
>     (LUT) and the PCI packet propagates upstream away from the NTB.  If the
>     destination system has IOMMU enabled, the packet will be discarded because
>     the new RID is unknown to the IOMMU.  Adding a DMA alias for the new RID
>     allows IOMMU to properly recognize the packet.
> 
>     Each device behind the NTB has a unique RID assigned in the RID-LUT.  The
>     current DMA alias implementation supports only a single alias, so it's not
>     possible to support mutiple devices behind the NTB when IOMMU is enabled.
> 
>     Enable all possible aliases on a given bus (256) that are stored in a
>     bitset.  Alias devfn is directly translated to a bit number.  The bitset
is
>     not allocated for devices that have no need for DMA aliases.
> 
>     More details can be found in the following article:
> 
> http://www.plxtech.com/files/pdf/technical/expresslane/RTC_Enabling%20Muli
> tHostSystemDesigns.pdf
> 
>     Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>     Acked-by: David Woodhouse <David.Woodhouse@intel.com>
>     Acked-by: Joerg Roedel <jroedel@suse.de>
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index bfd4f7c..1b49e94 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -660,8 +660,8 @@ static struct iommu_group
> *get_pci_function_alias_group(struct pci_dev *pdev,
>  }
> 
>  /*
> - * Look for aliases to or from the given device for exisiting groups.  The
> - * dma_alias_devfn only supports aliases on the same bus, therefore the
search
> + * Look for aliases to or from the given device for existing groups. DMA
> + * aliases are only supported on the same bus, therefore the search
>   * space is quite small (especially since we're really only looking at pcie
>   * device, and therefore only expect multiple slots on the root complex or
>   * downstream switch ports).  It's conceivable though that a pair of
> @@ -686,11 +686,7 @@ static struct iommu_group *get_pci_alias_group(struct
> pci_dev *pdev,
>  			continue;
> 
>  		/* We alias them or they alias us */
> -		if (((pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)
> &&
> -		     pdev->dma_alias_devfn == tmp->devfn) ||
> -		    ((tmp->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN) &&
> -		     tmp->dma_alias_devfn == pdev->devfn)) {
> -
> +		if (pci_devs_are_dma_aliases(pdev, tmp)) {
>  			group = get_pci_alias_group(tmp, devfns);
>  			if (group) {
>  				pci_dev_put(tmp);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c82ebd0..0b90c21 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4588,12 +4588,27 @@ int pci_set_vga_state(struct pci_dev *dev, bool
> decode,
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
> -	dev->dma_alias_devfn = devfn;
> -	dev->dev_flags |= PCI_DEV_FLAGS_DMA_ALIAS_DEVFN;
> +	if (!dev->dma_alias_mask)
> +		dev->dma_alias_mask = kcalloc(BITS_TO_LONGS(U8_MAX),
> +					      sizeof(long), GFP_KERNEL);
> +	if (!dev->dma_alias_mask) {
> +		dev_warn(&dev->dev, "Unable to allocate DMA alias mask\n");
> +		return;
> +	}
> +
> +	set_bit(devfn, dev->dma_alias_mask);
>  	dev_info(&dev->dev, "Enabling fixed DMA alias to %02x.%d\n",
>  		 PCI_SLOT(devfn), PCI_FUNC(devfn));
>  }
> 
> +bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
> +{
> +	return (dev1->dma_alias_mask &&
> +		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
> +	       (dev2->dma_alias_mask &&
> +		test_bit(dev1->devfn, dev2->dma_alias_mask));
> +}
> +
>  bool pci_device_is_present(struct pci_dev *pdev)
>  {
>  	u32 v;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8004f67..ae7daeb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1537,6 +1537,7 @@ static void pci_release_dev(struct device *dev)
>  	pcibios_release_device(pci_dev);
>  	pci_bus_put(pci_dev->bus);
>  	kfree(pci_dev->driver_override);
> +	kfree(pci_dev->dma_alias_mask);
>  	kfree(pci_dev);
>  }
> 
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index a20ce7d..33e0f03 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -40,11 +40,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	 * If the device is broken and uses an alias requester ID for
>  	 * DMA, iterate over that too.
>  	 */
> -	if (unlikely(pdev->dev_flags & PCI_DEV_FLAGS_DMA_ALIAS_DEVFN)) {
> -		ret = fn(pdev, PCI_DEVID(pdev->bus->number,
> -					 pdev->dma_alias_devfn), data);
> -		if (ret)
> -			return ret;
> +	if (unlikely(pdev->dma_alias_mask)) {
> +		u8 devfn;
> +
> +		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
> +			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
> +				 data);
> +			if (ret)
> +				return ret;
> +		}
>  	}
> 
>  	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 7e70190..5581d05 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -166,8 +166,6 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_ASSIGNED = (__force pci_dev_flags_t) (1 << 2),
>  	/* Flag for quirk use to store if quirk-specific ACS is enabled */
>  	PCI_DEV_FLAGS_ACS_ENABLED_QUIRK = (__force pci_dev_flags_t) (1
> << 3),
> -	/* Flag to indicate the device uses dma_alias_devfn */
> -	PCI_DEV_FLAGS_DMA_ALIAS_DEVFN = (__force pci_dev_flags_t) (1 <<
> 4),
>  	/* Use a PCIe-to-PCI bridge alias even if !pci_is_pcie */
>  	PCI_DEV_FLAG_PCIE_BRIDGE_ALIAS = (__force pci_dev_flags_t) (1 <<
> 5),
>  	/* Do not use bus resets for device */
> @@ -273,7 +271,7 @@ struct pci_dev {
>  	u8		rom_base_reg;	/* which config register controls
> the ROM */
>  	u8		pin;		/* which interrupt pin this device uses
*/
>  	u16		pcie_flags_reg;	/* cached PCIe Capabilities
> Register */
> -	u8		dma_alias_devfn;/* devfn of DMA alias, if any */
> +	unsigned long	*dma_alias_mask;/* mask of enabled devfn aliases */
> 
>  	struct pci_driver *driver;	/* which driver has allocated this
device */
>  	u64		dma_mask;	/* Mask of the bits of bus address this
> @@ -1989,6 +1987,7 @@ static inline struct eeh_dev
> *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  #endif
> 
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
> +bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
>  int pci_for_each_dma_alias(struct pci_dev *pdev,
>  			   int (*fn)(struct pci_dev *pdev,
>  				     u16 alias, void *data), void *data);
> 
> commit 8e6b62b5dc00bee0bd1f6fada928969159b8083a
> Author: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
> Date:   Thu Mar 3 15:53:20 2016 +0100
> 
>     PCI: Add DMA alias quirk for mic_x200_dma
> 
>     The MIC x200 NTB forwards DMA transactions upstream using multiple alien
>     RIDs.  These RIDs have to be added as aliases to the DMA device to allow
>     buffer access when the IOMMU is enabled.
> 
>     Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
>     Acked-by: David Woodhouse <David.Woodhouse@intel.com>
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7559e40..5cccc78 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3725,6 +3725,20 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892,
> quirk_use_pcie_bridge_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e,
> quirk_use_pcie_bridge_dma_alias);
> 
>  /*
> + * MIC x200 NTB forwards PCIe traffic using multiple alien RIDs. They have to
> + * be added as aliases to the DMA device in order to allow buffer access
> + * when IOMMU is enabled. Following devfns have to match RIT-LUT table
> + * programmed in the EEPROM.
> + */
> +static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
> +{
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264,
> quirk_mic_x200_dma_alias);
> +
> +/*
>   * Intersil/Techwell TW686[4589]-based video capture cards have an empty
> (zero)
>   * class code.  Fix it.
>   */

------=_NextPart_001_0043_01D194E7.EFE40770
Content-Type: application/octet-stream;
	name="0001-PCI-Add-DMA-alias-quirk-for-mic_x200_dma.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-PCI-Add-DMA-alias-quirk-for-mic_x200_dma.patch"

>From 2c4c6ae7e915290f8b432f0fca9c77b03bc63609 Mon Sep 17 00:00:00 2001=0A=
From: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>=0A=
Date: Thu, 3 Mar 2016 15:53:20 +0100=0A=
Subject: [PATCH] PCI: Add DMA alias quirk for mic_x200_dma=0A=
=0A=
The MIC x200 NTB forwards DMA transactions upstream using multiple alien=0A=
RIDs.  These RIDs have to be added as aliases to the DMA device to allow=0A=
buffer access when the IOMMU is enabled.=0A=
=0A=
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@intel.com>=0A=
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>=0A=
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>=0A=
Acked-by: David Woodhouse <David.Woodhouse@intel.com>=0A=
---=0A=
 drivers/pci/quirks.c | 15 +++++++++++++++=0A=
 1 file changed, 15 insertions(+)=0A=
=0A=
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c=0A=
index 7559e40..8889ac4 100644=0A=
--- a/drivers/pci/quirks.c=0A=
+++ b/drivers/pci/quirks.c=0A=
@@ -3725,6 +3725,21 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, =
quirk_use_pcie_bridge_dma_alias);=0A=
 DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, =
quirk_use_pcie_bridge_dma_alias);=0A=
 =0A=
 /*=0A=
+ * MIC x200 NTB forwards PCIe traffic using multiple alien RIDs. They =
have to=0A=
+ * be added as aliases to the DMA device in order to allow buffer access=0A=
+ * when IOMMU is enabled. Following devfns have to match RIT-LUT table=0A=
+ * programmed in the EEPROM.=0A=
+ */=0A=
+static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)=0A=
+{=0A=
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));=0A=
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));=0A=
+	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));=0A=
+}=0A=
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, =
quirk_mic_x200_dma_alias);=0A=
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, =
quirk_mic_x200_dma_alias);=0A=
+=0A=
+/*=0A=
  * Intersil/Techwell TW686[4589]-based video capture cards have an =
empty (zero)=0A=
  * class code.  Fix it.=0A=
  */=0A=
-- =0A=
1.8.3.1=0A=
=0A=

------=_NextPart_001_0043_01D194E7.EFE40770--

------=_NextPart_000_0042_01D194E7.EFE40770
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
VMv3yxHO8jex40LgMIIFijCCBHKgAwIBAgITMwAAHtrUMHJqXk2MNwAAAAAe2jANBgkqhkiG9w0B
AQUFADB5MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRow
GAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMg
SXNzdWluZyBDQSA0QjAeFw0xNTEwMTIxMzEwNDlaFw0xODA5MjYxMzEwNDlaMEkxGzAZBgNVBAMT
Ekxhd3J5bm93aWN6LCBKYWNlazEqMCgGCSqGSIb3DQEJARYbamFjZWsubGF3cnlub3dpY3pAaW50
ZWwuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1tjwqdbx6/OJGZH6bcoU0kUw
Rfszjz7Ws3+m5aZzzysxb1a4/KemhppgfL8kAjJ4Ha35ixtjn2ZO+uAQ7IgJs512oyUkUZydLypc
4kobk1ZQiAeX1J/r0gwPQsbBBJu0rJ4uP9wMn6P1YQRHbjJ443cDPlYKjEzoFxnTlWwpQ4Zc3C8Y
DCLuZk6NPduNJ0++LIVOKi9s35cht7W8CxoVOjV9s9sZlEeN5oCGLVB9ORpt3GPh+8ap/WXTB6FW
Z8Zn/eH0FqPH/UOfbNlb6sJz9RnZ0RcIa+KJpj2QA38JfmSuGc+u+7Ds7/I+0GL3BIzOv9eGBA8h
DAAV8IwXGhwmQQIDAQABo4ICOTCCAjUwCwYDVR0PBAQDAgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsG
AQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4HevTmV8EMCAWQCAQgwHQYDVR0OBBYEFM3NoUwk
hZ72HaT2GREobB3IUpkTMB8GA1UdIwQYMBaAFNpBI5xaj3GvV4M+INPjZdsMywvbMGUGA1UdHwRe
MFwwWqBYoFaGVGh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIwRXh0
ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNybDCBnwYIKwYBBQUHAQEEgZIwgY8w
IgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmludGVsLmNvbS8waQYIKwYBBQUHMAKGXWh0dHA6Ly93
d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBC
YXNpYyUyMElzc3VpbmclMjBDQSUyMDRCLmNydDAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGC
NwoDDDApBgkrBgEEAYI3FQoEHDAaMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcKAwwwUwYDVR0RBEww
SqArBgorBgEEAYI3FAIDoB0MG2phY2VrLmxhd3J5bm93aWN6QGludGVsLmNvbYEbamFjZWsubGF3
cnlub3dpY3pAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCXms3sgvqozD+mirP5B9PANgCE
RVBbEkYt8TzJE0B1lcLfXavkPldx1vC2vpblXofPfVyRbaUbobbIqohYCiblPvqso5raQmr8GeR1
RiWmiqiye2sA2nvQh1m7Skc6h7XBI3knNDzhG87zmvweY0Fgmbvdi7PGfMxjT4eiLjvzhWCthkmJ
NYoJ7Whtn60/vHl1OO6b7JeTqfNDc1NxV/g4dlMyFsr+XtyMGFzI0ch6eIzlpqeFDzKLI/5i8tzc
cZikcJThuwA/SfHHWEHs33gEHxa4F1x6ngyN8OdZgwdBc6nk6wgx6vLeDnN67fCNhQAadMeHjdP+
QqAEvc7XavdRMIIGfTCCBWWgAwIBAgIKGZmpegAAAAAy3TANBgkqhkiG9w0BAQUFADB5MQswCQYD
VQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQKExFJbnRl
bCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSA0
QTAeFw0xMzEwMjEwODU4NThaFw0xNjEwMDUwODU4NThaMEkxGzAZBgNVBAMTEkxhd3J5bm93aWN6
LCBKYWNlazEqMCgGCSqGSIb3DQEJARYbamFjZWsubGF3cnlub3dpY3pAaW50ZWwuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAplKHW1GF9qUj6MGOr6H3a+meHkH/FZW7bNFAFGic
hxCpbgkwPVjFPo5gqoTk1/vZazgMlr6BrETZHAT78vC2OfpHEOgRcBvE3aJw8AMk9q8Scsx43UWY
iK9Ys1i7idBWNH45OfCyHu7Z0pHCFywyQgFUK4FM10MlFNBXzET+rmgqU9RBIRFWkMOi0G4gmL7c
lLApKKFjjfhTx75W2WK3vsNK4Uw+omqR/Kli7IeXExsKOXjv8kuzifYZNAUHMiAGUZURbp5hv7IY
wG7SI9CDwDrtpFbu9k8RRRLNJnt8n+cueMPmNMeMv6PVy/8hmKn0tW+wIIO6hPbe8MbCqLcQJwID
AQABo4IDNTCCAzEwCwYDVR0PBAQDAgQwMD0GCSsGAQQBgjcVBwQwMC4GJisGAQQBgjcVCIbDjHWE
meVRg/2BKIWOn1OCkcAJZ4S52UGHhP9OAgFkAgENMEQGCSqGSIb3DQEJDwQ3MDUwDgYIKoZIhvcN
AwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQUa/PH
evLj3Q34U/tCjZKn2DnMMIwwHwYDVR0jBBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwgckGA1Ud
HwSBwTCBvjCBu6CBuKCBtYZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50
ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3Jshl1odHRwOi8vY2Vy
dGlmaWNhdGVzLmludGVsLmNvbS9yZXBvc2l0b3J5L0NSTC9JbnRlbCUyMEV4dGVybmFsJTIwQmFz
aWMlMjBJc3N1aW5nJTIwQ0ElMjA0QS5jcmwwge8GCCsGAQUFBwEBBIHiMIHfMGkGCCsGAQUFBzAC
hl1odHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRlcy9JbnRlbCUyMEV4
dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjA0QS5jcnQwcgYIKwYBBQUHMAKGZmh0dHA6
Ly9jZXJ0aWZpY2F0ZXMuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0ludGVsJTIw
RXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRBLmNydDAfBgNVHSUEGDAWBggrBgEF
BQcDBAYKKwYBBAGCNwoDBDApBgkrBgEEAYI3FQoEHDAaMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcK
AwQwUwYDVR0RBEwwSqArBgorBgEEAYI3FAIDoB0MG2phY2VrLmxhd3J5bm93aWN6QGludGVsLmNv
bYEbamFjZWsubGF3cnlub3dpY3pAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQCZxulYBdgq
w81+yDpeBMgPwjP6kyC2V0UHwaRygJD6LJEq5KNaJBQl1leJ8esPXOyFCSHyhkAE89FrFvNRhvJs
1B2vpT7sPMy0S8LHwJ/y+vokKXE+b69KwtOIhvzFuZ2SjloRtrN9gIL3lJSy/8hNDnh5Gmzq/KgY
Fv2hOoi1vQYta94hBCgLAjMdbZPuPhdHZxq7QRK871Ghg1tD0Rj1fxEp4aX+UVlcJruVTVdWCjaC
nv0dmSxtIG0tDh8bb8ZfPDbijqz8ul26z+7wHJCDB6dT6zwDCXnWIoD8nzLlaCyRvWUtiTC3wXpy
mh1fAkT91KBs8uiS6O8FccYZoylvMYID5zCCA+MCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNV
BAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24x
KzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAB7a1DByal5N
jDcAAAAAHtowCQYFKw4DAhoFAKCCAiswGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG
9w0BCQUxDxcNMTYwNDEyMTYyMDA1WjAjBgkqhkiG9w0BCQQxFgQUN4kNsUFP9XBvJMP4Q/cl5pEs
gZEwgZMGCSqGSIb3DQEJDzGBhTCBgjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAoGCCqGSIb3
DQMHMAsGCWCGSAFlAwQBAjAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYFKw4DAhow
CwYJYIZIAWUDBAIDMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgEwgZgGCSsGAQQBgjcQBDGBijCB
hzB5MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYD
VQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNz
dWluZyBDQSA0QQIKGZmpegAAAAAy3TCBmgYLKoZIhvcNAQkQAgsxgYqggYcweTELMAkGA1UEBhMC
VVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29y
cG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECChmZ
qXoAAAAAMt0wDQYJKoZIhvcNAQEBBQAEggEAN8fJDVw5METAoe4Uu/SrIy9OB8V4ovJTp/8APBr9
fjM3SOWdUCuBa4xW1LklvwApn9EdEXaP9cvOZ+ThZdgdqAdJqgn+W1cfNyWLM1YPW3wpdyccYQ8B
sF92A0feAce0E852J10WCdajTzlXfTVrHUYf6/f5sb9SQCkJXwpgFDlK4naaIfcYbYMFddcj3+t+
pwp2/ohZwJu4TIy/BWZCmwOL2CtpwuARTsAwTTiB1AAwSkPaOy8uPiHbrFmQ3tYKSWNmN1I+dyK6
1F4UaAqNb7kly30QcnpsJri7G0Z75xforNshnyqrVv8niBxyc0mqnn5tKSbs0Wq5HlKqw0HUSwAA
AAAAAA==

------=_NextPart_000_0042_01D194E7.EFE40770--
