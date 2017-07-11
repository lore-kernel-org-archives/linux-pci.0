Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:22992
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932750AbdGKTIF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jul 2017 15:08:05 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Joerg Roedel' <jroedel@suse.de>,
        Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        "Samuel Sieb" <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Date: Tue, 11 Jul 2017 19:08:03 +0000
Message-ID: <CY4PR12MB16536D76B95B9CE43CD7370AF7AE0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170615140421.GB25710@suse.de>
 <20170615191545.GB12735@bhelgaas-glaptop.roam.corp.google.com>
 <20170616162923.GE25710@suse.de>
 <20170710165358.GD20365@bhelgaas-glaptop.roam.corp.google.com>
 <20170711114948.GA6244@suse.de>
In-Reply-To: <20170711114948.GA6244@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Joerg Roedel [mailto:jroedel@suse.de]
> Sent: Tuesday, July 11, 2017 7:50 AM
> To: Bjorn Helgaas
> Cc: Bjorn Helgaas; linux-pci@vger.kernel.org; linux-kernel@vger.kernel.or=
g;
> Daniel Drake; Deucher, Alexander; Samuel Sieb; David Woodhouse
> Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
>=20
> Hi Bjorn,
>=20
> On Mon, Jul 10, 2017 at 11:53:58AM -0500, Bjorn Helgaas wrote:
> > I'm still confused.  Per Samuel
> > (6dd9dbac-9b65-bc7c-bb08-413a05d09fc8@sieb.net):
> >
> > Samuel> The other patch seems to fix this issue without disabling ATS.
> > Samuel> Isn't that better?
> >
> > and Alex
> >
> (BN6PR12MB1652DF4130FC792B71DD9974F7C00@BN6PR12MB1652.namprd1
> 2.prod.outlook.com):
> >
> > Alex> I talked to our validation team and ATS was validated on Stoney,
> > Alex> so this patch is just working around something else.  The other
> > Alex> patch fixes it and is a valid optimization ...
> >
> > I'm confused about what this "other patch" is and whether we want that
> > one, this one, or both.

Here's the other patch:
https://lists.freedesktop.org/archives/amd-gfx/2017-May/009421.html

>=20
> The other patches floating around lowered the ATS flush-rate from the
> AMD IOMMU driver, which makes the issue disappear as well. But the issue
> only disappeared, it is not solved and could probably still be
> reproduced with a GPU usage pattern that increases the ATS flush-rate.
>=20
> So blacklisting the device for ATS is still the safest thing we could do
> here.

I don't have any objection per se, but I'd hate to add a quirk to disable i=
t only to remove it again in the future if we needed ATS related functional=
ity later.  We are in the process of upstreaming KFD support for Carrizo (w=
hich is a bigger version of Stoney) and that utilizes ATS related functiona=
lity to provide GPU access to pageable memory.  There are no immediate requ=
irements for Stoney, but that may change.

Alex
