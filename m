Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:58880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753454AbeCFS3c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Mar 2018 13:29:32 -0500
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
Subject: RE: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus
 test
Date: Tue, 6 Mar 2018 18:29:29 +0000
Message-ID: <DM5PR2101MB10300BF86C5FA9CC94B76182DCD90@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-3-decui@microsoft.com>
In-Reply-To: <20180306182128.23281-3-decui@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, March 6, 2018 10:22 AM
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
> Subject: [PATCH v3 2/6] PCI: hv: hv_eject_device_work(): remove the bogus=
 test
>=20
> When we're in the function, hpdev->state must be hv_pcichild_ejecting:
> see hv_pci_eject_device().
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 1233300f41c6..04edb24c92ee 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1796,10 +1796,7 @@ static void hv_eject_device_work(struct work_struc=
t *work)
>=20
>  	hpdev =3D container_of(work, struct hv_pci_dev, wrk);
>=20
> -	if (hpdev->state !=3D hv_pcichild_ejecting) {
> -		put_pcichild(hpdev, hv_pcidev_ref_pnp);
> -		return;
> -	}
> +	WARN_ON(hpdev->state !=3D hv_pcichild_ejecting);
>=20
>  	/*
>  	 * Ejection can come before or after the PCI bus has been set up, so
> --
> 2.7.4

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
