Return-Path: <SRS0=2ikk=7G=ACULAB.COM=David.Laight@kernel.org>
Return-Path: <SRS0=2ikk=7G=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <helgaas@kernel.org>, Roland Dreier <roland@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Emil Tantilov <emil.s.tantilov@intel.com>
Subject: RE: [PATCH] PCI: Update ACS quirk for more Intel 10G NICs
Date: Fri, 4 Aug 2017 13:28:32 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD004B362@AcuExch.aculab.com>
References: <20170720214101.7449-1-roland@kernel.org>
 <20170803214911.GG20308@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170803214911.GG20308@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas
> Sent: 03 August 2017 22:49
> On Thu, Jul 20, 2017 at 02:41:01PM -0700, Roland Dreier wrote:
> > From: Roland Dreier <roland@purestorage.com>
> >
> > Add one more variant of the 82599 plus the device IDs for X540 and X550
> > variants.  Intel has confirmed that none of these devices does peer-to-=
peer
> > between functions.  The X540 and X550 have added ACS capabilities in th=
eir
> > PCI config space, but the ACS control register is hard-wired to 0 for b=
oth
> > devices, so we still need the quirk for IOMMU grouping to allow assignm=
ent
> > of individual SR-IOV functions.
...
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -4335,12 +4335,33 @@ static const struct pci_dev_acs_enabled {
> >  	{ PCI_VENDOR_ID_INTEL, 0x1507, pci_quirk_mf_endpoint_acs },
> >  	{ PCI_VENDOR_ID_INTEL, 0x1514, pci_quirk_mf_endpoint_acs },
> >  	{ PCI_VENDOR_ID_INTEL, 0x151C, pci_quirk_mf_endpoint_acs },
> > +	{ PCI_VENDOR_ID_INTEL, 0x1528, pci_quirk_mf_endpoint_acs },
> >  	{ PCI_VENDOR_ID_INTEL, 0x1529, pci_quirk_mf_endpoint_acs },
> > +	{ PCI_VENDOR_ID_INTEL, 0x154A, pci_quirk_mf_endpoint_acs },
...

That list is looking a bit long.
Is it possible to run-time determine that the ACS control register is hard =
wired
to zero, and apply the quirk to all such devices.
Or even changing to a (device & mask) =3D=3D value test??

	David
