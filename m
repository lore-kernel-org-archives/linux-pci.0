Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35298 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbbINT6p (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2015 15:58:45 -0400
Received: by ykdu9 with SMTP id u9so164841640ykd.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2015 12:58:44 -0700 (PDT)
Date: Mon, 14 Sep 2015 14:58:40 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jay Cornwall <jay@jcornwall.me>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC 0/1] Add AtomicOp Requester support
Message-ID: <20150914195840.GA25767@google.com>
References: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jay,

The [0/n] overview text doesn't get included in the changelog, but
some of this description is very useful background.  So I'd suggest
incorporating at least part of it into the patch changelog.

On Wed, Aug 19, 2015 at 04:10:01PM -0500, Jay Cornwall wrote:
> The PCIe 3.0 AtomicOp (6.15) feature allows atomic transctions to be requested
> by, routed through and completed by PCIe components. Routing and completion
> do not require software support. Component support for each is detectable via
> the DEVCAP2 register.
> 
> AtomicOp requests are permitted only if a component's
> DEVCTL2.ATOMICOP_REQUESTER_ENABLE field is set. This capability cannot be
> detected but is a no-op if set on a component with no support. These requests
> can only be serviced if the upstream components support AtomicOp completion
> and/or routing to a component which does.
> 
> A concrete example is the AMD Fiji-class GPU, which is specified to support
> AtomicOp requests, routed through a PLX 8747 switch (advertising AtomicOp
> routing) to a Haswell host bridge (advertising AtomicOp completion support).
> When AtomicOp requests are disabled the GPU logs attempts to initiate requests
> to an MMIO register for debugging.
> 
> Several approaches for software support might be considered:
> 
>   1. drivers/pci sets DEVCTL2.ATOMICOP_REQUESTER_ENABLE unconditionally for
>      all endpoints and root ports
> 
>   2. drivers/pci attempts to establish a routable path to a completer prior to
>      setting DEVCTL2.ATOMICOP_REQUESTER_ENABLE
> 
>   3. Approach 1/2 with individual drivers (drm/amdgpu in the above example)
>      initiating the request for AtomicOp requester support through a function
>      exported from drivers/pci
> 
>   4. Individual drivers specify a target component for AtomicOp completion
> 
> Approach 1 has two drawbacks. There is no guarantee that there is a reachable
> component which can complete an AtomicOp request. It also prevents individual
> drivers from blacklisting devices with known incorrect implementations. This
> might otherwise provide useful diagnostics information. (e.g. AMD GPUs will
> log an error to an MMIO register if the AtomicOp requester is disabled when an
> atomic memory request would have been promoted to an AtomicOp.)
> 
> Approach 2 could only establish that there is a path to at least one completer,
> but it would not prevent requests being sent to a different device which does
> not support AtomicOp completion. For example, a root complex might support
> completion but a transaction could be sent to a different device which does
> not. The routable guarantee is not precise and so less useful.

I assume the common usage scenario is to enable AtomicOps for
host-to-device and/or device-to-host transactions, and we can ignore
device-to-device transactions for now.

If I understand correctly, AtomicOps must be supported by all devices
along the path, e.g., a Root Port, possibly some Switch Ports, and
finally an Endpoint.  I guess your worry with Approach 2 is for a
scenario like this:

  00:1c.0: PCI bridge to [bus 01-04]  Root Port, with AtomicOp Routing
  01:00.0: PCI bridge to [bus 02-04]  Upstream Port, with AtomicOp Routing
  02:00.0: PCI bridge to [bus 03]     Downstream Port, with AtomicOp Routing
  03:00.0: endpoint                   AtomicOp Completer Supported
  02:00.1: PCI bridge to [bus 04]     Downstream Port, with AtomicOp Routing
  04:00.0: endpoint                   no AtomicOp Completer support

It's true that we wouldn't want to enable AtomicOp routing to 04:00.0,
but isn't that what the AtomicOp Egress Blocking bit is for?  If we
set that in 02:00.1, we should be safe in the sense that AtomicOps
targeting 04:00.0 should cause non-fatal errors.

> Approach 3 allows drivers to enable AtomicOp requests on a per-device basis to
> support blacklisting. A downside is that if AtomicOp support becomes more
> prevalent it may be undesirable to explicitly enable the feature in individual
> drivers.

Your pci_enable_atomic_request() enables AtomicOps for one component.
I assume that means the driver would have to map out the topology,
figure out whether all the components support AtomicOp routing, and
call pci_enable_atomic_request() for the Root Port and the Endpoint.
That seems like a lot of grubbing around for a driver.

I think a driver should only call pci_enable_atomic_request() for its
own device, and the PCI core should figure out whether it can be
enabled, and if it can, do everything needed to enable it.

> Approach 4 is intractable as the target for a transaction is generally known
> only by the application. DEVCTL2.ATOMICOP_REQUESTER_ENABLE is also a 1:many
> capability and would not align well with this model.
> 
> In the absence of an ideal solution, I think approach 3(1) is the most
> appropriate. I am open to suggestions for an improved implementation.
> 
> Jay Cornwall (1):
>   PCI: Add pci_enable_atomic_request
> 
>  drivers/pci/pci.c             | 23 +++++++++++++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  1 +
>  3 files changed, 25 insertions(+)
> 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
