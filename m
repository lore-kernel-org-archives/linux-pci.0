Return-Path: <SRS0=BJII=BM=atomide.com=tony@kernel.org>
Return-Path: <SRS0=BJII=BM=atomide.com=tony@kernel.org>
Date: Fri, 13 Oct 2017 10:58:26 -0700
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	linux-kernel@vger.kernel.org, bhelgaas@google.com,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	shawn.lin@rock-chips.com, briannorris@chromium.org,
	dianders@chromium.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171013175825.GR4394@atomide.com>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
 <20170911151029.25185-2-jeffy.chen@rock-chips.com>
 <20171013030441.GA25517@bhelgaas-glaptop.roam.corp.google.com>
 <2453698.N4jfPaHx71@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2453698.N4jfPaHx71@aspire.rjw.lan>
List-ID: <linux-pci.vger.kernel.org>

* Rafael J. Wysocki <rjw@rjwysocki.net> [171013 06:32]:
> [+cc Tony]
> 
> On Friday, October 13, 2017 5:04:41 AM CEST Bjorn Helgaas wrote:
> > [+cc Rafael, linux-pm]
> > On Mon, Sep 11, 2017 at 11:10:27PM +0800, Jeffy Chen wrote:
> > > Add support for PCIE_WAKE pin in rockchip pcie driver.
...
> > > @@ -995,6 +996,15 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
> > >  		return err;
> > >  	}
> > >  
> > > +	/* Must init wakeup before setting dedicated wakeup irq. */
> > > +	device_init_wakeup(dev, true);
> > > +	irq = platform_get_irq_byname(pdev, "wakeup");
> > > +	if (irq >= 0) {
> > > +		err = dev_pm_set_dedicated_wake_irq(dev, irq);
> > 
> > I'm a little skeptical about dev_pm_set_dedicated_wake_irq(), not
> > because I know anything at all about it, but because there are only
> > five callers in the whole tree, three of which are in UART code, and
> > none in anything resembling PCI code.

Well it should work for any device that can provide an out of band wakeup
interrupt such as a dedicated GPIO line.

> > Is Rockchip really that special, or are we going about this the wrong
> > way?

Maybe this can be set up in a generic way somewhere similar to what
the I2C bus is doing?

See i2c_device_probe() for dev_pm_set_dedicated_wake_irq() in
drivers/i2c/i2c-core-base.c.

Regards,

Tony
