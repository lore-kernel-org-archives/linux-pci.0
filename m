Return-Path: <SRS0=z1an=YW=intel.com=tomas.winkler@kernel.org>
Return-Path: <SRS0=z1an=YW=intel.com=tomas.winkler@kernel.org>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Andreas Noever <andreas.noever@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Chen, Yu C" <yu.c.chen@intel.com>, "Levy, Amir
 (Jer)" <amir.jer.levy@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v4 1/8] PCI: Recognize Thunderbolt devices
Date: Sun, 8 Jan 2017 10:23:03 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B54376D27@hasmsx108.ger.corp.intel.com>
References: <cover.1483806825.git.lukas@wunner.de>
 <dbb277a11a08c515fe518447ad496dfbffc3e1d8.1483806825.git.lukas@wunner.de>
In-Reply-To: <dbb277a11a08c515fe518447ad496dfbffc3e1d8.1483806825.git.lukas@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

>=20
> We're about to allow runtime PM on Thunderbolt ports in
> pci_bridge_d3_possible() and unblock runtime PM for Thunderbolt host
> hotplug ports in pci_dev_check_d3cold().  In both cases we need to unique=
ly
> identify if a PCI device belongs to a Thunderbolt controller.
>=20
> We also have the need to detect presence of a Thunderbolt controller in
> drivers/platform/x86/apple-gmux.c because dual GPU MacBook Pros cannot
> switch external DP/HDMI ports between GPUs if they have Thunderbolt.
>=20
> Furthermore, in multiple places in the DRM subsystem we need to detect
> whether a GPU is on-board or attached with Thunderbolt.  As an example,
> Thunderbolt-attached GPUs shall not be registered with vga_switcheroo.
>=20
> Intel uses a Vendor-Specific Extended Capability (VSEC) with ID 0x1234 on
> devices belonging to a Thunderbolt controller which allows us to recogniz=
e
> them.
>=20
> Detect presence of this VSEC on device probe and cache it in a newly adde=
d
> is_thunderbolt bit in struct pci_dev which can then be queried by
> pci_bridge_d3_possible(), pci_dev_check_d3cold(), apple-gmux and others.
>=20
> Cc: Andreas Noever <andreas.noever@gmail.com>
> Cc: Tomas Winkler <tomas.winkler@intel.com>
> Cc: Amir Levy <amir.jer.levy@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci.h   |  2 ++
>  drivers/pci/probe.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  1 +
>  3 files changed, 37 insertions(+)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index cb17db2..45c2b81
> 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -3,6 +3,8 @@
>=20
>  #define PCI_FIND_CAP_TTL	48
>=20
> +#define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */


Shouldn't bet this defined in pci_ids.h ?=20

>  extern const unsigned char pcie_link_speed[];
>=20
>  bool pcie_cap_has_lnkctl(const struct pci_dev *dev); diff --git
> a/drivers/pci/probe.c b/drivers/pci/probe.c index e164b5c..891a8fa 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1206,6 +1206,37 @@ void set_pcie_hotplug_bridge(struct pci_dev
> *pdev)
>  		pdev->is_hotplug_bridge =3D 1;
>  }
>=20
> +static void set_pcie_vendor_specific(struct pci_dev *dev) {


Why don't u implement this  in quirk.c ?

> +	int vsec =3D 0;
> +	u32 header;
> +
> +	while ((vsec =3D pci_find_next_ext_capability(dev, vsec,
> +						    PCI_EXT_CAP_ID_VNDR))) {
> +		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
> &header);
> +
> +		/* Is the device part of a Thunderbolt controller? */
> +		if (dev->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
> +		    PCI_VNDR_HEADER_ID(header) =3D=3D PCI_VSEC_ID_INTEL_TBT)
> +			dev->is_thunderbolt =3D 1;
> +	}
> +
> +	/*
> +	 * Is the device attached with Thunderbolt?  Walk upwards and check
> for
> +	 * each encountered bridge if it's part of a Thunderbolt controller.
> +	 * Reaching the host bridge means dev is soldered to the mainboard.
> +	 */
> +	if (!dev->is_thunderbolt) {
> +		struct pci_dev *parent =3D dev;
> +
> +		while ((parent =3D pci_upstream_bridge(parent)))
> +			if (parent->is_thunderbolt) {
> +				dev->is_thunderbolt =3D 1;
> +				break;
> +			}
> +	}
> +}
> +
>  /**
>   * pci_ext_cfg_is_aliased - is ext config space just an alias of std con=
fig?
>   * @dev: PCI device
> @@ -1358,6 +1389,9 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* need to have dev->class ready */
>  	dev->cfg_size =3D pci_cfg_space_size(dev);
>=20
> +	/* need to have dev->cfg_size ready */
> +	set_pcie_vendor_specific(dev);
> +
>  	/* "Unknown power state" */
>  	dev->current_state =3D PCI_UNKNOWN;
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h index e2d1a12..3c7=
75e8
> 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -358,6 +358,7 @@ struct pci_dev {
>  	unsigned int	is_virtfn:1;
>  	unsigned int	reset_fn:1;
>  	unsigned int    is_hotplug_bridge:1;
> +	unsigned int	is_thunderbolt:1; /* part of Thunderbolt daisy chain
> */
>  	unsigned int    __aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
>  	unsigned int	broken_intx_masking:1;
> --
> 2.11.0
