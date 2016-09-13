Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Long Li <longli@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 2/2] pci-hyperv: properly handle device eject
Date: Tue, 13 Sep 2016 17:33:24 +0000
Message-ID: <BN3PR03MB22277BEB00D3BFE0C1C06F5ACEFE0@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1473724441-21207-1-git-send-email-longli@exchange.microsoft.com>
 <1473724441-21207-2-git-send-email-longli@exchange.microsoft.com>
 <MWHPR03MB2669F839E1B02D2A35D4FFE3BFFE0@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB2669F839E1B02D2A35D4FFE3BFFE0@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, September 13, 2016 2:51 AM
> To: Long Li <longli@microsoft.com>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Bjorn Helgaas
> <bhelgaas@google.com>
> Cc: devel@linuxdriverproject.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org
> Subject: RE: [PATCH 2/2] pci-hyperv: properly handle device eject
>=20
> > From: devel [mailto:driverdev-devel-bounces@linuxdriverproject.org] On
> > Behalf Of Long Li
> > Sent: Tuesday, September 13, 2016 7:54 ...
> > A PCI_EJECT message can arrive at the same time we are calling
> > pci_scan_child_bus in the workqueue for the previous
> PCI_BUS_RELATIONS
> > message, in this case we could potentailly modify the bus from two plac=
es.
> > Properly lock the bus access.
> >
> > --- a/drivers/pci/host/pci-hyperv.c
> > +++ b/drivers/pci/host/pci-hyperv.c
> > @@ -1587,7 +1587,7 @@ static void hv_eject_device_work(struct
> > work_struct
> > *work)
> >         pdev =3D pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domai=
n,
> 0,
> >                                            wslot);
> >         if (pdev) {
> > -               pci_stop_and_remove_bus_device(pdev);
> > +               pci_stop_and_remove_bus_device_locked(pdev);
> >                 pci_dev_put(pdev);
> >         }
>=20
> The _locked version tries to get the mutex pci_rescan_remove_lock.
>=20
> But it looks pci_scan_child_bus() doesn't try to get the mutex(?), so how=
 can
> this patch make sure the 2 code paths are not running simultaneously?

Thanks for the review.

The lock is to protect the following call to pci_scan_child_bus() in pci_de=
vices_present_work():

                /*
                 * Tell the core to rescan bus
                 * because there may have been changes.
                 */
                pci_lock_rescan_remove();
                pci_scan_child_bus(hbus->pci_bus);
                pci_unlock_rescan_remove();

This race condition has shown up in the tests.

You raised a valid concern in create_root_hv_pci_bus(). There might be anot=
her race condition there. I'll look into this.

>=20
> Thanks,
> -- Dexuan
