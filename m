Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeHHDbg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Aug 2018 23:31:36 -0400
Date: Tue, 7 Aug 2018 20:14:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/AER: Do not clear AER bits if we don't own AER
Message-ID: <20180808011429.GB49411@bhelgaas-glaptop.roam.corp.google.com>
References: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
 <20180730233547.1238-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730233547.1238-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 06:35:31PM -0500, Alexandru Gagniuc wrote:
> When we don't own AER, we shouldn't touch the AER error bits. Clearing
> error bits willy-nilly might cause firmware to miss some errors. In
> theory, these bits get cleared by FFS, or via ACPI _HPX method. These
> mechanisms are not subject to the problem.

What's FFS?

I guess you mean FFS and _HPX are not subject to the problem because
they're supplied by firmware, so firmware would be responsible for
looking at the bits before clearing them?

> This race is mostly of theoretical significance, since I can't
> reasonably demonstrate this race in the lab.
> 
> On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
> need for two checks: aer_cap and get_firmware_first().
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> 
> Changes since v2:
>   - Added missing negation in pci_cleanup_aer_error_status_regs()
> 
>  drivers/pci/pcie/aer.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a2e88386af28..40e5c86271d1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>  		aer_set_firmware_first(dev);
>  	return dev->__aer_firmware_first;
>  }
> +
> +static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
> +{
> +	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
> +}

I think it complicates things to have both "firmware_first" and
"kernel_first" interfaces, so I would prefer to stick with the
existing "firmware_first" style.

>  #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
>  				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
>  
> @@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> -	if (pcie_aer_get_firmware_first(dev))
> -		return -EIO;
> -
> -	if (!dev->aer_cap)
> +	if (!pcie_aer_is_kernel_first(dev))
>  		return -EIO;
>  
>  	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);

This change doesn't actually fix anything, does it?  It looks like a
cleanup that doesn't change the behavior.

> @@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
>  
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  {
> -	if (pcie_aer_get_firmware_first(dev))
> +	if (!pcie_aer_is_kernel_first(dev))
>  		return -EIO;

This change does effectively add a test for dev->aer_cap.  That makes
sense in terms of symmetry with pci_enable_pcie_error_reporting(),
but I think it should be a separate patch because it's conceptually
separate from the change below.

We should keep the existing behavior (but add the symmetry) here for
now, but it's not clear to me that these paths should care about AER
or firmware-first at all.  PCI_EXP_DEVCTL is not an AER register and
we have the _HPX mechanism for firmware to influence it (which these
paths currently ignore).  I suspect we should program these reporting
enable bits in the core enumeration path instead of having drivers
call these interfaces.

If/when we make changes along these lines, the history will be easier
to follow if *this* change is not connected with the change below to
pci_cleanup_aer_error_status_regs().

>  	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> @@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  	if (!pci_is_pcie(dev))
>  		return -ENODEV;
>  
> -	pos = dev->aer_cap;
> -	if (!pos)
> +	if (!pcie_aer_is_kernel_first(dev))
>  		return -EIO;

This part makes sense to me, but I think I would rather have it match
the existing style in pci_enable_pcie_error_reporting(), i.e., keep
the test for dev->aer_cap and add a test for
pcie_aer_get_firmware_first().

> +	pos = dev->aer_cap;
>  	port_type = pci_pcie_type(dev);
>  	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> -- 
> 2.17.1
> 
