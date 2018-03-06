Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pu1apc01on0099.outbound.protection.outlook.com ([104.47.126.99]:40736
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932885AbeCFAR0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Mar 2018 19:17:26 -0500
From: Dexuan Cui <decui@microsoft.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
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
Date: Tue, 6 Mar 2018 00:17:06 +0000
Message-ID: <KL1P15301MB00062E5D982DC248708DF286BFD90@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180305192134.32207-1-decui@microsoft.com>
 <20180305192134.32207-6-decui@microsoft.com>
 <DM5PR2101MB10300B0494E43D69A20C86B3DCDA0@DM5PR2101MB1030.namprd21.prod.outlook.com>
In-Reply-To: <DM5PR2101MB10300B0494E43D69A20C86B3DCDA0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Michael Kelley (EOSG)
> Sent: Monday, March 5, 2018 15:48
> > @@ -1756,11 +1757,23 @@ static void hv_pci_devices_present(struct
> hv_pcibus_device
> > *hbus,
> >  	}
> >
> >  	spin_lock_irqsave(&hbus->device_list_lock, flags);
> > +
> > +	/*
> > +	 * If pending_dr is true, we have already queued a work,
> > +	 * which will see the new dr. Otherwise, we need to
> > +	 * queue a new work.
> > +	 */
> > +	pending_dr =3D !list_empty(&hbus->dr_list);
> >  	list_add_tail(&dr->list_entry, &hbus->dr_list);
> > -	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>=20
> A minor point:  The spin_unlock_irqrestore() call can
> stay here.   Once we have the list status in a local variable
> and the new entry is added to the list, nothing bad can
> happen if we drop the spin lock.   At worst, and very unlikely,
> we'll queue work when some other thread has already queued
> work to process the list entry, but that's no big deal.   I'd argue
> for keeping the code covered by a spin lock as small as possible.
>=20
> Michael

I agree.  Will fix this in v3.

> >
> > -	get_hvpcibus(hbus);
> > -	queue_work(hbus->wq, &dr_wrk->wrk);
> > +	if (pending_dr) {
> > +		kfree(dr_wrk);
> > +	} else {
> > +		get_hvpcibus(hbus);
> > +		queue_work(hbus->wq, &dr_wrk->wrk);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
> >  }

To receive more comments from others,  I'll hold off v3 until tomorrow.

Thanks,
-- Dexuan
