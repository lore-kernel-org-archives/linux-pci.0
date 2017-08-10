Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:34096 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdHJIWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2017 04:22:00 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH] PCI: rockchip: fix system hang up if activate CONFIG_DEBUG_SHIRQ
Date: Thu, 10 Aug 2017 16:21:13 +0800
Message-Id: <1502353273-123788-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

With CONFIG_DEBUG_SHIRQ enabled, the irq tear down routine
would still access the irq handler registed as a shard irq.
Per the comment within the function of __free_irq, it says
"It's a shared IRQ -- the driver ought to be prepared for
an IRQ event to happen even now it's being freed". However
when failing to probe the driver, it may disable the clock
for accessing the register and the following check for shared
irq state would call the irq handler which accesses the register
w/o the clk enabled. That will hang the system forever.

With adding some dump_stack we could see how that happened.

calling  rockchip_pcie_driver_init+0x0/0x28 @ 1
rockchip-pcie f8000000.pcie: no vpcie3v3 regulator found
rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
rockchip-pcie f8000000.pcie: PCIe link training gen1 timeout!
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.13.0-rc3-next-20170807-ARCH+ #189
Hardware name: Firefly-RK3399 Board (DT)
Call trace:
[<ffff000008089bf0>] dump_backtrace+0x0/0x250
[<ffff000008089eb0>] show_stack+0x20/0x28
[<ffff000008c3313c>] dump_stack+0x90/0xb0
[<ffff000008632ad4>] rockchip_pcie_read.isra.11+0x54/0x58
[<ffff0000086334fc>] rockchip_pcie_client_irq_handler+0x30/0x1a0
[<ffff00000813ce98>] __free_irq+0x1c8/0x2dc
[<ffff00000813d044>] free_irq+0x44/0x74
[<ffff0000081415fc>] devm_irq_release+0x24/0x2c
[<ffff00000877429c>] release_nodes+0x1d8/0x30c
[<ffff000008774838>] devres_release_all+0x3c/0x5c
[<ffff00000876f19c>] driver_probe_device+0x244/0x494
[<ffff00000876f50c>] __driver_attach+0x120/0x124
[<ffff00000876cb80>] bus_for_each_dev+0x6c/0xac
[<ffff00000876e984>] driver_attach+0x2c/0x34
[<ffff00000876e3a4>] bus_add_driver+0x244/0x2b0
[<ffff000008770264>] driver_register+0x70/0x110
[<ffff0000087718b4>] platform_driver_register+0x60/0x6c
[<ffff0000091eb108>] rockchip_pcie_driver_init+0x20/0x28
[<ffff000008083a2c>] do_one_initcall+0xc8/0x130
[<ffff0000091a0ea8>] kernel_init_freeable+0x1a0/0x238
[<ffff000008c461cc>] kernel_init+0x18/0x108
[<ffff0000080836c0>] ret_from_fork+0x10/0x50

In order to fix this, we check the clk state before accessing the
pcie register in rockchip_pcie_read, but don't touch rockchip_pcie_write
as no case to trigger that from write routine.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---
Hi Bjorn, Thomas and Marc,

This fix looks more like a hack, but I don't know the legit way to
deal with that case. Just quick look into the drivers/pci/host, and
I see almost all drivers register shard irq and also disable the clk
in their probe's error handle path. So I guess this is NOT pcie-rockchip
specified even not pcie host drivers specified, but folks just luckily didn't
trip over it.

Could you give some suggestion on this?

 drivers/pci/host/pcie-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 39aafe2..daaa868b 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -17,6 +17,7 @@
 
 #include <linux/bitrev.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
@@ -252,6 +253,9 @@ struct rockchip_pcie {
 
 static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
 {
+	if (!__clk_is_enabled(rockchip->hclk_pcie))
+		return 0;
+
 	return readl(rockchip->apb_base + reg);
 }
 
-- 
1.9.1
