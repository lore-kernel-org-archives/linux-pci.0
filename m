Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755633AbcKWQJK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Nov 2016 11:09:10 -0500
Date: Wed, 23 Nov 2016 10:09:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <20161118232544.GI28386@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161118232544.GI28386@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 18, 2016 at 06:25:44PM -0500, Keith Busch wrote:
> On Fri, Oct 28, 2016 at 06:58:14PM -0400, Keith Busch wrote:
> > Here's version 3. Two of the patches from v2 have already been applied
> > upstream, so this is down to three patches now.
> > 
> > The main difference with v2 is setting subordinates to removed when
> > detected (patch 1/3).
> > 
> > Patch 2/3 short-cuts pci_device_is_present if is_removed is set.
> > 
> > Otherwise, the same as before. Just to restate the justification, this
> > significantly speeds up many device removals without relying on hardware.
> > 
> > Keith Busch (3):
> >   pci: Add is_removed state
> >   pci: No config access for removed devices
> >   pci/msix: Skip disabling removed devices
> > 
> >  drivers/pci/hotplug/pciehp_pci.c |  5 +++++
> >  drivers/pci/msi.c                |  7 ++++++-
> >  drivers/pci/pci.c                |  2 ++
> >  drivers/pci/pcie/pcie-dpc.c      |  4 ++++
> >  include/linux/pci.h              | 25 +++++++++++++++++++++++++
> >  5 files changed, 42 insertions(+), 1 deletion(-)
> 
> Hi Bjorn,
> 
> Just wanted to check in with you on this series. Any thoughts on
> this? I've been pinged from several hardware vendors on this since they
> say it improves system stability. I keep telling them to bug you about
> it, but I guess they think I'm less intimidating. :)

I'd think they'd want somebody *more* intimidating to encourage
progress :)

Sorry I haven't had a chance to look at these yet.  I want to think
about them a little more because it seems like these should be
optimizations, not really fixes.  If they improve stability by fixing
Linux issues, details of those issues would help.  But maybe the
improvement is from avoiding things the hardware doesn't handle quite
correctly.

And I'm always hesitant about things like flags that say "this device
is being removed but hasn't been removed yet" because the remove
process is already complicated and we've tripped over races and
ordering issues in the past.  That's not to say this is a bad
approach; it's just an excuse for why I need some time to work through
these patches.

Bjorn
