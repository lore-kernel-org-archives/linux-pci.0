Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:46503 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756093AbaDKOcf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Apr 2014 10:32:35 -0400
Date: Fri, 11 Apr 2014 16:32:28 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Neil Greatorex <neil@fatboyfat.co.uk>,
	Willy Tarreau <w@1wt.eu>,
	Matthew Minter <matthew_minter@xyratex.com>,
	Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Gregory =?UTF-8?B?Q2zDqW1lbnQ=?=
	<gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Fixing PCIe issues on Armada XP
Message-ID: <20140411163228.4214645c@skate>
In-Reply-To: <20140410181953.50ccfcc3@skate>
References: <20140410181953.50ccfcc3@skate>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/W1HhlruT9H3213LTb1aY=1c"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello all,

On Thu, 10 Apr 2014 18:19:53 +0200, Thomas Petazzoni wrote:

> This is an e-mail that attempts to summarize the situation in terms of
> Armada XP PCIe issues.

Attached is a v2 of the patches to fix the various pci-mvebu issues.
Changes since the version posted yesterday:

 * Include a fix for the timing issue of the PCIe interface that gets
   its clock disabled. I've chosen a different approach than the one
   suggested by Jason Gunthorpe, which does not involve resetting the
   PHY. I've tested my fix on the Mirabox, and the Armada 385 DB board
   on which Gregory originally reported the problem (I finally managed
   to reproduce the problem, it was due to the fact that only one of
   the PCIe interfaces is actually affected by the problem, because
   only the clock of the first PCIe interface is used by the
   mvebu-soc-id stuff).

 * Invert the order of Willy's and Jason's patches around MBus
   addresses.

I've also:

 * Pushed the patches at
   https://github.com/MISL-EBU-System-SW/mainline-public/tree/3.14/pci-debug

 * Included a single combined patch, because I know one of you needs
   that to test easily.

Can everybody test these patches, and confirm that they solve all the
outstanding problems?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-igb-Fix-Null-pointer-dereference-in-igb_reset_q_vect.patch

>From 8996f4001da3d364b3d1b0633e059b5ff3da3b5b Mon Sep 17 00:00:00 2001
From: Christoph Paasch <christoph.paasch@uclouvain.be>
Date: Fri, 21 Mar 2014 03:48:19 -0700
Subject: [PATCH 01/13] igb: Fix Null-pointer dereference in igb_reset_q_vector

When igb_set_interrupt_capability() calls
igb_reset_interrupt_capability() (e.g., because CONFIG_PCI_MSI is unset),
num_q_vectors has been set but no vector has yet been allocated.

igb_reset_interrupt_capability() will then call igb_reset_q_vector,
which assumes that the vector is allocated. As this is not the case, we
are accessing a NULL-pointer.

This patch fixes it by checking that q_vector is indeed different from
NULL.

