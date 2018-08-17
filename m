Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Message-ID: <8b11e45e969c8407bf063c4d515305eab2b0769d.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/6] pci: Set pci_dev->is_added before calling
 device_add
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck
 <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas Wunner
 <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta
 Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Date: Fri, 17 Aug 2018 14:57:40 +1000
In-Reply-To: <20180817044902.31420-3-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
	 <20180817044902.31420-3-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

s/device_add/device_attach .. ugh.

On Fri, 2018-08-17 at 14:48 +1000, Benjamin Herrenschmidt wrote:
> This re-fixes the bug reported by Hari Vyas <hari.vyas@broadcom.com>
> after my revert of his commit but in a much simpler way.
> 
> The main issues is that is_added was being set after the driver
> got bound and started, and thus setting it could race with other
> changes to struct pci_dev.
> 
> This fixes it by setting the flag first, which also has the
> advantage of matching the fact that we are clearing it *after*
> unbinding in the remove path, thus the flag is now symtetric
> and always set while the driver code is running.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  drivers/pci/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 35b7fc87eac5..48ae63673aa8 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -321,16 +321,16 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	pci_proc_attach_device(dev);
>  	pci_bridge_d3_update(dev);
>  
> +	dev->is_added = 1;
>  	dev->match_driver = true;
>  	retval = device_attach(&dev->dev);
>  	if (retval < 0 && retval != -EPROBE_DEFER) {
> +		dev->is_added = 0;
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
>  		pci_proc_detach_device(dev);
>  		pci_remove_sysfs_dev_files(dev);
>  		return;
>  	}
> -
> -	dev->is_added = 1;
>  }
>  EXPORT_SYMBOL_GPL(pci_bus_add_device);
>  
