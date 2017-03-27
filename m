Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0113.outbound.protection.outlook.com ([104.47.34.113]:26047
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751526AbdC0SOY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Mar 2017 14:14:24 -0400
From: Long Li <longli@microsoft.com>
To: KY Srinivasan <kys@microsoft.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] pci-hyperv: Fix an atomic bug
Date: Mon, 27 Mar 2017 18:14:01 +0000
Message-ID: <BN3PR03MB222767E990C6D37430F965D4CE330@BN3PR03MB2227.namprd03.prod.outlook.com>
References: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
 <1490378842-26950-3-git-send-email-kys@exchange.microsoft.com>
In-Reply-To: <1490378842-26950-3-git-send-email-kys@exchange.microsoft.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: devel [mailto:driverdev-devel-bounces@linuxdriverproject.org] On
> Behalf Of kys@exchange.microsoft.com
> Sent: Friday, March 24, 2017 11:07 AM
> To: helgaas@kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen
> Hemminger <sthemmin@microsoft.com>
> Cc: stable@vger.kernel.org
> Subject: [PATCH 2/2] pci-hyperv: Fix an atomic bug
>=20
> From: K. Y. Srinivasan <kys@microsoft.com>
>=20
> The memory allocation here needs to be non-blocking.
> Fix the issue.
>=20
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> Cc: <stable@vger.kernel.org>

Reviewed-by: Long Li <longli@microsoft.com>

> ---
>  drivers/pci/host/pci-hyperv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 32a16fb..85088a1 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -877,7 +877,7 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
>                 hv_int_desc_free(hpdev, int_desc);
>         }
>=20
> -       int_desc =3D kzalloc(sizeof(*int_desc), GFP_KERNEL);
> +       int_desc =3D kzalloc(sizeof(*int_desc), GFP_ATOMIC);
>         if (!int_desc)
>                 goto drop_reference;
>=20
> --
> 1.7.1
>=20
> _______________________________________________
> devel mailing list
> devel@linuxdriverproject.org
> http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