Fixes: 02ef6e1d0b0023 (igb: Fix queue allocation method to accommodate changing during runtime)
Cc: Carolyn Wyborny <carolyn.wyborny@intel.com>
Signed-off-by: Christoph Paasch <christoph.paasch@uclouvain.be>
Tested-by: Jeff Pieper <jeffrey.e.pieper@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 46d31a4..bfcf192 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1014,6 +1014,12 @@ static void igb_reset_q_vector(struct igb_adapter *adapter, int v_idx)
 {
 	struct igb_q_vector *q_vector = adapter->q_vector[v_idx];
 
+	/* Coming from igb_set_interrupt_capability, the vectors are not yet
+	 * allocated. So, q_vector is NULL so we should stop here.
+	 */
+	if (!q_vector)
+		return;
+
 	if (q_vector->tx.ring)
 		adapter->tx_ring[q_vector->tx.ring->queue_index] = NULL;
 
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0002-igb-Unset-IGB_FLAG_HAS_MSIX-flag-when-falling-back-t.patch

>From 9ecd88559e5d53d8923e1942e2a42aa266404554 Mon Sep 17 00:00:00 2001
From: Christoph Paasch <christoph.paasch@uclouvain.be>
Date: Fri, 21 Mar 2014 04:02:09 -0700
Subject: [PATCH 02/13] igb: Unset IGB_FLAG_HAS_MSIX-flag when falling back to
 msi-only

Prior to cd14ef54d25 (igb: Change to use statically allocated array for
MSIx entries), having msix_entries different from NULL was an indicator
that MSIX is enabled.
In igb_set_interrupt_capabiliy we may fall back to MSI-only. Prior to
the above patch msix_entries was set to NULL by
igb_reset_interrupt_capability.

However, now we are checking the flag for IGB_FLAG_HAS_MSIX and so the
stack gets completly confused:

[   42.659791] ------------[ cut here ]------------
[   42.715032] WARNING: CPU: 7 PID: 0 at net/sched/sch_generic.c:264 dev_watchdog+0x15c/0x1fb()
[   42.848263] NETDEV WATCHDOG: eth0 (igb): transmit queue 0 timed out
[   42.923253] Modules linked in:
[   42.959875] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 3.14.0-rc2-mptcp #437
[   43.043184] Hardware name: HP ProLiant DL165 G7, BIOS O37 01/26/2011
[   43.119215]  0000000000000108 ffff88023fdc3da8 ffffffff81487847 0000000000000108
[   43.208165]  ffff88023fdc3df8 ffff88023fdc3de8 ffffffff81034e7d ffff88023fdc3dd8
[   43.297120]  ffffffff813fff10 ffff880236018000 ffff880236b178c0 0000000000000008
[   43.386071] Call Trace:
[   43.415303]  <IRQ>  [<ffffffff81487847>] dump_stack+0x49/0x62
[   43.484174]  [<ffffffff81034e7d>] warn_slowpath_common+0x77/0x91
[   43.556049]  [<ffffffff813fff10>] ? dev_watchdog+0x15c/0x1fb
[   43.623759]  [<ffffffff81034f2b>] warn_slowpath_fmt+0x41/0x43
[   43.692511]  [<ffffffff813fff10>] dev_watchdog+0x15c/0x1fb
[   43.758141]  [<ffffffff813ffdb4>] ? __netdev_watchdog_up+0x64/0x64
[   43.832091]  [<ffffffff8103cd04>] call_timer_fn+0x17/0x6f
[   43.896682]  [<ffffffff8103cebe>] run_timer_softirq+0x162/0x1a2
[   43.967511]  [<ffffffff81038520>] __do_softirq+0xcd/0x1cc
[   44.032104]  [<ffffffff81038689>] irq_exit+0x3a/0x48
[   44.091492]  [<ffffffff81026d43>] smp_apic_timer_interrupt+0x43/0x50
[   44.167525]  [<ffffffff8148c24a>] apic_timer_interrupt+0x6a/0x70
[   44.239392]  <EOI>  [<ffffffff8100992c>] ? default_idle+0x6/0x8
[   44.310343]  [<ffffffff81009b31>] arch_cpu_idle+0x13/0x18
[   44.374934]  [<ffffffff81066126>] cpu_startup_entry+0xa7/0x101
[   44.444724]  [<ffffffff81025660>] start_secondary+0x1b2/0x1b7
[   44.513472] ---[ end trace a5a075fd4e7f854f ]---
[   44.568753] igb 0000:04:00.0 eth0: Reset adapter
[   46.206945] random: nonblocking pool is initialized
[   46.465670] irq 44: nobody cared (try booting with the "irqpoll" option)
[   46.545862] CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W    3.14.0-rc2-mptcp #437
[   46.640610] Hardware name: HP ProLiant DL165 G7, BIOS O37 01/26/2011
[   46.716641]  ffff8802363f8c84 ffff88023fdc3e38 ffffffff81487847 00000000a03cdb6d
[   46.805598]  ffff8802363f8c00 ffff88023fdc3e68 ffffffff81068489 0000007f81825400
[   46.894539]  ffff8802363f8c00 0000000000000000 0000000000000000 ffff88023fdc3ea8
[   46.983484] Call Trace:
[   47.012714]  <IRQ>  [<ffffffff81487847>] dump_stack+0x49/0x62
[   47.081585]  [<ffffffff81068489>] __report_bad_irq+0x35/0xc1
[   47.149295]  [<ffffffff81068683>] note_interrupt+0x16e/0x1ea
[   47.217006]  [<ffffffff8106679e>] handle_irq_event_percpu+0x116/0x12e
[   47.294075]  [<ffffffff810667e9>] handle_irq_event+0x33/0x4f
[   47.361787]  [<ffffffff81068c95>] handle_fasteoi_irq+0x83/0xd1
[   47.431577]  [<ffffffff81003d5b>] handle_irq+0x1f/0x28
[   47.493047]  [<ffffffff81003567>] do_IRQ+0x4e/0xd4
[   47.550358]  [<ffffffff8148b06a>] common_interrupt+0x6a/0x6a
[   47.618066]  <EOI>  [<ffffffff8100992c>] ? default_idle+0x6/0x8
[   47.689016]  [<ffffffff81009b31>] arch_cpu_idle+0x13/0x18
[   47.753605]  [<ffffffff81066126>] cpu_startup_entry+0xa7/0x101
[   47.823397]  [<ffffffff81025660>] start_secondary+0x1b2/0x1b7
[   47.892146] handlers:
[   47.919301] [<ffffffff812fbd7d>] igb_intr

So, this patch unsets the flag to indicate that we are not using MSIX.
This patch does exactly this: Unsetting the flag when falling back to MSI.

Fixes: cd14ef54d25b (igb: Change to use statically allocated array for MSIx entries)
Cc: Carolyn Wyborny <carolyn.wyborny@intel.com>
Signed-off-by: Christoph Paasch <christoph.paasch@uclouvain.be>
Tested-by: Jeff Pieper <jeffrey.e.pieper@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index bfcf192..d9c7eb2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1127,6 +1127,7 @@ static void igb_set_interrupt_capability(struct igb_adapter *adapter, bool msix)
 
 	/* If we can't do MSI-X, try MSI */
 msi_only:
+	adapter->flags &= ~IGB_FLAG_HAS_MSIX;
 #ifdef CONFIG_PCI_IOV
 	/* disable SR-IOV for non MSI-X configurations */
 	if (adapter->vf_data) {
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0003-ARM-mvebu-change-the-default-PCIe-apertures-for-Arma.patch

>From dc1e59a9dddf9f39b9a68fdd6d75e4517811de3b Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 4 Mar 2014 17:36:59 +0100
Subject: [PATCH 03/13] ARM: mvebu: change the default PCIe apertures for
 Armada 370/XP

The latest Marvell bootloaders for various boards change the MBus
Window base address from 0xC0000000 to 0xF0000000, in order to make
more RAM in the first 4 GB actually usable by the kernel (RAM that is
covered by the MBus window is "shadowed" and therefore not usable).

However, our default PCIe memory and I/O apertures where sitting at
0xe0000000 (for memory) and 0xe8000000 (for I/O), which will now be
outside of the MBus Window range on those platforms. To make things
work, we have to ensure those apertures use addresses in the
0xF0000000 -> 0xFFFFFFFF range.

Of course this change of the MBus Window base address from 0xC0000000
to 0xF0000000 also comes with a change of the internal register base
address from 0xD0000000 to 0xF1000000.

We have therefore designed the following memory map:

 * 0xF0000000 -> 0xF1000000: 16 MB, used for NOR flashes on Armada XP
   GP and Armada XP DB.

 * 0xF1000000 -> 0xF1100000: 1 MB, used for internal registers.

 * 0xF8000000 -> 0xFFE00000: 126 MB, used for PCIe memory.

 * 0xFFE00000 -> 0xFFF00000: 1 MB, used for PCIe I/O.

 * 0xFFF00000 -> 0xFFFFFFFF: 1 MB, used for the BootROM mapping

There is one exception to this layout: the Armada XP OpenBlocks, which
has a 128 MB NOR flash, mapped from 0xF0000000 to 0xF8000000. This
does not conflict with the current change for the PCIe I/O and memory
apertures, and continues to work because on Armada XP OpenBlocks, the
bootloader is an old one, and continues to have internal registers
mapped at 0xD0000000.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/armada-370-xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 74b5964..2188ce6 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -44,8 +44,8 @@
 		#size-cells = <1>;
 		controller = <&mbusc>;
 		interrupt-parent = <&mpic>;
-		pcie-mem-aperture = <0xe0000000 0x8000000>;
-		pcie-io-aperture  = <0xe8000000 0x100000>;
+		pcie-mem-aperture = <0xf8000000 0x7e00000>;
+		pcie-io-aperture  = <0xffe00000 0x100000>;
 
 		devbus-bootcs {
 			compatible = "marvell,mvebu-devbus";
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0004-ARM-mvebu-switch-the-Armada-XP-DB-to-use-internal-re.patch

>From b6ee050ba68e679ffc4549cb13913ba643c52d83 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 4 Mar 2014 17:37:00 +0100
Subject: [PATCH 04/13] ARM: mvebu: switch the Armada XP DB to use internal
 registers at 0xf1000000

Marvell has now provided bootloaders that are Device Tree capable for
the Armada XP DB board, and that also remap the internal register base
address to 0xf1000000. In addition, the bootloader now sets the MBus
Window base address to 0xf0000000, but on this board, this change
doesn't make much difference since the board is by default equipped
with 2 GB of RAM.

Therefore this commit updates the soc->ranges Device Tree property
with the fact that the internal registers are now mapped at
0xf1000000.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/armada-xp-db.dts | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index bcf6d79..448373c 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -2,7 +2,7 @@
  * Device Tree file for Marvell Armada XP evaluation board
  * (DB-78460-BP)
  *
- * Copyright (C) 2012 Marvell
+ * Copyright (C) 2012-2014 Marvell
  *
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
@@ -11,6 +11,15 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
+  *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
  */
 
 /dts-v1/;
@@ -30,7 +39,7 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
 
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0005-ARM-mvebu-switch-the-Armada-XP-GP-to-use-internal-re.patch

>From 05124e6a87b68c1aa1d138d1b1c0662386b9eab6 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 4 Mar 2014 17:37:01 +0100
Subject: [PATCH 05/13] ARM: mvebu: switch the Armada XP GP to use internal
 registers at 0xf1000000

Marvell has now provided bootloaders that are Device Tree capable for
the Armada XP GP board, and that also remap the internal register base
address to 0xf1000000. In addition, the bootloader now sets the MBus
Window base address to 0xf0000000, which allows to use much more RAM
in the last GB of RAM before the 4 GB limit (the entire space from
0xC0000000 to 0xFFFFFFFF was not usable due to being used for I/O, not
only the space from 0xF0000000 to 0xFFFFFFFF is used for I/O).

Therefore this commit:

 * Updates the memory->reg Device Tree property with the fact that in
   the first bank of RAM, memory up to 0xf0000000 can be used.

 * Updates the soc->ranges Device Tree property with the fact that the
   internal registers are now mapped at 0xf1000000.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/boot/dts/armada-xp-gp.dts | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 274e2ad..61bda68 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -2,7 +2,7 @@
  * Device Tree file for Marvell Armada XP development board
  * (DB-MV784MP-GP)
  *
- * Copyright (C) 2013 Marvell
+ * Copyright (C) 2013-2014 Marvell
  *
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
@@ -11,6 +11,15 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
  */
 
 /dts-v1/;
@@ -30,16 +39,17 @@
                  * 8 GB of plug-in RAM modules by default.The amount
                  * of memory available can be changed by the
                  * bootloader according the size of the module
-                 * actually plugged. Only 7GB are usable because
-                 * addresses from 0xC0000000 to 0xffffffff are used by
-                 * the internal registers of the SoC.
+                 * actually plugged. However, memory between
+                 * 0xF0000000 to 0xFFFFFFFF cannot be used, as it is
+                 * the address range used for I/O (internal registers,
+                 * MBus windows).
 		 */
-		reg = <0x00000000 0x00000000 0x00000000 0xC0000000>,
+		reg = <0x00000000 0x00000000 0x00000000 0xf0000000>,
 		      <0x00000001 0x00000000 0x00000001 0x00000000>;
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
 
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0006-irqchip-armada-370-xp-fix-invalid-cast-of-signed-val.patch

>From 5881c7df1167750b103a3612876c0d1c37b55345 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 8 Apr 2014 17:33:31 +0200
Subject: [PATCH 06/13] irqchip: armada-370-xp: fix invalid cast of signed
 value into unsigned variable

The armada_370_xp_alloc_msi() function returns a signed int, which is
negative on error. However, we store the return value into an
irq_hw_number_t, which is unsigned. Therefore, we actually never test
if armada_370_xp_alloc_msi() returns an error or not, which may lead
us to use hwirq numbers of as 0xffffffe4 (when
armada_370_xp_alloc_msi() returns -ENOSPC).

This commit fixes that by storing the return value of
armada_370_xp_alloc_msi() in a signed variable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5409564..7858729 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -130,8 +130,7 @@ static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
 				       struct msi_desc *desc)
 {
 	struct msi_msg msg;
-	irq_hw_number_t hwirq;
-	int virq;
+	int virq, hwirq;
 
 	hwirq = armada_370_xp_alloc_msi();
 	if (hwirq < 0)
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0007-irqchip-armada-370-xp-implement-the-check_device-msi.patch

>From 8ee3f1764fdc1c49b4199b36d21e5f40f53eca4f Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 8 Apr 2014 17:35:23 +0200
Subject: [PATCH 07/13] irqchip: armada-370-xp: implement the ->check_device()
 msi_chip operation

Until now, we were leaving the ->check_device() msi_chip operation
empty, which leads the PCI core to believe that we support both MSI
and MSI-X. In fact, we do not support MSI-X, so we have to tell this
to the PCI core by providing an implementation of this operation.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 7858729..5d925af 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -160,6 +160,15 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 	armada_370_xp_free_msi(d->hwirq);
 }
 
+static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
+					  int nvec, int type)
+{
+	/* We support MSI, but not MSI-X */
+	if (type == PCI_CAP_ID_MSI)
+		return 0;
+	return -EINVAL;
+}
+
 static struct irq_chip armada_370_xp_msi_irq_chip = {
 	.name = "armada_370_xp_msi_irq",
 	.irq_enable = unmask_msi_irq,
@@ -198,6 +207,7 @@ static int armada_370_xp_msi_init(struct device_node *node,
 
 	msi_chip->setup_irq = armada_370_xp_setup_msi_irq;
 	msi_chip->teardown_irq = armada_370_xp_teardown_msi_irq;
+	msi_chip->check_device = armada_370_xp_check_msi_device;
 	msi_chip->of_node = node;
 
 	armada_370_xp_msi_domain =
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0008-irqchip-armada-370-xp-Fix-releasing-of-MSIs.patch

>From 3521e42c3b6880fc466ef431e766d71bf77b206e Mon Sep 17 00:00:00 2001
From: Neil Greatorex <neil@fatboyfat.co.uk>
Date: Sun, 6 Apr 2014 16:10:43 +0100
Subject: [PATCH 08/13] irqchip: armada-370-xp: Fix releasing of MSIs

Store the value of d->hwirq in a local variable as the real value is wiped out
by calling irq_dispose_mapping. Without this patch, the armada_370_xp_free_msi
function would always free MSI#0, no matter what was passed to it.

Signed-off-by: Neil Greatorex <neil@fatboyfat.co.uk>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5d925af..939eb0d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -156,8 +156,10 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 					   unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
+	unsigned long hwirq = d->hwirq;
+
 	irq_dispose_mapping(irq);
-	armada_370_xp_free_msi(d->hwirq);
+	armada_370_xp_free_msi(hwirq);
 }
 
 static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0009-pci-mvebu-fix-off-by-one-in-the-computed-size-of-the.patch

>From 7c1f808988da77a1d315459f735609426abb2c41 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Wed, 9 Apr 2014 08:05:09 +0200
Subject: [PATCH 09/13] pci: mvebu: fix off-by-one in the computed size of the
 mbus windows

mvebu_pcie_handle_membase_change() and
mvebu_pcie_handle_iobase_change() do not correctly compute the window
size. PCI uses an inclusive start/end address pair, which requires a
+1 when converting to size.

This only worked because a bug in the mbus driver allowed it to
silently accept and round up bogus sizes.

Fix this by adding one to the computed size.

Signed-off-by: Willy Tarreau <w@1wt.eu>
Reviewed-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0e79665..eff0ab5 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -329,7 +329,7 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 	port->iowin_base = port->pcie->io.start + iobase;
 	port->iowin_size = ((0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
 			    (port->bridge.iolimitupper << 16)) -
-			    iobase);
+			    iobase) + 1;
 
 	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
 					  port->iowin_base, port->iowin_size,
@@ -362,7 +362,7 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	port->memwin_base  = ((port->bridge.membase & 0xFFF0) << 16);
 	port->memwin_size  =
 		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
-		port->memwin_base;
+		port->memwin_base + 1;
 
 	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
 				    port->memwin_base, port->memwin_size);
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0010-bus-mvebu-mbus-Avoid-setting-an-undefined-window-siz.patch

