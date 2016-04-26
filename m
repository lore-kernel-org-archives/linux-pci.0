Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56473 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750817AbcDZA5K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2016 20:57:10 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Fix BUG on device attach failure
Date: Tue, 26 Apr 2016 03:00:09 +0200
Message-ID: <5024018.XjBR86e3YV@vostro.rjw.lan>
In-Reply-To: <158b8ef6bf71ae69ef54871e4762b98deb981d6e.1461162854.git.lukas@wunner.de>
References: <158b8ef6bf71ae69ef54871e4762b98deb981d6e.1461162854.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 20, 2016 04:44:27 PM Lukas Wunner wrote:
> Previously when pci_bus_add_device() called device_attach() and it
> returned a negative value, we emitted a WARN but carried on.
> 
> Commit ab1a187bba5c ("PCI: Check device_attach() return value always"),
> introduced in Linux 4.6-rc1, changed this to unwind all steps preceding
> device_attach() and to not set dev->is_added = 1.
> 
> The latter leads to a BUG if pci_bus_add_device() was called from
> pci_bus_add_devices(). Fix by not recursing to a child bus if
> device_attach() failed for the bridge leading to it.
> 
> This can be triggered by plugging in a PCI device (e.g. Thunderbolt)
> while the system is asleep. The system locks up when woken because
> device_attach() returns -EPROBE_DEFER.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Both this and the [2/2] look reasonable to me.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: Split commit in two (Bjorn Helgaas).
> 
>  drivers/pci/bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 6c9f546..23a39fd 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -324,7 +324,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  	}
>  
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		BUG_ON(!dev->is_added);
> +		/* Skip if device attach failed */
> +		if (!dev->is_added)
> +			continue;
>  		child = dev->subordinate;
>  		if (child)
>  			pci_bus_add_devices(child);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
