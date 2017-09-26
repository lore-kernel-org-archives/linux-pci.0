Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032173AbdIZVe5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Sep 2017 17:34:57 -0400
Date: Tue, 26 Sep 2017 16:34:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / PCI: Do not resume any devices in pci_pm_prepare()
Message-ID: <20170926213455.GU15970@bhelgaas-glaptop.roam.corp.google.com>
References: <1877076.QiUpNxchJO@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1877076.QiUpNxchJO@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 25, 2017 at 01:33:13AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It should not be necessary to resume devices with ignore_children set
> in pci_pm_prepare(), because they should be resumed explcitly by

s/explcitly/explicitly/

> their children drivers during suspend if need be and they will be
> resumed by pci_pm_suspend() after that anyway, so avoid doing that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I think your previous patches to this file mostly used a "PCI / PM"
subject line prefix (as opposed to the "PM / PCI" here).  But maybe
the difference means something?

> ---
>  drivers/pci/pci-driver.c |    7 -------
>  1 file changed, 7 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -680,13 +680,6 @@ static int pci_pm_prepare(struct device
>  {
>  	struct device_driver *drv = dev->driver;
>  
> -	/*
> -	 * Devices having power.ignore_children set may still be necessary for
> -	 * suspending their children in the next phase of device suspend.
> -	 */
> -	if (dev->power.ignore_children)
> -		pm_runtime_resume(dev);
> -
>  	if (drv && drv->pm && drv->pm->prepare) {
>  		int error = drv->pm->prepare(dev);
>  		if (error)
> 
