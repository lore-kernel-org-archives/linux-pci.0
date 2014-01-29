Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:58230 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaA2U4o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jan 2014 15:56:44 -0500
Received: by mail-ig0-f179.google.com with SMTP id c10so5589499igq.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2014 12:56:44 -0800 (PST)
Date: Wed, 29 Jan 2014 13:56:40 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: msi: properly check return value of kmalloc
Message-ID: <20140129205640.GA16825@google.com>
References: <20140123184246.GA7461@google.com>
 <20140123193037.GA2605@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140123193037.GA2605@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 23, 2014 at 11:30:37AM -0800, Greg Kroah-Hartman wrote:
> Coverity reported that I forgot to check the return value of kmalloc
> when creating the MSI attribute name, so fix that up and properly free
> it if there is an error when allocating the msi_dev_attr variable.
> 
> Fixes: 1c51b50c2995 ("PCI/MSI: Export MSI mode using attributes, not kobjects")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied to my pci/msi branch, thanks!

> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 7a0fec6ce571..39dff3fe57af 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -545,9 +545,15 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	list_for_each_entry(entry, &pdev->msi_list, list) {
>  		char *name = kmalloc(20, GFP_KERNEL);
> +		if (!name)
> +			goto error_attrs;
> +
>  		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
> -		if (!msi_dev_attr)
> +		if (!msi_dev_attr) {
> +			kfree(name);
>  			goto error_attrs;
> +		}
> +
>  		sprintf(name, "%d", entry->irq);
>  		sysfs_attr_init(&msi_dev_attr->attr);
>  		msi_dev_attr->attr.name = name;
