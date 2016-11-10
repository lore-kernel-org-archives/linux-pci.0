Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:15925
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965893AbcKJUCY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 15:02:24 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Hadden Hoppert <haddenh@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "apw@canonical.com" <apw@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] PCI: hv: use the correct buffer size in
 new_pcichild_device()
Date: Thu, 10 Nov 2016 16:27:17 +0000
Message-ID: <BLUPR0301MB1587B92E6F6478DB59F72E2AABB80@BLUPR0301MB1587.namprd03.prod.outlook.com>
References: <MWHPR03MB26695762E11D248A4181F43EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
In-Reply-To: <MWHPR03MB26695762E11D248A4181F43EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Dexuan Cui
> Sent: Wednesday, November 9, 2016 11:18 PM
> To: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> devel@linuxdriverproject.org
> Cc: gregkh@linuxfoundation.org; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; Jake Oshins <jakeo@microsoft.com>; Hadden
> Hoppert <haddenh@microsoft.com>; Vitaly Kuznetsov
> <vkuznets@redhat.com>; jasowang@redhat.com; apw@canonical.com;
> olaf@aepfle.de; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/3] PCI: hv: use the correct buffer size in
> new_pcichild_device()
>=20
> We don't really need such a big on-stack buffer.
> vmbus_sendpacket() here only uses sizeof(struct pci_child_message).
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> CC: Jake Oshins <jakeo@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>
> CC: Haiyang Zhang <haiyangz@microsoft.com>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.=
c
> index 763ff87..93ed64a 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1271,9 +1271,9 @@ static struct hv_pci_dev
> *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	struct hv_pci_dev *hpdev;
>  	struct pci_child_message *res_req;
>  	struct q_res_req_compl comp_pkt;
> -	union {
> -	struct pci_packet init_packet;
> -		u8 buffer[0x100];
> +	struct {
> +		struct pci_packet init_packet;
> +		u8 buffer[sizeof(struct pci_child_message)];
>  	} pkt;
>  	unsigned long flags;
>  	int ret;
> --
> 2.7.4

This change seems good to me, in that it's always a bad idea to use too muc=
h stack.  But this won't fix the problem with VMAP_STACK.  The buffer could=
 still end up spanning two pages and the physical addresses of those pages =
would possibly be discontiguous.  Do you want to just refactor this so that=
 it uses a fixed buffer, one that will work with VMAP_STACK?  Or is that co=
ming in a future patch?=20

-- Jake Oshins

