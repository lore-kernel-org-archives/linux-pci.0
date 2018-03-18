Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0104.outbound.protection.outlook.com ([104.47.40.104]:7296
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754301AbeCRWmD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Mar 2018 18:42:03 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in new_pcichild_device
Date: Sun, 18 Mar 2018 22:42:00 +0000
Message-ID: <DM5PR2101MB10305A8292BCC1F75AC578C3DCD50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1521384808-23627-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf
> Of Jia-Ju Bai
> Sent: Sunday, March 18, 2018 7:53 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.=
com>; Stephen
> Hemminger <sthemmin@microsoft.com>; bhelgaas@google.com
> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-kernel=
@vger.kernel.org;
> Jia-Ju Bai <baijiaju1990@gmail.com>
> Subject: [PATCH 2/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_K=
ERNEL in
> new_pcichild_device
>=20
> new_pcichild_device() is not called in atomic context.
>=20
> The call chain ending up at new_pcichild_device() is:
> [1] new_pcichild_device() <- pci_devices_present_work()
> pci_devices_present_work() is only set in INIT_WORK().
>=20
> Despite never getting called from atomic context,
> new_pcichild_device() calls kzalloc with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL
> to avoid busy waiting.
>=20
> This is found by a static analysis tool named DCNS written by myself.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> ---
>  drivers/pci/host/pci-hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 0fe3ea1..289e31d 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1500,7 +1500,7 @@ static struct hv_pci_dev *new_pcichild_device(struc=
t
> hv_pcibus_device *hbus,
>  	unsigned long flags;
>  	int ret;
>=20
> -	hpdev =3D kzalloc(sizeof(*hpdev), GFP_ATOMIC);
> +	hpdev =3D kzalloc(sizeof(*hpdev), GFP_KERNEL);
>  	if (!hpdev)
>  		return NULL;
>=20
> --
> 1.9.1
