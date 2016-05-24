Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:56065 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbcEXNE1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 09:04:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: Add PCIe driver for Rockchip Soc
Date: Tue, 24 May 2016 15:03:13 +0200
Message-ID: <9836736.6VjP1ug4kE@wuerfel>
In-Reply-To: <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
References: <1463740105-7061-1-git-send-email-shawn.lin@rock-chips.com> <1463740156-7148-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, May 20, 2016 6:29:16 PM CEST Shawn Lin wrote:

> +static int rockchip_pcie_wr_own_conf(struct rockchip_pcie_port *pp,
> +				     int where, int size, u32 val)
> +{
> +	u32 tmp;
> +	int offset;
> +
> +	offset = (where & (~0x3));
> +	tmp = readl(pp->apb_base + PCIE_RC_CONFIG_BASE + offset);
> +	if (size == 4) {
> +		writel(val, pp->apb_base + PCIE_RC_CONFIG_BASE + where);
> +	} else if (size == 2) {
> +		if (where & 0x2)
> +			tmp = ((tmp & 0xffff) | (val << 16));
> +		else
> +			tmp = ((tmp & 0xffff0000) | val);
> +
> +		writel(tmp, pp->apb_base + PCIE_RC_CONFIG_BASE + offset);
> +	} else if (size == 1) {
> +		if ((where & 0x3) == 0)
> +			tmp = ((tmp & (~0xff)) | val);
> +		else if ((where & 0x3) == 1)
> +			tmp = ((tmp & (~0xff00)) | (val << 8));
> +		else if ((where & 0x3) == 2)
> +			tmp = ((tmp & (~0xff0000)) | (val << 16));
> +		else if ((where & 0x3) == 3)
> +			tmp = ((tmp & (~0xff000000)) | (val << 24));
> +
> +		writel(tmp, pp->apb_base + PCIE_RC_CONFIG_BASE + offset);
> +	} else {
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +	return PCIBIOS_SUCCESSFUL;
> +}

Why can't you access the individual sub-word registers here?

> +
> +static int rockchip_pcie_rd_other_conf(struct rockchip_pcie_port *pp,
> +				       struct pci_bus *bus, u32 devfn,
> +				       int where, int size, u32 *val)
> +{
> +	u32 busdev;
> +
> +	busdev = PCIE_ECAM_ADDR(bus->number, PCI_SLOT(devfn),
> +				PCI_FUNC(devfn), where);
> +
> +	if (busdev & (size - 1)) {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	if (size == 4) {
> +		*val = readl(pp->reg_base + busdev);
> +	} else if (size == 2) {
> +		*val = readw(pp->reg_base + busdev);
> +	} else if (size == 1) {
> +		*val = readb(pp->reg_base + busdev);
> +	} else {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +

This looks like the normal ECAM operations, you could just call those.

> +	while (time_before(jiffies, timeout)) {
> +		regmap_read(port->grf, port->pcie_status, &status);
> +		if ((status & (1 << 9))) {
> +			dev_info(port->dev, "pll locked!\n");
> +			err = 0;
> +			break;
> +		}
> +	}

Maybe add an msleep(1) here to avoid busy-looping?


> +	for (reg_no = 0; reg_no < (port->mem_size >> 20); reg_no++) {
> +		err = rockchip_pcie_prog_ob_atu(port, reg_no + 1,
> +						AXI_WRAPPER_MEM_WRITE,
> +						20 - 1,
> +						port->mem_bus_addr +
> +							(reg_no << 20),
> +						0);
> +		if (err) {
> +			dev_err(dev, "Program RC outbound atu failed\n");
> +			return err;
> +		}
> +	}

What if there is more than one outbound memory window, e.g. prefetchable
and non-prefetchable?

Where do you set the I/O window?

> +	err = rockchip_pcie_prog_ib_atu(port, 2, 32 - 1, 0x0, 0);
> +	if (err) {
> +		dev_err(dev, "Program RC inbound atu failed\n");
> +		return err;
> +	}

And this doesn't seem to reflect the DMA ranges.

> +
> +	port->root_bus_nr = port->busn->start;
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		bus = pci_scan_root_bus_msi(port->dev, port->root_bus_nr,
> +					    &rockchip_pcie_ops, port, &res,
> +					    port->msi);
> +	} else {
> +		bus = pci_scan_root_bus(&pdev->dev, 0,
> +					&rockchip_pcie_ops, port, &res);


PCI_MSI is selected unconditionally from Kconfig for this driver, so no
need for the compile-time check here.

> +
> +static int rockchip_pcie_remove(struct platform_device *pdev)
> +{
> +	struct rockchip_pcie_port *port = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(port->hclk_pcie);
> +	clk_disable_unprepare(port->aclk_perf_pcie);
> +	clk_disable_unprepare(port->aclk_pcie);
> +	clk_disable_unprepare(port->clk_pciephy_ref);
> +
> +	return 0;
> +}

You don't seem to remove the child devices here. Have you tried unloading the module?

	Arnd


