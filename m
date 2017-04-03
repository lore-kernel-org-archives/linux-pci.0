Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750945AbdDCVDY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Apr 2017 17:03:24 -0400
Date: Mon, 3 Apr 2017 16:03:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        alex.williamson@redhat.com, dima.ruinskiy@intel.com,
        alexander.h.duyck@intel.com
Subject: Re: [PATCH] PCI: do not perform FLR for 82579 devices
Message-ID: <20170403210319.GB13232@bhelgaas-glaptop.roam.corp.google.com>
References: <20170319081542.20908-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170319081542.20908-1-sasha.neftin@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 19, 2017 at 10:15:42AM +0200, Sasha Neftin wrote:
> This patch come to solve problem of 82579 network adapters hang.
> Link on Datasheets and Specification Updates:
> http://www.intel.com/content/www/us/en/embedded/products
> /networking/82579-gigabit-ethernet-connection-family-documentation.html
> Please, refer to Specification Update:
> http://www.intel.com/content/dam/www/public/us/en/documents/
> specification-updates/
> 82579lm-82579v-gigabit-network-connection-spec-update.pdf
> 
> Reproduction:
> Attach the device to a VM, then detach and try to attach again.
> 
> Fix:
> Operating system won't support FLR for 82579 devices.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>

Applied to pci/virtualization for v4.12, thanks!

> ---
>  drivers/pci/pci.c    |  6 ++++++
>  drivers/pci/quirks.c | 13 +++++++++++++
>  include/linux/pci.h  |  2 ++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7904d02ffdb9..bef14777bb30 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3781,6 +3781,9 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>  	if (!(cap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
>  
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> @@ -3801,6 +3804,9 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  	if (!pos)
>  		return -ENOTTY;
>  
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
>  	pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap);
>  	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
>  		return -ENOTTY;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1800befa8b8b..eb333a61637e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4566,3 +4566,16 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2030, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2031, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2032, quirk_no_aersid);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2033, quirk_no_aersid);
> +
> +/*
> + * Workaround FLR issues for 82579 devices
> + * This code make sure not perform the FLR (Function Level Reset) via PCIe,
> + * in order to workaround a bug found while using device passthrough,
> + * where the interface would become non-responsive.
> + */
> +static void quirk_intel_no_flr(struct pci_dev *dev)
> +{
> +	dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_intel_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_intel_no_flr);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e2d1a124216a..f4fea5ad2d12 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -178,6 +178,8 @@ enum pci_dev_flags {
>  	PCI_DEV_FLAGS_NO_PM_RESET = (__force pci_dev_flags_t) (1 << 7),
>  	/* Get VPD from function 0 VPD */
>  	PCI_DEV_FLAGS_VPD_REF_F0 = (__force pci_dev_flags_t) (1 << 8),
> +	/* Do not use FLR even if device advertises PCI_AF_CAP */
> +	PCI_DEV_FLAGS_NO_FLR_RESET = (__force pci_dev_flags_t) (1 << 9),
>  };
>  
>  enum pci_irq_reroute_variant {
> -- 
> 2.11.0
> 
