Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47497 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641AbcBPQxg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 16 Feb 2016 11:53:36 -0500
Date: Tue, 16 Feb 2016 10:53:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, allen.m.kay@intel.com,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] pci: Wait for up to an additional 1000ms after FLR reset
Message-ID: <20160216165333.GB18685@localhost>
References: <20160212235013.16862.53910.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160212235013.16862.53910.stgit@gimli.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alex,

On Fri, Feb 12, 2016 at 04:51:08PM -0700, Alex Williamson wrote:
> Some devices take longer than the spec indicates to return from FLR
> reset, a notable case of this is Intel integrated graphics (IGD),
> which can often take an additional 300ms powering down an attached
> LCD panel as part of the FLR.  Allow devices up to an additional
> 1000ms, testing every 100ms whether the first dword of config space
> is read as -1.

This gives me a little more heartburn about ignoring presence detect
during reset and pretending that the post-reset device is the same as
the pre-reset device.  I suspect this problem wouldn't occur if we
just watched for a new device to show up after the FLR, because we
wouldn't have a timeout at all.

But given that this *is* the way we do it, ...

> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
> 
> Copying KVM list as this patch is required for IGD assignment.
> 
>  drivers/pci/pci.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 602eb42..3b90a42 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3414,6 +3414,25 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>  
> +static void pci_wait_alive(struct pci_dev *dev)
> +{
> +	int i;
> +	u32 id;
> +
> +	for (i = 0; i < 10; i++) {
> +		pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> +		if (~id != 0) {
> +			if (i > 0)
> +				dev_info(&dev->dev, "Required additional %d"
> +				         "ms to return from reset\n", i * 100);
> +			return;
> +		}
> +		msleep(100);
> +	}
> +
> +	dev_warn(&dev->dev, "Failed to return from reset\n");
> +}
> +
>  static int pcie_flr(struct pci_dev *dev, int probe)
>  {
>  	u32 cap;
> @@ -3430,6 +3449,7 @@ static int pcie_flr(struct pci_dev *dev, int probe)
>  
>  	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
>  	msleep(100);
> +	pci_wait_alive(dev);

Can we fold the msleep() into pci_wait_alive(), so all the delay
happens in one place?  Maybe you can add a comment to the effect that
the spec says devices should be ready 100ms after FLR, but some
devices take longer.

>  	return 0;
>  }
>  
> @@ -3460,6 +3480,7 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
>  
>  	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
>  	msleep(100);
> +	pci_wait_alive(dev);
>  	return 0;
>  }
>  
> 
