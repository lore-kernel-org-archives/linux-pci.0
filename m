Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36554 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750840AbcJ2LMp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2016 07:12:45 -0400
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jon Mason <jonmason@broadcom.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] ARM: BCM5301X: Add back handler ignoring external imprecise aborts
Date: Sat, 29 Oct 2016 13:12:29 +0200
Message-Id: <20161029111229.26875-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafał Miłecki <rafal@milecki.pl>

Since early BCM5301X days we got abort handler that was removed by
commit 937b12306ea79 ("ARM: BCM5301X: remove workaround imprecise abort
fault handler"). It assumed we need to deal only with pending aborts
left by the bootloader. Unfortunately this isn't true for BCM5301X.

When probing PCI config space (device enumeration) it is expected to
have master aborts on the PCI bus. Most bridges don't forward (or they
allow disabling it) these errors onto the AXI/AMBA bus but not the
Northstar (BCM5301X) one.

iProc PCIe controller on Northstar seems to be some older one, without
a control register for errors forwarding. It means we need to workaround
this at platform level. All newer platforms are not affected by this
issue.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm/mach-bcm/bcm_5301x.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/mach-bcm/bcm_5301x.c
index c8830a2..fe067f6 100644
--- a/arch/arm/mach-bcm/bcm_5301x.c
+++ b/arch/arm/mach-bcm/bcm_5301x.c
@@ -9,14 +9,42 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include <asm/mach/arch.h>
+#include <asm/siginfo.h>
+#include <asm/signal.h>
+
+#define FSR_EXTERNAL		(1 << 12)
+#define FSR_READ		(0 << 10)
+#define FSR_IMPRECISE		0x0406
 
 static const char *const bcm5301x_dt_compat[] __initconst = {
 	"brcm,bcm4708",
 	NULL,
 };
 
+static int bcm5301x_abort_handler(unsigned long addr, unsigned int fsr,
+				  struct pt_regs *regs)
+{
+	/*
+	 * We want to ignore aborts forwarded from the PCIe bus that are
+	 * expected and shouldn't really be passed by the PCIe controller.
+	 * The biggest disadvantage is the same FSR code may be reported when
+	 * reading non-existing APB register and we shouldn't ignore that.
+	 */
+	if (fsr == (FSR_EXTERNAL | FSR_READ | FSR_IMPRECISE))
+		return 0;
+
+	return 1;
+}
+
+static void __init bcm5301x_init_early(void)
+{
+	hook_fault_code(16 + 6, bcm5301x_abort_handler, SIGBUS, BUS_OBJERR,
+			"imprecise external abort");
+}
+
 DT_MACHINE_START(BCM5301X, "BCM5301X")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
 	.dt_compat	= bcm5301x_dt_compat,
+	.init_early	= bcm5301x_init_early,
 MACHINE_END
-- 
2.9.3

