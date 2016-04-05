Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52217 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757979AbcDEL3q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 5 Apr 2016 07:29:46 -0400
Subject: Re: [PATCH] PCI: Fix device attach failure handling
To: Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <2c01b1a2d7703fbacae133502cbf6fce335077a9.1459423244.git.lukas@wunner.de>
CC: Alan Stern <stern@rowland.harvard.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <5703A1A2.8040002@ti.com>
Date: Tue, 5 Apr 2016 14:29:38 +0300
MIME-Version: 1.0
In-Reply-To: <2c01b1a2d7703fbacae133502cbf6fce335077a9.1459423244.git.lukas@wunner.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/31/2016 03:57 PM, Lukas Wunner wrote:
> Linux 4.5 introduced a behavioral change in device probing during the
> suspend process with commit 013c074f8642 ("PM / sleep: prohibit devices
> probing during suspend/hibernation"): It defers device probing during
> the entire suspend process, starting from the prepare phase and ending
> with the complete phase. A rule existed before that "we rely on sub-
> systems not to do any probing once a device is suspended" but it is
> enforced only now (Alan Stern, https://lkml.org/lkml/2015/9/15/908).
> 
> This resulted in a WARN splat if a PCI device (e.g. Thunderbolt) is
> plugged in while the system is asleep: Upon waking up, pciehp_resume()
> discovers new devices in the resume phase and immediately tries to bind
> them to a driver. Since probing is now deferred, device_attach() returns
> -EPROBE_DEFER, which provoked a WARN in pci_bus_add_device().
> 
> Linux 4.6-rc1 aggravates the situation with commit ab1a187bba5c ("PCI:
> Check device_attach() return value always"): pci_bus_add_device() no
> longer sets dev->is_added = 1 if device_attach() returned a negative
> value. This results in a BUG lockup in pci_bus_add_devices().
> 
> Fix the latter by not recursing to a child bus if device_attach() failed
> for the bridge leading to it.
> 
> Fix the former by not interpreting -EPROBE_DEFER as failure. The device
> will be probed eventually and there is proper locking in place to avoid
> races (e.g. if devices are unplugged again und thus deleted from the
> system before deferred probing happens, I have tested this). Also, those
> functions which dereference dev->driver (e.g. pci_pm_*()) do contain
> proper NULL pointer checks. So it seems safe to ignore -EPROBE_DEFER.
> 
> Note that even postponing the code in pciehp_resume() until the
> complete phase wouldn't avoid these troubles because dpm_complete()
> calls device_unblock_probing() only after ->complete has been
> executed for all devices. We lack a pm hook from which it would
> be safe to check a hotplug port and call device_attach() without
> risking -EPROBE_DEFER.

Unfortunately, I can't say too much about pci in general.
Regarding checking a hotplug port - Potentially,
PM notifiers can be used PM_SUSPEND_PREPARE/PM_POST_SUSPEND.
Smth. similar (more or less) was implemented for MMC

bbd4368 mmc: core: Signal wakeup event at card insert/removal
4c2ef25 mmc: fix all hangs related to mmc/sd card insert/removal during suspend/resume

> 
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>   drivers/pci/bus.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 6c9f546..dd7cdbe 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -294,7 +294,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>   
>   	dev->match_driver = true;
>   	retval = device_attach(&dev->dev);
> -	if (retval < 0) {
> +	if (retval < 0 && retval != -EPROBE_DEFER) {
>   		dev_warn(&dev->dev, "device attach failed (%d)\n", retval);
>   		pci_proc_detach_device(dev);
>   		pci_remove_sysfs_dev_files(dev);
> @@ -324,7 +324,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>   	}
>   
>   	list_for_each_entry(dev, &bus->devices, bus_list) {
> -		BUG_ON(!dev->is_added);
> +		/* Skip if device attach failed */
> +		if (!dev->is_added)
> +			continue;
>   		child = dev->subordinate;
>   		if (child)
>   			pci_bus_add_devices(child);
> 


-- 
regards,
-grygorii
