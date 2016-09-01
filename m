Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934454AbcIAQfP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Sep 2016 12:35:15 -0400
Date: Thu, 1 Sep 2016 11:34:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Doug Anderson <dianders@chromium.org>,
        Wenrui Li <wenrui.li@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [v10,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Message-ID: <20160901163455.GA9471@localhost>
References: <1471570498-3284-1-git-send-email-shawn.lin@rock-chips.com>
 <20160831181754.GA7460@roeck-us.net>
 <9075a2c1-c787-986f-31b4-4d5b7c92b771@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9075a2c1-c787-986f-31b4-4d5b7c92b771@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 01, 2016 at 11:39:41AM +0800, Shawn Lin wrote:
> Hi Guenter,
> 
> Thanks for your review, and I think it still not too late
> for nitpicking as it isn't merged to next branch. :)
> 
> We have amend the code a bit, so probably we fixed some of
> the minor issues against V10. But some of them are really
> personal taste, if you still insist on that, I will be ok
> to modify them.
> 
> I will push patch to fix them after your feedback. :)

In the interest of making progress, I made most of the changes Guenter
suggested (thanks very much, Guenter!) and made some more of my own on
top of those.

I can't conveniently build it, so I'm sure I've broken things.  I
pushed the current work-in-progress branch to pci/host-rockchip-wip.
After we fix build errors and other thinkos, I'll rename it and put it
in -next.

I'll also post the broken-out patches for the changes I made on top of
the previous v10 (2098142ae87d).  I'll eventually squash them all into
the original commit so we don't have the clutter in the logs.

> On 2016/9/1 2:17, Guenter Roeck wrote:
> >On Fri, Aug 19, 2016 at 09:34:58AM +0800, Shawn Lin wrote:
> 
> [...]
> 
> >>+	rockchip_pcie_enable_interrupts(port);
> >>+
> >
> >There is no matching disable_interrupts call in error handling after this.
> >Is that ok ?
> >
> 
> From test, probably ok since the genpd will be off and all of them
> wil be cleared.
> 
> >Also, is it ok to enable interrupts this early (before the rest of the
> >initialization is complete) ?
> >
> 
> The training starts, so we some client irq should be handled now, and we
> already register isr.
> 
> >>+	err = rockchip_pcie_init_irq_domain(port);
> >>+	if (err < 0)
> >>+		goto err_vpcie;
> >>+
> >>+	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
> >>+					       &res, &io_base);
> >>+	if (err)
> >>+		goto err_vpcie;
> >>+
> >>+	err = devm_request_pci_bus_resources(dev, &res);
> >>+	if (err)
> >>+		goto err_vpcie;
> >>+
> >>+	/* Get the I/O and memory ranges from DT */
> >>+	resource_list_for_each_entry(win, &res) {
> >>+		switch (resource_type(win->res)) {
> >>+		case IORESOURCE_IO:
> >>+			io = win->res;
> >>+			io->name = "I/O";
> >>+			io_size = resource_size(io);
> >>+			io_bus_addr = io->start - win->offset;
> >>+			err = pci_remap_iospace(io, io_base);
> >>+			if (err) {
> >>+				dev_warn(port->dev, "error %d: failed to map resource %pR\n",
> >>+					 err, io);
> >>+				continue;
> >>+			}
> >>+			break;
> >>+		case IORESOURCE_MEM:
> >>+			mem = win->res;
> >>+			mem->name = "MEM";
> >>+			mem_size = resource_size(mem);
> >>+			mem_bus_addr = mem->start - win->offset;
> >>+			break;
> >>+		case IORESOURCE_BUS:
> >>+			busn = win->res;
> >>+			break;
> >>+		default:
> >>+			continue;
> >>+		}
> >>+	}
> >>+
> >>+	if (mem_size)
> >
> >While strictly speaking not needed, I would recommend { }
> >here to improve readability.
> >
> >>+		for (reg_no = 0; reg_no < (mem_size >> 20); reg_no++) {
> >
> >This doesn't support mem sizes smaller than 1 << 20 (and clips the size
> >if it is not aligned to 1M). Is this intentional ?
> 
> yes, we don't support.
> 
> >
> >>+			err = rockchip_pcie_prog_ob_atu(port, reg_no + 1,
> >>+							AXI_WRAPPER_MEM_WRITE,
> >>+							20 - 1,
> >>+							mem_bus_addr +
> >>+							(reg_no << 20),
> >>+							0);
> >>+			if (err) {
> >>+				dev_err(dev, "program RC mem outbound ATU failed\n");
> >>+				goto err_vpcie;
> >>+			}
> >>+		}
> 
> >
> >>+			err = rockchip_pcie_prog_ob_atu(port,
> >>+							reg_no + 1 + offset,
> >>+							AXI_WRAPPER_IO_WRITE,
> >>+							20 - 1,
> >>+							io_bus_addr +
> >>+							(reg_no << 20),
> >>+							0);
> >>+			if (err) {
> >>+				dev_err(dev, "program RC io outbound ATU failed\n");
> >>+				goto err_vpcie;
> >>+			}
> >>+		}
> 
> >>+
> >>+	pci_bus_add_devices(bus);
> >>+
> >>+	dev_warn(dev, "only 32-bit config accesses supported; smaller writes may corrupt adjacent RW1C fields\n");
> >>+
> >
> >A warning which is always displayed seems to be a bit useless. If this is a
> >concern, maybe the driver should provide its own config space access functions
> >and map smaller accesses into 32 bit accesses. But isn't that already done ?
> >
> 
> No, that is just for normal code path. When users comfigure it via some
> user-space tool, it is sane to make them know this limitation. So we
> was suggested to do this.
> 
> >>+	return err;
> >>+
> >>+err_vpcie:
> >>+	if (!IS_ERR(port->vpcie3v3))
> >>+		regulator_disable(port->vpcie3v3);
> >>+	if (!IS_ERR(port->vpcie1v8))
> >>+		regulator_disable(port->vpcie1v8);
> >>+	if (!IS_ERR(port->vpcie0v9))
> >>+		regulator_disable(port->vpcie0v9);
> >>+err_set_vpcie:
> >>+	clk_disable_unprepare(port->clk_pcie_pm);
> >>+err_pcie_pm:
> >>+	clk_disable_unprepare(port->hclk_pcie);
> >>+err_hclk_pcie:
> >>+	clk_disable_unprepare(port->aclk_perf_pcie);
> >>+err_aclk_perf_pcie:
> >>+	clk_disable_unprepare(port->aclk_pcie);
> >>+err_aclk_pcie:
> >>+	return err;
> >>+}
> >>+
> >>+static const struct of_device_id rockchip_pcie_of_match[] = {
> >>+	{ .compatible = "rockchip,rk3399-pcie", },
> >>+	{}
> >>+};
> >>+
> >>+static struct platform_driver rockchip_pcie_driver = {
> >>+	.driver = {
> >>+		.name = "rockchip-pcie",
> >>+		.of_match_table = rockchip_pcie_of_match,
> >>+	},
> >>+	.probe = rockchip_pcie_probe,
> >>+
> >>+};
> >>+builtin_platform_driver(rockchip_pcie_driver);
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> -- 
> Best Regards
> Shawn Lin
> 
