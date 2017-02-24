Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751341AbdBXWS1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Feb 2017 17:18:27 -0500
Date: Fri, 24 Feb 2017 16:17:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 1/5] PCI: Recognize Thunderbolt devices
Message-ID: <20170224221724.GA26430@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1487938188.git.lukas@wunner.de>
 <c42a235e126f273e9b8712a7154f813f757db507.1487938188.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c42a235e126f273e9b8712a7154f813f757db507.1487938188.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 24, 2017 at 08:19:45PM +0100, Lukas Wunner wrote:
> Detect on probe whether a PCI device is part of a Thunderbolt controller.
> 
> Intel uses a Vendor-Specific Extended Capability (VSEC) with ID 0x1234
> on such devices.  Detect presence of this VSEC and cache it in a newly
> added is_thunderbolt bit in struct pci_dev.  Add a helper to check
> whether a given PCI device is situated on a Thunderbolt daisy chain.
> 
> The necessity arises from the following:
> 
> * To power off Thunderbolt controllers on Macs even if their BIOS is
>   older than 2015, their PCIe ports need to be whitelisted for runtime
>   PM.  For this we need a way to recognize them.
> 
> * Dual GPU MacBook Pros introduced 2011+ can no longer switch external
>   DisplayPort ports between GPUs.  (They're no longer just used for DP
>   but have become combined DP/Thunderbolt ports.)  The driver to switch
>   the ports, drivers/platform/x86/apple-gmux.c, needs to detect presence
>   of a Thunderbolt controller and, if found, keep external ports
>   permanently switched to the discrete GPU.
> 
> * If an external Thunderbolt GPU is connected to a dual GPU laptop (Mac
>   or not), that GPU is currently registered with vga_switcheroo even
>   though it can neither drive the laptop's panel nor be powered off by
>   the platform.  To vga_switcheroo it will appear as if two discrete
>   GPUs are present.  As a result, when the external GPU is runtime
>   suspended, vga_switcheroo will cut power to the internal discrete GPU
>   which may not be runtime suspended at all at this moment.  The
>   solution is to not register external GPUs with vga_switcheroo, which
>   necessitates a way to recognize if they're on a Thunderbolt daisy
>   chain.

If I understand correctly, vga_switcheroo manages two GPUs that have a
single output: either there's a mux that connects one GPU or the other
to the output, or one GPU is permanently connected to the output and
the other does offline rendering.

To this non-GPU person, it sounds like the important question is
whether two GPUs are related in this way (either they feed the same
mux, or there's some special offline rendering connection between
them).  That sounds unrelated to the question of how the GPUs
themselves are connected to the PCI hierarchy.

>From a pure PCI perspective, I assume it would be conceivable to have
two Thunderbolt-connected GPUs feeding into a mux.  Or to have a GPU
(unrelated to the mux) in a non-Thunderbolt plugin slot or connected
externally via a non-Thunderbolt switch and an iPass cable.

If that's the case, and we're using Thunderbolt-connectedness as a
hint that happens to work for the hardware we know about now, that's
fine -- I'm just trying to understand what's a hint and what's
intrisic to being connected via Thunderbolt.

> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Michael Jamet <michael.jamet@intel.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Amir Levy <amir.jer.levy@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.h   |  2 ++
>  drivers/pci/probe.c | 21 +++++++++++++++++++++
>  include/linux/pci.h | 23 +++++++++++++++++++++++
>  3 files changed, 46 insertions(+)
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
> index 204960e70333..7963ecc6d85f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1208,6 +1208,24 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev)
>  		pdev->is_hotplug_bridge = 1;
>  }
>  
> +static void set_pcie_thunderbolt(struct pci_dev *dev)
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
> +		    PCI_VNDR_HEADER_ID(header) == PCI_VSEC_ID_INTEL_TBT) {
> +			dev->is_thunderbolt = 1;
> +			return;
> +		}
> +	}
> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - is ext config space just an alias of std config?
>   * @dev: PCI device
> @@ -1360,6 +1378,9 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* need to have dev->class ready */
>  	dev->cfg_size = pci_cfg_space_size(dev);
>  
> +	/* need to have dev->cfg_size ready */
> +	set_pcie_thunderbolt(dev);
> +
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a124216a..36dfcfd946f4 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -358,6 +358,7 @@ struct pci_dev {
>  	unsigned int	is_virtfn:1;
>  	unsigned int	reset_fn:1;
>  	unsigned int    is_hotplug_bridge:1;
> +	unsigned int	is_thunderbolt:1; /* Thunderbolt controller */

I'm not really keen on having this in the PCI core because the core
doesn't need this or even know what it means.

pci_find_next_ext_capability() is available to drivers, and if
Thunderbolt-connectedness is useful information to apple-gmux or GPU
drivers, it's fine with me if you want to use it there.  I just don't
see the benefit to having it in the core.

>  	unsigned int    __aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
>  	unsigned int	broken_intx_masking:1;
> @@ -2171,6 +2172,28 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
>  	return bus->self && bus->self->ari_enabled;
>  }
>  
> +/**
> + * pci_is_thunderbolt_attached - whether device is on a Thunderbolt daisy chain
> + * @pdev: PCI device to check
> + *
> + * Walk upwards from @pdev and check for each encountered bridge if it's
> + * part of a Thunderbolt controller.  Reaching the host bridge means @pdev
> + * is soldered to the mainboard.

The comment suggests this returns false only if @pdev is soldered to
the mainboard.  I don't think that's the case.  This will return true
for a Thunderbolt controller and all devices downstream from it.  It
will return false for all others, whether they're soldered down or
not.

> + */
> +static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pdev;
> +
> +	if (pdev->is_thunderbolt)
> +		return true;
> +
> +	while ((parent = pci_upstream_bridge(parent)))
> +		if (parent->is_thunderbolt)
> +			return true;
> +
> +	return false;
> +}
> +
>  /* provide the legacy pci_dma_* API */
>  #include <linux/pci-dma-compat.h>
>  
> -- 
> 2.11.0
> 
