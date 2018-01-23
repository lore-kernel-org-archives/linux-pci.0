Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35281 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeAWKwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jan 2018 05:52:25 -0500
Received: by mail-pg0-f68.google.com with SMTP id o13so26352pgs.2
        for <linux-pci@vger.kernel.org>; Tue, 23 Jan 2018 02:52:25 -0800 (PST)
Date: Tue, 23 Jan 2018 18:52:08 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, project-aspen-dev@linaro.org,
        Jianguo Sun <sunjianguo1@huawei.com>
Subject: Re: [project-aspen-dev] [PATCH] PCI: histb: add power control GPIO
 for PCIe slot
Message-ID: <20180123105206.GA23797@dragon>
References: <1516669477-20151-1-git-send-email-shawn.guo@linaro.org>
 <20180123093944.rxysbjm2u6suycco@oak.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123093944.rxysbjm2u6suycco@oak.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Daniel,

On Tue, Jan 23, 2018 at 09:39:44AM +0000, Daniel Thompson wrote:
> > @@ -335,15 +344,28 @@ static int histb_pcie_probe(struct platform_device *pdev)
> >  		return PTR_ERR(pci->dbi_base);
> >  	}
> >  
> > +	hipcie->power_gpio = of_get_named_gpio_flags(np,
> > +				"power-gpios", 0, &of_flags);
> > +	if (of_flags & OF_GPIO_ACTIVE_LOW)
> > +		flag |= GPIOF_ACTIVE_LOW;
> 
> Why isn't this inside the if statement?

Are you asking why the flag manipulation is not in the gpio_is_valid()
if-clause below?

I guess this is a copy of how reset_gpio is handled.  It might be a bit
more sensible to check the validity of the GPIO before handling the
flag, but practically the current code doesn't really hurt too much.

I will take Fabio's suggestion to reimplement it with a fixed regulator.
But thanks for the comment anyway.

Shawn

> > +	if (gpio_is_valid(hipcie->power_gpio)) {
> > +		ret = devm_gpio_request_one(dev, hipcie->power_gpio,
> > +				flag, "PCIe device power control");
> > +		if (ret) {
> > +			dev_err(dev, "unable to request power gpio\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	hipcie->reset_gpio = of_get_named_gpio_flags(np,
> >  				"reset-gpios", 0, &of_flags);
> >  	if (of_flags & OF_GPIO_ACTIVE_LOW)
> >  		flag |= GPIOF_ACTIVE_LOW;
> >  	if (gpio_is_valid(hipcie->reset_gpio)) {
> >  		ret = devm_gpio_request_one(dev, hipcie->reset_gpio,
> > -				flag, "PCIe device power control");
> > +				flag, "PCIe device reset control");
> >  		if (ret) {
> > -			dev_err(dev, "unable to request gpio\n");
> > +			dev_err(dev, "unable to request reset gpio\n");
> >  			return ret;
> >  		}
> >  	}
> > -- 
> > 1.9.1
> > 
