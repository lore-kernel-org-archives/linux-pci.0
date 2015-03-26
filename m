Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:52974 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbCZMgm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2015 08:36:42 -0400
Message-ID: <5513FD48.3080502@huawei.com>
Date: Thu, 26 Mar 2015 20:36:24 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@redhat.com>,
	<linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Fam Zheng" <famz@redhat.com>,
	Yinghai Lu <yhlu.kernel.send@gmail.com>
Subject: Re: [PATCH v4 03/10] pci: drop some duplicate code
References: <1427369811-11721-1-git-send-email-mst@redhat.com> <1427369811-11721-4-git-send-email-mst@redhat.com>
In-Reply-To: <1427369811-11721-4-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/3/26 19:37, Michael S. Tsirkin wrote:
> pci_msi_init_pci_dev and pci_msi_off share a lot of code.
> This used to be justified since pci_msi_init_pci_dev
> wasn't compiled in when CONFIG_PCI_MSI is off.
> Now that it is, let's reuse code.

It's not correct, pci_msi_off() would be used in quirk when the msi_cap is not initialized.

For example:

/*
 * It's possible for the MSI to get corrupted if shpc and acpi
 * are used together on certain PXH-based systems.
 */
static void quirk_pcie_pxh(struct pci_dev *dev)
{
	pci_msi_off(dev);
	dev->no_msi = 1;
	dev_warn(&dev->dev, "PXH quirk detected; SHPC device MSI disabled\n");
}
DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHD_0,	quirk_pcie_pxh);


> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/pci/pci.c   | 23 ++++-------------------
>  drivers/pci/probe.c | 11 ++++-------
>  2 files changed, 8 insertions(+), 26 deletions(-)
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
> index 45d6d5c..baf8ddd 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1489,17 +1489,14 @@ static void pci_msi_init_pci_dev(struct pci_dev *dev)
>  	INIT_LIST_HEAD(&dev->msi_list);
>  #endif
>  
> +	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
> +	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> +
>  	/* Disable the msi hardware to avoid screaming interrupts
>  	 * during boot.  This is the power on reset default so
>  	 * usually this should be a noop.
>  	 */
> -	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
> -	if (dev->msi_cap)
> -		pci_msi_set_enable(dev, 0);
> -
> -	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> -	if (dev->msix_cap)
> -		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> +	pci_msi_off(dev);
>  }
>  
>  static void pci_init_capabilities(struct pci_dev *dev)
> 


-- 
Thanks!
Yijing

