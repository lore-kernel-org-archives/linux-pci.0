Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0112.outbound.protection.outlook.com ([104.47.40.112]:36512
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754383AbeCSCwL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Mar 2018 22:52:11 -0400
From: KY Srinivasan <kys@microsoft.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
 GFP_KERNEL in hv_pci_onchannelcallback
Date: Mon, 19 Mar 2018 02:52:08 +0000
Message-ID: <SN6PR2101MB0893202C038AB406C6A6546BA0D40@SN6PR2101MB0893.namprd21.prod.outlook.com>
References: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
In-Reply-To: <1521384782-23539-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> -----Original Message-----
> From: Jia-Ju Bai <baijiaju1990@gmail.com>
> Sent: Sunday, March 18, 2018 7:53 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; bhelgaas@google.com
> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jia-Ju Bai <baijiaju1990@gmail.com>
> Subject: [PATCH 1/2] pci: host: pci-hyperv: Replace GFP_ATOMIC with
> GFP_KERNEL in hv_pci_onchannelcallback
>=20
> hv_pci_onchannelcallback() is not called in atomic context.
>=20
> The call chain ending up at hv_pci_onchannelcallback() is:
> [1] hv_pci_onchannelcallback() <- hv_pci_probe()
> hv_pci_probe() is only set as ".probe" in hv_driver
> structure "hv_pci_drv".

This function is setup as the function to handle interrupts on the channel.=
 Hence the
need for GFP_ATOMIC.

K. Y
>=20
> Despite never getting called from atomic context,
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
> @@ -1887,7 +1887,7 @@ static void hv_pci_onchannelcallback(void
> *context)
>  	struct pci_dev_incoming *dev_message;
>  	struct hv_pci_dev *hpdev;
>=20
> -	buffer =3D kmalloc(bufferlen, GFP_ATOMIC);
> +	buffer =3D kmalloc(bufferlen, GFP_KERNEL);
>  	if (!buffer)
>  		return;
>=20
> @@ -1899,7 +1899,7 @@ static void hv_pci_onchannelcallback(void
> *context)
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
