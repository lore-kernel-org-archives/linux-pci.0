Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752184AbcLLXmb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Dec 2016 18:42:31 -0500
Date: Mon, 12 Dec 2016 17:42:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <20161118232544.GI28386@localhost.localdomain>
 <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
 <20161128180214.GF2609@localhost.localdomain>
 <20161208175432.GA28827@bhelgaas-glaptop.roam.corp.google.com>
 <20161208193253.GK25959@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161208193253.GK25959@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 08, 2016 at 02:32:53PM -0500, Keith Busch wrote:
> On Thu, Dec 08, 2016 at 11:54:32AM -0600, Bjorn Helgaas wrote:
> > On Mon, Nov 28, 2016 at 01:02:14PM -0500, Keith Busch wrote:
> > > On Wed, Nov 23, 2016 at 10:09:06AM -0600, Bjorn Helgaas wrote:
> > > > Sorry I haven't had a chance to look at these yet.  I want to think
> > > > about them a little more because it seems like these should be
> > > > optimizations, not really fixes.  If they improve stability by fixing
> > > > Linux issues, details of those issues would help.  But maybe the
> > > > improvement is from avoiding things the hardware doesn't handle quite
> > > > correctly.
> > > 
> > > I also think o  this mainly as an optimization since it significantly
> > > speeds up the hot removal of larger PCIe hierarchies. If this also happens
> > > to improve hot plug stability on hardware (which I understand it does),
> > > that's just a bonus, but the patch should be able to stand on its own
> > > merits without considering hardware issues.
> > 
> > In the pciehp thread, you cited performance improvements of seconds to
> > microseconds.  That's *huge*.  Can you give a few details in the
> > patches that realize that improvement (2 & 3, I think) about how they
> > account for it?  Are we simply avoiding seconds worth of config
> > accesses (I know they're not fast, but we can still do an awful lot
> > of them in a second), or are we avoiding timeouts somewhere, or what?
> 
> Depending on the device and the driver, there are hundreds to thousands
> of non-posted transactions submitted to the device to complete driver
> unbinding and removal. Since the device is gone, hardware has to handle
> that as an error condition, which is slower than the a successful
> non-posted transaction. Since we're doing 1000 of them for no particular
> reason, it takes a long time. If you hot remove a switch with multiple
> downstream devices, the serialized removal adds up to many seconds.

Another thread mentioned 1-2us as a reasonable config access cost, and
I'm still a little puzzled about how we get to something on the order
of a million times that cost.

I know this is all pretty hand-wavey, but 1000 config accesses to shut
down a device seems unreasonably high.  The entire config space is
only 4096 bytes, and most devices use a small fraction of that.  If
we're really doing 1000 accesses, it sounds like we're doing something
wrong, like polling without a delay or something.

I measured the cost of config reads during enumeration using the TSC
on a 2.8GHz CPU and found the following:

  1580 cycles, 0.565 usec (device present)
  1230 cycles, 0.440 usec (empty slot)
  2130 cycles, 0.761 usec (unimplemented function of multi-function device)

So 1-2usec does seem the right order of magnitude, and my "empty slot"
error responses are actually *faster* than the "device present" ones,
which is plausible to me because the Downstream Port can generate the
error response immediately without sending a packet down the link.
The "unimplemented function" responses take longer than the "empty
slot", which makes sense because the Downstream Port does have to send
a packet to the device, which then complains because it doesn't
implement that function.

Of course, these aren't the same case as yours, where the link used to
be up but is no longer.  Is there some hardware timeout to see if the
link will come back?

Bjorn
