Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752430AbdFLVsv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jun 2017 17:48:51 -0400
Date: Mon, 12 Jun 2017 16:48:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
Subject: Re: [PATCH v3] PCI: Workaround wrong flags completions for IDT switch
Message-ID: <20170612214848.GC28578@bhelgaas-glaptop.roam.corp.google.com>
References: <20170609231617.20243-1-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170609231617.20243-1-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 09, 2017 at 04:16:17PM -0700, Yinghai Lu wrote:
> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
> 
> The IDT switch incorrectly flags an ACS source violation on a read config
> request to an end point device on the completion (IDT 89H32H8G3-YC,
> errata #36) even though the PCI Express spec states that completions are
> never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1).

Can you include a URL where this erratum is published?  If not, can
you include the actual erratum text here?

Have you considered ways to make this patch apply only to the affected
IDT switches?  Currently it applies to *all* devices.

The purpose of the pci_bus_read_dev_vendor_id() path is to support the
Configuration Request Retry Status feature (see PCIe r3.1, sec 2.3.2),
which works by special handling of config reads of the Vendor ID after
a reset.  Normally, that Vendor ID read would be the first access to
a device when we enumerate it.

This patch adds config reads and writes of the ACS capability *before*
the Vendor ID read.  At that point we don't even know whether the
device exists.  If it doesn't exist, pci_find_ext_capability() would
read 0xffffffff data, and it probably fails reasonably gracefully.

But if the device *does* exist, I think this patch breaks the CRS
Software Visibility feature.  Without this patch, we try to read
Vendor ID, and the device may return a CRS Completion Status.  If CRS
visibility is enabled, the root complex may complete the request by
returning 0x0001 for the Vendor ID, in which case we sleep and try
again later.

With this patch, we first try to read the ACS capability.  If the
device returns a CRS Completion Status, the root complex is required
to reissue the config request.  This is the required behavior
regardless of whether CRS Software Visibility is enabled, so I think
this effectively disables that feature.

> The suggested workaround by IDT is to issue a configuration write to the
> downstream device before issuing the first config read. This allows the
> downstream device to capture its bus number, thus avoiding the ACS
> violation on the completion.
> 
> The patch does the following -
> 
> 1. Disable ACS source violation if enabled
> 2. Wait for config space access to become available by reading vendor id
> 3. Do a config write to the end point (errata workaround)
> 4. Enable ACS source validation (if it was enabled to begin with)
> 
> -v2: move workaround to pci_bus_read_dev_vendor_id() from pci_bus_check_dev()
>      and move enable_acs_sv to drivers/pci/pci.c -- by Yinghai
> -v3: add bus->self check for root bus and virtual bus for sriov vfs.
> 
> Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> --
> 
>  drivers/pci/pci.c   |   33 +++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h   |    1 +
>  drivers/pci/probe.c |   38 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 70 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/pci/probe.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/probe.c
> +++ linux-2.6/drivers/pci/probe.c
> @@ -1763,8 +1763,8 @@ struct pci_dev *pci_alloc_dev(struct pci
>  }
>  EXPORT_SYMBOL(pci_alloc_dev);
>  
> -bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> -				int crs_timeout)
> +static bool __pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn,
> +					 u32 *l, int crs_timeout)
>  {
>  	int delay = 1;
>  
> @@ -1801,6 +1801,40 @@ bool pci_bus_read_dev_vendor_id(struct p
>  
>  	return true;
>  }
> +
> +bool pci_bus_read_dev_vendor_id(struct pci_bus *bus, int devfn, u32 *l,
> +				int crs_timeout)
> +{
> +	int found;
> +	int enable = -1;
> +
> +	/*
> +	 * Some IDT switches flag an ACS violation for config reads
> +	 * even though the PCI spec allows for it (PCIe 3.1, 6.1.12.1)
> +	 * It flags it because the bus number is not properly set in the
> +	 * completion. The workaround is to do a dummy write to properly
> +	 * latch number once the device is ready for config operations
> +	 */
> +
> +	if (bus->self)
> +		enable = pci_std_enable_acs_sv(bus->self, false);
> +
> +	found = __pci_bus_read_dev_vendor_id(bus, devfn, l, crs_timeout);
> +
> +	/*
> +	 * The fact that we can read the vendor id indicates that the device
> +	 * is ready for config operations. Do the write as part of the errata
> +	 * workaround.
> +	 */
> +	if (bus->self) {
> +		if (found)
> +			pci_bus_write_config_word(bus, devfn, PCI_VENDOR_ID, 0);
> +		if (enable > 0)
> +			pci_std_enable_acs_sv(bus->self, enable);
> +	}
> +
> +	return found;
> +}
>  EXPORT_SYMBOL(pci_bus_read_dev_vendor_id);
>  
>  /*
> Index: linux-2.6/drivers/pci/pci.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.c
> +++ linux-2.6/drivers/pci/pci.c
> @@ -2838,6 +2838,39 @@ static bool pci_acs_flags_enabled(struct
>  }
>  
>  /**
> + *  pci_std_enable_acs_sv - enable/disable ACS source validation if supported by the switch
> + *  @dev - pcie switch/RP
> + *  @enable - enable (1) or disable (0) source validation
> + *
> + *  Returns : < 0 on failure
> + *           previous acs_sv state
> + */
> +int pci_std_enable_acs_sv(struct pci_dev *dev, bool enable)
> +{
> +	int pos;
> +	u16 cap;
> +	u16 ctrl;
> +	int retval;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos)
> +		return -ENODEV;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
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
> +	return retval;
> +}
> +
> +/**
>   * pci_acs_enabled - test ACS against required flags for a given device
>   * @pdev: device to test
>   * @acs_flags: required PCI ACS flags
> Index: linux-2.6/drivers/pci/pci.h
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci.h
> +++ linux-2.6/drivers/pci/pci.h
> @@ -343,6 +343,7 @@ static inline resource_size_t pci_resour
>  }
>  
>  void pci_enable_acs(struct pci_dev *dev);
> +int pci_std_enable_acs_sv(struct pci_dev *dev, bool enable);
>  
>  #ifdef CONFIG_PCIE_PTM
>  void pci_ptm_init(struct pci_dev *dev);
