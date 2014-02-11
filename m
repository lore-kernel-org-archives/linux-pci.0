Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:61693 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaBKX2u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 18:28:50 -0500
Received: by mail-ig0-f170.google.com with SMTP id m12so532034iga.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2014 15:28:49 -0800 (PST)
Date: Tue, 11 Feb 2014 16:28:45 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: allocation check missing
Message-ID: <20140211232845.GC21057@google.com>
References: <20140205115412.14423.23707.stgit@alan.etchedpixels.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140205115412.14423.23707.stgit@alan.etchedpixels.co.uk>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 05, 2014 at 11:54:34AM +0000, Alan wrote:
> If we fail to allocate the name, just drop nicely into the fail path
> 
> (as a footnote someone who works on this code more might want to shuffle
>  the allocations about so the name and attributes are allocated and freed
>  as one. There seems to be no reason to keep them separate)
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

I already applied Greg KH's identical patch, thanks! :)

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/msi&id=b3bac8e57c82e8d3e05f4abcb18c4f0a40656655

> ---
>  drivers/pci/msi.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 18ca2497..9bdf290 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -544,9 +544,13 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
>  		return -ENOMEM;
>  	list_for_each_entry(entry, &pdev->msi_list, list) {
>  		char *name = kmalloc(20, GFP_KERNEL);
> +		if (!name)
> +		        goto error_attrs;
>  		msi_dev_attr = kzalloc(sizeof(*msi_dev_attr), GFP_KERNEL);
> -		if (!msi_dev_attr)
> +		if (!msi_dev_attr) {
> +		        kfree(name);
>  			goto error_attrs;
> +                }
>  		sprintf(name, "%d", entry->irq);
>  		sysfs_attr_init(&msi_dev_attr->attr);
>  		msi_dev_attr->attr.name = name;
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
