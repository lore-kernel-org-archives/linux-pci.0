Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 13 Oct 2017 14:19:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
Message-ID: <20171013191906.GF25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
 <20170911151029.25185-2-jeffy.chen@rock-chips.com>
 <20171013030441.GA25517@bhelgaas-glaptop.roam.corp.google.com>
 <2453698.N4jfPaHx71@aspire.rjw.lan>
 <59E10709.4020300@rock-chips.com>
MIME-Version: 1.0
In-Reply-To: <59E10709.4020300@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>, linux-pci@vger.kernel.org,
 shawn.lin@rock-chips.com, briannorris@chromium.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 dianders@chromium.org, linux-rockchip@lists.infradead.org, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 14, 2017 at 02:33:45AM +0800, jeffy wrote:
> Hi Rafael,
> 
> On 10/13/2017 09:21 PM, Rafael J. Wysocki wrote:
> >>
> >>I'm a little skeptical about dev_pm_set_dedicated_wake_irq(), not
> >>because I know anything at all about it, but because there are only
> >>five callers in the whole tree, three of which are in UART code, and
> >>none in anything resembling PCI code.
> >>
> >>Is Rockchip really that special, or are we going about this the wrong
> >>way?
> 
> we used to put these codes in the wifi driver, but another wifi
> vendor suggests these should go into the pcie driver.
> 
> and as tony said, it could go into pcie common code :)

I guess the implication (I'm speculating here) is that in most
existing cases, the WAKE# signal is fielded by an ACPI BIOS, which
knows how it's connected.  I suppose that would end up being turned
into an SCI that Linux already knows how to handle generically.

And further, that the non-ACPI drivers are relatively new and you're
the first attempt to use WAKE# with a non-ACPI PCI host driver?

If this setup could be done somewhere in PCIe common code, that would
be great.  We have so much copy and pasted code already, it'd be nice
to avoid adding more.  I don't know if this would fit in
pci_scan_root_bus_bridge(), doing something like dma_configure() does
to get hold of a struct platform_device * or a struct device * so you
could lookup the IRQ?

> >>> >+		if (err)
> >>> >+			dev_err(dev, "failed to setup PCIe wakeup IRQ\n");
> >>> >+	}
> >>> >+
> >>> >  	return 0;
> >>
> >>The above could be structured as:
> >>
> >>  irq = platform_get_irq_byname(pdev, "wakeup");
> >>  if (irq < 0)
> >>    return 0;
> >>
> >>  device_init_wakeup(dev, true);
> >>  err = dev_pm_set_dedicated_wake_irq(dev, irq);
> >>  if (err) {
> >>    dev_pm_clear_wake_irq(dev);
> >>    device_init_wakeup(dev, false);
> >>  }
> >>
> there's no need to call dev_pm_clear_wake_irq when
> dev_pm_set_dedicated_wake_irq failed...and i agree the
> device_init_wakeup part, i'll add that in the next version(with
> brian's comment too)
> >>  return 0;
> >>
> >>to unindent the mainline non-error code.
> >>
> >>> >  }
> >>> >
> >>> >@@ -1542,11 +1552,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >>> >
> >>> >  	err = rockchip_pcie_parse_dt(rockchip);
> >>> >  	if (err)
> >>> >-		return err;
> >>> >+		goto err_disable_wake;
> >>> >
> >>> >  	err = rockchip_pcie_enable_clocks(rockchip);
> >>> >  	if (err)
> >>> >-		return err;
> >>> >+		goto err_disable_wake;
> >>> >
> >>> >  	err = rockchip_pcie_set_vpcie(rockchip);
> >>> >  	if (err) {
> >>> >@@ -1656,6 +1666,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
> >>> >  		regulator_disable(rockchip->vpcie0v9);
> >>> >  err_set_vpcie:
> >>> >  	rockchip_pcie_disable_clocks(rockchip);
> >>> >+err_disable_wake:
> >>> >+	dev_pm_clear_wake_irq(dev);
> >>> >+	device_init_wakeup(dev, false);
> >>
> >>I think this error cleanup should be done in rockchip_pcie_setup_irq()
> >>as shown above.  There's no real connection between
> >>rockchip_pcie_probe() and the wake setup.
> 
> this error handling is like inline "rockchip_pcie_cleanup_irq()",
> and they are harmless to be called even if we don't have the wakeup
> irq :)

I'm sure they're harmless.  The point is that the cleanup should be
done near the failure, not in the caller of the caller of the function
where the failure was detected.  You have:

  rockchip_pcie_probe
    rockchip_pcie_parse_dt
      rockchip_pcie_setup_irq
        err = dev_pm_set_dedicated_wake_irq
        if (err)
          dev_err(...)

So you detect the error in rockchip_pcie_setup_irq(), but you clean up
from it in rockchip_pcie_probe(), which doesn't make sense because
rockchip_pcie_probe() doesn't do anything related to wakeup interupts.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
