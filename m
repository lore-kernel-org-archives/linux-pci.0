Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Sep 2014 17:16:13 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Huang Ying <huang.ying.caritas@gmail.com>
Subject: Re: [Update][PATCH] PCI / PM: Allow PCI devices to be put into
 D3cold during system suspend
Message-ID: <20140902231613.GC12657@google.com>
References: <3331155.XU3LgTaBr4@vostro.rjw.lan>
 <2273188.7kGSSgiQeA@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2273188.7kGSSgiQeA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 21, 2014 at 03:18:24AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 448bd857d48e (PCI/PM: add PCIe runtime D3cold support) added
> a check to prevent PCI devices from being put into D3cold during
> system suspend without giving any particular reason.
> 
> Also the check isn't really necessary, because acpi_pci_set_power_state()
> maps PCI_D3hot to ACPI_STATE_D3_COLD anyway.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Added to pci/pm for v3.18, thanks!

> ---
> 
> Ying notices that acpi_pci_set_power_state() maps PCI D3hot to ACPI
> D3cold, so the check actually isn't effective even, but that means
> that the second part of my original changelog was in fact incorrect.
> 
> ---
>  drivers/pci/pci.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: linux-pm/drivers/pci/pci.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci.c
> +++ linux-pm/drivers/pci/pci.c
> @@ -1907,10 +1907,6 @@ int pci_prepare_to_sleep(struct pci_dev
>  	if (target_state == PCI_POWER_ERROR)
>  		return -EIO;
>  
> -	/* D3cold during system suspend/hibernate is not supported */
> -	if (target_state > PCI_D3hot)
> -		target_state = PCI_D3hot;
> -
>  	pci_enable_wake(dev, target_state, device_may_wakeup(&dev->dev));
>  
>  	error = pci_set_power_state(dev, target_state);
> 
