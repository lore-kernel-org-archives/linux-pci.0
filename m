Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbdE2AF1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 May 2017 20:05:27 -0400
Date: Mon, 29 May 2017 03:05:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Piotr Gregor <piotrgregor@rsyncme.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neo Jia <cjia@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Yongji Xie <xyjxie@linux.vnet.ibm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] PCI: Move test of INTx masking to pci_setup_device
Message-ID: <20170529030459-mutt-send-email-mst@kernel.org>
References: <20170526210222.GA22204@westernst>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170526210222.GA22204@westernst>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 26, 2017 at 10:02:25PM +0100, Piotr Gregor wrote:
> The test for INTx masking via config space command performed
> in pci_intx_mask_supported() should be performed before PCI device
> can be used. This is to avoid reading/writing of PCI_COMMAND_INTX_DISABLE
> register which may collide with MSI/MSI-X interrupts.
> 
> This patch moves test performed in pci_intx_mask_supported() to
> 
> static void pci_test_intx_masking(struct pci_dev *dev)
> 
> defined in drivers/pci/probe.c.
> 
> This function is called from pci_setup_device(). It skips the test
> if the device has been already marked to have broken INTx masking
> feature. Otherwise the test is executed and broken_intx_masking
> field of struct pci_dev is set accordingly. broken_intx_masking
> meaning is: if it is true then the test has been either skipped
> because the device has been already known to have broken INTx
> masking support, or the test's been done and it has detected INTx
> masking support to be broken.
> The test result can be queried at any time later from the pci_dev
> using same interface as before (though whith changed implementation)
> 
> static inline bool pci_intx_mask_supported(struct pci_dev *pdev)
> {
>         /*
>          * INTx masking is supported if device has not been marked
>          * to have this feature broken and it has passed
>          * pci_test_intx_masking() test.
>          */
>         return !pdev->broken_intx_masking;
> }
> 
> so current users of pci_intx_mask_supported: uio and vfio, keep
> their code unchanged.
> 
> Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>

