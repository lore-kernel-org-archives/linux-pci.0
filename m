Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38141 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752546Ab2GYUC4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Jul 2012 16:02:56 -0400
Date: Wed, 25 Jul 2012 16:02:55 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Bjorn Helgaas <bhelgaas@google.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	=?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
	Huang Ying <ying.huang@intel.com>,
	Zheng Yan <zheng.z.yan@intel.com>, <linux-pci@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] PCI / PM: Fix messages printed by acpi_pci_set_power_state()
In-Reply-To: <201207252151.14069.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.44L0.1207251600500.2008-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 25 Jul 2012, Rafael J. Wysocki wrote:

> 
> If a PCI device is put into D3_cold by acpi_bus_set_power(),
> the message printed by acpi_pci_set_power_state() says that its
> power state has been changed to D4, which doesn't make sense.
> In turn, if the device is put into D3_hot, the message says just
> "D3" without specifying which variant of D3 it is.
> 
> Fix that by using an array of state names corresponding to the
> PCI device power states instead of building the state name from
> the numeric value corresponding to the given state directly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/pci/pci-acpi.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> Index: linux/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux.orig/drivers/pci/pci-acpi.c
> +++ linux/drivers/pci/pci-acpi.c
> @@ -265,9 +265,17 @@ static int acpi_pci_set_power_state(stru
>  		error = acpi_bus_set_power(handle, state_conv[state]);
>  	}
>  
> -	if (!error)
> -		dev_printk(KERN_INFO, &dev->dev,
> -				"power state changed by ACPI to D%d\n", state);
> +	if (!error) {
> +		static const char *state_name[] = {
> +			[PCI_D0] = "D0",
> +			[PCI_D1] = "D1",
> +			[PCI_D2] = "D2",
> +			[PCI_D3hot] = "D3hot",
> +			[PCI_D3cold] = "D3cold"
> +		};
> +		dev_info(&dev->dev, "power state changed by ACPI to %s\n",
> +			 state_name[state]);
> +	}

How about using the pci_power_name macro defined in
include/linux/pci.h instead?

Alan Stern

