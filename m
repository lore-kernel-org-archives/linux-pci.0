Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752346AbcLHRyf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 12:54:35 -0500
Date: Thu, 8 Dec 2016 11:54:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20161208175432.GA28827@bhelgaas-glaptop.roam.corp.google.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <20161118232544.GI28386@localhost.localdomain>
 <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
 <20161128180214.GF2609@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161128180214.GF2609@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 28, 2016 at 01:02:14PM -0500, Keith Busch wrote:
> On Wed, Nov 23, 2016 at 10:09:06AM -0600, Bjorn Helgaas wrote:
> > Sorry I haven't had a chance to look at these yet.  I want to think
> > about them a little more because it seems like these should be
> > optimizations, not really fixes.  If they improve stability by fixing
> > Linux issues, details of those issues would help.  But maybe the
> > improvement is from avoiding things the hardware doesn't handle quite
> > correctly.
> 
> I also think o  this mainly as an optimization since it significantly
> speeds up the hot removal of larger PCIe hierarchies. If this also happens
> to improve hot plug stability on hardware (which I understand it does),
> that's just a bonus, but the patch should be able to stand on its own
> merits without considering hardware issues.

In the pciehp thread, you cited performance improvements of seconds to
microseconds.  That's *huge*.  Can you give a few details in the
patches that realize that improvement (2 & 3, I think) about how they
account for it?  Are we simply avoiding seconds worth of config
accesses (I know they're not fast, but we can still do an awful lot
of them in a second), or are we avoiding timeouts somewhere, or what?

Bjorn
