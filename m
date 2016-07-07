Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36386 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbcGGAoW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2016 20:44:22 -0400
Received: by mail-pa0-f49.google.com with SMTP id uj8so1062268pab.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Jul 2016 17:44:09 -0700 (PDT)
Date: Wed, 6 Jul 2016 17:44:06 -0700
From: Brian Norris <briannorris@chromium.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	Wenrui Li <wenrui.li@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	linux-rockchip@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 2/2] PCI: Rockchip: Add Rockchip PCIe controller
 support
Message-ID: <20160707004404.GA57063@google.com>
References: <1467789398-13501-1-git-send-email-shawn.lin@rock-chips.com>
 <1467789398-13501-2-git-send-email-shawn.lin@rock-chips.com>
 <20160707001254.GA100467@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160707001254.GA100467@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi again,

On Wed, Jul 06, 2016 at 05:12:55PM -0700, Brian Norris wrote:
> On Wed, Jul 06, 2016 at 03:16:38PM +0800, Shawn Lin wrote:
> > +static void rockchip_pcie_legacy_int_handler(struct irq_desc *desc)
> > +{
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	struct rockchip_pcie_port *port;
> > +	u32 reg;
> > +	u32 hwirq;
> > +	u32 virq;
> > +
> > +	chained_irq_enter(chip, desc);
> > +	port = irq_desc_get_handler_data(desc);
> > +
> > +	reg = pcie_read(port, PCIE_CLIENT_INT_STATUS);
> > +	reg = (reg & ROCKCHIP_PCIE_RPIFR1_INTR_MASK) >>
> > +	       ROCKCHIP_PCIE_RPIFR1_INTR_SHIFT;
> > +
> > +	while (reg) {
> > +		hwirq = ffs(reg);

As I noted on the DT binding patch, the use of 'ffs' here is causing you
to make the interrupt controller binding implicitly 1-based, where it
would seemingly make more sense to be 0-based I think.

> > +		reg &= ~BIT(hwirq);
> 
> Per Marc's suggestion, you have created an infinite loop :)
> 
> This should be:
> 
> 	hwirq = ffs(reg);
> 	reg &= ~BIT(hwirq - 1);

So, this should actually be:

		hwirq = ffs(reg) - 1;
		reg &= ~BIT(hwirq);

> ...which brings me to this question: are you ever testing non-MSI (i.e.,
> "legacy") interrupts on this driver? There seems to be quite a bit of
> discussion about the structuring of the interrupt-map and
> interrupt-controller handling, but it appears this mostly/only gets
> actually *used* for the legacy interrupt case, and on my tests, legacy
> interrupts aren't really working, at least not with the new binding
> examples that you proposed. But then, you didn't send a rk3399.dtsi
> update, so perhaps I constructed my DTS wrong...
> 
> If you haven't been testing legacy interrupts, I'd recommend booting
> with "pci=nomsi" and see what happens.
> 
> > +
> > +		virq = irq_find_mapping(port->irq_domain, hwirq);
> > +		if (virq)
> > +			generic_handle_irq(virq);
> > +		else
> > +			dev_err(port->dev, "unexpected IRQ, INT%d\n", hwirq);
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +

Brian