>From e3eaec9f807213a6321c44780a09187c93f0145a Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Tue, 8 Apr 2014 17:44:14 -0600
Subject: [PATCH 10/13] bus: mvebu-mbus: Avoid setting an undefined window size

The mbus hardware requires a power of two size, and size aligned base.
Currently, if a non-power of two is passed in to the low level routines
they configure the register in a way that results in undefined behaviour.

Call WARN and return EINVAL instead.

Also, update the debugfs routines to show a message if there is an
invalid register setting.

All together this makes the recent problems with silent failure
of PCI very obvious, noisy and debuggable.

Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 725c461..15a398d 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -56,6 +56,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/debugfs.h>
+#include <linux/log2.h>
 
 /*
  * DDR target is the same on all platforms.
@@ -266,6 +267,17 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 		mbus->soc->win_cfg_offset(win);
 	u32 ctrl, remap_addr;
 
+	if (!is_power_of_2(size)) {
+		WARN(true, "Invalid MBus window size: 0x%zx\n", size);
+		return -EINVAL;
+	}
+
+	if ((base & (phys_addr_t)(size - 1)) != 0) {
+		WARN(true, "Invalid MBus base/size: %pa len 0x%zx\n", &base,
+		     size);
+		return -EINVAL;
+	}
+
 	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
 		(attr << WIN_CTRL_ATTR_SHIFT)    |
 		(target << WIN_CTRL_TGT_SHIFT)   |
@@ -413,6 +425,10 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 			   win, (unsigned long long)wbase,
 			   (unsigned long long)(wbase + wsize), wtarget, wattr);
 
+		if (!is_power_of_2(wsize) ||
+		    ((wbase & (u64)(wsize - 1)) != 0))
+			seq_puts(seq, " (Invalid base/size!!)");
+
 		if (win < mbus->soc->num_remappable_wins) {
 			seq_printf(seq, " (remap %016llx)\n",
 				   (unsigned long long)wremap);
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0011-bus-mvebu-mbus-allow-several-windows-with-the-same-t.patch

>From d6184385d76474408ad9922be57d0d47525094e0 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 10 Apr 2014 16:15:15 +0200
Subject: [PATCH 11/13] bus: mvebu-mbus: allow several windows with the same
 target/attribute

Having multiple windows with the same target and attribute is actually
legal, and can be useful for PCIe windows, when PCIe BARs have a size
that isn't a power of two, and we therefore need to create several
MBus windows to cover the PCIe BAR for a given PCIe interface.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/bus/mvebu-mbus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 15a398d..54d339e 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -223,12 +223,6 @@ static int mvebu_mbus_window_conflicts(struct mvebu_mbus_state *mbus,
 		 */
 		if ((u64)base < wend && end > wbase)
 			return 0;
