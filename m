Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 18 Oct 2017 08:29:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v6 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171018132936.GP5641@bhelgaas-glaptop.roam.corp.google.com>
References: <20171013195059.23865-1-jeffy.chen@rock-chips.com>
 <20171013195059.23865-2-jeffy.chen@rock-chips.com>
 <20171016200350.GH25517@bhelgaas-glaptop.roam.corp.google.com>
 <20171018010312.GB65743@google.com>
MIME-Version: 1.0
In-Reply-To: <20171018010312.GB65743@google.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, Jeffy Chen <jeffy.chen@rock-chips.com>,
 linux-kernel@vger.kernel.org, dianders@chromium.org,
 linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 06:03:14PM -0700, Brian Norris wrote:
> On Mon, Oct 16, 2017 at 03:03:50PM -0500, Bjorn Helgaas wrote:
> > On Sat, Oct 14, 2017 at 03:50:56AM +0800, Jeffy Chen wrote:
> > > Add support for PCIE_WAKE pin in rockchip pcie driver.
> > > 
> > > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > > ---
> > > 
> > > Changes in v6:
> > > Fix device_init_wake error handling, and add some comments.
> > > 
> > > Changes in v5:
> > > Rebase
> > > 
> > > Changes in v3:
> > > Fix error handling
> > > 
> > > Changes in v2:
> > > Use dev_pm_set_dedicated_wake_irq
> > >         -- Suggested by Brian Norris <briannorris@chromium.com>
> > > 
> > >  drivers/pci/host/pcie-rockchip.c | 27 +++++++++++++++++++++------
> > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
> > > index 9051c6c8fea4..268513b6c9c4 100644
> > > --- a/drivers/pci/host/pcie-rockchip.c
> > > +++ b/drivers/pci/host/pcie-rockchip.c
> ...
> > > @@ -995,6 +996,17 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
> > >  		return err;
> > >  	}
> > >  
> > > +	irq = platform_get_irq_byname(pdev, "wakeup");
> > > +	if (irq >= 0) {
> > > +		/* Must init wakeup before setting dedicated wakeup irq. */
> > > +		device_init_wakeup(dev, true);
> > > +		err = dev_pm_set_dedicated_wake_irq(dev, irq);
> > > +		if (err) {
> > > +			dev_err(dev, "failed to setup PCIe wakeup IRQ\n");
> > > +			device_init_wakeup(dev, false);
> > > +		}
> > > +	}
> > 
> > There's nothing Rockchip-specific here, so I'm hoping you can explore
> > putting this support in the PCI core, so any system that describes the
> > WAKE# connection in the DT can benefit.
> 
> I guess it could work to look into pci_create_root_bus(), and
> do something like the following?
> 
> 	if (IS_ENABLED(CONFIG_OF) && parent && parent->of_node)
> 		... do OF parsing for generic features like WAKE# ...

That's exactly the sort of thing I was thinking.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
