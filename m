Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from quartz.orcorp.ca ([184.70.90.242]:46648 "EHLO quartz.orcorp.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935282AbaDJUMi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Apr 2014 16:12:38 -0400
Date: Thu, 10 Apr 2014 14:12:01 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Neil Greatorex <neil@fatboyfat.co.uk>, Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory =?iso-8859-1?Q?Cl=E9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-pci@vger.kernel.org,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140410201201.GA12661@obsidianresearch.com>
References: <20140410181953.50ccfcc3@skate>
 <20140410165733.GB23104@obsidianresearch.com>
 <20140410200153.46669e0c@skate>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <20140410200153.46669e0c@skate>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2014 at 08:01:53PM +0200, Thomas Petazzoni wrote:
> > Can you run Neil's patch and see if your system behaves the same?
> > Specifically that the link eventually goes down after
> > mvebu_pcie_set_local_dev_nr ?
> > 
> > I couldn't find any case where the BDF leaks below the TLP layer, and
> > the spec is very clear that the assigned BDF can change at run time,
> > so I don't have an explanation for why the link reset is happening.
> > Do you have a contact at Marvell that might shed some light on that
> > behavior?
> 
> There was a potential explanation about the mvebu-soc-id driver that
> enables the clock and then disables it, before the pci-mvebu driver.
> This is different that what was happening before, where the pci-mvebu
> driver was the only one to enable the clock, which was already enabled
> by the bootloader. So if the clock takes some time to stabilize, the
> introduction of mvebu-soc-id may lead to problems.

Oh, that certainly sounds like a potential problem. Disabling the
clock will certainly cause 'interesting' effects on the PEX, depending
on exactly what it does it could confuse the link partner (trigger a
timeout based retrain?).

Gating the clock without disabling the Phy first does sound like a
bad idea..

Neil, does this do anything for you?

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index f3b325f..e0a032f 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -107,7 +107,7 @@ static int __init mvebu_soc_id_init(void)
        iounmap(pci_base);
 
 res_ioremap:
-       clk_disable_unprepare(clk);
+//     clk_disable_unprepare(clk);
 
 clk_err:
        of_node_put(child);

> But I'm not entirely convinced by this, because in my testing, I saw:
> 
>  * Enable the clock
>  * Values in the PCI configuration space are correct (like
>    vendor/product ID)
>  * mvebu_pcie_set_local_dev_nr()
>  * Values in the PCI configuration space are no longer correct, unless
>    you wait a little bit.

Were you reading the configuation space through the MMIO mapping or
through the configuration indirection?

In any event, turning on the clock should almost certainly be
accompanied by a phy reset sequence to get both link ends on the same
page.

Attached is a rough, untested patch along those lines.

> > That does sound like more mbus troubles.
> 
> Interestingly, the problem occurred when I was plugging a SATA PCIe
> card. And regardless of whether the SATA PCIe card is present or not,
> the MBus mappings for the IGB are exactly the same.

Maybe something wrong with mbus window index 13?

Any change if you use other windows?

--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -299,7 +299,7 @@ static int mvebu_mbus_alloc_window(struct mvebu_mbus_state *mbus,
        int win;
 
        if (remap == MVEBU_MBUS_NO_REMAP) {
-               for (win = mbus->soc->num_remappable_wins;
+               for (win = 0;
                     win < mbus->soc->num_wins; win++)
                        if (mvebu_mbus_window_is_free(mbus, win))
                                return mvebu_mbus_setup_window(mbus, win, base,

Jason

--J2SCkAp4GZ/dPZZf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="pex-reset.diff"

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0d638b7..7b7d19a 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -21,6 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 
 /*
  * PCIe unit register offsets.
@@ -973,6 +974,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 		enum of_gpio_flags flags;
+		bool enabled;
 
 		if (!of_device_is_available(child))
 			continue;
@@ -1044,6 +1046,9 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		// Does this work on MVEBU?
+		enabled = __clk_is_enabled(port->clk);
+
 		ret = clk_prepare_enable(port->clk);
 		if (ret)
 			continue;
@@ -1057,7 +1062,35 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		mvebu_pcie_set_local_dev_nr(port, 1);
+		if (!enabled) {
+			u32 reg;
+			unsigned int tries;
+
+			/* The clock is being turned on for the first time, do
+			 * a PHY reset
+			 */
+			dev_info(&pdev->dev,
+				 "PCIe%d.%d: performing link reset\n",
+				 port->port, port->lane);
+			reg = mvebu_readl(port, PCIE_CTRL_OFF);
+			mvebu_writel(port,
+				     reg & ~BIT(30), // Conf_TrainingDisable
+				     PCIE_CTRL_OFF);
+			do {
+				udelay(100); // Guess?
+			} while (mvebu_pcie_link_up(port));
+			mvebu_pcie_set_local_dev_nr(port, 1);
+			mvebu_writel(port, reg | ~BIT(30), PCIE_CTRL_OFF);
+
+			for (tries = 0;
+			     !mvebu_pcie_link_up(port) && tries != 100; tries++)
+				udelay(100);
+		} else {
+			/* We expect the bootloader has setup the port and
+			 * waited for the link to go up
+			 */
+			mvebu_pcie_set_local_dev_nr(port, 1);
+		}
 
 		port->dn = child;
 		spin_lock_init(&port->conf_lock);

--J2SCkAp4GZ/dPZZf--
