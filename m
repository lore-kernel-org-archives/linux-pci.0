Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57879 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbbDBDwU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Apr 2015 23:52:20 -0400
Date: Thu, 2 Apr 2015 11:52:17 +0800
From: Fam Zheng <famz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v5 03/10] pci: drop some duplicate code
Message-ID: <20150402035217.GF15412@fam-t430.nay.redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
 <1427641227-7574-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427641227-7574-4-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 03/29 17:04, Michael S. Tsirkin wrote:
> pci_msi_setup_pci_dev and pci_msi_off share a lot of code.
> This used to be justified since pci_msi_setup_pci_dev
> wasn't compiled in when CONFIG_PCI_MSI is off.
> Now that it is, let's reuse code.
> 
> Since pci_msi_off is used by early quirks, doing this requires calling
> pci_msi_setup_pci_dev early after device allocation, so move the call to
> pci_setup_device.

The dropping of duplicated code looks good, but doesn't the moving of
pci_msi_setup_pci_dev call belong to a separate patch?

Fam

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/pci/pci.c   | 23 ++++-------------------
>  drivers/pci/probe.c | 31 +++++++++++++++----------------
>  2 files changed, 19 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 81f06e8..fcee8ea 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3106,26 +3106,11 @@ EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
>   */
>  void pci_msi_off(struct pci_dev *dev)
>  {
> -	int pos;
> -	u16 control;
> +	if (dev->msi_cap)
> +		pci_msi_set_enable(dev, 0);
>  
> -	/*
> -	 * This looks like it could go in msi.c, but we need it even when
> -	 * CONFIG_PCI_MSI=n.  For the same reason, we can't use
> -	 * dev->msi_cap or dev->msix_cap here.
> -	 */
> -	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -	if (pos) {
> -		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
> -		control &= ~PCI_MSI_FLAGS_ENABLE;
> -		pci_write_config_word(dev, pos + PCI_MSI_FLAGS, control);
> -	}
> -	pos = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> -	if (pos) {
> -		pci_read_config_word(dev, pos + PCI_MSIX_FLAGS, &control);
> -		control &= ~PCI_MSIX_FLAGS_ENABLE;
> -		pci_write_config_word(dev, pos + PCI_MSIX_FLAGS, control);
> -	}
> +	if (dev->msix_cap)
> +		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
>  }
>  EXPORT_SYMBOL_GPL(pci_msi_off);
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 50dd934..120772c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1084,6 +1084,18 @@ int pci_cfg_space_size(struct pci_dev *dev)
>  
>  #define LEGACY_IO_RESOURCE	(IORESOURCE_IO | IORESOURCE_PCI_FIXED)
>  
> +static void pci_msi_setup_pci_dev(struct pci_dev *dev)
> +{
> +	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
> +	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> +
> +	/* Disable the msi hardware to avoid screaming interrupts
> +	 * during boot.  This is the power on reset default so
> +	 * usually this should be a noop.
> +	 */
> +	pci_msi_off(dev);
> +}
> +
>  /**
>   * pci_setup_device - fill in class and map information of a device
>   * @dev: the device structure to fill
> @@ -1139,6 +1151,9 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> +	/* MSI/MSI-X setup has to be done early since it's used by quirks. */
> +	pci_msi_setup_pci_dev(dev);
> +
>  	/* Early fixups, before probing the BARs */
>  	pci_fixup_device(pci_fixup_early, dev);
>  	/* device class may be changed after fixup */
> @@ -1483,26 +1498,10 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	return dev;
>  }
>  
> -static void pci_msi_setup_pci_dev(struct pci_dev *dev)
> -{
> -	/* Disable the msi hardware to avoid screaming interrupts
> -	 * during boot.  This is the power on reset default so
> -	 * usually this should be a noop.
> -	 */
> -	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -	if (dev->msi_cap)
> -		pci_msi_set_enable(dev, 0);
> -
> -	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> -	if (dev->msix_cap)
> -		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> -}
> -
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>  	/* MSI/MSI-X list */
>  	pci_msi_init_pci_dev(dev);
> -	pci_msi_setup_pci_dev(dev);
>  
>  	/* Buffers for saving PCIe and PCI-X capabilities */
>  	pci_allocate_cap_save_buffers(dev);
> -- 
> MST
> 
