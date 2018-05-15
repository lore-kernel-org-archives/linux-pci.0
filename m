Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:41055 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752566AbeEOJSr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 May 2018 05:18:47 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v6 05/12] PCI: hotplug: Convert SHPC to be builtin only
Date: Tue, 15 May 2018 11:18:15 +0200
Message-ID: <17759569.7WoPFeBqHm@aspire.rjw.lan>
In-Reply-To: <20180510182844.77349-6-mika.westerberg@linux.intel.com>
References: <20180510182844.77349-1-mika.westerberg@linux.intel.com> <20180510182844.77349-6-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, May 10, 2018 8:28:37 PM CEST Mika Westerberg wrote:
> We need to be able coordinate between SHPC and acpiphp in order to
> determine which driver handles hotplug of a given bridge. Because
> acpiphp is already bool convert SHPC to be bool as well.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/hotplug/Kconfig | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
> index a8f21d051e0c..e9f78eb390d2 100644
> --- a/drivers/pci/hotplug/Kconfig
> +++ b/drivers/pci/hotplug/Kconfig
> @@ -104,14 +104,11 @@ config HOTPLUG_PCI_CPCI_GENERIC
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_SHPC
> -	tristate "SHPC PCI Hotplug driver"
> +	bool "SHPC PCI Hotplug driver"
>  	help
>  	  Say Y here if you have a motherboard with a SHPC PCI Hotplug
>  	  controller.
>  
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called shpchp.
> -
>  	  When in doubt, say N.
>  
>  config HOTPLUG_PCI_POWERNV
> 

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
