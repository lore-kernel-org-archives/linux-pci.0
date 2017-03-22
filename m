Return-Path: <SRS0=0URG=27=microsoft.com=longli@kernel.org>
Return-Path: <SRS0=0URG=27=microsoft.com=longli@kernel.org>
From: Long Li <longli@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 v4] pci-hyperv: properly handle pci bus remove
Date: Wed, 22 Mar 2017 23:34:07 +0000
Message-ID: <CO2PR03MB2230B6B0B2C1F453E9C0B34DCE3C0@CO2PR03MB2230.namprd03.prod.outlook.com>
References: <BN3PR03MB22270F97B502941940E0E91ECE560@BN3PR03MB2227.namprd03.prod.outlook.com>
 <20170316200658.GC9739@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170316200658.GC9739@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Thursday, March 16, 2017 1:07 PM
> To: Long Li <longli@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>;
> devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2 v4] pci-hyperv: properly handle pci bus remove
>=20
> On Tue, Feb 28, 2017 at 02:19:45AM +0000, Long Li wrote:
> > hv_pci_devices_present is called in hv_pci_remove when we remove a PCI
> > device from host (e.g. by disabling SRIOV on a device). In
> > hv_pci_remove, the bus is already removed before the call, so we don't
> > need to rescan the bus in the workqueue scheduled from
> > hv_pci_devices_present. By introducing status hv_pcibus_removed, we
> can avoid this situation.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
> > Acked-by: K. Y. Srinivasan <kys@microsoft.com>
>=20
> This didn't apply for me because saving it to a file resulted in some enc=
oded
> file with "=3D3D" instead of "=3D".  I see that mutt is smart enough to d=
eal with
> that in this reply, so there's probably a way for it to decode it when sa=
ving to
> a file, but I don't know it.
>=20
> I tried to apply it by hand, but the hunk in hv_pci_remove() doesn't matc=
h
> the context.  I think your patch is based on something previous to
> 17978524a636 ("PCI: hv: Fix hv_pci_remove() for hot-remove").  Please
> refresh the patch so it applies to my "master" branch (currently v4.11-rc=
1).
>=20
> Also, the "default: break;" case below is redundant and can be removed.
>=20
> So I'll wait for your updated versions of both these patches.
>=20
> > ---
> >  drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-hyperv.c
> > b/drivers/pci/host/pci-hyperv.c index a8deeca..4a37598 100644
> > --- a/drivers/pci/host/pci-hyperv.c
> > +++ b/drivers/pci/host/pci-hyperv.c
> > @@ -348,6 +348,7 @@ enum hv_pcibus_state {
> >  	hv_pcibus_init =3D 0,
> >  	hv_pcibus_probed,
> >  	hv_pcibus_installed,
> > +	hv_pcibus_removed,
> >  	hv_pcibus_maximum
> >  };
> >
> > @@ -1481,13 +1482,24 @@ static void pci_devices_present_work(struct
> work_struct *work)
> >  		put_pcichild(hpdev, hv_pcidev_ref_initial);
> >  	}
> >
> > -	/* Tell the core to rescan bus because there may have been changes.
> */
> > -	if (hbus->state =3D=3D hv_pcibus_installed) {
> > +	switch (hbus->state) {
> > +	case hv_pcibus_installed:
> > +		/*
> > +		 * Tell the core to rescan bus
> > +		 * because there may have been changes.
> > +		 */
> >  		pci_lock_rescan_remove();
> >  		pci_scan_child_bus(hbus->pci_bus);
> >  		pci_unlock_rescan_remove();
> > -	} else {
> > +		break;
> > +
> > +	case hv_pcibus_init:
> > +	case hv_pcibus_probed:
> >  		survey_child_resources(hbus);
> > +		break;
> > +
> > +	default:
> > +		break;
>=20
> ^ This is redundant.

I found it still needs "default:break", or it will give a compiler warning:

drivers/pci/host/pci-hyperv.c: In function 'pci_devices_present_work':
drivers/pci/host/pci-hyperv.c:1510:2: warning: enumeration value 'hv_pcibus=
_removed' not handled in switch [-Wswitch]
  switch(hbus->state) {
  ^
drivers/pci/host/pci-hyperv.c:1510:2: warning: enumeration value 'hv_pcibus=
_maximum' not handled in switch [-Wswitch]

>=20
> >  	}
> >
> >  	up(&hbus->enum_sem);
> > @@ -2163,6 +2175,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	hbus =3D kzalloc(sizeof(*hbus), GFP_KERNEL);
> >  	if (!hbus)
> >  		return -ENOMEM;
> > +	hbus->state =3D hv_pcibus_init;
> >
> >  	/*
> >  	 * The PCI bus "domain" is what is called "segment" in ACPI and @@
> > -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  		pci_stop_root_bus(hbus->pci_bus);
> >  		pci_remove_root_bus(hbus->pci_bus);
> >  		pci_unlock_rescan_remove();
> > +		hbus->state =3D hv_pcibus_removed;
> >  	}
> >
> >  	ret =3D hv_send_resources_released(hdev);
> > --
> > 1.8.5.6
