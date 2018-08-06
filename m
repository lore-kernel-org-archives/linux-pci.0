Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbeHFXOw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Aug 2018 19:14:52 -0400
Date: Mon, 6 Aug 2018 16:03:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, rgummal@xilinx.com
Subject: Re: [PATCH 2/3] PCI: Use dedicated Xilinx controller irq number for
 AER
Message-ID: <20180806210357.GD30691@bhelgaas-glaptop.roam.corp.google.com>
References: <1533141889-19962-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1533141889-19962-3-git-send-email-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533141889-19962-3-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 01, 2018 at 10:14:48PM +0530, Bharat Kumar Gogada wrote:
> Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> Error Interrupt Message Number. The controller has dedicated interrupt line
> for reporting PCIe errors along with AER.
> 
> Using pci_dev->sysdata of root port to save controller irq number, which
> will be used for registering AER irq handler.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  drivers/pci/quirks.c |   29 +++++++++++++++++++++++++++++
>  1 files changed, 29 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f439de8..e666373 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4753,3 +4753,32 @@ static void quirk_gpu_hda(struct pci_dev *hda)
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
> +
> +#if defined(CONFIG_ARCH_ZYNQMP) && defined(CONFIG_PCIE_XILINX_NWL) && \
> +	defined(CONFIG_PCIEAER)
> +/*
> + * Xilinx ZynqMP PS PCIe does not report AER interrupts using Advanced
> + * Error Interrupt Message Number. The controller has dedicated interrupt line
> + * for reporting PCIe errors along with AER.

Your comment says "PCIe errors along with AER", but your ifdef tests
CONFIG_PCIEAER.  Per PCIe r4.0, sec 6.2.6, interrupts can be generated
even if AER isn't supported.  Don't we want to allow that?

> + */
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +
> +static void quirk_xilinx_aer_irq(struct pci_dev *dev)
> +{
> +	struct device_node *dev_node;
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)) {
> +		dev_node = of_find_compatible_node(NULL, NULL,
> +						   "xlnx,nwl-pcie-2.11");
> +		if (!dev_node) {
> +			dev_err(&dev->dev, "Error could not find ZynqMP PS PCIe node\n");

Use pci_err().

Doesn't arm64 support generic kernels that may contain support for
several platforms?  We don't want a warning if a generic kernel
happens to be running on a non-ZynqMP system.

> +			return;
> +		}
> +
> +		dev->sysdata = dev_node->data;
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_XILINX, PCI_ANY_ID, quirk_xilinx_aer_irq);
> +#endif
> -- 
> 1.7.1
> 
