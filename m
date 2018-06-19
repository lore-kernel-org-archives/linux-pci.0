Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 19 Jun 2018 17:13:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] PCI: Do not enable PASID when End-to-End TLP is not
 supported
Message-ID: <20180619221359.GG33049@bhelgaas-glaptop.roam.corp.google.com>
References: <1526748769-701-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1526748769-701-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 open list <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 19, 2018 at 12:52:49PM -0400, Sinan Kaya wrote:
> A PCIe endpoint carries the process address space identifier (PASID) in
> the TLP prefix as part of the memory read/write transaction. The address
> information in the TLP is relevant only for a given PASID context.
> 
> A translation agent takes PASID value and the address information from the
> TLP to look up the physical address in the system.
> 
> If a bridge drops the TLP prefix, the translation agent can resolve the
> address to an incorrect location and cause data corruption. Prevent
> this condition by requiring End-to-End TLP prefix to be supported on the
> entire data path between the endpoint and the root port.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/pci/ats.c             | 16 ++++++++++++++++
>  include/uapi/linux/pci_regs.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 89305b5..0bcded5 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -265,7 +265,9 @@ EXPORT_SYMBOL_GPL(pci_reset_pri);
>  int pci_enable_pasid(struct pci_dev *pdev, int features)
>  {
>  	u16 control, supported;
> +	struct pci_dev *bridge;
>  	int pos;
> +	u32 cap;
>  
>  	if (WARN_ON(pdev->pasid_enabled))
>  		return -EBUSY;
> @@ -274,6 +276,20 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (!pos)
>  		return -EINVAL;
>  
> +	bridge = pci_upstream_bridge(pdev);
> +	while (bridge) {
> +		if (!pci_find_capability(bridge, PCI_CAP_ID_EXP))
> +			return -EINVAL;
> +
> +		if (pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap))
> +			return -EINVAL;
> +
> +		if (!(cap & PCI_EXP_DEVCAP2_E2ETLP))
> +			return -EINVAL;
> +
> +		bridge = pci_upstream_bridge(bridge);
> +	}

Hi Sinan,

Would you consider implementing this in the style of c46fd358070f
("PCI/ASPM: Enable Latency Tolerance Reporting when supported"), i.e.,
add a bit in struct pci_dev so we don't have to search up the tree and
re-lookup the PCIe capability several times for the endpoints of the
hierarchy?

This loop looks much like the one in pci_enable_atomic_ops_to_root()
but doesn't use exactly the same iteration.

Maybe we should someday collect up and combine all the places that
read the capability registers so we don't have to read them multiple
times?  Not sure if that would make readability better or worse -- it
would add a second place to look at, while with this patch, everything
is all in one place.

> +
>  	pci_read_config_word(pdev, pos + PCI_PASID_CAP, &supported);
>  	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 103ba79..d91dea5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -634,6 +634,7 @@
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
