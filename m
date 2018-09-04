Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeIDRdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 13:33:45 -0400
Date: Tue, 4 Sep 2018 08:08:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/VMD: Set up firmware first if capable
Message-ID: <20180904130839.GA107892@bhelgaas-glaptop.roam.corp.google.com>
References: <1535675403-2903-1-git-send-email-jonathan.derrick@intel.com>
 <1535675403-2903-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1535675403-2903-2-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2018 at 06:30:03PM -0600, Jon Derrick wrote:
> Some VMD devices will want to use firmware first error-handling on the
> entire domain. This is detected by the BIOS setting the VMD endpoint's
> interface to 0x1.

I assume there's some spec that codifies this "programming interface
0x1 means firmware-first".  Can you reference that section of the
spec?  Even if it's not public, it will help people who maintain this
in the future.

I also have questions along the lines of Keith's: how are errors
reported in the non-firmware-first case, and in the firmware-first
case, how are the errors passed on to the OS?

> Detect this condition and propogate it to the entire domain.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/pci/common.c        | 17 ++++++++++++++++-
>  drivers/pci/controller/vmd.c | 25 ++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index d4ec117..f07f2e4 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -663,8 +663,23 @@ static void set_dma_domain_ops(struct pci_dev *pdev) {}
>  
>  static void set_dev_domain_options(struct pci_dev *pdev)
>  {
> -	if (is_vmd(pdev->bus))
> +	if (is_vmd(pdev->bus)) {
> +		struct pci_host_bridge *hb;
> +		struct pci_dev *vmd;
> +
>  		pdev->hotplug_user_indicators = 1;
> +
> +		/*
> +		 * The VMD endpoint is not PCIe, so will fail
> +		 * pcie_aer_get_firmware_first(). Set and get the raw member
> +		 * instead.
> +		 */
> +		hb = pci_find_host_bridge(pdev->bus);
> +		vmd = to_pci_dev(hb->dev.parent);
> +
> +		pdev->__aer_firmware_first = vmd->__aer_firmware_first;
> +		pdev->__aer_firmware_first_valid = vmd->__aer_firmware_first_valid;
> +	}
>  }
>  
>  int pcibios_add_device(struct pci_dev *dev)
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index fd2dbd7..74a1a04 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -44,6 +44,11 @@ enum vmd_features {
>  	 * bus numbering
>  	 */
>  	VMD_FEAT_HAS_BUS_RESTRICTIONS	= (1 << 1),
> +
> +	/*
> +	 * Device may request firmware first error-handling on the domain
> +	 */
> +	VMD_FEAT_HAS_FIRMWARE_FIRST	= (1 << 2),
>  };
>  
>  /*
> @@ -633,6 +638,23 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  			busn_start = 128;
>  	}
>  
> +	/*
> +	 * Certain VMD devices may request firmware first error-handling
> +	 * support on the domain. These domains are virtual and not described
> +	 * by ACPI, so we must set it explicitly. This sets firmware first on
> +	 * the endpoint and has a corresponding domain setting in
> +	 * arch/x86/pci/common.c
> +	 */
> +	if (features & VMD_FEAT_HAS_FIRMWARE_FIRST) {
> +		u8 interface;
> +
> +		pci_read_config_byte(vmd->dev, PCI_CLASS_PROG, &interface);
> +		if (interface == 0x1) {

This test of the programming interface should have a spec reference so
it doesn't look magical.

> +			vmd->dev->__aer_firmware_first = 1;
> +			vmd->dev->__aer_firmware_first_valid = 1;
> +		}
> +	}
> +
>  	res = &vmd->dev->resource[VMD_CFGBAR];
>  	vmd->resources[0] = (struct resource) {
>  		.name  = "VMD CFGBAR",
> @@ -860,7 +882,8 @@ static int vmd_resume(struct device *dev)
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> -				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
> +				VMD_FEAT_HAS_BUS_RESTRICTIONS |
> +				VMD_FEAT_HAS_FIRMWARE_FIRST,},

Why is this connected to specific hardware versions?  The non-VMD
firmware-first functionality is determined by firmware, independent of
any particular PCI device.

If there's a spec that says "programming interface 0x1 means something
other than firmware-first" on some devices, you could cite it here.
If early devices are an exception and programming interface will have
a consistent meaning in the future, you might be able to invert this
so you only have to mark the early devices instead of every new
version.

>  	{0,}
>  };
>  MODULE_DEVICE_TABLE(pci, vmd_ids);
> -- 
> 1.8.3.1
> 