-
-		/*
-		 * Check if target/attribute conflicts
-		 */
-		if (target == wtarget && attr == wattr)
-			return 0;
 	}
 
 	return 1;
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0012-pci-pci-mvebu-split-PCIe-BARs-into-multiple-MBus-win.patch

>From d5c41e956a19f4f7c69bc002291a866f4ad3e145 Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Thu, 10 Apr 2014 16:16:16 +0200
Subject: [PATCH 12/13] pci: pci-mvebu: split PCIe BARs into multiple MBus
 windows when needed

MBus windows are used on Marvell platforms to map certain peripherals
in the physical address space. In the PCIe context, MBus windows are
needed to map PCIe I/O and memory regions in the physical address.

However, those MBus windows can only have power of two sizes, while
PCIe BAR do not necessarily guarantee this. For this reason, the
current pci-mvebu breaks on platforms where PCIe devices have BARs
that don't sum up to a power of two size at the emulated bridge level.

This commit fixes this by allowing the pci-mvebu driver to create
multiple contiguous MBus windows (each having a power of two size) to
cover a given PCIe BAR.

To achieve this, two functions are added: mvebu_pcie_add_windows() and
mvebu_pcie_del_windows() to respectively add and remove all the MBus
windows that are needed to map the provided PCIe region base and
size. The emulated PCI bridge code now calls those functions, instead
of directly calling the mvebu-mbus driver functions.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 88 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index eff0ab5..487c926 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -291,6 +291,58 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+/*
+ * Remove windows, starting from the largest ones to the smallest
+ * ones.
+ */
+static void mvebu_pcie_del_windows(struct mvebu_pcie_port *port,
+				   phys_addr_t base, size_t size)
+{
+	while (size) {
+		size_t sz = 1 << (fls(size) - 1);
+
+		mvebu_mbus_del_window(base, sz);
+		base += sz;
+		size -= sz;
+	}
+}
+
+/*
+ * MBus windows can only have a power of two size, but PCI BARs do not
+ * have this constraint. Therefore, we have to split the PCI BAR into
+ * areas each having a power of two size. We start from the largest
+ * one (i.e highest order bit set in the size).
+ */
+static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
+				   unsigned int target, unsigned int attribute,
+				   phys_addr_t base, size_t size,
+				   phys_addr_t remap)
+{
+	size_t size_mapped = 0;
+
+	while (size) {
+		size_t sz = 1 << (fls(size) - 1);
+		int ret;
+
+		ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
+							sz, remap);
+		if (ret) {
+			dev_err(&port->pcie->pdev->dev,
+				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
+				base, sz, ret);
+			mvebu_pcie_del_windows(port, base - size_mapped,
+					       size_mapped);
+			return;
+		}
+
+		size -= sz;
+		size_mapped += sz;
+		base += sz;
+		if (remap != MVEBU_MBUS_NO_REMAP)
+			remap += sz;
+	}
+}
+
 static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 {
 	phys_addr_t iobase;
@@ -302,8 +354,8 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 		/* If a window was configured, remove it */
 		if (port->iowin_base) {
-			mvebu_mbus_del_window(port->iowin_base,
-					      port->iowin_size);
+			mvebu_pcie_del_windows(port, port->iowin_base,
+					       port->iowin_size);
 			port->iowin_base = 0;
 			port->iowin_size = 0;
 		}
@@ -331,9 +383,9 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 			    (port->bridge.iolimitupper << 16)) -
 			    iobase) + 1;
 
