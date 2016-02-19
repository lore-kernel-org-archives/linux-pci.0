Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030385AbcBSV5e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Feb 2016 16:57:34 -0500
Date: Fri, 19 Feb 2016 14:57:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: allen.m.kay@intel.com, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2] pci: Wait for up to 1000ms after FLR reset
Message-ID: <20160219145733.7f3a2f55@t450s.home>
In-Reply-To: <20160216205031.11990.51880.stgit@gimli.home>
References: <20160216205031.11990.51880.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 16 Feb 2016 13:53:19 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> Some devices take longer than the spec indicates to return from FLR
> reset, a notable case of this is Intel integrated graphics (IGD),
> which can often take an additional 300ms powering down an attached
> LCD panel as part of the FLR.  Allow devices up to 1000ms, testing
> every 100ms whether the first dword of config space is read as -1.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---

Self nak on this one, didn't account for VFs not implementing the first
dword.  Thanks,

Alex
 
> v2: Change loop to incorporate initial 100ms delay, replace delay in
>     callee functions, add comment.
> 
>  drivers/pci/pci.c |   26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 602eb42..0ce153c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3414,6 +3414,28 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>  
> +/*
> + * We should only need to wait 100ms after FLR, but some devices take longer.
> + * Wait for up to 1000ms for config space to return something other than -1.
> + * Intel IGD requires this when an LCD panel is attached.
> + */
> +static void pci_flr_wait(struct pci_dev *dev)
> +{
> +	int i = 0;
> +	u32 id;
> +
> +	do {
> +		msleep(100);
> +		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
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
> @@ -3429,7 +3451,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>  		dev_err(&dev->dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
>  
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
> -	msleep(100);
> +	pci_flr_wait(dev);
>  	return 0;
>  }
>  
> @@ -3459,7 +3481,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  		dev_err(&dev->dev, "timed out waiting for pending transaction; performing AF function level reset anyway\n");
>  
>  	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
> -	msleep(100);
> +	pci_flr_wait(dev);
>  	return 0;
>  }
>  
> 

