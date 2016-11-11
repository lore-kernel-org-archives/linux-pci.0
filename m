Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934871AbcKKW5n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 17:57:43 -0500
Date: Fri, 11 Nov 2016 16:57:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu: Move REQ_ACS_FLAGS out to header and rename
Message-ID: <20161111225740.GX9868@bhelgaas-glaptop.roam.corp.google.com>
References: <20161026175156.23495.12980.stgit@gimli.home>
 <20161026180134.23495.27520.stgit@gimli.home>
 <20161110122713.GI9996@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161110122713.GI9996@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 10, 2016 at 01:27:13PM +0100, Joerg Roedel wrote:
> On Wed, Oct 26, 2016 at 12:01:34PM -0600, Alex Williamson wrote:
> > Allow other parts of the kernel to see which PCI ACS flags the IOMMU
> > layer considers necessary for isolation.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > ---
> >  drivers/iommu/iommu.c |   18 +++++-------------
> >  include/linux/iommu.h |   11 +++++++++++
> >  2 files changed, 16 insertions(+), 13 deletions(-)
> 
> Applied, thanks Alex.

Hi Joerg, did you apply just this one (4/5), or the whole series?  If the
former, is it safe for me to apply 1, 2, 3, and 5?  I assumed these were
meant to go as a group.

Bjorn
