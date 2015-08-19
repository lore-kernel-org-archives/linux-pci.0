Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0056.outbound.protection.outlook.com ([157.56.111.56]:23714
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751015AbbHTC0T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Aug 2015 22:26:19 -0400
From: Jay Cornwall <jay@jcornwall.me>
To: <linux-pci@vger.kernel.org>
CC: Jay Cornwall <jay@jcornwall.me>
Subject: [PATCH RFC 0/1] Add AtomicOp Requester support
Date: Wed, 19 Aug 2015 16:10:01 -0500
Message-ID: <1440018602-4212-1-git-send-email-jay@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The PCIe 3.0 AtomicOp (6.15) feature allows atomic transctions to be requested
by, routed through and completed by PCIe components. Routing and completion
do not require software support. Component support for each is detectable via
the DEVCAP2 register.

AtomicOp requests are permitted only if a component's
DEVCTL2.ATOMICOP_REQUESTER_ENABLE field is set. This capability cannot be
detected but is a no-op if set on a component with no support. These requests
can only be serviced if the upstream components support AtomicOp completion
and/or routing to a component which does.

A concrete example is the AMD Fiji-class GPU, which is specified to support
AtomicOp requests, routed through a PLX 8747 switch (advertising AtomicOp
routing) to a Haswell host bridge (advertising AtomicOp completion support).
When AtomicOp requests are disabled the GPU logs attempts to initiate requests
to an MMIO register for debugging.

Several approaches for software support might be considered:

  1. drivers/pci sets DEVCTL2.ATOMICOP_REQUESTER_ENABLE unconditionally for
     all endpoints and root ports

  2. drivers/pci attempts to establish a routable path to a completer prior to
     setting DEVCTL2.ATOMICOP_REQUESTER_ENABLE

  3. Approach 1/2 with individual drivers (drm/amdgpu in the above example)
     initiating the request for AtomicOp requester support through a function
     exported from drivers/pci

  4. Individual drivers specify a target component for AtomicOp completion

Approach 1 has two drawbacks. There is no guarantee that there is a reachable
component which can complete an AtomicOp request. It also prevents individual
drivers from blacklisting devices with known incorrect implementations. This
might otherwise provide useful diagnostics information. (e.g. AMD GPUs will
log an error to an MMIO register if the AtomicOp requester is disabled when an
atomic memory request would have been promoted to an AtomicOp.)

Approach 2 could only establish that there is a path to at least one completer,
but it would not prevent requests being sent to a different device which does
not support AtomicOp completion. For example, a root complex might support
completion but a transaction could be sent to a different device which does
not. The routable guarantee is not precise and so less useful.

Approach 3 allows drivers to enable AtomicOp requests on a per-device basis to
support blacklisting. A downside is that if AtomicOp support becomes more
prevalent it may be undesirable to explicitly enable the feature in individual
drivers.

Approach 4 is intractable as the target for a transaction is generally known
only by the application. DEVCTL2.ATOMICOP_REQUESTER_ENABLE is also a 1:many
capability and would not align well with this model.

In the absence of an ideal solution, I think approach 3(1) is the most
appropriate. I am open to suggestions for an improved implementation.

Jay Cornwall (1):
  PCI: Add pci_enable_atomic_request

 drivers/pci/pci.c             | 23 +++++++++++++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  1 +
 3 files changed, 25 insertions(+)

-- 
1.9.1

