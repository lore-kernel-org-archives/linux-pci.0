Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38771 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171AbcGHQfh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 8 Jul 2016 12:35:37 -0400
Date: Fri, 8 Jul 2016 09:35:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Wenrui Li <wenrui.li@rock-chips.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [v6,2/2] PCI: Rockchip: Add Rockchip PCIe controller support
Message-ID: <20160708163511.GA23348@roeck-us.net>
References: <1467789398-13501-2-git-send-email-shawn.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467789398-13501-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 06, 2016 at 03:16:38PM +0800, Shawn Lin wrote:
> This patch adds Rockchip PCIe controller support found
> on RK3399 Soc platform.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---

[ ... ]

> +	/* Get the I/O and memory ranges from DT */
> +	resource_list_for_each_entry(win, &res) {
> +		switch (resource_type(win->res)) {
> +		case IORESOURCE_IO:
> +			io = win->res;
> +			io->name = "I/O";
> +			io_size = resource_size(io);
> +			io_bus_addr = io->start - win->offset;
> +			err = pci_remap_iospace(io, io_base);

This function is not exported. Either it will have to be exported
(which may be difficult since it is declared as __weak), or the
driver must only be built into the kernel, or the function can
not be used.

Guenter
