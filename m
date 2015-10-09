Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:50803 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbbJIPfy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 11:35:54 -0400
Date: Fri, 9 Oct 2015 16:35:43 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Julia Lawall <julia.lawall@lip6.fr>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/9] pci: mvebu: fix memory leaks and refcount leaks
Message-ID: <20151009153543.GX32532@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
 <E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk>
 <20151009165240.3ba17ece@free-electrons.com>
 <20151009150710.GJ14688@lunn.ch>
 <20151009171442.52988f0b@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009171442.52988f0b@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 05:14:42PM +0200, Thomas Petazzoni wrote:
> Julia: some of the Device Tree iterator functions have a somewhat
> "interesting" behavior in that they take the reference on the current
> child when entering the loop, and release it before entering the next
> iteration (which will also take a reference to the next child).
> 
> This means that if you have an exit point inside the loop (break or
> return), you are loosing a reference. For example,
> http://lxr.free-electrons.com/source/arch/arm/mach-shmobile/pm-rmobile.c#L367
> is wrong because there is a missing of_node_put(np) before the "return
> -ENOMEM".
> 
> So essentially, every exit point in such Device Tree iteration loops
> should make to call of_node_put() on the current element before exiting
> the loop unexpectedly.

There is an exception to that... if the loop is part of a DT node lookup
function, which would return a DT node based on some search criteria, it
would be valid to break out of the loop while holding a reference.

For example, of_get_child_by_name(), of_find_next_cache_node(),
of_graph_get_port_by_id(), are valid breaker-outer cases. ;)

However, of_platform_bus_probe(), of_platform_populate(),
of_overlay_apply_one(), overlay_subtree_check() are examples of
incorrect break-out cases.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
