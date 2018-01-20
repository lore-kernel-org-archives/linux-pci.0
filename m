Return-Path: <SRS0=78K1=EP=amd.com=Felix.Kuehling@kernel.org>
Return-Path: <SRS0=78K1=EP=amd.com=Felix.Kuehling@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Add pci_enable_atomic_ops_to_root
To: linux-pci@vger.kernel.org, helgaas@kernel.org
Cc: oded.gabbay@gmail.com, Jay.Cornwall@amd.com
References: <1515113100-4718-1-git-send-email-Felix.Kuehling@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <58bc31f6-b4ff-1a24-f8c5-deb8031a266a@amd.com>
Date: Sat, 20 Jan 2018 18:17:50 -0500
MIME-Version: 1.0
In-Reply-To: <1515113100-4718-1-git-send-email-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

Ping.

This commit series is a dependency for getting KFD support for dGPUs
upstream. I'm hoping this will make it into Linux 4.16.

Is there anything missing? Anything else you'd like me to change?

Thank you,
  Felix


On 2018-01-04 07:44 PM, Felix Kuehling wrote:
> From: Jay Cornwall <Jay.Cornwall@amd.com>
>
> The PCIe 3.0 AtomicOp (6.15) feature allows atomic transctions to be
> requested by, routed through and completed by PCIe components. Routing and
> completion do not require software support. Component support for each is
> detectable via the DEVCAP2 register.
>
> A Requester is permitted to use AtomicOps only if its
> PCI_EXP_DEVCTL2_ATOMIC_REQ is set. A driver should set
> PCI_EXP_DEVCTL2_ATOMIC_REQ only if the Completer and all intermediate
> routing elements support AtomicOps.
>
> A concrete example is the AMD Fiji-class GPU, which is specified to
> support AtomicOp requests, routed through a PLX 8747 switch (advertising
> AtomicOp routing) to a Haswell host bridge (advertising AtomicOp
> completion support).
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
> v6: Add comp_caps param, fix upstream port detection, cosmetic/comments
> v7: Reword commit message
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
> +			if ((cap & comp_caps) != comp_caps)
> +				return -EINVAL;
> +			break;
> +		}
> +
> +		/*
> +		 * Upstream ports may block AtomicOps on egress.
> +		 */
> +		if (!bridge->has_secondary_link) {
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
> index c170c92..52a17754 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2061,6 +2061,7 @@ void pci_request_acs(void);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> +int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 comp_caps);
>  
>  #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
>  #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 70c2b2a..f31b56b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -624,7 +624,9 @@
>  #define PCI_EXP_DEVCAP2		36	/* Device Capabilities 2 */
>  #define  PCI_EXP_DEVCAP2_ARI		0x00000020 /* Alternative Routing-ID */
>  #define  PCI_EXP_DEVCAP2_ATOMIC_ROUTE	0x00000040 /* Atomic Op routing */
> -#define PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* Atomic 64-bit compare */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP32	0x00000080 /* 32b AtomicOp completion */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
> +#define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
>  #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
