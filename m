Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:64384
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754328AbdC1UhH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Mar 2017 16:37:07 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Joerg Roedel' <jroedel@suse.de>
CC: 'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Date: Tue, 28 Mar 2017 20:37:01 +0000
Message-ID: <BN6PR12MB16527AD3EF2DDA863957B87EF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652414344196BA60520B828F7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328202844.GQ8329@suse.de>
In-Reply-To: <20170328202844.GQ8329@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Joerg Roedel [mailto:jroedel@suse.de]
> Sent: Tuesday, March 28, 2017 4:29 PM
> To: Deucher, Alexander
> Cc: 'Joerg Roedel'; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Daniel Drake; Nath, Arindam
> Subject: Re: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
>=20
> On Tue, Mar 28, 2017 at 08:18:26PM +0000, Deucher, Alexander wrote:
> > > -----Original Message-----
> > > From: Joerg Roedel [mailto:joro@8bytes.org]
> > > Sent: Tuesday, March 28, 2017 8:17 AM
> > > To: Bjorn Helgaas
> > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; Joerg
> Roedel;
> > > Daniel Drake; Deucher, Alexander
> > > Subject: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
> > >
> > > From: Joerg Roedel <jroedel@suse.de>
> > >
> > > ATS is broken on these devices. Under invalidation load, the
> > > GPU does not reply to invalidations anymore, causing
> > > Completion-wait loop timeouts on the AMD IOMMU driver side.
> > > Fix it by not enabling ATS on these devices.
> > >
> > > Note that below mentioned commit is not broken, it just
> > > triggers the issue because it might cause invalidation
> > > storms on devices.
> > >
> > > Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> > > Reported-by: Daniel Drake <drake@endlessm.com>
> > > Cc: Daniel Drake <drake@endlessm.com>
> > > Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> > > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> >
> > Did you see Arindam's patch from yesterday[1]?  Not sure which is the
> proper fix, maybe both?
>=20
> Arindam's patch makes sense on its own, but not as a fix for this issue.
> It lowers the invalidation load on the GPU, but there are still ways to
> trigger a high invalidation rate on the device. So it might hide the
> issue, but not fix it.
>=20
> We need to disable ATS on the device if it doesn't work reliably.

The question is, could the problem stem from flushing an entity that didn't=
 request it, or should that not matter?  I guess it shouldn't matter otherw=
ise we'd see this on other platforms like Carrizo as well.

Alex
