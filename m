Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:35597 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753499AbaBUJjw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 04:39:52 -0500
Date: Fri, 21 Feb 2014 10:39:36 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Cooper <jason@lakedaemon.net>,
	"Longchamp, Valentin" <Valentin.Longchamp@keymile.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>
Subject: Re: pci-mvebu driver on km_kirkwood
Message-ID: <20140221103936.56b3d9f8@skate>
In-Reply-To: <53071970.1040400@keymile.com>
References: <53039894.10905@keymile.com>
	<20140218212751.07c2aeb5@skate>
	<53046D98.6020801@keymile.com>
	<20140219102658.76eec91e@skate>
	<53047BBB.6040108@keymile.com>
	<20140219143749.65ff3155@skate>
	<CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>
	<20140220095518.7ca36f0a@skate>
	<20140220173518.GA19893@obsidianresearch.com>
	<20140220212914.29ddc031@skate>
	<20140221003227.GF19893@obsidianresearch.com>
	<20140221093444.35870a73@skate>
	<5307152D.3020804@keymile.com>
	<20140221101218.45766e8a@skate>
	<53071970.1040400@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Gerlando Falauto,

On Fri, 21 Feb 2014 10:16:32 +0100, Gerlando Falauto wrote:

> > Sure, but whichever choice we make, the Linux PCI core must know by how
> > much we've enlarge the bridge window BAR, otherwise the Linux PCI core
> > may allocate for the next bridge window BAR a range of addresses that
> > doesn't overlap with what it has allocate for the previous bridge
> > window BAR, but that ends up overlapping due to us "extending" the
> > previous bridge window BAR to match the MBus requirements.
> >
> > Gerlando, would you be able to test a quick hack that creates 2 windows
> > to cover exactly 128 MB + 64 MB ? This would at least allow us to
> > confirm that the strategy of splitting in multiple windows is usable.
> 
> Sure, though probably not until next week.

No problem at all.

> I guess it would then also be useful to restore my previous setup, where 
> the total PCIe aperture is 192MB, right?

Yes, that's the case I'm interested in at the moment. If you could try
the above (ugly) patch, and see if you can access all your device BARs,
it would be interesting. It would tell us if two separate windows
having the same target/attribute and consecutive placement in the
physical address space can actually work to address a given PCIe
device. As you will see, the patch makes a very ugly special case for
192 MB :-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 2394e97..f763ecc 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -223,11 +223,13 @@ static int mvebu_mbus_window_conflicts(struct mvebu_mbus_state *mbus,
                if ((u64)base < wend && end > wbase)
                        return 0;
 
+#if 0
                /*
                 * Check if target/attribute conflicts
                 */
                if (target == wtarget && attr == wattr)
                        return 0;
+#endif
        }
 
        return 1;
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 2aa7b77c..67fe6df 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -361,8 +361,15 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
                (((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
                port->memwin_base;
 
-       mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
-                                   port->memwin_base, port->memwin_size);
+       if (port->memwin_size == (SZ_128M + SZ_64M)) {
+               mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
+                                           port->memwin_base, SZ_128M);
+               mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
+                                           port->memwin_base + SZ_128M, SZ_64M);
+       } else {
+               mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
+                                           port->memwin_base, port->memwin_size);
+       }
 }
 
 /*



-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
