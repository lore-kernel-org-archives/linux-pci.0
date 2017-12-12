Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbdLLX1M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Dec 2017 18:27:12 -0500
Date: Tue, 12 Dec 2017 17:27:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: oded.gabbay@gmail.com, amd-gfx@lists.freedesktop.org,
        Jay Cornwall <Jay.Cornwall@amd.com>, linux-pci@vger.kernel.org,
        Ram Amrani <Ram.Amrani@cavium.com>,
        Doug Ledford <dledford@redhat.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        Ariel Elior <Ariel.Elior@cavium.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 29/37] PCI: Add pci_enable_atomic_ops_to_root
Message-ID: <20171212232707.GF53955@bhelgaas-glaptop.roam.corp.google.com>
References: <1512792555-26042-1-git-send-email-Felix.Kuehling@amd.com>
 <1512792555-26042-30-git-send-email-Felix.Kuehling@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1512792555-26042-30-git-send-email-Felix.Kuehling@amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Ram, Michal, Ariel, Doug, Jason]

The [29/37] in the subject makes it look like this is part of a larger
series, but I can't find the rest of it on linux-pci or linux-kernel.

I don't want to merge a new interface unless there's an in-tree user
of it.  I assume the rest of the series includes a user.

On Fri, Dec 08, 2017 at 11:09:07PM -0500, Felix Kuehling wrote:
> From: Jay Cornwall <Jay.Cornwall@amd.com>
> 
> The PCIe 3.0 AtomicOp (6.15) feature allows atomic transctions to be
> requested by, routed through and completed by PCIe components. Routing and
> completion do not require software support. Component support for each is
> detectable via the DEVCAP2 register.
> 
> AtomicOp requests are permitted only if a component's
> DEVCTL2.ATOMICOP_REQUESTER_ENABLE field is set. This capability cannot be
> detected but is a no-op if set on a component with no support. These
> requests can only be serviced if the upstream components support AtomicOp
> completion and/or routing to a component which does.
> 
> A concrete example is the AMD Fiji-class GPU, which is specified to
> support AtomicOp requests, routed through a PLX 8747 switch (advertising
> AtomicOp routing) to a Haswell host bridge (advertising AtomicOp
> completion support). When AtomicOp requests are disabled the GPU logs
> attempts to initiate requests to an MMIO register for debugging.
> 
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
> 
> CC: linux-pci@vger.kernel.org
> Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/pci/pci.c             | 81 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  2 ++
>  3 files changed, 84 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6078dfc..89a8bb0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2966,6 +2966,87 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  }
>  
>  /**
> + * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
> + * @dev: the PCI device
> + *
> + * Return 0 if the device is capable of generating AtomicOp requests,

I don't believe this part.

You return 0 if the upstream path can route AtomicOps and the Root
Port can complete them.  But there's nothing here that's conditional
on capabilities of *dev*.

You could read back PCI_EXP_DEVCTL2 to see if
PCI_EXP_DEVCTL2_ATOMIC_REQ was writable, but even then, you can't
really tell what the device is capable of.

> + * all upstream bridges support AtomicOp routing, egress blocking is disabled
> + * on all upstream ports, and the root port supports 32-bit, 64-bit and/or
> + * 128-bit AtomicOp completion, or negative otherwise.
> + */
> +int pci_enable_atomic_ops_to_root(struct pci_dev *dev)
> +{
> +	struct pci_bus *bus = dev->bus;
> +
> +	if (!pci_is_pcie(dev))
> +		return -EINVAL;
> +
> +	switch (pci_pcie_type(dev)) {
> +	/*
> +	 * PCIe 3.0, 6.15 specifies that endpoints and root ports are permitted
> +	 * to implement AtomicOp requester capabilities.
> +	 */
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_LEG_END:
> +	case PCI_EXP_TYPE_RC_END:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	while (bus->parent) {
> +		struct pci_dev *bridge = bus->self;
> +		u32 cap;
> +
> +		pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
> +
> +		switch (pci_pcie_type(bridge)) {
> +		/*
> +		 * Upstream, downstream and root ports may implement AtomicOp
> +		 * routing capabilities. AtomicOp routing via a root port is
> +		 * not considered.
> +		 */
> +		case PCI_EXP_TYPE_UPSTREAM:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTE))
> +				return -EINVAL;
> +			break;
> +
> +		/*
> +		 * Root ports are permitted to implement AtomicOp completion
> +		 * capabilities.
> +		 */
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +			if (!(cap & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
> +				     PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
> +				     PCI_EXP_DEVCAP2_ATOMIC_COMP128)))
> +				return -EINVAL;
> +			break;
> +		}

IIUC, you want to enable an endpoint, e.g., an AMD Fiji-class GPU, to
initiate AtomicOps that target system memory.  This interface
(pci_enable_atomic_ops_to_root()) doesn't specify what size operations
the driver wants to do.  If the GPU requests a 128-bit op and the Root
Port doesn't support it, I think we'll see an Unsupported Request
error.

Do you need to extend this interface so the driver can specify what
sizes it wants?

The existing code in qedr_pci_set_atomic() is very similar.  We should
make this new interface work for both places, then actually use it in
qedr_pci_set_atomic().

> +
> +		/*
> +		 * Upstream ports may block AtomicOps on egress.
> +		 */
> +		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_UPSTREAM) {

pci_pcie_type() is not a reliable method for determining the function
of a switch port.  There are systems where the upstream port is
labeled as a downstream port, e.g.,
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c8fc9339409d

> +			u32 ctl2;
> +
> +			pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2,
> +						   &ctl2);
> +			if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_EGRESS_BLOCK)
> +				return -EINVAL;
> +		}
> +
> +		bus = bus->parent;
> +	}
> +
> +	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> +				 PCI_EXP_DEVCTL2_ATOMIC_REQ);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
> +
> +/**
>   * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
>   * @dev: the PCI device
>   * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f4f8ee5..2a39f63 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2062,6 +2062,7 @@ void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> +int pci_enable_atomic_ops_to_root(struct pci_dev *dev);
>  
>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
>  #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index f8d5804..45f251a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -623,7 +623,9 @@
>  #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
>  #define  PCI_EXP_DEVCAP2_ARI		0x00000020 /* Alternative Routing-ID */
>  #define  PCI_EXP_DEVCAP2_ATOMIC_ROUTE	0x00000040 /* Atomic Op routing */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp completion */
>  #define PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* Atomic 64-bit compare */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion*/

The comments should be similar.  I think yours are better than the
original, so please change the original to

  /* 64b AtomicOp completion */

so they all match.

>  #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
> -- 
> 2.7.4
> 
