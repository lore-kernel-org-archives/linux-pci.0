Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:11605 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271AbaGHCLc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jul 2014 22:11:32 -0400
Message-ID: <53BB5348.10701@huawei.com>
Date: Tue, 8 Jul 2014 10:11:20 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Wuyun <wuyun.wu@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>
Subject: Re: [PATCH] PCI/MSI: Use irq_get_msi_desc() to simplify code
References: <1404463406-3484-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1404463406-3484-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch has been integrate into "[PATCH v3 0/6] Cleanup for MSI" patchset.

On 2014/7/4 16:43, Yijing Wang wrote:
> Use irq_get_msi_desc() to get MSI irq related msi_desc
> directly.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/msi.c |   12 +++++-------
>  1 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 3bee1ba..f95af2b 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -487,7 +487,6 @@ EXPORT_SYMBOL_GPL(pci_restore_msi_state);
>  static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct msi_desc *entry;
>  	unsigned long irq;
>  	int retval;
> @@ -496,12 +495,11 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
>  	if (retval)
>  		return retval;
>  
> -	list_for_each_entry(entry, &pdev->msi_list, list) {
> -		if (entry->irq == irq) {
> -			return sprintf(buf, "%s\n",
> -				       entry->msi_attrib.is_msix ? "msix" : "msi");
> -		}
> -	}
> +	entry = irq_get_msi_desc(irq);
> +	if (entry)
> +		return sprintf(buf, "%s\n",
> +				entry->msi_attrib.is_msix ? "msix" : "msi");
> +
>  	return -ENODEV;
>  }
>  
> 


-- 
Thanks!
Yijing

