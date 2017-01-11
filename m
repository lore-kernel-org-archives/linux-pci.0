Return-Path: <SRS0=P80y=YZ=intel.com=tomas.winkler@kernel.org>
Return-Path: <SRS0=P80y=YZ=intel.com=tomas.winkler@kernel.org>
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andreas Noever
	<andreas.noever@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Chen, Yu C" <yu.c.chen@intel.com>, "Levy, Amir
 (Jer)" <amir.jer.levy@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
Subject: RE: [PATCH v4 1/8] PCI: Recognize Thunderbolt devices
Date: Wed, 11 Jan 2017 10:01:14 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B5437A15E@hasmsx108.ger.corp.intel.com>
References: <cover.1483806825.git.lukas@wunner.de>
 <dbb277a11a08c515fe518447ad496dfbffc3e1d8.1483806825.git.lukas@wunner.de>
 <5B8DA87D05A7694D9FA63FD143655C1B54376D27@hasmsx108.ger.corp.intel.com>
 <20170108134751.GA23120@wunner.de>
In-Reply-To: <20170108134751.GA23120@wunner.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

>=20
> On Sun, Jan 08, 2017 at 10:23:03AM +0000, Winkler, Tomas wrote:
> > > We're about to allow runtime PM on Thunderbolt ports in
> > > pci_bridge_d3_possible() and unblock runtime PM for Thunderbolt host
> > > hotplug ports in pci_dev_check_d3cold().  In both cases we need to
> > > uniquely identify if a PCI device belongs to a Thunderbolt controller=
.
> > >
> > > We also have the need to detect presence of a Thunderbolt controller
> > > in drivers/platform/x86/apple-gmux.c because dual GPU MacBook Pros
> > > cannot switch external DP/HDMI ports between GPUs if they have
> Thunderbolt.
> > >
> > > Furthermore, in multiple places in the DRM subsystem we need to
> > > detect whether a GPU is on-board or attached with Thunderbolt.  As
> > > an example, Thunderbolt-attached GPUs shall not be registered with
> vga_switcheroo.
> > >
> > > Intel uses a Vendor-Specific Extended Capability (VSEC) with ID
> > > 0x1234 on devices belonging to a Thunderbolt controller which allows
> > > us to recognize them.
> > >
> > > Detect presence of this VSEC on device probe and cache it in a newly
> > > added is_thunderbolt bit in struct pci_dev which can then be queried
> > > by pci_bridge_d3_possible(), pci_dev_check_d3cold(), apple-gmux and
> others.
> > >
> > > Cc: Andreas Noever <andreas.noever@gmail.com>
> > > Cc: Tomas Winkler <tomas.winkler@intel.com>
> > > Cc: Amir Levy <amir.jer.levy@intel.com>
> > > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > > ---
> > >  drivers/pci/pci.h   |  2 ++
> > >  drivers/pci/probe.c | 34 ++++++++++++++++++++++++++++++++++
> > >  include/linux/pci.h |  1 +
> > >  3 files changed, 37 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h index
> > > cb17db2..45c2b81
> > > 100644
> > > --- a/drivers/pci/pci.h
> > > +++ b/drivers/pci/pci.h
> > > @@ -3,6 +3,8 @@
> > >
> > >  #define PCI_FIND_CAP_TTL	48
> > >
> > > +#define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
> >
> > Shouldn't bet this defined in pci_ids.h ?
>=20
> That file is solely intended for IDs used in multiple places, as explaine=
d in the
> comment at its top.  This particular ID is only used in the PCI core, hen=
ce it's in
> the PCI core's private drivers/pci/pci.h.
>=20
> However the line is formatted such that it can just be moved to the globa=
l
> include/linux/pci_ids.h should it be needed someplace else in the future.
>=20
>=20
> > >  extern const unsigned char pcie_link_speed[];
> > >
> > >  bool pcie_cap_has_lnkctl(const struct pci_dev *dev); diff --git
> > > a/drivers/pci/probe.c b/drivers/pci/probe.c index e164b5c..891a8fa
> > > 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -1206,6 +1206,37 @@ void set_pcie_hotplug_bridge(struct pci_dev
> > > *pdev)
> > >  		pdev->is_hotplug_bridge =3D 1;
> > >  }
> > >
> > > +static void set_pcie_vendor_specific(struct pci_dev *dev) {
> >
> >
> > Why don't u implement this  in quirk.c ?
>=20
> The is_thunderbolt bit signifies whether a given PCI device is part of a
> Thunderbolt daisy chain.  (As explained in the comment in include/linux/p=
ci.h,
> see below.)  So it is set on all the PCI devices that comprise a Thunderb=
olt
> controller, but also on all endpoint devices that are attached via Thunde=
rbolt.
>=20
> Consequently this function needs to be executed for all PCI devices, not =
just
> for a subset that could be identified by a vendor, device or class ID.

Ok, god it.=20

>=20
> In the DRM drivers nouveau, radeon and amdgpu I need to prevent calls to
> vga_switcheroo_register_client() and vga_switcheroo_init_domain_pm_ops()
> if the device in question is attached via Thunderbolt.  That's because ex=
ternal
> GPUs can't drive the panel of a laptop or be powered down like an on-boar=
d
> Optimus/PowerXpress GPU.  We've got a bug there right now that manifests
> itself once someone attaches an eGPU to a dual GPU laptop.
> With this patch I'll be able to just skip registration with vga_switchero=
o if
> is_thunderbolt is set on a GPU's pci_dev, thereby fixing the bug.
>=20
>=20
> BTW do you have information on the contents/meaning of the VSEC that you
> would be able/allowed to share?  What I've seen so far is that its length=
 is 0x1c
> bytes on older controllers (e.g. Light Ridge, Port Ridge) and its content=
s are
> always the same, regardless if the controller is used in host mode or end=
point
> mode:

Sorry, currently nothing I can share.
=20
> 500: 0b 00 01 00 34 12 c1 01|50 09 00 00 39 00 00 00
> 510: 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> However on Alpine Ridge the size of the VSEC has increased significantly =
to
> 0xd8 bytes, even though the version stayed at 1 as before:
>=20
> 500: 0b 00 01 60 34 12 81 0d 50 09 b0 0c b9 06 18 08
> 510: 00 38 00 01 00 00 00 00 00 00 00 00 32 02 10 00
> 520: ef d3 00 40 00 00 00 00 f0 f0 30 c1 00 02 30 00
> 530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 590: 00 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
> 5a0: 00 00 00 00 00 00 00 00 00 00 00 00 38 24 01 00
> 5b0: 08 40 00 1c 00 00 01 18 04 03 00 f0 06 00 00 00
> 5c0: 00 00 08 40 06 00 00 01 90 00 08 1b 00 08 80 08
> 5d0: 80 7f 08 00 00 00 00 00
>=20
> Thanks,
>=20
> Lukas
>=20
> >
> > > +	int vsec =3D 0;
> > > +	u32 header;
> > > +
> > > +	while ((vsec =3D pci_find_next_ext_capability(dev, vsec,
> > > +						    PCI_EXT_CAP_ID_VNDR))) {
> > > +		pci_read_config_dword(dev, vsec + PCI_VNDR_HEADER,
> > > &header);
> > > +
> > > +		/* Is the device part of a Thunderbolt controller? */
> > > +		if (dev->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
> > > +		    PCI_VNDR_HEADER_ID(header) =3D=3D PCI_VSEC_ID_INTEL_TBT)
> > > +			dev->is_thunderbolt =3D 1;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Is the device attached with Thunderbolt?  Walk upwards and
> > > +check
> > > for
> > > +	 * each encountered bridge if it's part of a Thunderbolt controller=
.
> > > +	 * Reaching the host bridge means dev is soldered to the mainboard.
> > > +	 */
> > > +	if (!dev->is_thunderbolt) {
> > > +		struct pci_dev *parent =3D dev;
> > > +
> > > +		while ((parent =3D pci_upstream_bridge(parent)))
> > > +			if (parent->is_thunderbolt) {
> > > +				dev->is_thunderbolt =3D 1;
> > > +				break;
> > > +			}
> > > +	}
> > > +}
> > > +
> > >  /**
> > >   * pci_ext_cfg_is_aliased - is ext config space just an alias of std=
 config?
> > >   * @dev: PCI device
> > > @@ -1358,6 +1389,9 @@ int pci_setup_device(struct pci_dev *dev)
> > >  	/* need to have dev->class ready */
> > >  	dev->cfg_size =3D pci_cfg_space_size(dev);
> > >
> > > +	/* need to have dev->cfg_size ready */
> > > +	set_pcie_vendor_specific(dev);
> > > +
> > >  	/* "Unknown power state" */
> > >  	dev->current_state =3D PCI_UNKNOWN;
> > >
> > > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > > e2d1a12..3c775e8
> > > 100644
> > > --- a/include/linux/pci.h
> > > +++ b/include/linux/pci.h
> > > @@ -358,6 +358,7 @@ struct pci_dev {
> > >  	unsigned int	is_virtfn:1;
> > >  	unsigned int	reset_fn:1;
> > >  	unsigned int    is_hotplug_bridge:1;
> > > +	unsigned int	is_thunderbolt:1; /* part of Thunderbolt daisy chain
> */
> > >  	unsigned int    __aer_firmware_first_valid:1;
> > >  	unsigned int	__aer_firmware_first:1;
> > >  	unsigned int	broken_intx_masking:1;
> > > --
> > > 2.11.0
