Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pu1apc01on0122.outbound.protection.outlook.com ([104.47.126.122]:13753
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751144AbeCEFLv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 00:11:51 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Date: Mon, 5 Mar 2018 05:11:35 +0000
Message-ID: <KL1P15301MB0006F7C015D8D113FC2ACD1DBFDA0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180303001947.20564-1-decui@microsoft.com>
 <20180303001947.20564-2-decui@microsoft.com>
 <DM5PR2101MB1030BC8E7A263D65A1A64B26DCC40@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB1030BC8E7A263D65A1A64B26DCC40@DM5PR2101MB1030.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Michael Kelley (EOSG)
> Sent: Saturday, March 3, 2018 08:10
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-
> owner@vger.kernel.org> On Behalf Of Dexuan Cui
> > Sent: Friday, March 2, 2018 4:21 PM
> > When we hot-remove the device, we first receive a PCI_EJECT message and
> > then receive a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=
=3D
> 0.
> >
> > The first message is offloaded to hv_eject_device_work(), and the secon=
d
> > is offloaded to pci_devices_present_work(). Both the paths can be runni=
ng
> > list_del(&hpdev->list_entry), causing general protection fault, because
> > system_wq can run them concurrently.
> >
> > The patch eliminates the race condition.
>=20
> With this patch, the enum_sem field in struct hv_pcibus_device
> is no longer needed.  The semaphore serializes execution in
> hv_pci_devices_present_work(), and that serialization is now done
> with the ordered workqueue.  Also, the last paragraph of the top level
> comment for hv_pci_devices_present_work() should be updated to
> reflect the new ordering assumptions.

Thanks! I'll make an extra patch for this.

> Separately, an unrelated bug:  At the top of hv_eject_device_work(),
> the first test may do a put_pcichild() and return.  This exit path also
> needs to do put_hvpcibus() to balance the ref counts, or do a goto
> the last two lines at the bottom of the function.

When we're in hv_eject_device_work(), IMO hpdev->state must be=20
hv_pcichild_ejecting, so I'm going to make a patch like this:

@@ -1867,10 +1867,7 @@ static void hv_eject_device_work(struct work_struct =
*work)

        hpdev =3D container_of(work, struct hv_pci_dev, wrk);

-       if (hpdev->state !=3D hv_pcichild_ejecting) {
-               put_pcichild(hpdev, hv_pcidev_ref_pnp);
-               return;
-       }
+       WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);

        /*
         * Ejection can come before or after the PCI bus has been set up, s=
o
=20
> > @@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct
> hv_pcibus_device *hbus,
> >  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >
> >  	get_hvpcibus(hbus);
> > -	schedule_work(&dr_wrk->wrk);
> > +	queue_work(hbus->wq, &dr_wrk->wrk);
>=20
> This invocation of get_hvpcibus() and queue_work() could be made
> conditional on whether the preceding list_add_tail() transitioned
> the list from empty to non-empty.  If the list was already non-empty,
> a previously queued invocation of hv_pci_devices_present_work()
> will find the new entry and process it.   But this is an
> optimization in a non-perf sensitive code path, so may not be
> worth it.

Exactly. I'll add the the optimization.

> > @@ -1848,7 +1850,7 @@ static void hv_pci_eject_device(struct hv_pci_dev
> *hpdev)
> >  	get_pcichild(hpdev, hv_pcidev_ref_pnp);
> >  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
> >  	get_hvpcibus(hpdev->hbus);
> > -	schedule_work(&hpdev->wrk);
> > +	queue_work(hpdev->hbus->wq, &hpdev->wrk);
> >  }
> >
> >  /**
> > @@ -2463,11 +2465,17 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
> >  	sema_init(&hbus->enum_sem, 1);
> >  	init_completion(&hbus->remove_event);
> > +	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
> > +					   hbus->sysdata.domain);
> > +	if (!hbus->wq) {
> > +		ret =3D -ENOMEM;
> > +		goto free_bus;
> > +	}
> >
> >  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL,=
 0,
> >  			 hv_pci_onchannelcallback, hbus);
> >  	if (ret)
> > -		goto free_bus;
> > +		goto destroy_wq;
> >
> >  	hv_set_drvdata(hdev, hbus);
> >
> > @@ -2536,6 +2544,9 @@ static int hv_pci_probe(struct hv_device *hdev,
> >  	hv_free_config_window(hbus);
> >  close:
> >  	vmbus_close(hdev->channel);
> > +destroy_wq:
> > +	drain_workqueue(hbus->wq);
>=20
> The drain_workqueue() call isn't necessary.  destroy_workqueue() calls
> drain_workqueue() and there better not be anything in the workqueue
> anyway since all the ref counts are zero.

OK. Will remove it.

> > +	destroy_workqueue(hbus->wq);
> >  free_bus:
> >  	free_page((unsigned long)hbus);
> >  	return ret;
> > @@ -2615,6 +2626,8 @@ static int hv_pci_remove(struct hv_device *hdev)
> >  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
> >  	put_hvpcibus(hbus);
> >  	wait_for_completion(&hbus->remove_event);
> > +	drain_workqueue(hbus->wq);
>=20
> Same here -- drain_workqueue() isn't needed.  The workqueue
> must be empty anyway since the remove_event has completed
> and the ref counts will all be zero.

Will remove it.

> > +	destroy_workqueue(hbus->wq);

I'm going to post a v2 patchset tomorrow.

Thanks,
-- Dexuan
