Return-Path: <SRS0=WRPC=JZ=redhat.com=alex.williamson@kernel.org>
Return-Path: <SRS0=WRPC=JZ=redhat.com=alex.williamson@kernel.org>
Date: Mon, 9 Jul 2018 17:15:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 1/1] Workaround for ACS related bug in certain IDT
 switches
Message-ID: <20180709171530.67273897@t450s.home>
In-Reply-To: <db975ca6-8676-d68b-4c8c-e4936b5cec3c@oracle.com>
References: <4117c119-c754-bf4e-544c-19cb6e239f38@oracle.com>
	<db975ca6-8676-d68b-4c8c-e4936b5cec3c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 9 Jul 2018 11:31:25 -0400
James Puthukattukaran <james.puthukattukaran@oracle.com> wrote:

> Check if the switch (if it exists) is an IDT type switch with this bug
> before attempting to read the vendor id. If so, call pci_idt_bus_quirk().
> 
> The pci_idt_bus_quirk() implements the workaround as described below.
> The IDT switch incorrectly flags an ACS source violation on a read config
> request to an end point device on the completion (IDT 89H32H8G3-YC,
> errata #36) even though the PCI Express spec states that completions are
> never affected by ACS source violation (PCIe Spec r4.0, sec 6.12.1.1). Here's
> the specific copy of the errata text
> 
> "Item #36 - Downstream port applies ACS Source Validation to Completions
> Section 6.12.1.1 of the PCI Express Base Specification 3.1 states
> that completions are never affected
> by ACS Source Validation. However, completions received by a
> downstream port of the PCIe switch from a device that has not yet
> captured a PCIe bus number are incorrectly dropped by ACS source
> validation by the switch downstream port.
> 
> Workaround: Issue a CfgWr1 to the downstream device before issuing
> the first CfgRd1 to the device.
> This allows the downstream device to capture its bus number; ACS
> source validation no longer stops
> completions from being forwarded by the downstream port. It has been
> observed that Microsoft Windows implements this workaround already;
> however, some versions of Linux and other operating systems may not. "
> 
> The suggested workaround by IDT is to issue a configuration write to the
> downstream device before issuing the first config read. This allows the
> downstream device to capture its bus number, thus avoiding the ACS
> violation on the completion. In order to make sure that the device is ready
> for config accesses, we do what is currently done in making config reads
> till it succeeds and then do the config write as specified by the errata.
> However, to avoid hitting the errata issue when doing config reads, we
> disable ACS SV around this process.
> 
> The patch does the following -
> 
> 1. Disable ACS source violation if enabled.
> 2. Wait for config space access to become available by reading vendor id
> 3. Do a config write to the end point (errata workaround)
> 4. Enable ACS source validation (if it was enabled to begin with)
> 
> Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/pci.h    |  5 ++++
>  drivers/pci/probe.c  | 17 +++++++++++++-
>  drivers/pci/quirks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index c358e7a0..f638c06 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -225,6 +225,11 @@ enum pci_bar_type {
>  int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
>  bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  				int crs_timeout);
> +int pci_idt_bus_quirk(struct pci_bus *bus, int devfn,
> +				u32 *pl, int crs_timeout);

Don't we need a static inline stub version of this
when !CONFIG_PCI_QUIRKS?  Also note the multi-line comment style
suggested in section 8) of Documentation/process/coding-style.rst.  The
format used throughout this patch is only recommended for a couple
directories, not including the pci subsystem.  Thanks,

Alex

> +bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn,
> +				u32 *pl, int crs_timeout);
> +
>  int pci_setup_device(struct pci_dev *dev);
>  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
>  		    struct resource *res, unsigned int reg);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac876e3..0b00d0e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2156,7 +2156,7 @@ static bool pci_bus_wait_crs(struct pci_bus *bus, int devfn, u32 *l,
>  	return true;
>  }
>  
> -bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  				int timeout)
>  {
>  	if (pci_bus_read_config_dword(bus, devfn, PCI_VENDOR_ID, l))
> @@ -2172,6 +2172,21 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
>  
>  	return true;
>  }
> +
> +bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +					int timeout)
> +{
> +	struct pci_dev *bridge = bus->self;
> +
> +	/* Certain IDT switches have an issue where it improperly triggers
> +	 * an ACS violation
> +	 */
> +	if (bridge && bridge->vendor == PCI_VENDOR_ID_IDT &&
> +	    bridge->device == 0x80b5)
> +		return pci_idt_bus_quirk(bus, devfn, l, timeout);
> +
> +	return pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
> +}
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
>  /*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f439de8..8299de8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4753,3 +4753,68 @@ static void quirk_gpu_hda(struct pci_dev *hda)
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> +
> +/*
> + * The IDT switch incorrectly flags an ACS source violation on a read config
> + * request to an end point device on the completion (IDT 89H32H8G3-YC,
> + * errata #36) even though the PCI Express spec states that completions are
> + * never affected by ACS source violation (PCIe Spec r4.0, sec 6.12.1.1).
> + * Here's * the specific copy of the errata text --
> + *
> + * "Item #36 - Downstream port applies ACS Source Validation to Completions
> + * Section 6.12.1.1 of the PCI Express Base Specification 3.1 states
> + * that completions are never affected
> + * by ACS Source Validation. However, completions received by a
> + * downstream port of the PCIe switch from a device that has not yet
> + * captured a PCIe bus number are incorrectly dropped by ACS source
> + * validation by the switch downstream port."
> + *
> + * The suggested workaround by IDT is to issue a configuration write to the
> + * downstream device before issuing the first config read. This allows the
> + * downstream device to capture its bus number, thus avoiding the ACS
> + * violation on the completion. In order to make sure that the device is ready
> + * for config accesses, we do what is currently done in making config reads
> + * till it succeeds and then do the config write as specified by the errata.
> + * However, to avoid hitting the errata issue when doing config reads, we
> + * disable ACS SV around this process.
> + */
> +int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l,
> +			int timeout)
> +{
> +
> +	int pos;
> +	u16 ctrl = 0;
> +	bool found;
> +	struct pci_dev *dev = bus->self;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +
> +	/* If capability exists, disable acs for the IDT switch before
> +	 * attempting the initial config accesses to the endpoint device.
> +	 */
> +	if (pos) {
> +		pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +		if (ctrl & PCI_ACS_SV)
> +			pci_write_config_word(dev, pos + PCI_ACS_CTRL,
> +							ctrl & ~PCI_ACS_SV);
> +	}
> +
> +	/* found indicates whether the endpoint device was identified
> +	 * as present or not
> +	 */
> +	found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
> +
> +	/* Write 0 to the devfn device under the PCIE switch (bus->self)
> +	 * as part of forcing the devfn number to latch with the device
> +	 * below
> +	 */
> +	if (found)
> +		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
> +
> +	/* Re-enable ACS_SV if it was previously */
> +	if (ctrl & PCI_ACS_SV)
> +		pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +
> +	return found;
> +}
> +
