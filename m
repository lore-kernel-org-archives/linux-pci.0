Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0093.outbound.protection.outlook.com ([104.47.34.93]:61216
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935238AbcKJQwf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Nov 2016 11:52:35 -0500
From: Dexuan Cui <decui@microsoft.com>
To: Jake Oshins <jakeo@microsoft.com>,
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
Date: Thu, 10 Nov 2016 16:52:31 +0000
Message-ID: <MWHPR03MB26690DD8D1756E3202D27820BFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <MWHPR03MB26695762E11D248A4181F43EBFB80@MWHPR03MB2669.namprd03.prod.outlook.com>
 <BLUPR0301MB1587B92E6F6478DB59F72E2AABB80@BLUPR0301MB1587.namprd03.prod.outlook.com>
In-Reply-To: <BLUPR0301MB1587B92E6F6478DB59F72E2AABB80@BLUPR0301MB1587.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> From: Jake Oshins
> > From: Dexuan Cui
> > Sent: Wednesday, November 9, 2016 11:18 PM
> > We don't really need such a big on-stack buffer.
> > vmbus_sendpacket() here only uses sizeof(struct pci_child_message).
> >
> > @@ -1271,9 +1271,9 @@ static struct hv_pci_dev
> > *new_pcichild_device(struct hv_pcibus_device *hbus,
> >  	struct hv_pci_dev *hpdev;
> >  	struct pci_child_message *res_req;
> >  	struct q_res_req_compl comp_pkt;
> > -	union {
> > -	struct pci_packet init_packet;
> > -		u8 buffer[0x100];
> > +	struct {
> > +		struct pci_packet init_packet;
> > +		u8 buffer[sizeof(struct pci_child_message)];
> >  	} pkt;
> >  	unsigned long flags;
> >  	int ret;
>=20
> This change seems good to me, in that it's always a bad idea to use too m=
uch
> stack.  But this won't fix the problem with VMAP_STACK.  The buffer could=
 still
> end up spanning two pages and the physical addresses of those pages would
> possibly be discontiguous.  Do you want to just refactor this so that it =
uses a
> fixed buffer, one that will work with VMAP_STACK?  Or is that coming in a=
 future
> patch?

Hi Jake, I think the VMAP_STACK issue you mentioned should be another diffe=
rent
issue fixed by Long Li: https://patchwork.ozlabs.org/patch/692447/.=20

The VMAP_STACK issue is only an issue when we pass the buffer's physical ad=
dress
to the hypercall.

Here the buffer is not passed to any hypercall. We just use vmbus_sendpacke=
t()
to memcpy the buffer into the per-channel ringbuffer.

Thanks,
-- Dexuan
