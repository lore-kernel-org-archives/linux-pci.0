Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db5eur01on0083.outbound.protection.outlook.com ([104.47.2.83]:29616
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932282AbcKIPZT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Nov 2016 10:25:19 -0500
From: Ilya Lesokhin <ilyal@mellanox.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Adi Menachem <adim@mellanox.com>
Subject: RE: Shouldn't VFIO virtualize the ATS capability?
Date: Wed, 9 Nov 2016 15:25:16 +0000
Message-ID: <VI1PR0502MB2957CCD1E8EE93A3BC6CE178D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
References: <VI1PR0502MB295799E38EEC9E1F939B68B5D4A40@VI1PR0502MB2957.eurprd05.prod.outlook.com>
        <20161106100832.41e173d5@t450s.home>
        <VI1PR0502MB29579BD9AA9A2E85288798E4D4B90@VI1PR0502MB2957.eurprd05.prod.outlook.com>
 <20161109080746.24dd79dd@t450s.home>
In-Reply-To: <20161109080746.24dd79dd@t450s.home>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, November 09, 2016 5:08 PM
> To: Ilya Lesokhin <ilyal@mellanox.com>
> Cc: linux-pci@vger.kernel.org; kvm@vger.kernel.org; bhelgaas@google.com;
> Adi Menachem <adim@mellanox.com>
> Subject: Re: Shouldn't VFIO virtualize the ATS capability?
>=20
> On Wed, 9 Nov 2016 14:49:02 +0000
> Ilya Lesokhin <ilyal@mellanox.com> wrote:
>=20
> > I would virtualize the "ATS Control Register".
>=20
> And do what?
I think it should be read only.
>=20
> > Regarding poor behavior, I couldn't really find what happens when ATS i=
s
> misconfigured, but I would assume it can cause problems.
> > The scenarios I'm concerned about are:
> > 	1. The guest enables translation caching, while the hypervisor thinks
> there are disabled -> Hypervisor won't issue invalidations.
>=20
> Aren't invalidations issued by the iommu, why does the hypervisor need to
> participate?  How would a software entity induce an invalidation?
That's what one might expect from a sane design, but
http://lxr.free-electrons.com/source/drivers/iommu/intel-iommu.c?v=3D4.8#L1=
549
seems to imply otherwise :(
>=20
> > 	2. Smallest Translation Unit misconfiguration. Not sure if it will cau=
se
> invalid access or only poor caching behavior.
> >
> > Thanks,
> > Ilya
> >
> > > -----Original Message-----
> > > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > > Sent: Sunday, November 06, 2016 7:09 PM
> > > To: Ilya Lesokhin <ilyal@mellanox.com>
> > > Cc: linux-pci@vger.kernel.org; kvm@vger.kernel.org;
> > > bhelgaas@google.com
> > > Subject: Re: Shouldn't VFIO virtualize the ATS capability?
> > >
> > > On Sun, 6 Nov 2016 11:13:09 +0000
> > > Ilya Lesokhin <ilyal@mellanox.com> wrote:
> > >
> > > > Hi
> > > > I've noticed that VFIO doesn't virtualize the ATS capability.
> > > > It seems to me that translation caching and Smallest Translation
> > > > Unit is
> > > something you would want to control on the host. Am I wrong?
> > >
> > > What about those fields would we virtualize?  Why does the host need
> > > to be an intermediary?  Can the user induce poor behavior with
> > > direct access to them?  Thanks,
> > >
> > > Alex

