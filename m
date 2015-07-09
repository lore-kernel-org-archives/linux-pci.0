Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:51354 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbbGITJb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2015 15:09:31 -0400
Date: Thu, 9 Jul 2015 15:08:25 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Grant Likely <grant.likely@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Borislav Petkov <bp@alien8.de>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>,
	Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	xen-devel@lists.xenproject.org
Subject: Re: [RFC Patch V1 06/12] PCI: Use for_pci_msi_entry() to access MSI
 device list
Message-ID: <20150709190825.GF21016@l.oracle.com>
References: <1436428847-8886-1-git-send-email-jiang.liu@linux.intel.com>
 <1436428847-8886-7-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436428847-8886-7-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 09, 2015 at 04:00:41PM +0800, Jiang Liu wrote:
> Use accessor for_pci_msi_entry() to access MSI device list, so we could easily
> move msi_list from struct pci_dev into struct device later.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/pci/msi.c          |   39 ++++++++++++++++++++-------------------
>  drivers/pci/xen-pcifront.c |    2 +-

Acked-by on the Xen bits.

>  2 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7b4c20c9f9ca..d09afa78d7a1 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -131,7 +131,7 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  	if (type == PCI_CAP_ID_MSI && nvec > 1)
>  		return 1;
>  
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>  		ret = arch_setup_msi_irq(dev, entry);
>  		if (ret < 0)
>  			return ret;
> @@ -151,7 +151,7 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
>  	int i;
>  	struct msi_desc *entry;
>  
> -	list_for_each_entry(entry, &dev->msi_list, list)
> +	for_each_pci_msi_entry(entry, dev)
>  		if (entry->irq)
>  			for (i = 0; i < entry->nvec_used; i++)
>  				arch_teardown_msi_irq(entry->irq + i);
> @@ -168,7 +168,7 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
>  
>  	entry = NULL;
>  	if (dev->msix_enabled) {
> -		list_for_each_entry(entry, &dev->msi_list, list) {
> +		for_each_pci_msi_entry(entry, dev) {
>  			if (irq == entry->irq)
>  				break;
>  		}
> @@ -282,7 +282,7 @@ void default_restore_msi_irqs(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  
> -	list_for_each_entry(entry, &dev->msi_list, list)
> +	for_each_pci_msi_entry(entry, dev)
>  		default_restore_msi_irq(dev, entry->irq);
>  }
>  
> @@ -363,21 +363,22 @@ EXPORT_SYMBOL_GPL(pci_write_msi_msg);
>  
>  static void free_msi_irqs(struct pci_dev *dev)
>  {
> +	struct list_head *msi_list = dev_to_msi_list(&dev->dev);
>  	struct msi_desc *entry, *tmp;
>  	struct attribute **msi_attrs;
>  	struct device_attribute *dev_attr;
>  	int i, count = 0;
>  
> -	list_for_each_entry(entry, &dev->msi_list, list)
> +	for_each_pci_msi_entry(entry, dev)
>  		if (entry->irq)
>  			for (i = 0; i < entry->nvec_used; i++)
>  				BUG_ON(irq_has_action(entry->irq + i));
>  
>  	pci_msi_teardown_msi_irqs(dev);
>  
> -	list_for_each_entry_safe(entry, tmp, &dev->msi_list, list) {
> +	list_for_each_entry_safe(entry, tmp, msi_list, list) {
>  		if (entry->msi_attrib.is_msix) {
> -			if (list_is_last(&entry->list, &dev->msi_list))
> +			if (list_is_last(&entry->list, msi_list))
>  				iounmap(entry->mask_base);
>  		}
>  
> @@ -448,7 +449,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
>  
>  	if (!dev->msix_enabled)
>  		return;
> -	BUG_ON(list_empty(&dev->msi_list));
> +	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
>  
>  	/* route the table */
>  	pci_intx_for_msi(dev, 0);
> @@ -456,7 +457,7 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
>  
>  	arch_restore_msi_irqs(dev);
> -	list_for_each_entry(entry, &dev->msi_list, list)
> +	for_each_pci_msi_entry(entry, dev)
>  		msix_mask_irq(entry, entry->masked);
>  
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> @@ -501,7 +502,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>  	int count = 0;
>  
>  	/* Determine how many msi entries we have */
> -	list_for_each_entry(entry, &pdev->msi_list, list)
> +	for_each_pci_msi_entry(entry, pdev)
>  		++num_msi;
>  	if (!num_msi)
>  		return 0;
> @@ -510,7 +511,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>  	msi_attrs = kzalloc(sizeof(void *) * (num_msi + 1), GFP_KERNEL);
>  	if (!msi_attrs)
>  		return -ENOMEM;
> -	list_for_each_entry(entry, &pdev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, pdev) {
>  		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
>  		if (!msi_dev_attr)
>  			goto error_attrs;
> @@ -599,7 +600,7 @@ static int msi_verify_entries(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>  		if (!dev->no_64bit_msi || !entry->msg.address_hi)
>  			continue;
>  		dev_err(&dev->dev, "Device has broken 64-bit MSI but arch"
> @@ -636,7 +637,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
>  	mask = msi_mask(entry->msi_attrib.multi_cap);
>  	msi_mask_irq(entry, mask, mask);
>  
> -	list_add_tail(&entry->list, &dev->msi_list);
> +	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
>  
>  	/* Configure MSI capability structure */
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
> @@ -713,7 +714,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  		entry->mask_base		= base;
>  		entry->nvec_used		= 1;
>  
> -		list_add_tail(&entry->list, &dev->msi_list);
> +		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
>  	}
>  
>  	return 0;
> @@ -725,7 +726,7 @@ static void msix_program_entries(struct pci_dev *dev,
>  	struct msi_desc *entry;
>  	int i = 0;
>  
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>  		int offset = entries[i].entry * PCI_MSIX_ENTRY_SIZE +
>  						PCI_MSIX_ENTRY_VECTOR_CTRL;
>  
> @@ -806,7 +807,7 @@ out_avail:
>  		struct msi_desc *entry;
>  		int avail = 0;
>  
> -		list_for_each_entry(entry, &dev->msi_list, list) {
> +		for_each_pci_msi_entry(entry, dev) {
>  			if (entry->irq != 0)
>  				avail++;
>  		}
> @@ -895,8 +896,8 @@ void pci_msi_shutdown(struct pci_dev *dev)
>  	if (!pci_msi_enable || !dev || !dev->msi_enabled)
>  		return;
>  
> -	BUG_ON(list_empty(&dev->msi_list));
> -	desc = list_first_entry(&dev->msi_list, struct msi_desc, list);
> +	BUG_ON(list_empty(dev_to_msi_list(&dev->dev)));
> +	desc = first_msi_entry(dev);
>  
>  	pci_msi_set_enable(dev, 0);
>  	pci_intx_for_msi(dev, 1);
> @@ -1001,7 +1002,7 @@ void pci_msix_shutdown(struct pci_dev *dev)
>  		return;
>  
>  	/* Return the device with MSI-X masked as initial states */
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>  		/* Keep cached states to be restored */
>  		__pci_msix_desc_mask_irq(entry, 1);
>  	}
> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index 8b7a900cd28b..c777b97207d5 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -265,7 +265,7 @@ static int pci_frontend_enable_msix(struct pci_dev *dev,
>  	}
>  
>  	i = 0;
> -	list_for_each_entry(entry, &dev->msi_list, list) {
> +	for_each_pci_msi_entry(entry, dev) {
>  		op.msix_entries[i].entry = entry->msi_attrib.entry_nr;
>  		/* Vector is useless at this point. */
>  		op.msix_entries[i].vector = -1;
> -- 
> 1.7.10.4
> 
