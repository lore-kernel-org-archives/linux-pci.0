Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34260 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388324AbeGXRGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jul 2018 13:06:43 -0400
Subject: Re: [PATCH v2] PCI/AER: Do not clear AER bits if we don't own AER
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Frederick Lawler <fred@fredlawl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
References: <20180717153135.25925-1-mr.nuke.me@gmail.com>
 <20180723165251.11424-1-mr.nuke.me@gmail.com>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
Date: Tue, 24 Jul 2018 10:59:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180723165251.11424-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 07/23/2018 11:52 AM, Alexandru Gagniuc wrote:
> When we don't own AER, we shouldn't touch the AER error bits. Clearing
> error bits willy-nilly might cause firmware to miss some errors. In
> theory, these bits get cleared by FFS, or via ACPI _HPX method. These
> mechanisms are not subject to the problem.
> 
> This race is mostly of theoretical significance, since I can't
> reasonably demonstrate this race in the lab.
> 
> On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
> need for two checks: aer_cap and get_firmware_first().
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>   drivers/pci/pcie/aer.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..85c3e173c025 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>   		aer_set_firmware_first(dev);
>   	return dev->__aer_firmware_first;
>   }
> +
> +static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
> +{
> +	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
> +}
> +
>   #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>   				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
>   
> @@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
>   
>   int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>   {
> -	if (pcie_aer_get_firmware_first(dev))
> -		return -EIO;
> -
> -	if (!dev->aer_cap)
> +	if (!pcie_aer_is_kernel_first(dev))
>   		return -EIO;
>   
>   	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
> @@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>   
>   int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>   {
> -	if (pcie_aer_get_firmware_first(dev))
> +	if (!pcie_aer_is_kernel_first(dev))
>   		return -EIO;
>   
>   	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> @@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>   	if (!pci_is_pcie(dev))
>   		return -ENODEV;
>   
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (pcie_aer_is_kernel_first(dev))

This here is missing a '!'. It's in my local branch, so I must have 
exported the patch before I fixed that. I'll get that fixed next rev.

>   		return -EIO;
>   
> +	pos = dev->aer_cap;
>   	port_type = pci_pcie_type(dev);
>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> 
