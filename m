Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753903AbdGJQyQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 12:54:16 -0400
Date: Mon, 10 Jul 2017 11:53:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Samuel Sieb <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170710165358.GD20365@bhelgaas-glaptop.roam.corp.google.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170615140421.GB25710@suse.de>
 <20170615191545.GB12735@bhelgaas-glaptop.roam.corp.google.com>
 <20170616162923.GE25710@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170616162923.GE25710@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 16, 2017 at 06:29:23PM +0200, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Thu, Jun 15, 2017 at 02:15:45PM -0500, Bjorn Helgaas wrote:
> > It was marked "superseded" in patchwork and thus off my radar.  I
> > don't remember if I did that or why.  I changed it back to "New" so I
> > won't forget about it.
> 
> Great!
> 
> > You mention (May 24) the original bug report.  Can you include the URL
> > for that?
> 
> I think there were multiple reports, here is one I could still find:
> 
> 	https://lists.linuxfoundation.org/pipermail/iommu/2017-March/020836.html
> 
> > I admit I just don't have warm fuzzies that the problem is well
> > understood.
> 
> The current understanding (without my ability to debug the hardware
> involved) is that the GPU in the Stoney systems gets into a weird state
> when ATS invalidations are sent too fast and stops responding to the
> iommu.
> 
> The iommu then can't complete the invalidation commands and the driver
> throws completion-wait loop timeout messages out.

I'm still confused.  Per Samuel
(6dd9dbac-9b65-bc7c-bb08-413a05d09fc8@sieb.net):

Samuel> The other patch seems to fix this issue without disabling ATS.
Samuel> Isn't that better?

and Alex
(BN6PR12MB1652DF4130FC792B71DD9974F7C00@BN6PR12MB1652.namprd12.prod.outlook.com):

Alex> I talked to our validation team and ATS was validated on Stoney,
Alex> so this patch is just working around something else.  The other
Alex> patch fixes it and is a valid optimization ...

I'm confused about what this "other patch" is and whether we want that
one, this one, or both.

Bjorn
