Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:57204 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbcKNMsG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Nov 2016 07:48:06 -0500
Date: Mon, 14 Nov 2016 13:48:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu: Move REQ_ACS_FLAGS out to header and rename
Message-ID: <20161114124803.GW2078@8bytes.org>
References: <20161026175156.23495.12980.stgit@gimli.home>
 <20161026180134.23495.27520.stgit@gimli.home>
 <20161110122713.GI9996@8bytes.org>
 <20161111225740.GX9868@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161111225740.GX9868@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 11, 2016 at 04:57:40PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 10, 2016 at 01:27:13PM +0100, Joerg Roedel wrote:
> > On Wed, Oct 26, 2016 at 12:01:34PM -0600, Alex Williamson wrote:
> > > Allow other parts of the kernel to see which PCI ACS flags the IOMMU
> > > layer considers necessary for isolation.
> > > 
> > > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > ---
> > >  drivers/iommu/iommu.c |   18 +++++-------------
> > >  include/linux/iommu.h |   11 +++++++++++
> > >  2 files changed, 16 insertions(+), 13 deletions(-)
> > 
> > Applied, thanks Alex.
> 
> Hi Joerg, did you apply just this one (4/5), or the whole series?  If the
> former, is it safe for me to apply 1, 2, 3, and 5?  I assumed these were
> meant to go as a group.

Ah yes, I missed that this patch was part of a series and applied it. I
can still remove it, as the tree is not yet pushed. Will you take the
while series? Then you can add my

	Acked-by: Joerg Roedel <jroedel@suse.de>

to this patch.


Thanks,

	Joerg

