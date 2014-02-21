Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-de.keymile.com ([195.8.104.250]:54433 "EHLO
	mail-de.keymile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754462AbaBUMYq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2014 07:24:46 -0500
Message-ID: <53074584.5010202@keymile.com>
Date: Fri, 21 Feb 2014 13:24:36 +0100
From: Gerlando Falauto <gerlando.falauto@keymile.com>
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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
	=?ISO-8859-1?Q?Gregory_Cl=E9ment?=
	<gregory.clement@free-electrons.com>
Subject: Re: pci-mvebu driver on km_kirkwood
References: <53039894.10905@keymile.com>	<20140218212751.07c2aeb5@skate>	<53046D98.6020801@keymile.com>	<20140219102658.76eec91e@skate>	<53047BBB.6040108@keymile.com>	<20140219143749.65ff3155@skate>	<CAErSpo4=6VgJazaErcx=ztKhZ_62xBrQ6K1eN_dVpvV4R0T2ag@mail.gmail.com>	<20140220095518.7ca36f0a@skate>	<20140220173518.GA19893@obsidianresearch.com>	<20140220212914.29ddc031@skate>	<20140221003227.GF19893@obsidianresearch.com>	<20140221093444.35870a73@skate>	<5307152D.3020804@keymile.com>	<20140221101218.45766e8a@skate>	<53071970.1040400@keymile.com> <20140221103936.56b3d9f8@skate>
In-Reply-To: <20140221103936.56b3d9f8@skate>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Thomas,

On 02/21/2014 10:39 AM, Thomas Petazzoni wrote:
> Dear Gerlando Falauto,

[...]

>> I guess it would then also be useful to restore my previous setup, where
>> the total PCIe aperture is 192MB, right?
>
> Yes, that's the case I'm interested in at the moment. If you could try
> the above (ugly) patch, and see if you can access all your device BARs,
> it would be interesting. It would tell us if two separate windows
> having the same target/attribute and consecutive placement in the
> physical address space can actually work to address a given PCIe
> device. As you will see, the patch makes a very ugly special case for
> 192 MB :-)
>

So I restored the total aperture size to 192MB.
I had to rework your patch a bit because:

a) I'm running an older kernel and driver
b) sizes are actually 1-byte offset

So here it is:

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index dd4445f..27fe162 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -251,11 +251,13 @@ static int mvebu_mbus_window_conflicts(struct 
mvebu_mbus_state *mbus,
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
index c8397c4..120a822 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -332,10 +332,21 @@ static void 
mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
  		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
  		port->memwin_base;

-	mvebu_mbus_add_window_remap_flags(port->name, port->memwin_base,
-					  port->memwin_size,
-					  MVEBU_MBUS_NO_REMAP,
-					  MVEBU_MBUS_PCI_MEM);
+	if (port->memwin_size + 1 == (SZ_128M + SZ_64M)) {
+		mvebu_mbus_add_window_remap_flags(port->name, port->memwin_base,
+						  SZ_128M - 1,
+						  MVEBU_MBUS_NO_REMAP,
+						  MVEBU_MBUS_PCI_MEM);
+		mvebu_mbus_add_window_remap_flags(port->name, port->memwin_base + 
SZ_128M,
+						  SZ_64M - 1,
+						  MVEBU_MBUS_NO_REMAP,
+						  MVEBU_MBUS_PCI_MEM);
+	} else {
+		mvebu_mbus_add_window_remap_flags(port->name, port->memwin_base,
+						  port->memwin_size,
+						  MVEBU_MBUS_NO_REMAP,
+						  MVEBU_MBUS_PCI_MEM);
+	}
  }

  /*


Here's the assignment (same as before):

pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xebffffff]
pci 0000:01:00.0: BAR 1: assigned [mem 0xe0000000-0xe7ffffff]
pci 0000:01:00.0: BAR 3: assigned [mem 0xe8000000-0xe87fffff]
pci 0000:01:00.0: BAR 4: assigned [mem 0xe8800000-0xe8801fff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe8802000-0xe8802fff]
pci 0000:01:00.0: BAR 2: assigned [mem 0xe8803000-0xe8803fff]
pci 0000:01:00.0: BAR 5: assigned [mem 0xe8804000-0xe8804fff]

And here's the output I get from:

# cat /sys/kernel/debug/mvebu-mbus/devices
[00] 00000000e8000000 - 00000000ec000000 : pcie0.0 (remap 00000000e8000000)
[01] disabled
[02] disabled
[03] disabled
[04] 00000000ff000000 - 00000000ff010000 : nand
[05] 00000000f4000000 - 00000000f8000000 : vpcie
[06] 00000000fe000000 - 00000000fe010000 : dragonite
[07] 00000000e0000000 - 00000000e8000000 : pcie0.0

I did not get to test the whole address space thoroughly, but all the 
BARs are still accessible (mainly BAR0 which contains the control space 
and is mapped on the "new" MBUS window, and BAR1 which is the "big" 
one). So at least, the issues we had before are now gone.
So I'd say this looks like a very promising approach. :-)

Thank you,
Gerlando
