Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0132.outbound.protection.outlook.com ([104.47.33.132]:35493
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932084AbeCEXrf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 18:47:35 -0500
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Jack Morgenstein <jackm@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a
 new work when necessary
Date: Mon, 5 Mar 2018 23:47:32 +0000
Message-ID: <DM5PR2101MB10300B0494E43D69A20C86B3DCDA0@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180305192134.32207-1-decui@microsoft.com>
 <20180305192134.32207-6-decui@microsoft.com>
In-Reply-To: <20180305192134.32207-6-decui@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Dexuan Cui
> Sent: Monday, March 5, 2018 11:22 AM
> To: bhelgaas@google.com; linux-pci@vger.kernel.org; KY Srinivasan <kys@mi=
crosoft.com>;
> Stephen Hemminger <sthemmin@microsoft.com>; olaf@aepfle.de; apw@canonical=
.com;
> jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;=
 Haiyang Zhang
> <haiyangz@microsoft.com>; vkuznets@redhat.com; marcelo.cerri@canonical.co=
m; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Dexuan Cui <decui@microso=
ft.com>; Jack
> Morgenstein <jackm@mellanox.com>; stable@vger.kernel.org
> Subject: [PATCH v2 5/6] PCI: hv: hv_pci_devices_present(): only queue a n=
ew work when
> necessary
>=20
> If there is a pending work, we just need to add the new dr into
> the dr_list.
>=20
> This is suggested by Michael Kelley.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 3a385212f666..d3aa6736a9bb 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1733,6 +1733,7 @@ static void hv_pci_devices_present(struct hv_pcibus=
_device *hbus,
>  	struct hv_dr_state *dr;
>  	struct hv_dr_work *dr_wrk;
>  	unsigned long flags;
> +	bool pending_dr;
>=20
>  	dr_wrk =3D kzalloc(sizeof(*dr_wrk), GFP_NOWAIT);
>  	if (!dr_wrk)
> @@ -1756,11 +1757,23 @@ static void hv_pci_devices_present(struct hv_pcib=
us_device
> *hbus,
>  	}
>=20
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
> +
> +	/*
> +	 * If pending_dr is true, we have already queued a work,
> +	 * which will see the new dr. Otherwise, we need to
> +	 * queue a new work.
> +	 */
> +	pending_dr =3D !list_empty(&hbus->dr_list);
>  	list_add_tail(&dr->list_entry, &hbus->dr_list);
> -	spin_unlock_irqrestore(&hbus->device_list_lock, flags);

A minor point:  The spin_unlock_irqrestore() call can
stay here.   Once we have the list status in a local variable
and the new entry is added to the list, nothing bad can
happen if we drop the spin lock.   At worst, and very unlikely,
we'll queue work when some other thread has already queued
work to process the list entry, but that's no big deal.   I'd argue
for keeping the code covered by a spin lock as small as possible.

Michael

>=20
> -	get_hvpcibus(hbus);
> -	queue_work(hbus->wq, &dr_wrk->wrk);
> +	if (pending_dr) {
> +		kfree(dr_wrk);
> +	} else {
> +		get_hvpcibus(hbus);
> +		queue_work(hbus->wq, &dr_wrk->wrk);
> +	}
> +
> +	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  }
>=20
>  /**
> --
> 2.7.4
