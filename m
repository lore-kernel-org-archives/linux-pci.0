Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40926 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbbLDSZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 4 Dec 2015 13:25:45 -0500
Date: Fri, 4 Dec 2015 12:25:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jay Cornwall <jay@jcornwall.me>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Add pci_enable_atomic_request
Message-ID: <20151204182540.GC20125@localhost>
References: <1443110390-4080-1-git-send-email-jay@jcornwall.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443110390-4080-1-git-send-email-jay@jcornwall.me>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 24, 2015 at 10:59:50AM -0500, Jay Cornwall wrote:
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
> Add pci_enable_atomic_request for per-device control over AtomicOp requests.
> Upstream bridges are checked for AtomicOp routing capability and the call
> fails if any lack this capability. The root port is checked for AtomicOp
> completion capabilities and the call fails if it does not support any.
> Routes to other PCIe components are not checked for AtomicOp routing and
> completion capabilities.
> 
> v2: Check for AtomicOp route to root port with AtomicOp completion
> v3: Style fixes
> 
> Signed-off-by: Jay Cornwall <jay@jcornwall.me>

Hi Jay,

Is there a user for this new functionality?  I don't like to add things
that have no apparent user.

Bjorn

> ---
>  drivers/pci/pci.c             | 70 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  5 ++++
>  3 files changed, 76 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6a9a111..edc56e4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2453,6 +2453,76 @@ bool pci_acs_path_enabled(struct pci_dev *start,
>  }
>  
>  /**
> + * pci_enable_atomic_request - enable or disable AtomicOp requester
> + * @dev: the PCI device
> + *
> + * Return 0 if the device is capable of generating AtomicOp requests,
> + * all upstream bridges support AtomicOp routing, and the root port supports
> + * 32-bit, 64-bit and/or 128-bit AtomicOp completion, or negative otherwise.
> + */
> +int pci_enable_atomic_request(struct pci_dev *dev)
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
> +	case PCI_EXP_TYPE_ROOT_PORT:
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
> +			if (!(cap & PCI_EXP_DEVCAP2_ATOMIC_ROUTING))
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
> +
> +
> +		bus = bus->parent;
> +	}
> +
> +	pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> +				 PCI_EXP_DEVCTL2_ATOMICOP_REQ);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(pci_enable_atomic_request);
> +
> +/**
>   * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
>   * @dev: the PCI device
>   * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTC, 4=INTD)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e90eb22..4e50003 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1801,6 +1801,7 @@ void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> +int pci_enable_atomic_request(struct pci_dev *dev);
>  
>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
>  #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 413417f..013c2bd 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -571,6 +571,10 @@
>   */
>  #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
>  #define  PCI_EXP_DEVCAP2_ARI		0x00000020 /* Alternative Routing-ID */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_ROUTING	0x00000040 /* AtomicOp routing */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp completion */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion*/
>  #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
> @@ -578,6 +582,7 @@
>  #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
>  #define  PCI_EXP_DEVCTL2_ARI		0x0020	/* Alternative Routing-ID */
> +#define  PCI_EXP_DEVCTL2_ATOMICOP_REQ	0x0040	/* Allow AtomicOp requests */
>  #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
>  #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
>  #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
