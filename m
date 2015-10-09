Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:51040 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500AbbJIQtW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2015 12:49:22 -0400
Date: Fri, 9 Oct 2015 17:49:06 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/9] pci: mvebu: fix memory leaks and refcount leaks
Message-ID: <20151009164906.GC32532@n2100.arm.linux.org.uk>
References: <20151003181228.GI21513@n2100.arm.linux.org.uk>
 <E1ZiRIs-0004Id-AN@rmk-PC.arm.linux.org.uk>
 <20151009165240.3ba17ece@free-electrons.com>
 <20151009150710.GJ14688@lunn.ch>
 <20151009171442.52988f0b@free-electrons.com>
 <20151009153543.GX32532@n2100.arm.linux.org.uk>
 <alpine.DEB.2.10.1510091838440.2665@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.10.1510091838440.2665@hadrien>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 06:39:47PM +0200, Julia Lawall wrote:
> I guess that this incorrect too, for the opposite reason (double put)?
> 
> drivers/clk/tegra/clk-emc.c:
> 
> 	for_each_child_of_node(np, node) {
>                 err = of_property_read_u32(node, "nvidia,ram-code",
>                                            &node_ram_code);
>                 if (err) {
>                         of_node_put(node);
>                         continue;
> 		}

Oh yes, most definitely.  Nice find!

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
