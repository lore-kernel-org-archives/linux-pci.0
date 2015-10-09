Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:65157 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757049AbbJIQju (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:39:50 -0400
Date: Fri, 9 Oct 2015 18:39:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/9] pci: mvebu: fix memory leaks and refcount leaks
In-Reply-To: <20151009153543.GX32532@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.10.1510091838440.2665@hadrien>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk> <E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk> <20151009165240.3ba17ece@free-electrons.com> <20151009150710.GJ14688@lunn.ch> <20151009171442.52988f0b@free-electrons.com>
 <20151009153543.GX32532@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Fri, 9 Oct 2015, Russell King - ARM Linux wrote:

> On Fri, Oct 09, 2015 at 05:14:42PM +0200, Thomas Petazzoni wrote:
> > Julia: some of the Device Tree iterator functions have a somewhat
> > "interesting" behavior in that they take the reference on the current
> > child when entering the loop, and release it before entering the next
> > iteration (which will also take a reference to the next child).
> >
> > This means that if you have an exit point inside the loop (break or
> > return), you are loosing a reference. For example,
> > http://lxr.free-electrons.com/source/arch/arm/mach-shmobile/pm-rmobile.c#L367
> > is wrong because there is a missing of_node_put(np) before the "return
> > -ENOMEM".
> >
> > So essentially, every exit point in such Device Tree iteration loops
> > should make to call of_node_put() on the current element before exiting
> > the loop unexpectedly.
>
> There is an exception to that... if the loop is part of a DT node lookup
> function, which would return a DT node based on some search criteria, it
> would be valid to break out of the loop while holding a reference.
>
> For example, of_get_child_by_name(), of_find_next_cache_node(),
> of_graph_get_port_by_id(), are valid breaker-outer cases. ;)
>
> However, of_platform_bus_probe(), of_platform_populate(),
> of_overlay_apply_one(), overlay_subtree_check() are examples of
> incorrect break-out cases.

Thanks for the examples.

I guess that this incorrect too, for the opposite reason (double put)?

drivers/clk/tegra/clk-emc.c:

	for_each_child_of_node(np, node) {
                err = of_property_read_u32(node, "nvidia,ram-code",
                                           &node_ram_code);
                if (err) {
                        of_node_put(node);
                        continue;
		}

julia
