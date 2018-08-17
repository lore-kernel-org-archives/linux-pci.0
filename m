Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbeHQR3F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Aug 2018 13:29:05 -0400
Date: Fri, 17 Aug 2018 09:25:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "liudongdong3@huawei.com" <liudongdong3@huawei.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/DPC: Add 'nodpc' parameter
Message-ID: <20180817142529.GA128050@bhelgaas-glaptop.roam.corp.google.com>
References: <1534368400-2807-1-git-send-email-jonathan.derrick@intel.com>
 <20180816154940.GD5762@bombadil.infradead.org>
 <1534434641.17819.27.camel@intel.com>
 <20180816203111.GB10316@bhelgaas-glaptop.roam.corp.google.com>
 <1534452635.17819.53.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1534452635.17819.53.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 16, 2018 at 08:50:42PM +0000, Derrick, Jonathan wrote:
> On Thu, 2018-08-16 at 15:31 -0500, Bjorn Helgaas wrote:
> > On Thu, Aug 16, 2018 at 03:50:47PM +0000, Derrick, Jonathan wrote:
> > > On Thu, 2018-08-16 at 08:49 -0700, Matthew Wilcox wrote:
> > > > On Wed, Aug 15, 2018 at 03:26:39PM -0600, Jon Derrick wrote:
> > > > > Some users may want to disable downstream port containment
> > > > > (DPC),
> > > > > so
> > > > > give them this option
> > > > 
> > > > Is it possible they might only want to disable DPC on a subset of
> > > > the
> > > > hierarchy rather than globally?
> > > 
> > > Absolutely. I was hoping Logan's pci dev_str would land because I
> > > have
> > > a few others I want to convert to that api for granular tuning
> > 
> > What's the use case here?  I acknowledge there are cases where we
> > need
> > them, but I'm not a fan of kernel parameters in general because
> > they're a real hassle for users.
> > 
> > Is there something wrong with DPC?  Is there some way we can make it
> > smarter so it does the right thing automatically?
> I've encountered some BIOS or switches (not sure who) who've appeared
> to have enabled DPC by default, prior to kernel setup. Some users may
> just not want this, but it was primarily intended for debugging when I
> conceived it.
> 
> There's also the ongoing thread in linux-pci about err handling in PPC
> EEH, who may also desire to disable DPC until those issues are
> resolved.

I haven't caught up on that thread yet.  If DPC is incompatible with
PPC EEH, there's always the possibility of a switch in the code to
disable DPC automatically on PPC.

> It can also be disabled with setpci, but is that any less of a hassle?
> Genuine question to understand your point of view.

Keith already answered here; setpci is primarily for debugging and
shouldn't be recommended as normal practice.

> > I'm more OK with a blanket "nodpc" switch intended for debugging.
> > If we add the complexity of subsets of the hierarchy it starts
> > sounding like an administrative thing that makes me more hesitant. 
> ...
> To again understand your point of view, is there anything wrong with
> administrative things in kernel boot parameters? There will be cases
> where we may want to deviate from default or global pci=* parameters
> for certain hierarchies and they can't necessarily be set after the
> fact (ex, hpmemsize).

"There will be cases" sounds like we're doing something that *might*
be useful in the future.  It's better if we wait until we actually
discover a need for something.

There's also a tendency among users to trip over a problem, discover a
boot parameter like "pci=nomsi", and conclude that the problem is
"fixed".  In fact, we want the bug report so we can fix the kernel so
no boot parameter is needed.

I agree there are things that can't be set after boot.  Is this one of
them?  This seems like something that could be controlled at run-time.
But even there, I will ask what the requirement for it is, because we
don't want to clutter sysfs with things only needed for debugging.

Boot parameters are a hassle because it's hard to build a user
interface on top of them, and they require a reboot to take effect.
