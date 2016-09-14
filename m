Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:52558 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S932550AbcINAXp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2016 20:23:45 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, Peter Wu <peter@lekensteyn.nl>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 4/4] PCI: Avoid unnecessary resume on shutdown
Date: Wed, 14 Sep 2016 02:29:52 +0200
Message-ID: <2217882.yevB8EWaHc@vostro.rjw.lan>
In-Reply-To: <9f9152c11c6178bbac53fd3d0ef0d38173ad4b0b.1472554278.git.lukas@wunner.de>
References: <cover.1472554278.git.lukas@wunner.de> <9f9152c11c6178bbac53fd3d0ef0d38173ad4b0b.1472554278.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, August 31, 2016 08:15:18 AM Lukas Wunner wrote:
> We currently perform a mandatory runtime resume of all PCI devices on
> ->shutdown.  However it is pointless to wake devices only to immediately
> power them down afterwards.  (Or have the firmware reset them, in case
> of a reboot.)
> 
> It seems there are only two cases when a runtime resume is actually
> necessary:  If the driver has declared a ->shutdown callback or if kexec
> is in progress.
> 
> Constrain resume of a device to these cases and let it slumber
> otherwise, thereby conserving energy and speeding up shutdown.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pci-driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index fd4b9c4..09a4e56 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -459,6 +459,11 @@ static void pci_device_shutdown(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct pci_driver *drv = pci_dev->driver;
>  
> +	/* Fast path for suspended devices */
> +	if (pm_runtime_suspended(dev) && (!drv || !drv->shutdown) &&
> +	    !kexec_in_progress)

What happens if runtime suspend or resume of the device happens here?

> +		return;
> +
>  	pm_runtime_resume(dev);
>  
>  	if (drv && drv->shutdown)
> 

Thanks,
Rafael

