Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbdDDUjh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Apr 2017 16:39:37 -0400
Date: Tue, 4 Apr 2017 15:39:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: KY Srinivasan <kys@microsoft.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH 0/2] pci-hyperv: Some miscellaneous fixes
Message-ID: <20170404203929.GF27692@bhelgaas-glaptop.roam.corp.google.com>
References: <1490378800-26907-1-git-send-email-kys@exchange.microsoft.com>
 <20170404190331.GD27692@bhelgaas-glaptop.roam.corp.google.com>
 <DM5PR03MB249052D8580711F8999048D8A00B0@DM5PR03MB2490.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM5PR03MB249052D8580711F8999048D8A00B0@DM5PR03MB2490.namprd03.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 04, 2017 at 07:54:33PM +0000, KY Srinivasan wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> > Sent: Tuesday, April 4, 2017 12:04 PM
> > To: KY Srinivasan <kys@microsoft.com>
> > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> > vkuznets@redhat.com; jasowang@redhat.com;
> > leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen
> > Hemminger <sthemmin@microsoft.com>
> > Subject: Re: [PATCH 0/2] pci-hyperv: Some miscellaneous fixes
> > 
> > On Fri, Mar 24, 2017 at 11:06:40AM -0700, kys@exchange.microsoft.com
> > wrote:
> > > From: K. Y. Srinivasan <kys@microsoft.com>
> > >
> > > Some miscellaneous fixes.
> > >
> > > K. Y. Srinivasan (2):
> > >   pci-hyperv: Fix a bug in specifying CPU affinity
> > >   pci-hyperv: Fix an atomic bug
> > >
> > >  drivers/pci/host/pci-hyperv.c |   13 +++++++++----
> > >  1 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > I applied these with Long's reviewed-by to pci/host-hv for v4.12 with the
> > following subject lines:
> > 
> >   PCI: hv: Specify CPU_AFFINITY_ALL for MSI affinity when >= 32 CPUs
> >   PCI: hv: Allocate interrupt descriptors with GFP_ATOMIC
> > 
> Thank you.
> 
> > There were two copies of [1/2], which makes this error-prone.  I applied
> > the second one that defines CPU_AFFINITY_ALL.
> 
> Thanks again; sorry for the confusion.
> 
> > 
> > They're both marked for stable, but without any clue about when the
> > problems were introduced or how serious they are, I did not queue them for
> > v4.11.  If you want them in v4.11, please supply those additional details.
> 
> I think these issues have been there since   the driver got merged upstream.
> I would want this to be applied against 4.11 as well. Let me know if I should resend
> these patches.

No need to resend, but I do need more details about what issues these fix
and why they're more urgent than garden-variety bug fixes that are planned
for v4.12.  In general for-linus is for fixing problems we added during the
merge window, or other high-priority, low-risk changes.

Bjorn
