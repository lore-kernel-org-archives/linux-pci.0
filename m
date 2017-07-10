Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbdGJVLw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jul 2017 17:11:52 -0400
Date: Mon, 10 Jul 2017 16:11:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: remove unused struct resource *res from
 pci_resource_io
Message-ID: <20170710211139.GE5610@bhelgaas-glaptop.roam.corp.google.com>
References: <1499331620-132371-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499331620-132371-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 06, 2017 at 05:00:20PM +0800, Shawn Lin wrote:
> It is never used and introduces a compile warning:
> 
> drivers/pci/pci-sysfs.c: In function 'pci_resource_io':
> drivers/pci/pci-sysfs.c:1214:19: warning: variable 'res' set but not
> used [-Wunused-but-set-variable]
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied to pci/trivial for v4.14, thanks!

> ---
> 
>  drivers/pci/pci-sysfs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2f3780b..0e43705 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1211,11 +1211,8 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
>  {
>  	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
>  	int bar = (unsigned long)attr->private;
> -	struct resource *res;
>  	unsigned long port = off;
>  
> -	res = &pdev->resource[bar];
> -
>  	port += pci_resource_start(pdev, bar);
>  
>  	if (port > pci_resource_end(pdev, bar))
> -- 
> 1.9.1
> 
> 
