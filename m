Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41366 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751562AbcFPJ66 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jun 2016 05:58:58 -0400
Date: Thu, 16 Jun 2016 11:58:55 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marc Zyngier <marc.zyngier@arm.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Heiko Stuebner <heiko@sntech.de>,
	Doug Anderson <dianders@chromium.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Documentation: bindings: add dt doc for Rockchip
 PCIe controller
Message-ID: <20160616115855.3d3961ae@free-electrons.com>
In-Reply-To: <5324957.LqZqpRHMK9@wuerfel>
References: <1466041821-1649-1-git-send-email-shawn.lin@rock-chips.com>
	<5811436.gqkV56Lax5@wuerfel>
	<da207bdc-738f-f2b1-7026-e368355936e9@rock-chips.com>
	<5324957.LqZqpRHMK9@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Thu, 16 Jun 2016 11:22:02 +0200, Arnd Bergmann wrote:

> > >> +    reset-names = "core", "mgmt", "mgmt-sticky", "pipe";
> > >> +    phys = <&pcie_phy>;
> > >> +    phy-names = "pcie-phy";
> > >> +    pinctrl-names = "default";
> > >> +    pinctrl-0 = <&pcie_clkreq>;
> > >> +    #interrupt-cells = <1>;
> > >> +    interrupt-controller;
> > >> +    interrupt-map-mask = <0 0 0 7>;
> > >> +    interrupt-map = <0 0 0 1 &pcie0 1>,
> > >> +                    <0 0 0 2 &pcie0 2>,
> > >> +                    <0 0 0 3 &pcie0 3>,
> > >> +                    <0 0 0 4 &pcie0 4>;
> > >> +};
> > >>  
> > >
> > > One thing that came up in the review of the new Marvell PCIe driver is that it's
> > > most likely invalid for a device node to have both "interrupt-controller"
> > > and "interrupt-map" properties. I originally thought this was a nice way to
> > > handle embedded irqchips within the PCIe host, but it only really works
> > > by coincidence with the current kernel, and only as long as the hwirq number
> > > of the irqchip matches the integer representation of the irq line in the root
> > > bridge (which it does in the example above).
> > >
> > > For that driver we concluded that it would be less of a hack to have the
> > > irqchip as a child node of the PCIe host after all (just not with
> > > device_type="pci" of course), and that makes the translation work as
> > > expected.
> > >
> > >       Arnd
> > >  
> > 
> > Original driver have an irqchip as child node. But Marc suggested don't 
> > need an intermediate node here.
> > Now the conclusion is to retain the child node?  
> 
> That is at least my view of the situation, sorry for the mixed messages
> you have been getting. Marc, Rob, do you agree with my finding?
> 
> If we want to allow having both interrupt-map and interrupt-controller
> in the same node, we need to rewrite both the irq parsing function and
> have extend the DT binding for the interrupt-map to explain what we
> actually expect to happen in that case. At the moment, we walk up the
> tree until we find either an interrupt-map or an interrupt-controller
> property, and use that to map the interrupt number. If we find an
> interrupt-controller, we ignore the interrupt-map.

I can confirm what Arnd said. If you have the following interrupt-map
property:

 +    interrupt-map = <0 0 0 1 &pcie0 0>,
 +                    <0 0 0 2 &pcie0 1>,
 +                    <0 0 0 3 &pcie0 2>,
 +                    <0 0 0 4 &pcie0 3>;

Then the hwirq you get in the ->map() function are [ 1 ; 4 ] instead of
the expected [ 0 ; 3 ]. I.e the translation to the interrupt number in
the "target" interrupt controller does not happen.

Now, the question is whether this is a bug *or* whether having
interrupt-map pointing to its own node is not a valid situation.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
