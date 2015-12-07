Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54733 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754245AbbLGQYB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Dec 2015 11:24:01 -0500
Date: Mon, 7 Dec 2015 10:23:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jay Cornwall <jay@jcornwall.me>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add pci_enable_atomic_request
Message-ID: <20151207162351.GH7994@localhost>
References: <1443110390-4080-1-git-send-email-jay@jcornwall.me>
 <20151204182540.GC20125@localhost>
 <c7259e37a065e8c7d386c806f521c46d@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c7259e37a065e8c7d386c806f521c46d@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 04, 2015 at 01:33:30PM -0600, Jay Cornwall wrote:
> On 2015-12-04 12:25, Bjorn Helgaas wrote:
> >On Thu, Sep 24, 2015 at 10:59:50AM -0500, Jay Cornwall wrote:
> >>The PCIe 3.0 AtomicOp (6.15) feature allows atomic transctions
> >>to be requested
> >>by, routed through and completed by PCIe components. Routing and
> >>completion
> >>do not require software support. Component support for each is
> >>detectable via
> >>the DEVCAP2 register.
> >>
> >>AtomicOp requests are permitted only if a component's
> >>DEVCTL2.ATOMICOP_REQUESTER_ENABLE field is set. This capability
> >>cannot be
> >>detected but is a no-op if set on a component with no support.
> >>These requests
> >>can only be serviced if the upstream components support AtomicOp
> >>completion
> >>and/or routing to a component which does.
> >>
> >>A concrete example is the AMD Fiji-class GPU, which is specified
> >>to support
> >>AtomicOp requests, routed through a PLX 8747 switch (advertising
> >>AtomicOp
> >>routing) to a Haswell host bridge (advertising AtomicOp
> >>completion support).
> >>When AtomicOp requests are disabled the GPU logs attempts to
> >>initiate requests
> >>to an MMIO register for debugging.
> >>
> >>Add pci_enable_atomic_request for per-device control over
> >>AtomicOp requests.
> >>Upstream bridges are checked for AtomicOp routing capability and
> >>the call
> >>fails if any lack this capability. The root port is checked for
> >>AtomicOp
> >>completion capabilities and the call fails if it does not support any.
> >>Routes to other PCIe components are not checked for AtomicOp
> >>routing and
> >>completion capabilities.
> >>
> >>v2: Check for AtomicOp route to root port with AtomicOp completion
> >>v3: Style fixes
> >>
> >>Signed-off-by: Jay Cornwall <jay@jcornwall.me>
> >
> >Hi Jay,
> >
> >Is there a user for this new functionality?  I don't like to add things
> >that have no apparent user.
> >
> >Bjorn
> 
> The client for this code is scheduled to be upstreamed in
> drm/amdgpu, but we have some internal restructuring to complete
> before a patchset will be available.
> 
> If you'd prefer, I can resubmit this patch as part of that series
> when it is ready.

Yeah, that'd be great, why don't we do that.  Thanks!

Bjorn
