Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:39210 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbeACUIl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jan 2018 15:08:41 -0500
Date: Wed, 3 Jan 2018 12:08:37 -0800
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        JeffyChen <jeffy.chen@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH v11 4/5] PCI / PM: Add support for the PCIe WAKE#
 signal for OF
Message-ID: <20180103200837.GP3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
 <20171228165134.GH3875@atomide.com>
 <6120485.xubBpvge6h@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6120485.xubBpvge6h@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

* Rafael J. Wysocki <rjw@rjwysocki.net> [171228 17:33]:
> So we are fine except for the race and we need the wakeirq field in wakeup
> sources to automatically arm the wakeup IRQs during suspend.
> 
> If I'm not mistaken, we only need something like the patch below (untested).

Yeah for your patch below works just fine for my
test cases so:

Tested-by: Tony Lindgren <tony@atomide.com>

> ---
>  drivers/base/power/wakeirq.c |    9 ++++-----
>  drivers/base/power/wakeup.c  |    2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/base/power/wakeirq.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeirq.c
> +++ linux-pm/drivers/base/power/wakeirq.c
> @@ -33,7 +33,6 @@ static int dev_pm_attach_wake_irq(struct
>  				  struct wake_irq *wirq)
>  {
>  	unsigned long flags;
> -	int err;
>  
>  	if (!dev || !wirq)
>  		return -EINVAL;
> @@ -45,12 +44,12 @@ static int dev_pm_attach_wake_irq(struct
>  		return -EEXIST;
>  	}
>  
> -	err = device_wakeup_attach_irq(dev, wirq);
> -	if (!err)
> -		dev->power.wakeirq = wirq;
> +	dev->power.wakeirq = wirq;
> +	if (dev->power.wakeup)
> +		device_wakeup_attach_irq(dev, wirq);
>  
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
> -	return err;
> +	return 0;
>  }
>  
>  /**
> Index: linux-pm/drivers/base/power/wakeup.c
> ===================================================================
> --- linux-pm.orig/drivers/base/power/wakeup.c
> +++ linux-pm/drivers/base/power/wakeup.c
> @@ -303,7 +303,7 @@ int device_wakeup_attach_irq(struct devi
>  	}
>  
>  	if (ws->wakeirq)
> -		return -EEXIST;
> +		dev_err(dev, "Leftover wakeup IRQ found, overriding\n");
>  
>  	ws->wakeirq = wakeirq;
>  	return 0;
> 
