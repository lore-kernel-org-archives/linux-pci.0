Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sat, 30 Jun 2018 14:24:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
Message-ID: <20180630192403.GC9547@bhelgaas-glaptop.roam.corp.google.com>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 30, 2018 at 11:24:24AM -0400, Sinan Kaya wrote:
> A PCIe endpoint carries the process address space identifier (PASID) in
> the TLP prefix as part of the memory read/write transaction. The address
> information in the TLP is relevant only for a given PASID context.
> 
> An IOMMU takes PASID value and the address information from the
> TLP to look up the physical address in the system.
> 
> PASID is an End-End TLP Prefix (PCIe r4.0, sec 6.20).  Sec 2.2.10.2 says
> 
>   It is an error to receive a TLP with an End-End TLP Prefix by a
>   Receiver that does not support End-End TLP Prefixes. A TLP in
>   violation of this rule is handled as a Malformed TLP. This is a
>   reported error associated with the Receiving Port (see Section 6.2).
> 
> Prevent error condition by proactively requiring End-to-End TLP
> prefix to be supported on the entire data path between the endpoint and
> the root port before enabling PASID.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Applied to pci/virtualization for v4.19, thanks!

> ---
>  drivers/pci/ats.c             |  3 +++
>  drivers/pci/probe.c           | 24 ++++++++++++++++++++++++
>  include/linux/pci.h           |  1 +
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 4923a2a..5b78f3b 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -273,6 +273,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
>  
> +	if (!pdev->eetlp_prefix_path)
> +		return -EINVAL;
> +
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PASID);
>  	if (!pos)
>  		return -EINVAL;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ac876e3..39fd3ac 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2042,6 +2042,29 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  #endif
>  }
>  
> +static void pci_configure_eetlp_prefix(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCI_PASID
> +	struct pci_dev *bridge;
> +	u32 cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
> +	if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +		return;
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		dev->eetlp_prefix_path = 1;
> +	else {
> +		bridge = pci_upstream_bridge(dev);
> +		if (bridge && bridge->eetlp_prefix_path)
> +			dev->eetlp_prefix_path = 1;
> +	}
> +#endif
> +}
> +
>  static void pci_configure_device(struct pci_dev *dev)
>  {
>  	struct hotplug_params hpp;
> @@ -2051,6 +2074,7 @@ static void pci_configure_device(struct pci_dev *dev)
>  	pci_configure_extended_tags(dev, NULL);
>  	pci_configure_relaxed_ordering(dev);
>  	pci_configure_ltr(dev);
> +	pci_configure_eetlp_prefix(dev);
>  
>  	memset(&hpp, 0, sizeof(hpp));
>  	ret = pci_get_hp_params(dev, &hpp);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 340029b..6ba8184 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -350,6 +350,7 @@ struct pci_dev {
>  	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
>  					   supported from root to here */
>  #endif
> +	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
>  
>  	pci_channel_state_t error_state;	/* Current connectivity state */
>  	struct device	dev;			/* Generic device interface */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 4da87e2..a617ab2 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -636,6 +636,7 @@
>  #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
> +#define PCI_EXP_DEVCAP2_E2ETLP		0x00200000 /* End-to-End TLP Prefix */
>  #define PCI_EXP_DEVCTL2		40	/* Device Control 2 */
>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT	0x000f	/* Completion Timeout Value */
>  #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS	0x0010	/* Completion Timeout Disable */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
