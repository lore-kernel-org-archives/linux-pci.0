Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47162 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932106AbcCJUu4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Mar 2016 15:50:56 -0500
Date: Thu, 10 Mar 2016 14:50:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, allen.m.kay@intel.com,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3] pci: Wait for up to 1000ms after FLR reset
Message-ID: <20160310205036.GD14873@localhost>
References: <20160222200351.4709.85363.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160222200351.4709.85363.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 22, 2016 at 01:05:48PM -0700, Alex Williamson wrote:
> Some devices take longer than the spec indicates to return from FLR
> reset, a notable case of this is Intel integrated graphics (IGD),
> which can often take an additional 300ms powering down an attached
> LCD panel as part of the FLR.  Allow devices up to 1000ms, testing
> every 100ms whether the second dword of config space is read as -1.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied to pci/virtualization for v4.6, thanks, Alex!

> ---
> v3: Read 2nd dword since SR-IOV VFs don't implement the 1st dword
> v2: Change loop to incorporate initial 100ms delay, replace delay in
>     callee functions, add comment.
> 
>  drivers/pci/pci.c |   27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 602eb42..365ac76 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3414,6 +3414,29 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>  
> +/*
> + * We should only need to wait 100ms after FLR, but some devices take longer.
> + * Wait for up to 1000ms for config space to return something other than -1.
> + * Intel IGD requires this when an LCD panel is attached.  We read the 2nd
> + * dword because VFs don't implement the 1st dword.
> + */
> +static void pci_flr_wait(struct pci_dev *dev)
> +{
> +	int i = 0;
> +	u32 id;
> +
> +	do {
> +		msleep(100);
> +		pci_read_config_dword(dev, PCI_COMMAND, &id);
> +	} while (i++ < 10 && id == ~0);
> +
> +	if (id == ~0)
> +		dev_warn(&dev->dev, "Failed to return from FLR\n");
> +	else if (i > 1)
> +		dev_info(&dev->dev, "Required additional "
> +			 "%dms to return from FLR\n", (i - 1) * 100);
> +}
> +
>  static int pcie_flr(struct pci_dev *dev, int probe)
>  {
>  	u32 cap;
> @@ -3429,7 +3452,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>  		dev_err(&dev->dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>  
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
> -	msleep(100);
> +	pci_flr_wait(dev);
>  	return 0;
>  }
>  
> @@ -3459,7 +3482,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
>  
>  	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
> -	msleep(100);
> +	pci_flr_wait(dev);
>  	return 0;
>  }
>  
> 
