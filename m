Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57555 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751840AbbJLTqy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 12 Oct 2015 15:46:54 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM / sleep: Drop pm_request_idle() from pm_generic_complete()
Date: Mon, 12 Oct 2015 22:15:33 +0200
Message-ID: <1729985.4Y6lgbpPqx@vostro.rjw.lan>
In-Reply-To: <4970284.9k6NVjxDce@vostro.rjw.lan>
References: <4970284.9k6NVjxDce@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 30, 2015 02:44:29 AM Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The pm_request_idle() in pm_generic_complete() is pointless as it is
> called with the runtime PM usage counter different from zero (bumped
> up by the core during the prepare phase of system suspend) and the
> core calls pm_runtime_put() for all devices after executing their
> complete callbacks, so drop it.
> 
> This allows the PCI PM layer to use pm_generic_complete() too.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of https://patchwork.kernel.org/patch/7291251/ .

Due to the lack of comments for the last several days (which I'm taking as
the lack of objections), I'm tentatively queing this up for v4.4.

Please let me know if there are any problems with that.

Thanks,
Rafael


> ---
>  drivers/base/power/generic_ops.c |    6 ------
>  drivers/pci/pci-driver.c         |    9 ++-------
>  2 files changed, 2 insertions(+), 13 deletions(-)
> 
> Index: linux-pm/drivers/base/power/generic_ops.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/generic_ops.c
> +++ linux-pm/drivers/base/power/generic_ops.c
> @@ -296,11 +296,5 @@ void pm_generic_complete(struct device *
>  
>  	if (drv && drv->pm && drv->pm->complete)
>  		drv->pm->complete(dev);
> -
> -	/*
> -	 * Let runtime PM try to suspend devices that haven't been in use before
> -	 * going into the system-wide sleep state we're resuming from.
> -	 */
> -	pm_request_idle(dev);
>  }
>  #endif /* CONFIG_PM_SLEEP */
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -686,13 +686,8 @@ static int pci_pm_prepare(struct device
>  
>  static void pci_pm_complete(struct device *dev)
>  {
> -	struct device_driver *drv = dev->driver;
> -	struct pci_dev *pci_dev = to_pci_dev(dev);
> -
> -	pci_dev_complete_resume(pci_dev);
> -
> -	if (drv && drv->pm && drv->pm->complete)
> -		drv->pm->complete(dev);
> +	pci_dev_complete_resume(to_pci_dev(dev));
> +	pm_generic_complete(dev);
>  }
>  
>  #else /* !CONFIG_PM_SLEEP */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
