Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941064AbcLMUv0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Dec 2016 15:51:26 -0500
Date: Tue, 13 Dec 2016 14:50:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv4 next 0/3] Limiting pci access
Message-ID: <20161213205012.GA29950@bhelgaas-glaptop.roam.corp.google.com>
References: <1477695497-6207-1-git-send-email-keith.busch@intel.com>
 <20161118232544.GI28386@localhost.localdomain>
 <20161123160906.GB16033@bhelgaas-glaptop.roam.corp.google.com>
 <20161128180214.GF2609@localhost.localdomain>
 <20161208175432.GA28827@bhelgaas-glaptop.roam.corp.google.com>
 <20161208193253.GK25959@localhost.localdomain>
 <20161212234226.GA7973@bhelgaas-glaptop.roam.corp.google.com>
 <20161213005547.GA12844@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161213005547.GA12844@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 12, 2016 at 07:55:47PM -0500, Keith Busch wrote:
> On Mon, Dec 12, 2016 at 05:42:27PM -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 08, 2016 at 02:32:53PM -0500, Keith Busch wrote:
> > > Depending on the device and the driver, there are hundreds to thousands
> > > of non-posted transactions submitted to the device to complete driver
> > > unbinding and removal. Since the device is gone, hardware has to handle
> > > that as an error condition, which is slower than the a successful
> > > non-posted transaction. Since we're doing 1000 of them for no particular
> > > reason, it takes a long time. If you hot remove a switch with multiple
> > > downstream devices, the serialized removal adds up to many seconds.
> > 
> > Another thread mentioned 1-2us as a reasonable config access cost, and
> > I'm still a little puzzled about how we get to something on the order
> > of a million times that cost.
> > 
> > I know this is all pretty hand-wavey, but 1000 config accesses to shut
> > down a device seems unreasonably high.  The entire config space is
> > only 4096 bytes, and most devices use a small fraction of that.  If
> > we're really doing 1000 accesses, it sounds like we're doing something
> > wrong, like polling without a delay or something.
> 
> Every time pci_find_ext_capability is called on a removed device, the
> kernel will do 481 failed config space accesses trying to find that
> capability. The kernel used to do that multiple times to find the AER
> capability under conditions common to surprise removal.

Right, that's a perfect example.  I'd rather fix issues like this by
caching the position as you did with AER.  The "removed" bit makes
these issues "go away" without addressing the underlying problem.

We might still need a "removed" bit for other reasons, but I want to
be clear about those reasons, not just throw it in under the general
"make it go fast" umbrella.

> But now that we cache the AER position (commit: 66b80809), we've
> eliminated by far the worst offender. The counts I'm telling you are
> still referencing the original captured traces showing long tear down
> times, so it's not up-to-date with the most recent version of the kernel.
>  
> > I measured the cost of config reads during enumeration using the TSC
> > on a 2.8GHz CPU and found the following:
> > 
> >   1580 cycles, 0.565 usec (device present)
> >   1230 cycles, 0.440 usec (empty slot)
> >   2130 cycles, 0.761 usec (unimplemented function of multi-function device)
> > 
> > So 1-2usec does seem the right order of magnitude, and my "empty slot"
> > error responses are actually *faster* than the "device present" ones,
> > which is plausible to me because the Downstream Port can generate the
> > error response immediately without sending a packet down the link.
> > The "unimplemented function" responses take longer than the "empty
> > slot", which makes sense because the Downstream Port does have to send
> > a packet to the device, which then complains because it doesn't
> > implement that function.
> > 
> > Of course, these aren't the same case as yours, where the link used to
> > be up but is no longer.  Is there some hardware timeout to see if the
> > link will come back?
> 
> Yes, the hardware does not respond immediately under this test, which
> is considered an error condition. This is a reason why PCIe Device
> Capabilities 2 Completion Timeout Ranges are recommended to be in the
> 10ms range.

And we're apparently still doing a lot of these accesses?  I'm still
curious about exactly what these are, because it may be that we're
doing more than necessary.

Bjorn
