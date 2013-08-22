Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33396 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489Ab3HVVDH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2013 17:03:07 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so813664obc.40
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2013 14:03:05 -0700 (PDT)
Date: Thu, 22 Aug 2013 15:03:01 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
	jiang.liu@huawei.com, ebiederm@xmission.com
Subject: Re: [PATCH] PCI: use msi/x_set_enable() to simplify pci_msi_off()
Message-ID: <20130822210301.GA1626@google.com>
References: <1375962969-34824-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375962969-34824-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Eric]

On Thu, Aug 08, 2013 at 07:56:09PM +0800, Yijing Wang wrote:
> Move pci_msi_off() to driver/pci/msi.c and use msi_set_enable()
> and msix_set_enable() to simplify pci_msi_off() function code.

I was about to apply this, but there are callers that use
pci_msi_off() even when CONFIG_PCI_MSI=n, so I don't think we
can do this.  I think I'll apply the attached patch instead.

> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |   17 +++++++++++++++++
>  drivers/pci/pci.c |   28 ----------------------------
>  2 files changed, 17 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index aca7578..080d14f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1002,6 +1002,23 @@ void pci_disable_msix(struct pci_dev *dev)
>  EXPORT_SYMBOL(pci_disable_msix);
>  
>  /**
> + * pci_msi_off - disables any msi or msix capabilities
> + * @dev: the PCI device to operate on
> + *
> + * If you want to use msi see pci_enable_msi and friends.
> + * This is a lower level primitive that allows us to disable
> + * msi operation at the device level.
> + */
> +void pci_msi_off(struct pci_dev *dev)
> +{
> +	if (dev->msi_cap)
> +		msi_set_enable(dev, 0);
> +	if (dev->msix_cap)
> +		msix_set_enable(dev, 0);
> +}
> +EXPORT_SYMBOL_GPL(pci_msi_off);
> +
> +/**
>   * msi_remove_pci_irq_vectors - reclaim MSI(X) irqs to unused state
>   * @dev: pointer to the pci_dev data structure of MSI(X) device function
>   *
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e37fea6..6975f2a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3058,34 +3058,6 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
>  
> -/**
> - * pci_msi_off - disables any msi or msix capabilities
> - * @dev: the PCI device to operate on
> - *
> - * If you want to use msi see pci_enable_msi and friends.
> - * This is a lower level primitive that allows us to disable
> - * msi operation at the device level.
> - */
> -void pci_msi_off(struct pci_dev *dev)
> -{
> -	int pos;
> -	u16 control;
> -
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
> -}
> -EXPORT_SYMBOL_GPL(pci_msi_off);
> -
>  int pci_set_dma_max_seg_size(struct pci_dev *dev, unsigned int size)
>  {
>  	return dma_set_max_seg_size(&dev->dev, size);
> -- 
> 1.7.1


PCI: Add comment about needing pci_msi_off() even when CONFIG_PCI_MSI=n

From: Bjorn Helgaas <bhelgaas@google.com>

Per f5f2b13129 ("msi: sanely support hardware level msi disabling"), we
want pci_msi_off() to work even if MSI support is not compiled into the
kernel, and there are existing callers that use it when CONFIG_PCI_MSI=n.
This adds a comment to that effect.

No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 69dcd32..42e5f86 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3059,18 +3059,23 @@ bool pci_check_and_unmask_intx(struct pci_dev *dev)
 EXPORT_SYMBOL_GPL(pci_check_and_unmask_intx);
 
 /**
- * pci_msi_off - disables any msi or msix capabilities
+ * pci_msi_off - disables any MSI or MSI-X capabilities
  * @dev: the PCI device to operate on
  *
- * If you want to use msi see pci_enable_msi and friends.
- * This is a lower level primitive that allows us to disable
- * msi operation at the device level.
+ * If you want to use MSI, see pci_enable_msi() and friends.
+ * This is a lower-level primitive that allows us to disable
+ * MSI operation at the device level.
  */
 void pci_msi_off(struct pci_dev *dev)
 {
 	int pos;
 	u16 control;
 
+	/*
+	 * This looks like it could go in msi.c, but we need it even when
+	 * CONFIG_PCI_MSI=n.  For the same reason, we can't use
+	 * dev->msi_cap or dev->msix_cap here.
+	 */
 	pos = pci_find_capability(dev, PCI_CAP_ID_MSI);
 	if (pos) {
 		pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &control);
