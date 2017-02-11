Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Resend PATCH 1/2 v3] pci-hyperv: properly handle pci bus remove
Date: Sat, 11 Feb 2017 01:18:23 +0000
Message-ID: <BN3PR03MB222777D21F0DAA735ADAE5CFCE470@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1485236721-27620-1-git-send-email-longli@exchange.microsoft.com>
 <DM5PR03MB2490322EC48F7332D9ED3CB7A0760@DM5PR03MB2490.namprd03.prod.outlook.com>
In-Reply-To: <DM5PR03MB2490322EC48F7332D9ED3CB7A0760@DM5PR03MB2490.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

This patch and the other one in the series ([Resend PATCH 2/2 v3] pci-hyper=
v: lock pci bus on device eject) have been Acked.

Is there anything else should be done before it can be merged? Please let m=
e know.

Thanks

Long

> -----Original Message-----
> From: KY Srinivasan
> Sent: Friday, January 27, 2017 10:42 AM
> To: Long Li <longli@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>
> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Long Li <longli@microsoft.com>
> Subject: RE: [Resend PATCH 1/2 v3] pci-hyperv: properly handle pci bus
> remove
>=20
>=20
>=20
> > -----Original Message-----
> > From: Long Li [mailto:longli@exchange.microsoft.com]
> > Sent: Monday, January 23, 2017 9:45 PM
> > To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>
> > Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Long Li <longli@microsoft.com>
> > Subject: [Resend PATCH 1/2 v3] pci-hyperv: properly handle pci bus
> > remove
> >
> > [This sender failed our fraud detection checks and may not be who they
> > appear to be. Learn about spoofing at
> > http://aka.ms/LearnAboutSpoofing]
> >
> > From: Long Li <longli@microsoft.com>
> >
> > hv_pci_devices_present is called in hv_pci_remove when we remove a PCI
> > device from host (e.g. by disabling SRIOV on a device). In
> > hv_pci_remove, the bus is already removed before the call, so we don't
> > need to rescan the bus in the workqueue scheduled from
> > hv_pci_devices_present. By introducing status hv_pcibus_removed, we
> can avoid this situation.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
> >  drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-hyperv.c
> > b/drivers/pci/host/pci-hyperv.c index a8deeca..4a37598 100644
> > --- a/drivers/pci/host/pci-hyperv.c
> > +++ b/drivers/pci/host/pci-hyperv.c
> > @@ -348,6 +348,7 @@ enum hv_pcibus_state {
> >         hv_pcibus_init =3D 0,
> >         hv_pcibus_probed,
> >         hv_pcibus_installed,
> > +       hv_pcibus_removed,
> >         hv_pcibus_maximum
> >  };
> >
> > @@ -1481,13 +1482,24 @@ static void pci_devices_present_work(struct
> > work_struct *work)
> >                 put_pcichild(hpdev, hv_pcidev_ref_initial);
> >         }
> >
> > -       /* Tell the core to rescan bus because there may have been chan=
ges.
> */
> > -       if (hbus->state =3D=3D hv_pcibus_installed) {
> > +       switch (hbus->state) {
> > +       case hv_pcibus_installed:
> > +               /*
> > +                * Tell the core to rescan bus
> > +                * because there may have been changes.
> > +                */
> >                 pci_lock_rescan_remove();
> >                 pci_scan_child_bus(hbus->pci_bus);
> >                 pci_unlock_rescan_remove();
> > -       } else {
> > +               break;
> > +
> > +       case hv_pcibus_init:
> > +       case hv_pcibus_probed:
> >                 survey_child_resources(hbus);
> > +               break;
> > +
> > +       default:
> > +               break;
> >         }
> >
> >         up(&hbus->enum_sem);
> > @@ -2163,6 +2175,7 @@ static int hv_pci_probe(struct hv_device *hdev,
> >         hbus =3D kzalloc(sizeof(*hbus), GFP_KERNEL);
> >         if (!hbus)
> >                 return -ENOMEM;
> > +       hbus->state =3D hv_pcibus_init;
> >
> >         /*
> >          * The PCI bus "domain" is what is called "segment" in ACPI
> > and @@ -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device
> *hdev)
> >                 pci_stop_root_bus(hbus->pci_bus);
> >                 pci_remove_root_bus(hbus->pci_bus);
> >                 pci_unlock_rescan_remove();
> > +               hbus->state =3D hv_pcibus_removed;
> >         }
> >
> >         ret =3D hv_send_resources_released(hdev);
> > --
> > 1.8.5.6
