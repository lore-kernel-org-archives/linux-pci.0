Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60640 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086AbcAHRqR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 8 Jan 2016 12:46:17 -0500
Date: Fri, 8 Jan 2016 11:46:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] PCI: pciehp: Merge hotplug work requests
Message-ID: <20160108174612.GA5354@localhost>
References: <1446522496-21628-1-git-send-email-linux@roeck-us.net>
 <20160108161846.GA31005@localhost>
 <568FE426.5000707@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <568FE426.5000707@roeck-us.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 08, 2016 at 08:30:30AM -0800, Guenter Roeck wrote:
> On 01/08/2016 08:18 AM, Bjorn Helgaas wrote:
> >Hi Guenter,
> >
> >Sorry for the delay in getting to this.
> >
> >On Mon, Nov 02, 2015 at 07:48:15PM -0800, Guenter Roeck wrote:
> >>Some oddball devices may experience a PCIe link flap after power-on.
> >>This may result in the following sequence of events.
> >>
> >>fpc0 kernel: pciehp 0000:02:08.0:pcie24: Card present on Slot(0)
> >>fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Up event
> >>fpc0 kernel: pciehp 0000:02:08.0:pcie24:
> >>	Link Up event ignored on slot(0): already powering on
> >>fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Down event
> >>fpc0 kernel: pciehp 0000:02:08.0:pcie24:
> >>	Link Down event queued on slot(0): currently getting powered on
> >>fpc0 kernel: pciehp 0000:02:08.0:pcie24: slot(0): Link Up event
> >>fpc0 kernel: pciehp 0000:02:08.0:pcie24:
> >>	Link Up event queued on slot(0): currently getting powered off
> >>
> >>This causes the driver for affected devices to be instantiated, removed,
> >>and re-instantiated.
> >>
> >>An even worse problem is a device which resets itself continuously.
> >>This can result in the following endless sequence of messages.
> >>
> >>pciehp 0000:02:0a.0:pcie24: Card present on Slot(10)
> >>pciehp 0000:02:0a.0:pcie24: Card not present on Slot(10)
> >>pciehp 0000:02:0a.0:pcie24: Card present on Slot(10)
> >>pciehp 0000:02:0a.0:pcie24: Card not present on Slot(10)
> >>pciehp 0000:02:0a.0:pcie24: Card present on Slot(10)
> >>pciehp 0000:02:0a.0:pcie24: Card not present on Slot(10)
> >>
> >>The problem in the both cases is that all events are enqueued as hotplug
> >>work requests and executed in sequence, which can overwhelm the system
> >>and even result in "hung task" tracebacks in pciehp_power_thread().
> >>
> >>This exposes an underlying limitation of the hotplug state machine: It
> >>executes all received requests, even though only the most recent request
> >>really needs to be handled. As a result, by the time a request is handled,
> >>it may well be obsolete and have been superseded by many other enable /
> >>disable requests which have been enqueued in the meantime.
> >>
> >>To solve the problem, fold hotplug work requests into a single request.
> >>Store the request as well as the work data structure in 'struct slot',
> >>thus eliminating the need to allocate memory for each request.
> >>Handle a sequence of requests by setting a 'disable' flag when needed,
> >>indicating that a link needs to be disabled prior to re-enabling it.
> >>
> >>With this change, requests and request sequences are handled as follows.
> >>
> >>enable (single request):		enable link
> >>disable (single request):		disable link
> >>... disable-enable-disable...disable:	disable link
> >>... disable-enable-disable...enable:	disable link, then enable it
> >
> >I think this is a really good idea, but I would like to understand
> >what the critical points are and how they affect the state machine.
> >
> >I think you're basically accounting for the fact that some hotplug
> >controller commands are not completed instantaneously, and we might
> >receive more interrupts before the first command is completed.  I
> >suspect that your patch only makes a difference on controllers that
> >support Command Completed events, right?
> 
> No, not really. problem is that state change interrupts are not handled
> immediately but enqueued. By the time an event is handled by the workqueue,
> it is long since obsolete and superseded by other events.

Ah.  So the important interval is the one between pcie_isr(), where we
enqueue work, and the worker threads that are awakened to actually do
the work.  Then the idea is that only the most recent state is
important -- if we have several presence detect changes, e.g.,
present, absent, present, absent, before the worker thread starts
processing them, it should only look at the most recent state.  That
seems like the right thing to me, and I think the removal of kmalloc
from the ISR path is an important consequence of doing that.

Blue sky thinking:

  - Do all interrupt-related CSR reads in pcie_isr() (as opposed to
    doing some in pcie_isr() and others in the worker threads).  I
    think this is important for consistency.  I think it's a mistake
    to read and clear the status register in pcie_isr(), then go back
    and read other CSRs later in the worker threads.

  - Have pcie_isr() update a single set of "current state" CSR values.
    This means we don't need any allocation in pcie_isr().  Some
    values, e.g., Power Fault Detected, might be OR-d in.  Others, 
    e.g., Presence Detect, might overwrite the previous value.

  - Collapse the several worker threads into a single one that
    pcie_isr() would awaken (as opposed to having pcie_isr() decide
    whether this is a button press, presence detect change, link
    event, etc.)

  - Have the single worker thread figure out what happened and how to
    advance the state machine, based on the CSR values read by the
    most recent pcie_isr() invocation.

This would be a lot of changes, but I think it has the potential to
centralize the state machine management and simplify things
significantly.

Bjorn