-	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
-					  port->iowin_base, port->iowin_size,
-					  iobase);
+	mvebu_pcie_add_windows(port, port->io_target, port->io_attr,
+			       port->iowin_base, port->iowin_size,
+			       iobase);
 }
 
 static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
@@ -344,8 +396,8 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 
 		/* If a window was configured, remove it */
 		if (port->memwin_base) {
-			mvebu_mbus_del_window(port->memwin_base,
-					      port->memwin_size);
+			mvebu_pcie_del_windows(port, port->memwin_base,
+					       port->memwin_size);
 			port->memwin_base = 0;
 			port->memwin_size = 0;
 		}
@@ -364,8 +416,9 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
 		port->memwin_base + 1;
 
-	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
-				    port->memwin_base, port->memwin_size);
+	mvebu_pcie_add_windows(port, port->mem_target, port->mem_attr,
+			       port->memwin_base, port->memwin_size,
+			       MVEBU_MBUS_NO_REMAP);
 }
 
 /*
@@ -721,14 +774,21 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 
 	/*
 	 * On the PCI-to-PCI bridge side, the I/O windows must have at
-	 * least a 64 KB size and be aligned on their size, and the
-	 * memory windows must have at least a 1 MB size and be
-	 * aligned on their size
+	 * least a 64 KB size and the memory windows must have at
+	 * least a 1 MB size. Moreover, MBus windows need to have a
+	 * base address aligned on their size, and their size must be
+	 * a power of two. This means that if the BAR doesn't have a
+	 * power of two size, several MBus windows will actually be
+	 * created. We need to ensure that the biggest MBus window
+	 * (which will be the first one) is aligned on its size, which
+	 * explains the rounddown_pow_of_two() being done here.
 	 */
 	if (res->flags & IORESOURCE_IO)
-		return round_up(start, max_t(resource_size_t, SZ_64K, size));
+		return round_up(start, max_t(resource_size_t, SZ_64K,
+					     rounddown_pow_of_two(size)));
 	else if (res->flags & IORESOURCE_MEM)
-		return round_up(start, max_t(resource_size_t, SZ_1M, size));
+		return round_up(start, max_t(resource_size_t, SZ_1M,
+					     rounddown_pow_of_two(size)));
 	else
 		return start;
 }
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0013-pci-pci-mvebu-wait-for-a-device-to-appear-to-fix-clo.patch

>From 72706b22617da7ef8dcf1924f4c204383111401c Mon Sep 17 00:00:00 2001
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Fri, 11 Apr 2014 15:22:36 +0200
Subject: [PATCH 13/13] pci: pci-mvebu: wait for a device to appear to fix
 clock issues

