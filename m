Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbdA1V7p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Jan 2017 16:59:45 -0500
Date: Sat, 28 Jan 2017 15:52:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/8] PCI: Recognize Thunderbolt devices
Message-ID: <20170128215208.GM20550@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1484486499.git.lukas@wunner.de>
 <bfabf33fc63abbeb84e11e544456098dff0e4604.1484486499.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bfabf33fc63abbeb84e11e544456098dff0e4604.1484486499.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jan 15, 2017 at 09:03:45PM +0100, Lukas Wunner wrote:
> We're about to allow runtime PM on Thunderbolt ports in
> pci_bridge_d3_possible() and unblock runtime PM for Thunderbolt host
> hotplug ports in pci_dev_check_d3cold().  In both cases we need to
> uniquely identify if a PCI device belongs to a Thunderbolt controller.

Sounds like "a device belongs to a Thunderbolt controller" means the
device is part of a Thunderbolt controller or part of the hierarchy
below it?

> We also have the need to detect presence of a Thunderbolt controller in
> drivers/platform/x86/apple-gmux.c because dual GPU MacBook Pros cannot
> switch external DP/HDMI ports between GPUs if they have Thunderbolt.

This series doesn't touch apple-gmux.c, and I don't know anything
about this MacBook Pro topology, so I can't tell why Thunderbolt is
relevant here.

> Furthermore, in multiple places in the DRM subsystem we need to detect
> whether a GPU is on-board or attached with Thunderbolt.  As an example,
> Thunderbolt-attached GPUs shall not be registered with vga_switcheroo.

Why?  The connection between vga_switcheroo and Thunderbolt is not
obvious, at least to this non-GPU person.

> Intel uses a Vendor-Specific Extended Capability (VSEC) with ID 0x1234
> on devices belonging to a Thunderbolt controller which allows us to
> recognize them.
> 
> Detect presence of this VSEC on device probe and cache it in a newly
> added is_thunderbolt bit in struct pci_dev which can then be queried by
> pci_bridge_d3_possible(), pci_dev_check_d3cold(), apple-gmux and others.
> 
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Amir Levy <amir.jer.levy@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.h   |  2 ++
>  drivers/pci/probe.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  3 files changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index cb17db242f30..45c2b8144911 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -3,6 +3,8 @@
>  
>  #define PCI_FIND_CAP_TTL	48
>  
> +#define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> +
>  extern const unsigned char pcie_link_speed[];
>  
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e164b5c9f0f0..891a8fa1f9f6 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1206,6 +1206,37 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
>  		pdev->is_hotplug_bridge = 1;
>  }
>  
> +static void set_pcie_vendor_specific(struct pci_dev *dev)

This is very specific to Thunderbolt, so let's name it something that
conveys that information.  The fact that we use a vendor-specific
capability to figure it out isn't really relevant in the caller.

> +{
> +	int vsec = 0;
> +	u32 header;
> +
> +	while ((vsec = pci_find_next_ext_capability(dev, vsec,
> +						    PCI_EXT_CAP_ID_VNDR))) {
> +		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER, &header);
> +
> +		/* Is the device part of a Thunderbolt controller? */
> +		if (dev->vendor == PCI_VENDOR_ID_INTEL &&
> +		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT)
> +			dev->is_thunderbolt = 1;

			return;

> +	}
> +
> +	/*
> +	 * Is the device attached with Thunderbolt?  Walk upwards and check for
> +	 * each encountered bridge if it's part of a Thunderbolt controller.
> +	 * Reaching the host bridge means dev is soldered to the mainboard.
> +	 */
> +	if (!dev->is_thunderbolt) {

The "if" is unnecessary if you return above.

> +		struct pci_dev *parent = dev;
> +
> +		while ((parent = pci_upstream_bridge(parent)))
> +			if (parent->is_thunderbolt) {
> +				dev->is_thunderbolt = 1;
> +				break;
> +			}
> +	}
> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1358,6 +1389,9 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* need to have dev->class ready */
>  	dev->cfg_size = pci_cfg_space_size(dev);
>  
> +	/* need to have dev->cfg_size ready */
> +	set_pcie_vendor_specific(dev);
> +
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a124216a..3c775e8498f1 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -358,6 +358,7 @@ struct pci_dev {
>  	unsigned int	is_virtfn:1;
>  	unsigned int	reset_fn:1;
>  	unsigned int    is_hotplug_bridge:1;
> +	unsigned int	is_thunderbolt:1; /* part of Thunderbolt daisy chain */
>  	unsigned int    __aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
>  	unsigned int	broken_intx_masking:1;
> -- 
> 2.11.0
> 
