Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41077 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751060AbcDZA51 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 25 Apr 2016 20:57:27 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: Do not treat EPROBE_DEFER as device attach failure
Date: Tue, 26 Apr 2016 03:00:26 +0200
Message-ID: <1558609.LLbJNF1kgE@vostro.rjw.lan>
In-Reply-To: <7be989e10e72ac58951737bbd455955940388d82.1461162854.git.lukas@wunner.de>
References: <158b8ef6bf71ae69ef54871e4762b98deb981d6e.1461162854.git.lukas@wunner.de> <7be989e10e72ac58951737bbd455955940388d82.1461162854.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 20, 2016 04:44:27 PM Lukas Wunner wrote:
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
> Check device_attach() return value always"): If device_attach() returns
> a negative value, pci_bus_add_device() now removes the sysfs and procfs
> entries for the device and pci_bus_add_devices() subsequently locks up
> with a BUG. Even with the BUG fixed we're still in trouble because the
> device remains on the deferred probing list even though its sysfs and
> procfs entries are gone and its children won't be added.
> 
> Fix by not interpreting -EPROBE_DEFER as failure. The device will be
> probed eventually (through device_unblock_probing() in dpm_complete())
> and there is proper locking in place to avoid races (e.g. if devices are
> unplugged again und thus deleted from the system before deferred probing
> happens, I have tested this). Also, those functions which dereference
> dev->driver (e.g. pci_pm_*()) do contain proper NULL pointer checks.
> So it seems safe to ignore -EPROBE_DEFER.
> 
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v2: Split commit in two, explain when exactly deferred probing will
>     happen (Bjorn Helgaas).
> 
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 23a39fd..dd7cdbe 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -294,7 +294,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	dev->match_driver = true;
>  	retval = device_attach(&dev->dev);
> -	if (retval < 0) {
> +	if (retval < 0 && retval != -EPROBE_DEFER) {
>  		dev_warn(&dev->dev, "device attach failed (%d)\n", retval);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