With the introduction of the mvebu-soc-id mechanism in
arch/arm/mach-mvebu/, the PCIe clocks can be gated during early boot,
and then re-enabled later when the pci-mvebu driver gets
called. However, after the clock has been enabled, it takes some time
for the PCIe device to become visible: this is causing problems on
some platforms where PCIe devices may not be detected at boot time due
to this.

To fix this, this commit introduces a simple loop that waits for a
valid device to actually show up on each PCIe interface for which the
link is up.

It fixes a problem reported both by Gregory Clement and Neil
Greatorex, which were seeing all PCIe devices detected when
earlyprintk was enabled, but one of the device was missing when
earlyprintk was disabled. This was due to the fact that earlyprintk
was slowing down the boot sufficiently to make the problem invisible.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reported-by: Neil Greatorex <neil@fatboyfat.co.uk>
Reported-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/pci/host/pci-mvebu.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 487c926..008d718 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -21,6 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 
 /*
  * PCIe unit register offsets.
@@ -162,6 +163,14 @@ static void mvebu_pcie_set_local_bus_nr(struct mvebu_pcie_port *port, int nr)
 	mvebu_writel(port, stat, PCIE_STAT_OFF);
 }
 
+static u32 mvebu_pcie_get_local_bus_nr(struct mvebu_pcie_port *port)
+{
+	u32 stat;
+
+	stat = mvebu_readl(port, PCIE_STAT_OFF);
+	return (stat & PCIE_STAT_BUS) >> 8;
+}
+
 static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 {
 	u32 stat;
@@ -172,6 +181,30 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 	mvebu_writel(port, stat, PCIE_STAT_OFF);
 }
 
+static void mvebu_pcie_wait_dev(struct mvebu_pcie_port *port)
+{
+	int tries;
+
+	for (tries = 0; tries < 1000; tries++) {
+		u32 vpid;
+
+		mvebu_writel(port,
+			     PCIE_CONF_ADDR(mvebu_pcie_get_local_bus_nr(port),
+					    PCI_DEVFN(0, 0), PCI_VENDOR_ID),
+			     PCIE_CONF_ADDR_OFF);
+		vpid = mvebu_readl(port, PCIE_CONF_DATA_OFF);
+
+		if (vpid != 0xffffffff)
+			break;
+
+		udelay(100);
+	}
+
+	if (tries >= 1000)
+		dev_warn(&port->pcie->pdev->dev,
+			 "timeout when looking for the PCIe device\n");
+}
+
 /*
  * Setup PCIE BARs and Address Decode Wins:
  * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
@@ -951,6 +984,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 		enum of_gpio_flags flags;
+		int linkup;
 
 		if (!of_device_is_available(child))
 			continue;
@@ -1035,8 +1069,13 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		linkup = mvebu_pcie_link_up(port);
+
 		mvebu_pcie_set_local_dev_nr(port, 1);
 
+		if (linkup)
+			mvebu_pcie_wait_dev(port);
+
 		port->dn = child;
 		spin_lock_init(&port->conf_lock);
 		mvebu_sw_pci_bridge_init(port);
-- 
1.8.3.2


--MP_/W1HhlruT9H3213LTb1aY=1c
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=combined.patch

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 74b5964..2188ce6 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -44,8 +44,8 @@
 		#size-cells = <1>;
 		controller = <&mbusc>;
 		interrupt-parent = <&mpic>;
-		pcie-mem-aperture = <0xe0000000 0x8000000>;
-		pcie-io-aperture  = <0xe8000000 0x100000>;
+		pcie-mem-aperture = <0xf8000000 0x7e00000>;
+		pcie-io-aperture  = <0xffe00000 0x100000>;
 
 		devbus-bootcs {
 			compatible = "marvell,mvebu-devbus";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index bcf6d79..448373c 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -2,7 +2,7 @@
  * Device Tree file for Marvell Armada XP evaluation board
  * (DB-78460-BP)
  *
- * Copyright (C) 2012 Marvell
+ * Copyright (C) 2012-2014 Marvell
  *
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
@@ -11,6 +11,15 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
+  *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
  */
 
 /dts-v1/;
@@ -30,7 +39,7 @@
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
 
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 274e2ad..61bda68 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -2,7 +2,7 @@
  * Device Tree file for Marvell Armada XP development board
  * (DB-MV784MP-GP)
  *
- * Copyright (C) 2013 Marvell
+ * Copyright (C) 2013-2014 Marvell
  *
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
@@ -11,6 +11,15 @@
  * This file is licensed under the terms of the GNU General Public
  * License version 2.  This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
+ *
+ * Note: this Device Tree assumes that the bootloader has remapped the
+ * internal registers to 0xf1000000 (instead of the default
+ * 0xd0000000). The 0xf1000000 is the default used by the recent,
+ * DT-capable, U-Boot bootloaders provided by Marvell. Some earlier
+ * boards were delivered with an older version of the bootloader that
+ * left internal registers mapped at 0xd0000000. If you are in this
+ * situation, you should either update your bootloader (preferred
+ * solution) or the below Device Tree should be adjusted.
  */
 
 /dts-v1/;
@@ -30,16 +39,17 @@
                  * 8 GB of plug-in RAM modules by default.The amount
                  * of memory available can be changed by the
                  * bootloader according the size of the module
-                 * actually plugged. Only 7GB are usable because
-                 * addresses from 0xC0000000 to 0xffffffff are used by
-                 * the internal registers of the SoC.
+                 * actually plugged. However, memory between
+                 * 0xF0000000 to 0xFFFFFFFF cannot be used, as it is
+                 * the address range used for I/O (internal registers,
+                 * MBus windows).
 		 */
-		reg = <0x00000000 0x00000000 0x00000000 0xC0000000>,
+		reg = <0x00000000 0x00000000 0x00000000 0xf0000000>,
 		      <0x00000001 0x00000000 0x00000001 0x00000000>;
 	};
 
 	soc {
-		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
 
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 725c461..54d339e 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -56,6 +56,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/debugfs.h>
+#include <linux/log2.h>
 
 /*
  * DDR target is the same on all platforms.
@@ -222,12 +223,6 @@ static int mvebu_mbus_window_conflicts(struct mvebu_mbus_state *mbus,
 		 */
 		if ((u64)base < wend && end > wbase)
 			return 0;
-
-		/*
-		 * Check if target/attribute conflicts
-		 */
-		if (target == wtarget && attr == wattr)
-			return 0;
 	}
 
 	return 1;
