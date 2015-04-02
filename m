Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56629 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbbDBDib (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Apr 2015 23:38:31 -0400
Date: Thu, 2 Apr 2015 11:38:27 +0800
From: Fam Zheng <famz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Yinghai Lu <yhlu.kernel.send@gmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v5 02/10] pci: move pci_msi_init_pci_dev to probe.c
Message-ID: <20150402033827.GE15412@fam-t430.nay.redhat.com>
References: <1427641227-7574-1-git-send-email-mst@redhat.com>
 <1427641227-7574-3-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427641227-7574-3-git-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 03/29 17:04, Michael S. Tsirkin wrote:
> commit d5dea7d95c48d7bc951cee4910a7fd9c0cd26fb0
>     "PCI: msi: Disable msi interrupts when we initialize a pci device"
> fixes kexec when the booting kernel does not enable msi interupts.
> 
> Unfortunately the relevant functionality is in msi.c so it isn't
> compiled in when CONFIG_PCI_MSI is off, which means such configurations
> would still get interrupt storms.
> 
> Fix by moving part of the functionality probe.c, and compiling it
> unconditionally.

Reviewed-by: Fam Zheng <famz@redhat.com>

> 
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/pci/msi.c   | 12 ------------
>  drivers/pci/probe.c | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9942f68..f66be86 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1041,18 +1041,6 @@ EXPORT_SYMBOL(pci_msi_enabled);
>  void pci_msi_init_pci_dev(struct pci_dev *dev)
>  {
>  	INIT_LIST_HEAD(&dev->msi_list);
> -
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
>  }
>  
>  /**
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8d2f400..50dd934 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1483,10 +1483,26 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
>  	return dev;
>  }
>  
> +static void pci_msi_setup_pci_dev(struct pci_dev *dev)
> +{
> +	/* Disable the msi hardware to avoid screaming interrupts
> +	 * during boot.  This is the power on reset default so
> +	 * usually this should be a noop.
> +	 */
> +	dev->msi_cap = pci_find_capability(dev, PCI_CAP_ID_MSI);
> +	if (dev->msi_cap)
> +		pci_msi_set_enable(dev, 0);
> +
> +	dev->msix_cap = pci_find_capability(dev, PCI_CAP_ID_MSIX);
> +	if (dev->msix_cap)
> +		pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> +}
> +
>  static void pci_init_capabilities(struct pci_dev *dev)
>  {
>  	/* MSI/MSI-X list */
>  	pci_msi_init_pci_dev(dev);
> +	pci_msi_setup_pci_dev(dev);
>  
>  	/* Buffers for saving PCIe and PCI-X capabilities */
>  	pci_allocate_cap_save_buffers(dev);
> -- 
> MST
> 
