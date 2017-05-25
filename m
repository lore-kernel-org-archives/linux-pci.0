Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2329 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762510AbdEYSWF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 May 2017 14:22:05 -0400
Date: Thu, 25 May 2017 21:22:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Piotr Gregor <piotrgregor@rsyncme.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankede@nvidia.com>,
        Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] PCI: Move test of INTx masking to pci_setup_device
Message-ID: <20170525211833-mutt-send-email-mst@kernel.org>
References: <20170525181321.GA13617@westernst>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170525181321.GA13617@westernst>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 25, 2017 at 07:13:23PM +0100, Piotr Gregor wrote:
> The test for INTx masking via config space command performed
> in pci_intx_mask_supported should be performed before PCI device
> can be used. This is to avoid reading/writing of PCI_COMMAND_INTX_DISABLE
> register which may collide with MSI/MSI-X interrupts.
> 
> This patch simplifies test performed in pci_intx_mask_supported
> and introduces intx_mask_support field in struct pci_dev to store
> the result. The test itself is moved to pci_setup_device.
> The result can be queried at any time later from the pci_dev with
> 
> static inline bool pci_is_intx_mask_supported(struct pci_dev *pdev)
> {
>         /*
>          * INTx masking is supported if device passed INTx test
>          * and it's INTx masking feature works properly.
>          */
>         return (pdev->intx_mask_support && !pdev->broken_intx_masking);
> }
> 
> Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
> ---
>  drivers/pci/pci.c             | 42 +++++++++++++++++++++++-------------------
>  drivers/pci/probe.c           |  3 +++
>  drivers/uio/uio_pci_generic.c |  2 +-
>  drivers/vfio/pci/vfio_pci.c   |  2 +-
>  include/linux/pci.h           | 10 ++++++++++
>  5 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b01bd5b..bcaab9b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3709,42 +3709,46 @@ void pci_intx(struct pci_dev *pdev, int enable)
>  EXPORT_SYMBOL_GPL(pci_intx);
>  
>  /**
> - * pci_intx_mask_supported - probe for INTx masking support
> + * pci_intx_mask_supported - probe for INTx masking support in pci_setup_device
>   * @dev: the PCI device to operate on
>   *
> - * Check if the device dev support INTx masking via the config space
> - * command word.
> + * Check if the device dev supports INTx masking via the config space
> + * command word. Executed when PCI device is setup. Result is saved
> + * in intx_mask_support field of pci_dev and should be checked
> + * with pci_is_intx_mask_supported() after PCI device has been setup
> + * to avoid reading/writing of PCI_COMMAND_INTX_DISABLE register.
>   */
>  bool pci_intx_mask_supported(struct pci_dev *dev)
>  {
> -	bool mask_supported = false;
> -	u16 orig, new;
> +	u16 orig, toggle, new;
>  
> +	/*
> +	 * If device doesn't support this feature though it could pass the test.
> +	 */
>  	if (dev->broken_intx_masking)
>  		return false;
>  
>  	pci_cfg_access_lock(dev);
>  
> +	/*
> +	 * Perform the test.
> +	 */
>  	pci_read_config_word(dev, PCI_COMMAND, &orig);
> -	pci_write_config_word(dev, PCI_COMMAND,
> -			      orig ^ PCI_COMMAND_INTX_DISABLE);
> +	toggle = orig ^ PCI_COMMAND_INTX_DISABLE;
> +	pci_write_config_word(dev, PCI_COMMAND, toggle);
>  	pci_read_config_word(dev, PCI_COMMAND, &new);
>  
>  	/*
> -	 * There's no way to protect against hardware bugs or detect them
> -	 * reliably, but as long as we know what the value should be, let's
> -	 * go ahead and check it.
> +	 * Restore initial state.
>  	 */
> -	if ((new ^ orig) & ~PCI_COMMAND_INTX_DISABLE) {
> -		dev_err(&dev->dev, "Command register changed from 0x%x to 0x%x: driver or hardware bug?\n",
> -			orig, new);
> -	} else if ((new ^ orig) & PCI_COMMAND_INTX_DISABLE) {
> -		mask_supported = true;
> -		pci_write_config_word(dev, PCI_COMMAND, orig);
> -	}
> +	pci_write_config_word(dev, PCI_COMMAND, orig);
>  
>  	pci_cfg_access_unlock(dev);
> -	return mask_supported;
> +
> +	if (new == toggle)
> +		return true;
> +
> +	return false;
>  }
>  EXPORT_SYMBOL_GPL(pci_intx_mask_supported);
>  
> @@ -3798,7 +3802,7 @@ static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
>   * @dev: the PCI device to operate on
>   *
>   * Check if the device dev has its INTx line asserted, mask it and
> - * return true in that case. False is returned if not interrupt was
> + * return true in that case. False is returned if no interrupt was
>   * pending.
>   */
>  bool pci_check_and_mask_intx(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 19c8950..16c60ce 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1399,6 +1399,9 @@ int pci_setup_device(struct pci_dev *dev)
>  		}
>  	}
>  
> +	if (pci_intx_mask_supported(dev))
> +		dev->intx_mask_support = 1;
> +
>  	switch (dev->hdr_type) {		    /* header type */
>  	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
>  		if (class == PCI_CLASS_BRIDGE_PCI)
> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
> index d0b508b..8cd443c 100644
> --- a/drivers/uio/uio_pci_generic.c
> +++ b/drivers/uio/uio_pci_generic.c
> @@ -73,7 +73,7 @@ static int probe(struct pci_dev *pdev,
>  		return -ENODEV;
>  	}
>  
> -	if (!pci_intx_mask_supported(pdev)) {
> +	if (!pci_is_intx_mask_supported(pdev)) {
>  		err = -ENODEV;
>  		goto err_verify;
>  	}
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 324c52e..933456e 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -239,7 +239,7 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  			vdev->nointx = true;
>  			pci_intx(pdev, 0);
>  		} else
> -			vdev->pci_2_3 = pci_intx_mask_supported(pdev);
> +			vdev->pci_2_3 = pci_is_intx_mask_supported(pdev);
>  	}
>  
>  	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33c2b0b..0fbd278 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -367,6 +367,7 @@ struct pci_dev {
>  	unsigned int    __aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
>  	unsigned int	broken_intx_masking:1;
> +	unsigned int	intx_mask_support:1;	/* INTx masking is supported */
>  	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
>  	unsigned int	irq_managed:1;
>  	unsigned int	has_secondary_link:1;
> @@ -1003,6 +1004,15 @@ int __must_check pci_reenable_device(struct pci_dev *);
>  int __must_check pcim_enable_device(struct pci_dev *pdev);
>  void pcim_pin_device(struct pci_dev *pdev);
>  
> +static inline bool pci_is_intx_mask_supported(struct pci_dev *pdev)
> +{
> +	/*
> +	 * INTx masking is supported if device passed INTx test and it's INTx
> +	 * masking feature works properly.
> +	 */
> +	return (pdev->intx_mask_support && !pdev->broken_intx_masking);
> +}
> +

And now there's pci_is_intx_mask_supported and pci_intx_mask_supported
which are the same except pci_intx_mask_supported shouldn't be called by
anyone except in one place in pci code.

Pls don't do this. Rename pci_intx_mask_supported -> __pci_intx_mask_supported
and then everyone can just keep calling pci_intx_mask_supported as previously,
except it'll be faster and safer. And unexport
__pci_intx_mask_supported.


>  static inline int pci_is_enabled(struct pci_dev *pdev)
>  {
>  	return (atomic_read(&pdev->enable_cnt) > 0);
> -- 
> 2.1.4
