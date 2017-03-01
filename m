Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0070.outbound.protection.outlook.com ([104.47.32.70]:39949
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752144AbdCAX2m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Mar 2017 18:28:42 -0500
From: "Madhani, Himanshu" <Himanshu.Madhani@cavium.com>
To: Christoph Hellwig <hch@lst.de>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH] PCI/MSI: Only disable affinity settings if pre and post
 vector count is equal to max_vecs and not min_vecs
Date: Wed, 1 Mar 2017 23:27:56 +0000
Message-ID: <SN1PR0701MB18371313B1C1AAE90B12169BF5290@SN1PR0701MB1837.namprd07.prod.outlook.com>
References: <1487883699-3528-1-git-send-email-himanshu.madhani@cavium.com>
 <20170301152056.GA12708@lst.de>
In-Reply-To: <20170301152056.GA12708@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Wednesday, March 1, 2017 7:21 AM
> To: Madhani, Himanshu <Himanshu.Madhani@cavium.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; hch@lst.de
> Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and p=
ost
> vector count is equal to max_vecs and not min_vecs
>=20
> > @@ -1206,16 +1228,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_de=
v
> *dev, unsigned int min_vecs,
> >  	if (flags & PCI_IRQ_AFFINITY) {
> >  		if (!affd)
> >  			affd =3D &msi_default_affd;
> > -
> > -		if (affd->pre_vectors + affd->post_vectors > min_vecs)
> > -			return -EINVAL;
>=20
> Actually I think we can leave this check here.
>=20
> > -
> > -		/*
> > -		 * If there aren't any vectors left after applying the pre/post
> > -		 * vectors don't bother with assigning affinity.
> > -		 */
> > -		if (affd->pre_vectors + affd->post_vectors =3D=3D min_vecs)
> > -			affd =3D NULL;
>=20
> And only move this one down into the allocator helpers.

Will send out update soon.=20

Thanks,
Himanshu
