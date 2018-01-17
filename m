Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752641AbeAQSVv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jan 2018 13:21:51 -0500
Date: Wed, 17 Jan 2018 12:21:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI / PM: Fix trailing semicolon
Message-ID: <20180117182149.GB7039@bhelgaas-glaptop.roam.corp.google.com>
References: <20180117103321.24414-1-luisbg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180117103321.24414-1-luisbg@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael]

On Wed, Jan 17, 2018 at 10:33:21AM +0000, Luis de Bethencourt wrote:
> The trailing semicolon is an empty statement that does no operation.
> Removing it since it doesn't do anything.
> 
> Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Rafael, I have nothing queued for pci-driver.c, and you've merged most
of the recent changes there.  If you have any pending changes to it,
feel free to merge this one.  Otherwise, I'll be happy to pick it up.

I would change the subject to:

  PCI / PM: Remove spurious semicolon

> ---
> 
> Hi,
> 
> After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
> suggested I fix it treewide [0].
> 
> Best regards 
> Luis
> 
> 
> [0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
> [1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html
> 
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index d79dbc377b9c..5958c8dda4e3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -968,7 +968,7 @@ static int pci_pm_freeze_late(struct device *dev)
>  	if (dev_pm_smart_suspend_and_suspended(dev))
>  		return 0;
>  
> -	return pm_generic_freeze_late(dev);;
> +	return pm_generic_freeze_late(dev);
>  }
>  
>  static int pci_pm_freeze_noirq(struct device *dev)
> -- 
> 2.15.1
> 
