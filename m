Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752920AbdBJUpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Feb 2017 15:45:04 -0500
Date: Fri, 10 Feb 2017 14:45:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci: host: dra7xx: use GPIO descriptor
Message-ID: <20170210204500.GK29169@bhelgaas-glaptop.roam.corp.google.com>
References: <20170126132707.23249-1-linus.walleij@linaro.org>
 <20170210200711.GG29169@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170210200711.GG29169@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 10, 2017 at 02:07:11PM -0600, Bjorn Helgaas wrote:
> On Thu, Jan 26, 2017 at 02:27:07PM +0100, Linus Walleij wrote:
> > Instead of parsing around in the device tree and determine
> > polarity for the GPIO line and whatnot: utilize the GPIO
> > library's intrinsic handling of OF GPIOs and polarity.
> > 
> > If the line is flagged active low, gpiolib will deal with
> > this.
> > 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Kishon?  Looks like a nice simplification.

Never mind, I just noticed that we already merged a very similar patch:

https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-designware&id=d92b1ced97031ba0fe883911450b3072b069ce4f

Kishon's is slightly different because it uses devm_gpiod_get_optional()
instead of devm_gpiod_get().

They both look slightly funny because we throw away the struct gpio_desc *
that's returned, without ever using it anywhere (except to test for error).
I *assume* that's what you want, since that's the way it was before the
patch, too.

> > ---
> > Would be nice if someone with the hardware could test this
> > and see if it works.
> > ---
> >  drivers/pci/host/pci-dra7xx.c | 22 +++++-----------------
> >  1 file changed, 5 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> > index 9595fad63f6f..85ac2856c80f 100644
> > --- a/drivers/pci/host/pci-dra7xx.c
> > +++ b/drivers/pci/host/pci-dra7xx.c
> > @@ -16,7 +16,7 @@
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> >  #include <linux/init.h>
> > -#include <linux/of_gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/pci.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> > @@ -320,9 +320,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *np = dev->of_node;
> >  	char name[10];
> > -	int gpio_sel;
> > -	enum of_gpio_flags flags;
> > -	unsigned long gpio_flags;
> > +	struct gpio_desc *gpiod;
> >  
> >  	dra7xx = devm_kzalloc(dev, sizeof(*dra7xx), GFP_KERNEL);
> >  	if (!dra7xx)
> > @@ -388,19 +386,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
> >  		goto err_get_sync;
> >  	}
> >  
> > -	gpio_sel = of_get_gpio_flags(dev->of_node, 0, &flags);
> > -	if (gpio_is_valid(gpio_sel)) {
> > -		gpio_flags = (flags & OF_GPIO_ACTIVE_LOW) ?
> > -				GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
> > -		ret = devm_gpio_request_one(dev, gpio_sel, gpio_flags,
> > -					    "pcie_reset");
> > -		if (ret) {
> > -			dev_err(dev, "gpio%d request failed, ret %d\n",
> > -				gpio_sel, ret);
> > -			goto err_gpio;
> > -		}
> > -	} else if (gpio_sel == -EPROBE_DEFER) {
> > -		ret = -EPROBE_DEFER;
> > +	gpiod = devm_gpiod_get(dev, "pcie_reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(gpiod)) {
> > +		ret = PTR_ERR(gpiod);
> >  		goto err_gpio;
> >  	}
> >  
> > -- 
> > 2.9.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
