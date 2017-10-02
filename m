Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbdJBX3o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Oct 2017 19:29:44 -0400
Date: Mon, 2 Oct 2017 18:29:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] PCI / PM: Add dev_dbg() to print device suspend power
 states
Message-ID: <20171002232941.GF5407@bhelgaas-glaptop.roam.corp.google.com>
References: <8776535.A6PtrVU7Ea@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8776535.A6PtrVU7Ea@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 30, 2017 at 01:31:15AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It sometimes is useful to know what power states the kernel thinks
> it puts PCI devices into during system suspend, so add a dev_dbg()
> statement for that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I think you have other pending changes in this path, so can you take
this one as well?

> ---
>  drivers/pci/pci-driver.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -798,6 +798,9 @@ static int pci_pm_suspend_noirq(struct d
>  			pci_prepare_to_sleep(pci_dev);
>  	}
>  
> +	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
> +		pci_power_name(pci_dev->current_state));
> +
>  	pci_pm_set_unknown_state(pci_dev);
>  
>  	/*
> 
