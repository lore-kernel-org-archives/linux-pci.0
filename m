Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:46773 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbaDDQKm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Apr 2014 12:10:42 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so3672236pab.4
        for <linux-pci@vger.kernel.org>; Fri, 04 Apr 2014 09:10:42 -0700 (PDT)
Date: Fri, 4 Apr 2014 10:10:38 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Jan Beulich <JBeulich@suse.com>
Cc: gregkh@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: simplify populate_msi_sysfs()
Message-ID: <20140404161038.GB9007@google.com>
References: <530F0BD3020000780011FC25@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <530F0BD3020000780011FC25@nat28.tlf.novell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 27, 2014 at 08:56:35AM +0000, Jan Beulich wrote:
> While originally this was a patch to fix the two memory leaks (which
> got preempted by the two commits that went in the day before I wanted
> to submit this fix), I think this can (and should) be done more
> efficiently:
> - swapping the order of the two allocations and storing the
>   msi_dev_attr-derived pointer right after allocation, allowing the
>   cleanup code to pick things up without extra effort
> - using kasprintf() instead of the kmalloc()/sprintf() pair
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied (with Greg's ack) to my pending/msi branch, which will be rebased
and renamed after v3.15-rc1.  Thanks!

> ---
>  drivers/pci/msi.c |   16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> --- 3.14-rc4/drivers/pci/msi.c
> +++ 3.14-rc4-pci-msi-sysfs-cleanup/drivers/pci/msi.c
> @@ -544,22 +544,18 @@ static int populate_msi_sysfs(struct pci
>  	if (!msi_attrs)
>  		return -ENOMEM;
>  	list_for_each_entry(entry, &pdev->msi_list, list) {
> -		char *name = kmalloc(20, GFP_KERNEL);
> -		if (!name)
> -			goto error_attrs;
> -
>  		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
> -		if (!msi_dev_attr) {
> -			kfree(name);
> +		if (!msi_dev_attr)
>  			goto error_attrs;
> -		}
> +		msi_attrs[count] = &msi_dev_attr->attr;
>  
> -		sprintf(name, "%d", entry->irq);
>  		sysfs_attr_init(&msi_dev_attr->attr);
> -		msi_dev_attr->attr.name = name;
> +		msi_dev_attr->attr.name = kasprintf(GFP_KERNEL, "%d",
> +						    entry->irq);
> +		if (!msi_dev_attr->attr.name)
> +			goto error_attrs;
>  		msi_dev_attr->attr.mode = S_IRUGO;
>  		msi_dev_attr->show = msi_mode_show;
> -		msi_attrs[count] = &msi_dev_attr->attr;
>  		++count;
>  	}
>  
> 
> 
> 
