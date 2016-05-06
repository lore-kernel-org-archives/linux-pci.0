Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55093 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758421AbcEFPsy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 6 May 2016 11:48:54 -0400
Date: Fri, 6 May 2016 10:48:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jay Cornwall <jay@jcornwall.me>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add pci_enable_atomic_request
Message-ID: <20160506154841.GA15666@localhost>
References: <1443110390-4080-1-git-send-email-jay@jcornwall.me>
 <20151204182540.GC20125@localhost>
 <c7259e37a065e8c7d386c806f521c46d@jcornwall.me>
 <20151207162351.GH7994@localhost>
 <ec60daae6d886179a4d86c421ba66545@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ec60daae6d886179a4d86c421ba66545@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 28, 2016 at 03:10:01PM -0500, Jay Cornwall wrote:
> On 2015-12-07 10:23, Bjorn Helgaas wrote:
> >On Fri, Dec 04, 2015 at 01:33:30PM -0600, Jay Cornwall wrote:
> >>On 2015-12-04 12:25, Bjorn Helgaas wrote:
> >>>On Thu, Sep 24, 2015 at 10:59:50AM -0500, Jay Cornwall wrote:
> >>>>The PCIe 3.0 AtomicOp (6.15) feature allows atomic transctions
> >>>>to be requested
> >>>>by, routed through and completed by PCIe components. Routing and
> >>>>completion
> >>>>do not require software support. Component support for each is
> >>>>detectable via
> >>>>the DEVCAP2 register.
> >>>>
> >>>>AtomicOp requests are permitted only if a component's
> >>>>DEVCTL2.ATOMICOP_REQUESTER_ENABLE field is set. This capability
> >>>>cannot be
> >>>>detected but is a no-op if set on a component with no support.
> >>>>These requests
> >>>>can only be serviced if the upstream components support AtomicOp
> >>>>completion
> >>>>and/or routing to a component which does.
> >>>>
> >>>>A concrete example is the AMD Fiji-class GPU, which is specified
> >>>>to support
> >>>>AtomicOp requests, routed through a PLX 8747 switch (advertising
> >>>>AtomicOp
> >>>>routing) to a Haswell host bridge (advertising AtomicOp
> >>>>completion support).
> >>>>When AtomicOp requests are disabled the GPU logs attempts to
> >>>>initiate requests
> >>>>to an MMIO register for debugging.
> >>>>
> >>>>Add pci_enable_atomic_request for per-device control over
> >>>>AtomicOp requests.
> >>>>Upstream bridges are checked for AtomicOp routing capability and
> >>>>the call
> >>>>fails if any lack this capability. The root port is checked for
> >>>>AtomicOp
> >>>>completion capabilities and the call fails if it does not support any.
> >>>>Routes to other PCIe components are not checked for AtomicOp
> >>>>routing and
> >>>>completion capabilities.
> >>>>
> >>>>v2: Check for AtomicOp route to root port with AtomicOp completion
> >>>>v3: Style fixes
> >>>>
> >>>>Signed-off-by: Jay Cornwall <jay@jcornwall.me>
> >>>
> >>>Hi Jay,
> >>>
> >>>Is there a user for this new functionality?  I don't like to add things
> >>>that have no apparent user.
> >>>
> >>>Bjorn
> >>
> >>The client for this code is scheduled to be upstreamed in
> >>drm/amdgpu, but we have some internal restructuring to complete
> >>before a patchset will be available.
> >>
> >>If you'd prefer, I can resubmit this patch as part of that series
> >>when it is ready.
> >
> >Yeah, that'd be great, why don't we do that.  Thanks!
> >
> >Bjorn
> 
> We've been testing this prior to upstreaming the client code and ran
> into a problem. When the client driver (amdgpu) is running within a
> virtual machine on the physical PCI function (not SR-IOV) the
> hypervisor virtualizes the PCI configuration space and blocks writes
> to DEVCTL2.ATOMICOP_REQUESTER_ENABLE.
> 
> I think the host is intended to manage the PCI configuration space
> in this model. The client driver cannot run simultaneously on the
> host and guest. This appears to leave the PCI subsystem as the
> remaining opportunity to enable this feature.
> 
> Would you object to calling pci_enable_atomic_request
> unconditionally in pci_init_capabilites? On most PCIe devices this
> should be a no-op but I don't see a way to check for this in the
> AtomicOp specification.

The spec says "discovery of AtomicOp Requester capabilities is outside
the scope of this specification" [PCIe r3.0, sec 6.15], so I think the
intent is that a driver knows the capability of the device and enables
and uses AtomicOps when appropriate.  

Once enabled in Device Control 2, a device's use of AtomicOps is
competely device-specific.  In many cases, the device probably doesn't
support AtomicOps, so enabling them would be a no-op.  But there could
be devices where AtomicOps are nominally supported but untested or
broken.  Even if we didn't change their drivers, those devices could
start using AtomicOps, so I'm not comfortable with the PCI core
enabling AtomicOp requests indiscriminately.

I don't know anything about the interface between the hypervisor and
the client driver.  Is there any opportunity for an ioctl or sysfs
file or anything whereby the client could ask the hypervisor to enable
AtomicOps?

Bjorn
