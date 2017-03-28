Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn3nam01on0066.outbound.protection.outlook.com ([104.47.33.66]:35293
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752363AbdC1VNd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Mar 2017 17:13:33 -0400
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: 'Joerg Roedel' <jroedel@suse.de>
CC: 'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Date: Tue, 28 Mar 2017 21:13:23 +0000
Message-ID: <BN6PR12MB165289163EA3548B59D0C1ACF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652414344196BA60520B828F7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328202844.GQ8329@suse.de>
 <BN6PR12MB16527AD3EF2DDA863957B87EF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328205616.GR8329@suse.de>
In-Reply-To: <20170328205616.GR8329@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: 'Joerg Roedel' [mailto:jroedel@suse.de]
> Sent: Tuesday, March 28, 2017 4:56 PM
> To: Deucher, Alexander
> Cc: 'Joerg Roedel'; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Daniel Drake; Nath, Arindam
> Subject: Re: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
>=20
> On Tue, Mar 28, 2017 at 08:37:01PM +0000, Deucher, Alexander wrote:
> > The question is, could the problem stem from flushing an entity that
> > didn't request it, or should that not matter?  I guess it shouldn't
> > matter otherwise we'd see this on other platforms like Carrizo as
> > well.
>=20
> What do you mean by "didn't request it"? The IOMMU driver only sends
> io/tlb invalidations to devices it enabled ATS on.

If I understand Arindam's patch correctly, it only flushes TLB entries for =
domains in the flush queue whereas the previous behavior was to flush all d=
omains.  If there was no TLB flush in the queue for that domain, could flus=
hing it cause a problem?  Sorry, I'm not too familiar with the IOMMU code o=
r ATS.

Alex
