Return-Path: <SRS0=WI4l=YY=microsoft.com=longli@kernel.org>
Return-Path: <SRS0=WI4l=YY=microsoft.com=longli@kernel.org>
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>, Bjorn Helgaas
	<bhelgaas@google.com>, "devel@linuxdriverproject.org"
	<devel@linuxdriverproject.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 v3] pci-hyperv: properly handle pci bus remove
Date: Mon, 9 Jan 2017 22:50:44 +0000
Message-ID: <BN3PR03MB2227414C9F64D691FA8459F9CE640@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1475563367-16511-1-git-send-email-longli@exchange.microsoft.com>
 <20161111210359.GD9868@bhelgaas-glaptop.roam.corp.google.com>
 <DM5PR03MB249014B12EF338110F2F9F8CA0BB0@DM5PR03MB2490.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB249014B12EF338110F2F9F8CA0BB0@DM5PR03MB2490.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn

This patch is still pending. The patch has been ack'ed.

Do you want me to resend this patch?

Thanks

Long

> -----Original Message-----
> From: KY Srinivasan
> Sent: Friday, November 11, 2016 2:21 PM
> To: Bjorn Helgaas <helgaas@kernel.org>; Long Li <longli@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; Bjorn Helgaas
> <bhelgaas@google.com>; devel@linuxdriverproject.org; linux-
> pci@vger.kernel.org; linux-kernel@vger.kernel.org; Long Li
> <longli@microsoft.com>
> Subject: RE: [PATCH 1/2 v3] pci-hyperv: properly handle pci bus remove
>=20
>=20
>=20
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Friday, November 11, 2016 1:04 PM
> > To: Long Li <longli@microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>;
> > devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Long Li <longli@microsoft.com>
> > Subject: Re: [PATCH 1/2 v3] pci-hyperv: properly handle pci bus remove
> >
> > On Mon, Oct 03, 2016 at 11:42:47PM -0700, Long Li wrote:
> > > From: Long Li <longli@microsoft.com>
> > >
> > > hv_pci_devices_present is called in hv_pci_remove when we remove a
> > > PCI
> > device from host (e.g. by disabling SRIOV on a device). In
> > hv_pci_remove, the bus is already removed before the call, so we don't
> > need to rescan the bus in the workqueue scheduled from
> > hv_pci_devices_present. By introducing status hv_pcibus_removed, we
> can avoid this situation.
> > >
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > Tested-by: Cathy Avery <cavery@redhat.com>
> > > Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
>=20
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>
>=20
>=20
> >
> > I need an ack from the Hyper-V maintainers.  I see acks for previous
> > versions, but I don't know whether you've changed things that would
> > invalidate those acks.  If the acks still apply, please include them
> > and repost these patches.
> >
> > Also, please run "git log --oneline drivers/pci/host/pci-hyperv.c" and
> > make your subject line match the previous ones.
> >
> > > ---
> > >  drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
> > >  1 file changed, 17 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/host/pci-hyperv.c
> > > b/drivers/pci/host/pci-hyperv.c index a8deeca..4a37598 100644
> > > --- a/drivers/pci/host/pci-hyperv.c
> > > +++ b/drivers/pci/host/pci-hyperv.c
> > > @@ -348,6 +348,7 @@ enum hv_pcibus_state {
> > >  	hv_pcibus_init =3D 0,
> > >  	hv_pcibus_probed,
> > >  	hv_pcibus_installed,
> > > +	hv_pcibus_removed,
> > >  	hv_pcibus_maximum
> > >  };
> > >
> > > @@ -1481,13 +1482,24 @@ static void pci_devices_present_work(struct
> > work_struct *work)
> > >  		put_pcichild(hpdev, hv_pcidev_ref_initial);
> > >  	}
> > >
> > > -	/* Tell the core to rescan bus because there may have been changes.
> > */
> > > -	if (hbus->state =3D=3D hv_pcibus_installed) {
> > > +	switch (hbus->state) {
> > > +	case hv_pcibus_installed:
> > > +		/*
> > > +		 * Tell the core to rescan bus
> > > +		 * because there may have been changes.
> > > +		 */
> > >  		pci_lock_rescan_remove();
> > >  		pci_scan_child_bus(hbus->pci_bus);
> > >  		pci_unlock_rescan_remove();
> > > -	} else {
> > > +		break;
> > > +
> > > +	case hv_pcibus_init:
> > > +	case hv_pcibus_probed:
> > >  		survey_child_resources(hbus);
> > > +		break;
> > > +
> > > +	default:
> > > +		break;
> > >  	}
> > >
> > >  	up(&hbus->enum_sem);
> > > @@ -2163,6 +2175,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> > >  	hbus =3D kzalloc(sizeof(*hbus), GFP_KERNEL);
> > >  	if (!hbus)
> > >  		return -ENOMEM;
> > > +	hbus->state =3D hv_pcibus_init;
> > >
> > >  	/*
> > >  	 * The PCI bus "domain" is what is called "segment" in ACPI and @@
> > > -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device *hdev)
> > >  		pci_stop_root_bus(hbus->pci_bus);
> > >  		pci_remove_root_bus(hbus->pci_bus);
> > >  		pci_unlock_rescan_remove();
> > > +		hbus->state =3D hv_pcibus_removed;
> > >  	}
> > >
> > >  	ret =3D hv_send_resources_released(hdev);
> > > --
> > > 1.8.5.6
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > > info at
> >
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger.k
> > e
> > rnel.org%2Fmajordomo-
> >
> info.html&data=3D02%7C01%7Ckys%40microsoft.com%7C982492a275ed4126c4
> >
> d308d40a7644da%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6361
> >
> 44950466092469&sdata=3D9cXs6P1zoQ7qB%2BxYD9bsd%2BLMN%2BjwSPQkxnj
> > iqBdv9go%3D&reserved=3D0
