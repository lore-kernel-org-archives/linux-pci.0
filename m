Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdKVUNF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Nov 2017 15:13:05 -0500
Date: Wed, 22 Nov 2017 14:12:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/pci: convert to use for_each_pci_bridge()
 helper
Message-ID: <20171122201259.GA21158@bhelgaas-glaptop.roam.corp.google.com>
References: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110175230.82522-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 07:52:29PM +0200, Andy Shevchenko wrote:
> ...which makes code slightly cleaner.
> 
> Requires: d43f59ce6c50 ("PCI: Add for_each_pci_bridge() helper")

Requires: 24a0c654d7d6 ("PCI: Add for_each_pci_bridge() helper")

(My fault, I rebased that commit before sending it to Linus.)

> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

These don't depend on anything in the PCI core, so they could go
either via my tree or the powerpc tree.  Since you acked this,
Michael, I corrected the SHA1 above and put these both on my pci/misc
branch.

If you pick them up, let me know and I'll drop them from my tree.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/kernel/pci-hotplug.c | 7 ++-----
>  arch/powerpc/kernel/pci_of_scan.c | 7 ++-----
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 2d71269e7dc1..741f47295188 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -134,11 +134,8 @@ void pci_hp_add_devices(struct pci_bus *bus)
>  		pcibios_setup_bus_devices(bus);
>  		max = bus->busn_res.start;
>  		for (pass = 0; pass < 2; pass++) {
> -			list_for_each_entry(dev, &bus->devices, bus_list) {
> -				if (pci_is_bridge(dev))
> -					max = pci_scan_bridge(bus, dev,
> -							      max, pass);
> -			}
> +			for_each_pci_bridge(dev, bus)
> +				max = pci_scan_bridge(bus, dev, max, pass);
>  		}
>  	}
>  	pcibios_finish_adding_to_bus(bus);
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 0d790f8432d2..8bdaa2a6fa62 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -369,11 +369,8 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
>  	pcibios_setup_bus_devices(bus);
>  
>  	/* Now scan child busses */
> -	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		if (pci_is_bridge(dev)) {
> -			of_scan_pci_bridge(dev);
> -		}
> -	}
> +	for_each_pci_bridge(dev, bus)
> +		of_scan_pci_bridge(dev);
>  }
>  
>  /**
> -- 
> 2.14.2
> 
