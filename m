Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42339 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbbKYUoa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 25 Nov 2015 15:44:30 -0500
Date: Wed, 25 Nov 2015 14:44:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bogicevic Sasa <brutallesale@gmail.com>
Cc: bhelgaas@google.com, wangyijing@huawei.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] drivers:pci:hotplug Fix all "space prohibited before
 that ..."
Message-ID: <20151125204424.GG8869@localhost>
References: <1447590327-3496-1-git-send-email-brutallesale@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447590327-3496-1-git-send-email-brutallesale@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bogicevic,

On Sun, Nov 15, 2015 at 01:25:27PM +0100, Bogicevic Sasa wrote:
> This fixes all errors "space prohibited before that..." from
> checkpatch.pl

I'd take this, but I'd prefer to fix everything under drivers/pci in a
single patch, and I see several other instances of this.  I just did this
to find them:

  $ grep -r " ," drivers/pci/

Can you expand this patch to fix them all?

Thanks,
  Bjorn

> Signed-off-by: Bogicevic Sasa <brutallesale@gmail.com>
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index d1fab97..2bac1b9 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -45,10 +45,10 @@
>  
>  #define MY_NAME	"pci_hotplug"
>  
> -#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt , MY_NAME , __func__ , ## arg); } while (0)
> -#define err(format, arg...) printk(KERN_ERR "%s: " format , MY_NAME , ## arg)
> -#define info(format, arg...) printk(KERN_INFO "%s: " format , MY_NAME , ## arg)
> -#define warn(format, arg...) printk(KERN_WARNING "%s: " format , MY_NAME , ## arg)
> +#define dbg(fmt, arg...) do { if (debug) printk(KERN_DEBUG "%s: %s: " fmt, MY_NAME, __func__, ## arg); } while (0)
> +#define err(format, arg...) printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
> +#define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
>  
>  
>  /* local variables */
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
