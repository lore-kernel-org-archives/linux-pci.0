Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbdFOTPr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jun 2017 15:15:47 -0400
Date: Thu, 15 Jun 2017 14:15:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Samuel Sieb <samuel@sieb.net>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] PCI: Add ATS-disable quirk for AMD Stoney GPUs
Message-ID: <20170615191545.GB12735@bhelgaas-glaptop.roam.corp.google.com>
References: <1491575538-22694-1-git-send-email-joro@8bytes.org>
 <20170615140421.GB25710@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615140421.GB25710@suse.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 04:04:21PM +0200, Joerg Roedel wrote:
> Hi Bjorn,
> 
> On Fri, Apr 07, 2017 at 04:32:18PM +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > ATS is broken on this hardware and causes IOMMU stalls and
> > system failure. Disable ATS on these devices to make them
> > usable again with IOMMU enabled.
> > 
> > Note that the commit in the Fixes-tag is not buggy, it
> > just uncovers the problem in the hardware by increasing
> > the ATS-flush rate.
> > 
> > Fixes: b1516a14657a ('iommu/amd: Implement flush queue')
> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
> > ---
> >  drivers/pci/quirks.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> 
> Any more objections on this patch? Please let me know if you want to
> have something changed.

It was marked "superseded" in patchwork and thus off my radar.  I
don't remember if I did that or why.  I changed it back to "New" so I
won't forget about it.

You mention (May 24) the original bug report.  Can you include the URL
for that?

I admit I just don't have warm fuzzies that the problem is well
understood.

Bjorn
