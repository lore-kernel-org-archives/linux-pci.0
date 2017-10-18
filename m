Return-Path: <SRS0=Ab4q=BR=chromium.org=briannorris@kernel.org>
Return-Path: <SRS0=Ab4q=BR=chromium.org=briannorris@kernel.org>
Date: Tue, 17 Oct 2017 18:03:14 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
	bhelgaas@google.com, shawn.lin@rock-chips.com,
	dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171018010312.GB65743@google.com>
References: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
 <20171013195059.23865-2-jeffy.chen@rock-chips.com>
 <20171016200350.GH25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171016200350.GH25517@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 16, 2017 at 03:03:50PM -0500, Bjorn Helgaas wrote:
> On Sat, Oct 14, 2017 at 03:50:56AM +0800, Jeffy Chen wrote:
> > Add support for PCIE_WAKE pin in rockchip pcie driver.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > 
> > Changes in v6:
> > Fix device_init_wake error handling, and add some comments.
> > 
> > Changes in v5:
> > Rebase
> > 
> > Changes in v3:
> > Fix error handling
> > 
> > Changes in v2:
> > Use dev_pm_set_dedicated_wake_irq
> >         -- Suggested by Brian Norris <briannorris@chromium.com>
> > 
> >  drivers/pci/host/pcie-rockchip.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> > index 9051c6c8fea4..268513b6c9c4 100644
> > --- a/drivers/pci/host/pcie-rockchip.c
> > +++ b/drivers/pci/host/pcie-rockchip.c
...
> > @@ -995,6 +996,17 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
> >  		return err;
> >  	}
> >  
> > +	irq = platform_get_irq_byname(pdev, "wakeup");
> > +	if (irq >= 0) {
> > +		/* Must init wakeup before setting dedicated wakeup irq. */
> > +		device_init_wakeup(dev, true);
> > +		err = dev_pm_set_dedicated_wake_irq(dev, irq);
> > +		if (err) {
> > +			dev_err(dev, "failed to setup PCIe wakeup IRQ\n");
> > +			device_init_wakeup(dev, false);
> > +		}
> > +	}
> 
> There's nothing Rockchip-specific here, so I'm hoping you can explore
> putting this support in the PCI core, so any system that describes the
> WAKE# connection in the DT can benefit.

I guess it could work to look into pci_create_root_bus(), and
do something like the following?

	if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node)
		... do OF parsing for generic features like WAKE# ...

Brian
