Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45299 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbcDGVlM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Apr 2016 17:41:12 -0400
Date: Thu, 7 Apr 2016 16:41:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
	agross@codeaurora.org, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci, acpi: free IO resource during shutdown
Message-ID: <20160407214108.GB24492@localhost>
References: <1457389310-3538-1-git-send-email-okaya@codeaurora.org>
 <1457389310-3538-2-git-send-email-okaya@codeaurora.org>
 <20160407160624.GB8780@localhost>
 <57069CAF.8090803@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57069CAF.8090803@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 07, 2016 at 01:45:19PM -0400, Sinan Kaya wrote:
> On 4/7/2016 12:06 PM, Bjorn Helgaas wrote:
> >> __release_pci_root_info function if the region type is IO.
> > I don't know what "removing a slot" means.  You're changing
> > pci_root.c, so I assume this is really an ACPI host bridge removal?
> > 
> 
> Correct, I'm removing the host bridge.
> 
> > The release should correspond to a mapping, and the changelog should
> > point out where that mapping happens so we can see the symmetry.
> > 
> 
> I apologize. This is based on Tomasz's v5 patch here.
> 
> https://github.com/semihalf-nowicki-tomasz/linux/blob/pci-acpi-v5/drivers/acpi/pci_root.c
> 
> 
> > You say this is undoing the effect of pci_remap_iospace(), but that's
> > only called by native drivers and the generic (OF) driver, not by
> > pci_root.c.
> 
> See the ACPI root bridge driver above.

If this is a fix to patches that haven't been merged yet, we need to
squash the fix into the patches.

> > Please combine this with the previous patch so we have the new
> > function and its use in the same patch.
> 
> I can do that. I was trying to keep the reviews as small as possible.

The object is not to make patches as small as possible.  The object is
to make them easy to review, merge, bisect, revert, and backport.  If
we're adding something new and it's called by many arches or many
drivers, we might have to split it up for merging through several
trees or so we can revert pieces independently.  But here there's only
one caller and I don't think we get any benefit from splitting it.

But I guess this is all moot since it should be squashed into whatever
added the pci_remap_iospace() in the first place.

Bjorn
