Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:22304
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932111AbeCCQJt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 3 Mar 2018 11:09:49 -0500
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
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
        Dexuan Cui <decui@microsoft.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/3] PCI: hv: serialize the present/eject work items
Date: Sat, 3 Mar 2018 16:09:46 +0000
Message-ID: <DM5PR2101MB1030BC8E7A263D65A1A64B26DCC40@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180303001947.20564-1-decui@microsoft.com>
 <20180303001947.20564-2-decui@microsoft.com>
In-Reply-To: <20180303001947.20564-2-decui@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf
> Of Dexuan Cui
> Sent: Friday, March 2, 2018 4:21 PM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan <kys@mi=
crosoft.com>;
> Stephen Hemminger <sthemmin@microsoft.com>
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;=
 Haiyang Zhang
> <haiyangz@microsoft.com>; olaf@aepfle.de; apw@canonical.com; jasowang@red=
hat.com;
> vkuznets@redhat.com; marcelo.cerri@canonical.com; Dexuan Cui <decui@micro=
soft.com>;
> Jack Morgenstein <jackm@mellanox.com>; stable@vger.kernel.org
> Subject: [PATCH 2/3] PCI: hv: serialize the present/eject work items
>=20
> When we hot-remove the device, we first receive a PCI_EJECT message and
> then receive a PCI_BUS_RELATIONS message with bus_rel->device_count =3D=
=3D 0.
>=20
> The first message is offloaded to hv_eject_device_work(), and the second
> is offloaded to pci_devices_present_work(). Both the paths can be running
> list_del(&hpdev->list_entry), causing general protection fault, because
> system_wq can run them concurrently.
>=20
> The patch eliminates the race condition.

With this patch, the enum_sem field in struct hv_pcibus_device
is no longer needed.  The semaphore serializes execution in
hv_pci_devices_present_work(), and that serialization is now done
with the ordered workqueue.  Also, the last paragraph of the top level
comment for hv_pci_devices_present_work() should be updated to
reflect the new ordering assumptions.

Separately, an unrelated bug:  At the top of hv_eject_device_work(),
the first test may do a put_pcichild() and return.  This exit path also
needs to do put_hvpcibus() to balance the ref counts, or do a goto
the last two lines at the bottom of the function.

>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 1233300f41c6..57b1fb3ebdb9 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -461,6 +461,8 @@ struct hv_pcibus_device {
>  	struct retarget_msi_interrupt retarget_msi_interrupt_params;
>=20
>  	spinlock_t retarget_msi_interrupt_lock;
> +
> +	struct workqueue_struct *wq;
>  };
>=20
>  /*
> @@ -1770,7 +1772,7 @@ static void hv_pci_devices_present(struct hv_pcibus=
_device *hbus,
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>=20
>  	get_hvpcibus(hbus);
> -	schedule_work(&dr_wrk->wrk);
> +	queue_work(hbus->wq, &dr_wrk->wrk);

This invocation of get_hvpcibus() and queue_work() could be made
conditional on whether the preceding list_add_tail() transitioned
the list from empty to non-empty.  If the list was already non-empty,
a previously queued invocation of hv_pci_devices_present_work()
will find the new entry and process it.   But this is an
optimization in a non-perf sensitive code path, so may not be
worth it.

>  }
>=20
>  /**
> @@ -1848,7 +1850,7 @@ static void hv_pci_eject_device(struct hv_pci_dev *=
hpdev)
>  	get_pcichild(hpdev, hv_pcidev_ref_pnp);
>  	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
>  	get_hvpcibus(hpdev->hbus);
> -	schedule_work(&hpdev->wrk);
> +	queue_work(hpdev->hbus->wq, &hpdev->wrk);
>  }
>=20
>  /**
> @@ -2463,11 +2465,17 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
>  	sema_init(&hbus->enum_sem, 1);
>  	init_completion(&hbus->remove_event);
> +	hbus->wq =3D alloc_ordered_workqueue("hv_pci_%x", 0,
> +					   hbus->sysdata.domain);
> +	if (!hbus->wq) {
> +		ret =3D -ENOMEM;
> +		goto free_bus;
> +	}
>=20
>  	ret =3D vmbus_open(hdev->channel, pci_ring_size, pci_ring_size, NULL, 0=
,
>  			 hv_pci_onchannelcallback, hbus);
>  	if (ret)
> -		goto free_bus;
> +		goto destroy_wq;
>=20
>  	hv_set_drvdata(hdev, hbus);
>=20
> @@ -2536,6 +2544,9 @@ static int hv_pci_probe(struct hv_device *hdev,
>  	hv_free_config_window(hbus);
>  close:
>  	vmbus_close(hdev->channel);
> +destroy_wq:
> +	drain_workqueue(hbus->wq);

The drain_workqueue() call isn't necessary.  destroy_workqueue() calls
drain_workqueue() and there better not be anything in the workqueue
anyway since all the ref counts are zero.

> +	destroy_workqueue(hbus->wq);
>  free_bus:
>  	free_page((unsigned long)hbus);
>  	return ret;
> @@ -2615,6 +2626,8 @@ static int hv_pci_remove(struct hv_device *hdev)
>  	irq_domain_free_fwnode(hbus->sysdata.fwnode);
>  	put_hvpcibus(hbus);
>  	wait_for_completion(&hbus->remove_event);
> +	drain_workqueue(hbus->wq);

Same here -- drain_workqueue() isn't needed.  The workqueue
must be empty anyway since the remove_event has completed
and the ref counts will all be zero.

> +	destroy_workqueue(hbus->wq);
>  	free_page((unsigned long)hbus);
>  	return 0;
>  }
> --
> 2.7.4