Looks sane

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/pci/pci.c   | 42 +-----------------------------------------
>  drivers/pci/probe.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h | 13 +++++++++++--
>  3 files changed, 56 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b01bd5b..7c4e1aa 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3708,46 +3708,6 @@ void pci_intx(struct pci_dev *pdev, int enable)
>  }
>  EXPORT_SYMBOL_GPL(pci_intx);
>  
> -/**
> - * pci_intx_mask_supported - probe for INTx masking support
> - * @dev: the PCI device to operate on
> - *
> - * Check if the device dev support INTx masking via the config space
> - * command word.
> - */
> -bool pci_intx_mask_supported(struct pci_dev *dev)
> -{
> -	bool mask_supported = false;
> -	u16 orig, new;
> -
> -	if (dev->broken_intx_masking)
> -		return false;
> -
> -	pci_cfg_access_lock(dev);
> -
> -	pci_read_config_word(dev, PCI_COMMAND, &orig);
> -	pci_write_config_word(dev, PCI_COMMAND,
> -			      orig ^ PCI_COMMAND_INTX_DISABLE);
> -	pci_read_config_word(dev, PCI_COMMAND, &new);
> -
> -	/*
> -	 * There's no way to protect against hardware bugs or detect them
> -	 * reliably, but as long as we know what the value should be, let's
> -	 * go ahead and check it.
> -	 */
> -	if ((new ^ orig) & ~PCI_COMMAND_INTX_DISABLE) {
> -		dev_err(&dev->dev, "Command register changed from 0x%x to 0x%x: driver or hardware bug?\n",
> -			orig, new);
> -	} else if ((new ^ orig) & PCI_COMMAND_INTX_DISABLE) {
> -		mask_supported = true;
> -		pci_write_config_word(dev, PCI_COMMAND, orig);
> -	}
> -
> -	pci_cfg_access_unlock(dev);
> -	return mask_supported;
> -}
> -EXPORT_SYMBOL_GPL(pci_intx_mask_supported);
> -
>  static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
>  {
>  	struct pci_bus *bus = dev->bus;
> @@ -3798,7 +3758,7 @@ static bool pci_check_and_set_intx_mask(struct pci_dev *dev, bool mask)
>   * @dev: the PCI device to operate on
>   *
>   * Check if the device dev has its INTx line asserted, mask it and
> - * return true in that case. False is returned if not interrupt was
> + * return true in that case. False is returned if no interrupt was
>   * pending.
>   */
>  bool pci_check_and_mask_intx(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 19c8950..ee6b55c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1330,6 +1330,48 @@ static void pci_msi_setup_pci_dev(struct pci_dev *dev)
>  }
>  
>  /**
> + * pci_test_intx_masking - probe for INTx masking support
> + * @dev: the PCI device to operate on
> + *
> + * Check if the @dev supports INTx masking via the config space
> + * command word. Executed when PCI device is setup. Result is saved
> + * in broken_intx_masking field of struct pci_dev and can be checked
> + * with pci_intx_mask_supported at any time later, after the PCI device
> + * has been setup (this avoids testing of PCI_COMMAND_INTX_DISABLE
> + * register at runtime).
> + */
> +static void pci_test_intx_masking(struct pci_dev *dev)
> +{
> +	u16 orig, toggle, new;
> +
> +	/*
> +	 * If device doesn't support this feature though it could pass the test.
> +	 */
> +	if (dev->broken_intx_masking)
> +		return;
> +
> +	pci_cfg_access_lock(dev);
> +
> +	/*
> +	 * Perform the test.
> +	 */
> +	pci_read_config_word(dev, PCI_COMMAND, &orig);
> +	toggle = orig ^ PCI_COMMAND_INTX_DISABLE;
> +	pci_write_config_word(dev, PCI_COMMAND, toggle);
> +	pci_read_config_word(dev, PCI_COMMAND, &new);
> +
> +	/*
> +	 * Restore initial state.
> +	 */
> +	pci_write_config_word(dev, PCI_COMMAND, orig);
> +
> +	pci_cfg_access_unlock(dev);
> +
> +	if (new != toggle)
> +		dev->broken_intx_masking = 1;
> +}
> +
> +/**
>   * pci_setup_device - fill in class and map information of a device
>   * @dev: the device structure to fill
>   *
> @@ -1399,6 +1441,8 @@ int pci_setup_device(struct pci_dev *dev)
>  		}
>  	}
>  
> +	pci_test_intx_masking(dev);
> +
>  	switch (dev->hdr_type) {		    /* header type */
>  	case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
>  		if (class == PCI_CLASS_BRIDGE_PCI)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33c2b0b..8a307fc 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -366,7 +366,7 @@ struct pci_dev {
>  	unsigned int	is_thunderbolt:1; /* Thunderbolt controller */
>  	unsigned int    __aer_firmware_first_valid:1;
>  	unsigned int	__aer_firmware_first:1;
> -	unsigned int	broken_intx_masking:1;
> +	unsigned int	broken_intx_masking:1; /* INTx masking can't be used */
>  	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
>  	unsigned int	irq_managed:1;
>  	unsigned int	has_secondary_link:1;
> @@ -1003,6 +1003,16 @@ int __must_check pci_reenable_device(struct pci_dev *);
>  int __must_check pcim_enable_device(struct pci_dev *pdev);
>  void pcim_pin_device(struct pci_dev *pdev);
>  
> +static inline bool pci_intx_mask_supported(struct pci_dev *pdev)
> +{
> +	/*
> +	 * INTx masking is supported if device has not been marked
> +	 * to have this feature broken and it has passed
> +	 * pci_test_intx_masking() test.
> +	 */
> +	return !pdev->broken_intx_masking;
> +}
> +
>  static inline int pci_is_enabled(struct pci_dev *pdev)
>  {
>  	return (atomic_read(&pdev->enable_cnt) > 0);
> @@ -1026,7 +1036,6 @@ int __must_check pci_set_mwi(struct pci_dev *dev);
>  int pci_try_set_mwi(struct pci_dev *dev);
>  void pci_clear_mwi(struct pci_dev *dev);
>  void pci_intx(struct pci_dev *dev, int enable);
> -bool pci_intx_mask_supported(struct pci_dev *dev);
>  bool pci_check_and_mask_intx(struct pci_dev *dev);
>  bool pci_check_and_unmask_intx(struct pci_dev *dev);
>  int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask);
> -- 
> 2.1.4
