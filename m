Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 May 2018 08:45:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: dmeyer@gigaio.com
Cc: logang@deltatee.com, kurt.schwemmer@microsemi.com,
        linux-pci@vger.kernel.org, linux-ntb@googlegroups.com,
        bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
        allenbh@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
Message-ID: <20180517134521.GC19955@bhelgaas-glaptop.roam.corp.google.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 17, 2018 at 05:00:13AM -0700, dmeyer@gigaio.com wrote:
> From: Doug Meyer <dmeyer@gigaio.com>
> 
> Here we add the PCI quirk for the Microsemi Switchtec parts to allow
> non-transparent bridging to work when the IOMMU is turned on.

I'm not an NTB expert, but it *sounds* like you're specifically fixing
DMA initiated by an NT endpoint.  I assume other aspects of
non-transparent bridging, e.g., routing of config accesses,
interrupts, doorbells, etc., might work even without this quirk.

> When a requestor on one NT endpoint accesses memory on another NT
> endpoint, it does this via a devfn proxy ID. Proxy IDs are uniquely
> assigned on a per-requestor basis within the NT hardware, and are not
> visible via PCI enumeration. As a result, a memory access from a peer
> NT endpoint will have an unrecognized requestor ID devfn which the
> IOMMU will reject.

It would be very helpful if you could include a reference to the
relevant section of a publicly available spec.

> The quirk introduced here interrogates each configured remote NT
> endpoint at runtime to obtain the proxy IDs that have been assigned,
> and aliases every proxy ID to the local (enumerated) NT endpoint's
> device. The IOMMU then accepts the remote proxy IDs as if they were
> requests coming directly from the enumerated endpoint, giving remote
> requestors access to memory resources which a given host has made
> available. Operation with the IOMMU off is unchanged by this quirk.

Who assigns these proxy IDs?  Quirks run before drivers claim the
device, so it looks like this assumes the proxy ID assignments are
either hard-wired into the device or programmed by firmware.  If the
latter, how would they be programmed for hot-added NTBs?

I'm wondering if all this could or should be done in the switchtec
driver instead of in a quirk.  But I really don't know how that driver
works.

> Signed-off-by: Doug Meyer <dmeyer@gigaio.com>
> ---
>  drivers/pci/quirks.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 196 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 2990ad1..c7e27b3 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -27,6 +27,7 @@
>  #include <linux/mm.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/switchtec.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -4741,3 +4742,198 @@ static void quirk_gpu_hda(struct pci_dev *hda)
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> +
> +/*
> + * Microsemi Switchtec NTB uses devfn proxy IDs to move TLPs between
> + * NT endpoints via the internal switch fabric. These IDs replace the
> + * originating requestor ID TLPs which access host memory on peer NTB
> + * ports. Therefore, all proxy IDs must be aliased to the NTB device
> + * to permit access when the IOMMU is turned on.
> + */
> +static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
> +{
> +	void __iomem *mmio = NULL;

Don't initialize variables unless there's a path through the
code that would otherwise use an uninitialized value.

> +	struct ntb_info_regs __iomem *mmio_ntb = NULL;
> +	struct ntb_ctrl_regs __iomem *mmio_ctrl = NULL;
> +	struct sys_info_regs __iomem *mmio_sys_info = NULL;
> +

No blank line here.

> +	u64 partition_map;
> +	u8 partition;
> +	int pp;
> +
> +	if (pci_enable_device(pdev)) {
> +		dev_err(&pdev->dev, "Cannot enable Switchtec device\n");

Use "pci_err(pdev, ...)" here and below.

> +		return;
> +	}
> +
> +	mmio = pci_iomap(pdev, 0, 0);
> +	if (mmio == NULL) {
> +		dev_err(&pdev->dev, "Cannot iomap Switchtec device\n");
> +		return;
> +	}
> +
> +	dev_info(&pdev->dev, "Setting Switchtec proxy ID aliases\n");
> +
> +	mmio_ntb = mmio + SWITCHTEC_GAS_NTB_OFFSET;
> +	mmio_ctrl = (void * __iomem) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
> +	mmio_sys_info = mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
> +
> +	partition = ioread8(&mmio_ntb->partition_id);
> +
> +	partition_map = (u64) ioread32((void * __iomem) &mmio_ntb->ep_map);
> +	partition_map |=
> +		((u64) ioread32((void * __iomem) &mmio_ntb->ep_map + 4)) << 32;
> +	partition_map &= ~(1ULL << partition);
> +
> +	for (pp = 0; pp < (sizeof(partition_map) * 8); pp++) {
> +		struct ntb_ctrl_regs __iomem *mmio_peer_ctrl;
> +		u32 table_sz = 0;
> +		int te;
> +
> +		if (!(partition_map & (1ULL << pp)))
> +			continue;
> +
> +		dev_dbg(&pdev->dev, "Processing partition %d\n", pp);
> +
> +		mmio_peer_ctrl = &mmio_ctrl[pp];
> +
> +		table_sz = ioread16(&mmio_peer_ctrl->req_id_table_size);
> +		if (!table_sz) {
> +			dev_warn(&pdev->dev, "Partition %d table_sz 0\n", pp);
> +			continue;
> +		}
> +
> +		if (table_sz > 512) {
> +			dev_warn(&pdev->dev,
> +				 "Invalid Switchtec partition %d table_sz %d\n",
> +				 pp, table_sz);
> +			continue;
> +		}
> +
> +		for (te = 0; te < table_sz; te++) {
> +			u32 rid_entry;
> +			u8 devfn;
> +
> +			rid_entry = ioread32(&mmio_peer_ctrl->req_id_table[te]);
> +			devfn = (rid_entry >> 1) & 0xFF;
> +			dev_dbg(&pdev->dev,
> +				"Aliasing Partition %d Proxy ID %02d.%d\n",
> +				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +			pci_add_dma_alias(pdev, devfn);
> +		}
> +	}
> +
> +	pci_iounmap(pdev, mmio);

I think you should probably disable the device here (and in the error
return path) to balance the enable above.

> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFX24XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFX32XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFX48XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFX64XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFX80XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFX96XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PSX48XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PSX64XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PSX80XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PSX96XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PAX24XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PAX32XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PAX48XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PAX64XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PAX80XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PAX96XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXL24XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXL32XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXL48XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXL64XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXL80XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXL96XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXI24XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXI32XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXI48XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXI64XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXI80XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_MICROSEMI,
> +			      PCI_DEVICE_ID_MICROSEMI_PFXI96XG3,
> +			      PCI_CLASS_BRIDGE_OTHER, 8,
> +			      quirk_switchtec_ntb_dma_alias);
> -- 
> 1.8.3.1
> 
