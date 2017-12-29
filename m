Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:33714 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbdL2RPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Dec 2017 12:15:53 -0500
Date: Fri, 29 Dec 2017 09:15:48 -0800
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
Message-ID: <20171229171548.GI3875@atomide.com>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com>
 <CAJZ5v0hpK0_vjX3HinCpsFuKffVUn3d5EnqXdz0P893aRZgnRw@mail.gmail.com>
 <20171228165134.GH3875@atomide.com>
 <6120485.xubBpvge6h@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6120485.xubBpvge6h@aspire.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

* Rafael J. Wysocki <rjw@rjwysocki.net> [171228 17:33]:
> On Thursday, December 28, 2017 5:51:34 PM CET Tony Lindgren wrote:
> > 
> > Well Brian had a concern where we would have to implement PM runtime
> > for all device drivers for PCI devices.
> 
> Why would we?

Seems at least I was a bit confused. In the PCIe case the WAKE# is
owned by the PCIe slot, not the child PCIe device. So you're right,
there should be no need for the child PCIe device drivers to
implement runtime PM.

I was thinking the wakeirq case with WLAN on SDIO bus. Some WLAN
devices can have a hardwired OOB wakeirq wired to a GPIO controller.
In that case the wakeirq is owned by the child device driver
(WLAN controller) and not by the SDIO slot. I was earlier
thinking this is the same as the "Figure 5-4" case 1, but it's
not.

So in the PCIe WAKE# case for device tree, we must have the
wakeirq property for the PCIe slot for the struct device managing
that slot, and not for the child device driver. I think it's
already this way in the most recent set of patches, I need to
look again.

> > So isn't my option 1 above similar to the PCIe spec "Figure 5-4"
> > case 2?
> 
> No, it isn't, because in that case there is no practical difference
> between WAKE# and an in-band PME message sent by the device (Beacon)
> from the software perspective.
> 
> WAKE# causes the switch to send a PME message upstream and that is
> handled by the Root Complex through the standard mechanism already
> supported by our existing PME driver (drivers/pci/pcie/pme.c).

OK. So if "Figure 5-4" case 2 is already handled then and we need
to just deal with "Figure 5-4" case 1 :)

> > Yeah. FYI, for the dedicated wakeirq cases I have, we need to keep
> > them masked during runtime to avoid tons of interrupts as they
> > are often wired to the RX pins.
> 
> OK
> 
> BTW, enable_irq_wake() should take care of the sharing, shouldn't it?

That can be used to tell us which device has wakeirq enabled for
wake-up events, but only for resume not runtiem PM. We still have the
shared IRQ problem to deal with. And the PCIe subsystem still needs
to go through the child devices.

> But the WAKE# thing is not just for waking up the system from sleep states,
> it is for runtime PM's wakeup signaling too.

Yes my test cases have it working for runtime PM and for waking
up system from suspend.

> > > > Currently nothing happens with wakeirqs if there's no struct
> > > > wakeup_source. On device_wakeup_enable() we call device_wakeup_attach()
> > > > that just copies dev->power.wakeirq to ws->wakeirq. And when struct
> > > > wake_source is freed the device should be active and wakeirq
> > > > disabled. Or are you seeing other issues here?
> > > 
> > > I'm suspicious about one thing, but I need to look deeper into the code. :-)
> 
> So we are fine except for the race and we need the wakeirq field in wakeup
> sources to automatically arm the wakeup IRQs during suspend.

OK.

> If I'm not mistaken, we only need something like the patch below (untested).

Seems like it should fix the race, I'll do some testing next week.

Regards,

Tony

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
