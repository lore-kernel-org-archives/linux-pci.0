Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932577AbeF2XMI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Jun 2018 19:12:08 -0400
Date: Fri, 29 Jun 2018 18:12:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: Implement workaround for the ACS bug in the
 IDT, switch
Message-ID: <20180629231206.GF40928@bhelgaas-glaptop.roam.corp.google.com>
References: <4bd28931-8e8d-6bfe-a98c-49f8e2778c6e@oracle.com>
 <9d9f1948-51a4-f0a5-fccb-2c76931532df@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d9f1948-51a4-f0a5-fccb-2c76931532df@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 30, 2018 at 01:28:46PM -0400, James Puthukattukaran wrote:
> The IDT switch incorrectly flags an ACS source violation on a read config
> request to an end point device on the completion (IDT 89H32H8G3-YC,
> errata #36) even though the PCI Express spec states that completions are
> never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1). Here's

s/PCI Spec 3.1, Section 6.12.1.1/PCIe r4.0, sec 6.12.1.1/

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
>  drivers/pci/pci.h    |   2 +
>  drivers/pci/quirks.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 2132a60..586874d 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -228,6 +228,8 @@ bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *pl,
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn,
>  				u32 *pl, int crs_timeout);
> +bool pci_bus_generic_read_dev_vendor_id(struct pci_bus *bus, int devfn,
> +				u32 *pl, int crs_timeout);
>  #else
>  static int pci_bus_specific_read_dev_vendor_id(struct pci_bus *bus, int devfn,
>  				u32 *pl, int crs_timeout)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2b28584..2f5c024 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4742,11 +4742,112 @@ static void quirk_gpu_hda(struct pci_dev *hda)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  
> +/*
> + * The IDT switch incorrectly flags an ACS source violation on a read config
> + * request to an end point device on the completion (IDT 89H32H8G3-YC,
> + * errata #36) even though the PCI Express spec states that completions are
> + * never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1).
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
> +static int pci_idt_acs_quirk(struct pci_bus *bus, int devfn, int enable,
> +				bool found)
> +{
> +	int pos;
> +	u16 cap;
> +	u16 ctrl;
> +	int retval;
> +	struct pci_dev *dev = bus->self;
> +
> +
> +	/*
> +	 * Write 0 to the devfn device under the PCIE switch (bus->self)
> +	 * as part of forcing the devfn number to latch with the device
> +	 * below
> +	 */
> +	if (found)
> +		pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
> +
> +
> +	/* Enable/disable ACS SV feature (based on enable flag) */
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos)
> +		return -ENODEV;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> +
> +	if (!(cap & PCI_ACS_SV))
> +		return -ENODEV;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	retval = !!(ctrl & cap & PCI_ACS_SV);
> +	if (enable)
> +		ctrl |= (cap & PCI_ACS_SV);
> +	else
> +		ctrl &= ~(cap & PCI_ACS_SV);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +
> +	/*
> +	 * return the previous state of the ACS SV state i.e was SV enabled
> +	 * or disabled?
> +	 */
> +	return retval;
> +}
> +
> +static int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l,
> +				int timeout)
> +{
> +	int enable;
> +	bool found;
> +
> +	/*
> +	 * Disable acs for the IDT switch before attempting the initial
> +	 * config accesses to the endpoint device.
> +	 */
> +	enable = pci_idt_acs_quirk(bus, devfn, 0, false);
> +
> +	/*
> +	 * found indicates whether the endpoint device was identified
> +	 * as present or not
> +	 */
> +
> +	found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
> +
> +	/*
> +	 * re-enable acs feature for the switch again if it was enabled to
> +	 * start with
> +	 */
> +	if (enable > 0)
> +		pci_idt_acs_quirk(bus, devfn, enable, found);
> +
> +	return found ? 1 : 0;
> +}

The different meanings of the return values are confusing, it's ugly
to have to look up the ACS cap twice, and I don't think we need to
check ACS_SV in both the capability and control registers.  Can you do
something along these lines in a single function?

  u16 ctrl = 0;

  pos = pci_find_ext_capability(bridge, PCI_EXT_CAP_ID_ACS);
  if (pos) {
    pci_read_config_word(bridge, pos + PCI_ACS_CTRL, &ctrl);
    if (ctrl & PCI_ACS_SV)
      pci_write_config_word(bridge, pos + PCI_ACS_CTRL, ctrl & ~PCI_ACS_SV);
  } 

  found = pci_bus_generic_read_dev_vendor_id(bus, devfn, l, timeout);
  if (found)
    pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);

  if (ctrl & PCI_ACS_SV)
    pci_write_config_word(bridge, pos + PCI_ACS_CTRL, ctrl);
    
  return found;

> +
> +
>  static const struct pci_bus_specific_quirk{
>  	u16 vendor;
>  	u16 device;
>  	int (*bus_quirk)(struct pci_bus *bus, int devfn, u32 *l, int timeout);
>  } pci_bus_specific_quirks[] = {
> +	{ PCI_VENDOR_ID_IDT, 0x80b5, pci_idt_bus_quirk},
>  	{0}
>  };
>  
> -- 
> 1.8.3.1
> 
