Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeAQUMt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 15:12:49 -0500
Date: Wed, 17 Jan 2018 14:12:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frederick Lawler <fred@fredlawl.com>, Joe Perches <joe@perches.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] PCI: Create  minor pci_dev log wrapper functions
Message-ID: <20180117201239.GC7039@bhelgaas-glaptop.roam.corp.google.com>
References: <1515819518-6501-1-git-send-email-fred@fredlawl.com>
 <1515819518-6501-2-git-send-email-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515819518-6501-2-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+to Joe]

On Fri, Jan 12, 2018 at 10:58:36PM -0600, Frederick Lawler wrote:
> Add PCI-specific dev_printk() wrappers so we can do:
> 
>   pci_info(dev, "message\n");
> 
> instead of
> 
>   dev_info(&dev->dev, "message\n");

Hi Joe,

I proposed that Fred add pci_info(), pci_warn(), pci_err(), etc.
You've done sort of similar things in the past:

  256df2f3879e ("netdevice.h net/core/dev.c: Convert netdev_<level> logging macros to functions")
  a9a79dfec239 ("ata: Convert ata_<foo>_printk(KERN_<LEVEL> to ata_<foo>_<level>")

Do you have any implementation advice for us?  Fred started with inline
functions, but tripped over some issues with varargs in inlines, so
switched to the simple #defines below.

I notice your commits above use either multiple non-inline functions
(netdev) or a single non-inline *_printk() with macros to insert the
loglevel (ata).

Would you recommend:

  - simple #defines as below,
  - multiple non-inline functions like netdev,
  - single non-inline *_printk() with macros like ata,
  - something else?

Thanks for any advice!

Bjorn

> ---
> V2:
> * Replace static inline varadic functions with macros instead
> V3:
> * No changes to this file
> 
>  include/linux/pci.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c170c92..7a5012b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2281,4 +2281,31 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
>  /* provide the legacy pci_dma_* API */
>  #include <linux/pci-dma-compat.h>
>  
> +#define pci_printk(level, pdev, fmt, arg...)		\
> +	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> +
> +#define pci_emerg(pdev, fmt, arg...)			\
> +	dev_emerg(&(pdev)->dev, fmt, ##arg)
> +
> +#define pci_crit(pdev, fmt, arg...)			\
> +	dev_crit(&(pdev)->dev, fmt, ##arg)
> +
> +#define pci_alert(pdev, fmt, arg...)			\
> +	dev_alert(&(pdev)->dev, fmt, ##arg)
> +
> +#define pci_err(pdev, fmt, arg...)			\
> +	dev_err(&(pdev)->dev, fmt, ##arg)
> +
> +#define pci_notice(pdev, fmt, arg...)			\
> +	dev_notice(&(pdev)->dev, fmt, ##arg)
> +
> +#define pci_warn(pdev, fmt, arg...)			\
> +	dev_warn(&(pdev)->dev, fmt, ##arg)
> +
> +#define pci_info(pdev, fmt, arg...)			\
> +	 dev_info(&(pdev)->dev, fmt, ##arg)
> +
> +#define pci_dbg(pdev, fmt, arg...)			\
> +	dev_dbg(&(pdev)->dev, fmt, ##arg)
> +
>  #endif /* LINUX_PCI_H */
> -- 
> 2.7.4
> 
