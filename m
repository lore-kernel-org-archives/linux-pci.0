Return-Path: <linux-kernel-owner@vger.kernel.org>
From: KY Srinivasan <kys@microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Long Li <longli@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Long Li <longli@microsoft.com>
Subject: RE: [PATCH 1/2 v2] pci-hyperv: properly handle pci bus remove
Date: Tue, 4 Oct 2016 14:32:05 +0000
Message-ID: <DM5PR03MB2490B89BBA7DC75FF2FA8986A0C50@DM5PR03MB2490.namprd03.prod.outlook.com>
References: <1473905402-2375-1-git-send-email-longli@exchange.microsoft.com>
 <20160927192935.GB14642@localhost>
In-Reply-To: <20160927192935.GB14642@localhost>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> Sent: Tuesday, September 27, 2016 12:30 PM
> To: Long Li <longli@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Bjorn Helgaas <bhelgaas@google.com>;
> devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Long Li <longli@microsoft.com>
> Subject: Re: [PATCH 1/2 v2] pci-hyperv: properly handle pci bus remove
>=20
> On Wed, Sep 14, 2016 at 07:10:01PM -0700, Long Li wrote:
> > From: Long Li <longli@microsoft.com>
> >
> > hv_pci_devices_present is called in hv_pci_remove when we remove a PCI
> device from host (e.g. by disabling SRIOV on a device). In hv_pci_remove,
> the bus is already removed before the call, so we don't need to rescan th=
e
> bus in the workqueue scheduled from hv_pci_devices_present. By
> introducing status hv_pcibus_removed, we can avoid this situation.
> >
> > The patch fixes the following kernel panic.
> >
> > [  383.853124] Workqueue: events pci_devices_present_work [pci_hyperv]
> > [  383.853124] task: ffff88007f5f8000 ti: ffff88007f600000 task.ti:
> > ffff88007f600000
> > [  383.853124] RIP: 0010:[<ffffffff81349806>]  [<ffffffff81349806>]
> > pci_is_pcie+0x6/0x20
> > [  383.853124] RSP: 0018:ffff88007f603d38  EFLAGS: 00010206
> > [  383.853124] RAX: ffff88007f5f8000 RBX: 642f3d4854415056 RCX:
> > ffff88007f603fd8
> > [  383.853124] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 642f3d4854415056
> > [  383.853124] RBP: ffff88007f603d68 R08: 0000000000000246 R09:
> > ffffffffa045eb9e
> > [  383.853124] R10: ffff88007b419a80 R11: ffffea0001c0ef40 R12:
> > ffff880003ee1c00
> > [  383.853124] R13: 63702f30303a3137 R14: 0000000000000000 R15:
> > 0000000000000246
> > [  383.853124] FS:  0000000000000000(0000) GS:ffff88007b400000(0000)
> > knlGS:0000000000000000
> > [  383.853124] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  383.853124] CR2: 00007f68b3f52350 CR3: 0000000003546000 CR4:
> > 00000000000406f0
> > [  383.853124] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [  383.853124] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> > 0000000000000400
> > [  383.853124] Stack:
> > [  383.853124]  ffff88007f603d68 ffffffff8134db17 0000000000000008
> > ffff880003ee1c00
> > [  383.853124]  63702f30303a3137 ffff880003d8edb8 ffff88007f603da0
> > ffffffff8134ee2d
> > [  383.853124]  ffff880003d8ed00 ffff88007f603dd8 ffff880075fec320
> > ffff880003d8edb8
> > [  383.853124] Call Trace:
> > [  383.853124]  [<ffffffff8134db17>] ? pci_scan_slot+0x27/0x140
> > [  383.853124]  [<ffffffff8134ee2d>] pci_scan_child_bus+0x3d/0x150
> > [  383.853124]  [<ffffffffa045ef5a>]
> > pci_devices_present_work+0x3ea/0x400 [pci_hyperv]
> > [  383.853124]  [<ffffffff810a682b>] process_one_work+0x17b/0x470
> > [  383.853124]  [<ffffffff810a7666>] worker_thread+0x126/0x410
> > [  383.853124]  [<ffffffff810a7540>] ? rescuer_thread+0x460/0x460
> > [  383.853124]  [<ffffffff810aee1f>] kthread+0xcf/0xe0
> > [  383.853124]  [<ffffffff810aed50>] ?
> > kthread_create_on_node+0x140/0x140
> > [  383.853124]  [<ffffffff81699958>] ret_from_fork+0x58/0x90
> > [  383.853124]  [<ffffffff810aed50>] ?
> > kthread_create_on_node+0x140/0x140
> > [  383.853124] Code: 89 e5 5d 25 f0 00 00 00 c1 f8 04 c3 66 0f 1f 84 00
> > 00 00 00 00 66 66 66 66 90 55 0f b6 47 4a 48 89 e5 5d c3 90 66 66 66 66
> > 90 55 <80> 7f 4a 00 48 89 e5 5d 0f 95 c0 c3 0f 1f 40 00 66 2e 0f 1f 84
> > [  383.853124] RIP  [<ffffffff81349806>] pci_is_pcie+0x6/0x20
> > [  383.853124]  RSP <ffff88007f603d38>
>=20
> Personally, I would remove the timestamps and addresses from this trace
> because I don't think they contribute to diagnosing the problem.
>=20
> > Signed-off-by: Long Li <longli@microsoft.com>

Acked-by: KY Srinivasan <kys@microsoft.com>

Thanks,

K. Y
>=20
> I'm ready to apply these but am waiting for an ack from the maintainers
> listed in MAINTAINERS (feel free to update that if it's out of date).
>=20
> > ---
> >  drivers/pci/host/pci-hyperv.c | 20 +++++++++++++++++---
> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyper=
v.c
> > index a8deeca..4a37598 100644
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
> >  	 * The PCI bus "domain" is what is called "segment" in ACPI and
> > @@ -2305,6 +2318,7 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  		pci_stop_root_bus(hbus->pci_bus);
> >  		pci_remove_root_bus(hbus->pci_bus);
> >  		pci_unlock_rescan_remove();
> > +		hbus->state =3D hv_pcibus_removed;
> >  	}
> >
> >  	ret =3D hv_send_resources_released(hdev);
> > --
> > 1.8.5.6
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at
> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fvger.ke
> rnel.org%2Fmajordomo-
> info.html&data=3D01%7C01%7Ckys%40microsoft.com%7C16b06c0f0b744cc493c
> c08d3e70ca23f%7C72f988bf86f141af91ab2d7cd011db47%7C1&sdata=3DmdY6Lg
> az4D1S360p7orMYAHz6MfpVEp%2F412G2aBUHPw%3D&reserved=3D0
