Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751108AbeAEAR2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jan 2018 19:17:28 -0500
Date: Thu, 4 Jan 2018 18:17:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, oded.gabbay@gmail.com,
        Jay Cornwall <Jay.Cornwall@amd.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/9] PCI: Add pci_enable_atomic_ops_to_root
Message-ID: <20180105001725.GL189897@bhelgaas-glaptop.roam.corp.google.com>
References: <1515104268-25087-1-git-send-email-Felix.Kuehling@amd.com>
 <1515104268-25087-2-git-send-email-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515104268-25087-2-git-send-email-Felix.Kuehling@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 04, 2018 at 05:17:40PM -0500, Felix Kuehling wrote:
> From: Jay Cornwall <Jay.Cornwall@amd.com>
> 
> The PCIe 3.0 AtomicOp (6.15) feature allows atomic transctions to be
> requested by, routed through and completed by PCIe components. Routing and
> completion do not require software support. Component support for each is
> detectable via the DEVCAP2 register.
> 
> AtomicOp requests are permitted only if a component's
> DEVCTL2.ATOMICOP_REQUESTER_ENABLE field is set. This capability cannot be
> detected but is a no-op if set on a component with no support. 

I guess the driver is supposed to know whether its hardware is capable
of using AtomicOps, so the device itself doesn't need to advertise it.

I would word this as "A Requester is permitted to use AtomicOps only
if its PCI_EXP_DEVCTL2_ATOMIC_REQ is set.  A driver should set
PCI_EXP_DEVCTL2_ATOMIC_REQ only if the Completer and all intermediate
routing elements support AtomicOps."

> These
> requests can only be serviced if the upstream components support AtomicOp
> completion and/or routing to a component which does.
> 
> A concrete example is the AMD Fiji-class GPU, which is specified to
> support AtomicOp requests, routed through a PLX 8747 switch (advertising
> AtomicOp routing) to a Haswell host bridge (advertising AtomicOp
> completion support). When AtomicOp requests are disabled the GPU logs
> attempts to initiate requests to an MMIO register for debugging.

The last sentence isn't really relevant to this patch.

> Add pci_enable_atomic_ops_to_root for per-device control over AtomicOp
> requests. Upstream bridges are checked for AtomicOp routing capability and
> the call fails if any lack this capability. The root port is checked for
> AtomicOp completion capabilities and the call fails if it does not support
> any. Routes to other PCIe components are not checked for AtomicOp routing
> and completion capabilities.
> 
> v2: Check for AtomicOp route to root port with AtomicOp completion
> v3: Style fixes
> v4: Endpoint to root port only, check upstream egress blocking
> v5: Rebase, use existing PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK define
> v6: Add comp_caps param, fix upstream port detection, cosmetic/comments
> 
> CC: linux-pci@vger.kernel.org
> Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/pci/pci.c             | 80 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  4 ++-
>  3 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 4a7c686..9cea399 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3066,6 +3066,86 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
>  }
>  
>  /**
> + * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
> + * @dev: the PCI device
> + * @comp_caps: Caps required for atomic request completion
> + *
> + * Return 0 if all upstream bridges support AtomicOp routing, egress
> + * blocking is disabled on all upstream ports, and the root port
> + * supports the requested completion capabilities (32-bit, 64-bit
> + * and/or 128-bit AtomicOp completion), or negative otherwise.
> + */
> +int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 comp_caps)

I still want to see this used to replace qedr_pci_set_atomic() if
that's possible.  I'm not convinced yet that they need to be
different.

Bjorn
