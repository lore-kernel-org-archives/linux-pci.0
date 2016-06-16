Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59094 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbcFPG7r (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2016 02:59:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v3 1/2] Documentation: bindings: add dt doc for Rockchip PCIe controller
Date: Thu, 16 Jun 2016 09:00:41 +0200
Message-ID: <5811436.gqkV56Lax5@wuerfel>
In-Reply-To: <1466041821-1649-1-git-send-email-shawn.lin@rock-chips.com>
References: <1466041821-1649-1-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 16, 2016 9:50:21 AM CEST Shawn Lin wrote:

> +	reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
> +	phys = <&pcie_phy>;
> +	phy-names = "pcie-phy";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_clkreq>;
> +	#interrupt-cells = <1>;
> +	interrupt-controller;
> +	interrupt-map-mask = <0 0 0 7>;
> +	interrupt-map = <0 0 0 1 &pcie0 1>,
> +			<0 0 0 2 &pcie0 2>,
> +			<0 0 0 3 &pcie0 3>,
> +			<0 0 0 4 &pcie0 4>;
> +};
> 

One thing that came up in the review of the new Marvell PCIe driver is that it's
most likely invalid for a device node to have both "interrupt-controller"
and "interrupt-map" properties. I originally thought this was a nice way to
handle embedded irqchips within the PCIe host, but it only really works
by coincidence with the current kernel, and only as long as the hwirq number
of the irqchip matches the integer representation of the irq line in the root
bridge (which it does in the example above).

For that driver we concluded that it would be less of a hack to have the
irqchip as a child node of the PCIe host after all (just not with
device_type="pci" of course), and that makes the translation work as
expected.

	Arnd