@@ -266,6 +261,17 @@ static int mvebu_mbus_setup_window(struct mvebu_mbus_state *mbus,
 		mbus->soc->win_cfg_offset(win);
 	u32 ctrl, remap_addr;
 
+	if (!is_power_of_2(size)) {
+		WARN(true, "Invalid MBus window size: 0x%zx\n", size);
+		return -EINVAL;
+	}
+
+	if ((base & (phys_addr_t)(size - 1)) != 0) {
+		WARN(true, "Invalid MBus base/size: %pa len 0x%zx\n", &base,
+		     size);
+		return -EINVAL;
+	}
+
 	ctrl = ((size - 1) & WIN_CTRL_SIZE_MASK) |
 		(attr << WIN_CTRL_ATTR_SHIFT)    |
 		(target << WIN_CTRL_TGT_SHIFT)   |
@@ -413,6 +419,10 @@ static int mvebu_devs_debug_show(struct seq_file *seq, void *v)
 			   win, (unsigned long long)wbase,
 			   (unsigned long long)(wbase + wsize), wtarget, wattr);
 
+		if (!is_power_of_2(wsize) ||
+		    ((wbase & (u64)(wsize - 1)) != 0))
+			seq_puts(seq, " (Invalid base/size!!)");
+
 		if (win < mbus->soc->num_remappable_wins) {
 			seq_printf(seq, " (remap %016llx)\n",
 				   (unsigned long long)wremap);
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 5409564..939eb0d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -130,8 +130,7 @@ static int armada_370_xp_setup_msi_irq(struct msi_chip *chip,
 				       struct msi_desc *desc)
 {
 	struct msi_msg msg;
-	irq_hw_number_t hwirq;
-	int virq;
+	int virq, hwirq;
 
 	hwirq = armada_370_xp_alloc_msi();
 	if (hwirq < 0)
@@ -157,8 +156,19 @@ static void armada_370_xp_teardown_msi_irq(struct msi_chip *chip,
 					   unsigned int irq)
 {
 	struct irq_data *d = irq_get_irq_data(irq);
+	unsigned long hwirq = d->hwirq;
+
 	irq_dispose_mapping(irq);
-	armada_370_xp_free_msi(d->hwirq);
+	armada_370_xp_free_msi(hwirq);
+}
+
+static int armada_370_xp_check_msi_device(struct msi_chip *chip, struct pci_dev *dev,
+					  int nvec, int type)
+{
+	/* We support MSI, but not MSI-X */
+	if (type == PCI_CAP_ID_MSI)
+		return 0;
+	return -EINVAL;
 }
 
 static struct irq_chip armada_370_xp_msi_irq_chip = {
@@ -199,6 +209,7 @@ static int armada_370_xp_msi_init(struct device_node *node,
 
 	msi_chip->setup_irq = armada_370_xp_setup_msi_irq;
 	msi_chip->teardown_irq = armada_370_xp_teardown_msi_irq;
+	msi_chip->check_device = armada_370_xp_check_msi_device;
 	msi_chip->of_node = node;
 
 	armada_370_xp_msi_domain =
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 46d31a4..d9c7eb2 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1014,6 +1014,12 @@ static void igb_reset_q_vector(struct igb_adapter *adapter, int v_idx)
 {
 	struct igb_q_vector *q_vector = adapter->q_vector[v_idx];
 
+	/* Coming from igb_set_interrupt_capability, the vectors are not yet
+	 * allocated. So, q_vector is NULL so we should stop here.
+	 */
+	if (!q_vector)
+		return;
+
 	if (q_vector->tx.ring)
 		adapter->tx_ring[q_vector->tx.ring->queue_index] = NULL;
 
@@ -1121,6 +1127,7 @@ static void igb_set_interrupt_capability(struct igb_adapter *adapter, bool msix)
 
 	/* If we can't do MSI-X, try MSI */
 msi_only:
+	adapter->flags &= ~IGB_FLAG_HAS_MSIX;
 #ifdef CONFIG_PCI_IOV
 	/* disable SR-IOV for non MSI-X configurations */
 	if (adapter->vf_data) {
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0e79665..008d718 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -21,6 +21,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/clk-provider.h>
 
 /*
  * PCIe unit register offsets.
@@ -162,6 +163,14 @@ static void mvebu_pcie_set_local_bus_nr(struct mvebu_pcie_port *port, int nr)
 	mvebu_writel(port, stat, PCIE_STAT_OFF);
 }
 
+static u32 mvebu_pcie_get_local_bus_nr(struct mvebu_pcie_port *port)
+{
+	u32 stat;
+
+	stat = mvebu_readl(port, PCIE_STAT_OFF);
+	return (stat & PCIE_STAT_BUS) >> 8;
+}
+
 static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 {
 	u32 stat;
@@ -172,6 +181,30 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 	mvebu_writel(port, stat, PCIE_STAT_OFF);
 }
 
+static void mvebu_pcie_wait_dev(struct mvebu_pcie_port *port)
+{
+	int tries;
+
+	for (tries = 0; tries < 1000; tries++) {
+		u32 vpid;
+
+		mvebu_writel(port,
+			     PCIE_CONF_ADDR(mvebu_pcie_get_local_bus_nr(port),
+					    PCI_DEVFN(0, 0), PCI_VENDOR_ID),
+			     PCIE_CONF_ADDR_OFF);
+		vpid = mvebu_readl(port, PCIE_CONF_DATA_OFF);
+
+		if (vpid != 0xffffffff)
+			break;
+
+		udelay(100);
+	}
+
+	if (tries >= 1000)
+		dev_warn(&port->pcie->pdev->dev,
+			 "timeout when looking for the PCIe device\n");
+}
+
 /*
  * Setup PCIE BARs and Address Decode Wins:
  * BAR[0,2] -> disabled, BAR[1] -> covers all DRAM banks
@@ -291,6 +324,58 @@ static int mvebu_pcie_hw_wr_conf(struct mvebu_pcie_port *port,
 	return PCIBIOS_SUCCESSFUL;
 }
 
+/*
+ * Remove windows, starting from the largest ones to the smallest
+ * ones.
+ */
+static void mvebu_pcie_del_windows(struct mvebu_pcie_port *port,
+				   phys_addr_t base, size_t size)
+{
+	while (size) {
+		size_t sz = 1 << (fls(size) - 1);
+
+		mvebu_mbus_del_window(base, sz);
+		base += sz;
+		size -= sz;
+	}
+}
+
+/*
+ * MBus windows can only have a power of two size, but PCI BARs do not
+ * have this constraint. Therefore, we have to split the PCI BAR into
+ * areas each having a power of two size. We start from the largest
+ * one (i.e highest order bit set in the size).
+ */
+static void mvebu_pcie_add_windows(struct mvebu_pcie_port *port,
+				   unsigned int target, unsigned int attribute,
+				   phys_addr_t base, size_t size,
+				   phys_addr_t remap)
+{
+	size_t size_mapped = 0;
+
+	while (size) {
+		size_t sz = 1 << (fls(size) - 1);
+		int ret;
+
+		ret = mvebu_mbus_add_window_remap_by_id(target, attribute, base,
+							sz, remap);
+		if (ret) {
+			dev_err(&port->pcie->pdev->dev,
+				"Could not create MBus window at 0x%x, size 0x%x: %d\n",
+				base, sz, ret);
+			mvebu_pcie_del_windows(port, base - size_mapped,
+					       size_mapped);
+			return;
+		}
+
+		size -= sz;
+		size_mapped += sz;
+		base += sz;
+		if (remap != MVEBU_MBUS_NO_REMAP)
+			remap += sz;
+	}
+}
+
 static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 {
 	phys_addr_t iobase;
@@ -302,8 +387,8 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 
 		/* If a window was configured, remove it */
 		if (port->iowin_base) {
-			mvebu_mbus_del_window(port->iowin_base,
-					      port->iowin_size);
+			mvebu_pcie_del_windows(port, port->iowin_base,
+					       port->iowin_size);
 			port->iowin_base = 0;
 			port->iowin_size = 0;
 		}
@@ -329,11 +414,11 @@ static void mvebu_pcie_handle_iobase_change(struct mvebu_pcie_port *port)
 	port->iowin_base = port->pcie->io.start + iobase;
 	port->iowin_size = ((0xFFF | ((port->bridge.iolimit & 0xF0) << 8) |
 			    (port->bridge.iolimitupper << 16)) -
-			    iobase);
+			    iobase) + 1;
 
-	mvebu_mbus_add_window_remap_by_id(port->io_target, port->io_attr,
-					  port->iowin_base, port->iowin_size,
-					  iobase);
+	mvebu_pcie_add_windows(port, port->io_target, port->io_attr,
+			       port->iowin_base, port->iowin_size,
+			       iobase);
 }
 
 static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
@@ -344,8 +429,8 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 
 		/* If a window was configured, remove it */
 		if (port->memwin_base) {
-			mvebu_mbus_del_window(port->memwin_base,
-					      port->memwin_size);
+			mvebu_pcie_del_windows(port, port->memwin_base,
+					       port->memwin_size);
 			port->memwin_base = 0;
 			port->memwin_size = 0;
 		}
@@ -362,10 +447,11 @@ static void mvebu_pcie_handle_membase_change(struct mvebu_pcie_port *port)
 	port->memwin_base  = ((port->bridge.membase & 0xFFF0) << 16);
 	port->memwin_size  =
 		(((port->bridge.memlimit & 0xFFF0) << 16) | 0xFFFFF) -
-		port->memwin_base;
+		port->memwin_base + 1;
 
-	mvebu_mbus_add_window_by_id(port->mem_target, port->mem_attr,
-				    port->memwin_base, port->memwin_size);
+	mvebu_pcie_add_windows(port, port->mem_target, port->mem_attr,
+			       port->memwin_base, port->memwin_size,
+			       MVEBU_MBUS_NO_REMAP);
 }
 
 /*
@@ -721,14 +807,21 @@ static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 
 	/*
 	 * On the PCI-to-PCI bridge side, the I/O windows must have at
-	 * least a 64 KB size and be aligned on their size, and the
-	 * memory windows must have at least a 1 MB size and be
-	 * aligned on their size
+	 * least a 64 KB size and the memory windows must have at
+	 * least a 1 MB size. Moreover, MBus windows need to have a
+	 * base address aligned on their size, and their size must be
+	 * a power of two. This means that if the BAR doesn't have a
+	 * power of two size, several MBus windows will actually be
+	 * created. We need to ensure that the biggest MBus window
+	 * (which will be the first one) is aligned on its size, which
+	 * explains the rounddown_pow_of_two() being done here.
 	 */
 	if (res->flags & IORESOURCE_IO)
-		return round_up(start, max_t(resource_size_t, SZ_64K, size));
+		return round_up(start, max_t(resource_size_t, SZ_64K,
+					     rounddown_pow_of_two(size)));
 	else if (res->flags & IORESOURCE_MEM)
-		return round_up(start, max_t(resource_size_t, SZ_1M, size));
+		return round_up(start, max_t(resource_size_t, SZ_1M,
+					     rounddown_pow_of_two(size)));
 	else
 		return start;
 }
@@ -891,6 +984,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 		enum of_gpio_flags flags;
+		int linkup;
 
 		if (!of_device_is_available(child))
 			continue;
@@ -975,8 +1069,13 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		linkup = mvebu_pcie_link_up(port);
+
 		mvebu_pcie_set_local_dev_nr(port, 1);
 
+		if (linkup)
+			mvebu_pcie_wait_dev(port);
+
 		port->dn = child;
 		spin_lock_init(&port->conf_lock);
 		mvebu_sw_pci_bridge_init(port);

--MP_/W1HhlruT9H3213LTb1aY=1c--
