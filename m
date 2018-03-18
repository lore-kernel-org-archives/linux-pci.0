Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0107.outbound.protection.outlook.com ([104.47.42.107]:29664
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754230AbeCRWk6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Mar 2018 18:40:58 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Date: Sun, 18 Mar 2018 22:40:55 +0000
Message-ID: <DM5PR2101MB1030145AB251BF2F31FBA4BEDCD50@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
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
> Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with GFP_K=
ERNEL in
> hv_pci_onchannelcallback
>=20
> hv_pci_onchannelcallback() is not called in atomic context.
>=20
> The call chain ending up at hv_pci_onchannelcallback() is:
> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
> hv_pci_probe() is only set as ".probe" in hv_driver
> structure "hv_pci_drv".
>=20
> Despite never getting called from atomic context,

Not true.   hv_pci_probe() registers hv_pci_onchannelcallback() as
a callback function that is invoked from the VMbus interrupt handler.
So GFP_ATOMIC is appropriate.

Michael

> hv_pci_onchannelcallback() calls kmalloc with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL
> to avoid busy waiting.
>=20
> This is found by a static analysis tool named DCNS written by myself.
>=20
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 0fe3ea1..c5c8a99 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1887,7 +1887,7 @@ static void hv_pci_onchannelcallback(void *context)
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
>=20
> -	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
> +	buffer =3D kmalloc(bufferlen, GFP_KERNEL);
>  	if (!buffer)
>  		return;
>=20
> @@ -1899,7 +1899,7 @@ static void hv_pci_onchannelcallback(void *context)
>  			kfree(buffer);
>  			/* Handle large packet */
>  			bufferlen =3D bytes_recvd;
> -			buffer =3D kmalloc(bytes_recvd, GFP_ATOMIC);
> +			buffer =3D kmalloc(bytes_recvd, GFP_KERNEL);
>  			if (!buffer)
>  				return;
>  			continue;
> --
> 1.9.1
