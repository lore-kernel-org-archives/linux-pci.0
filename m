Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0136.outbound.protection.outlook.com ([157.56.111.136]:40768
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751359AbaI3JuX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 30 Sep 2014 05:50:23 -0400
From: Richard Zhu <r65037@freescale.com>
To: <linux-pci-owner@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <shawn.guo@freescale.com>,
	<festevam@gmail.com>, <l.stach@pengutronix.de>,
	<tharvey@gateworks.com>, Richard Zhu <r65037@freescale.com>
Subject: [PATCH v4 03/10] PCI: imx6: Fix possible dead lock
Date: Tue, 30 Sep 2014 17:19:50 +0800
Message-ID: <1412068796-16931-4-git-send-email-r65037@freescale.com>
In-Reply-To: <1412068796-16931-1-git-send-email-r65037@freescale.com>
References: <1412068796-16931-1-git-send-email-r65037@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

kernel report one possible dead lock during imx6sx pcie
suspend resume stress tests, after enable Lock Debugging.
platform: imx6sx sdb board + xhci(pcie2usb3.0 ep)

reason: usleep_range used in imx6_pcie_link_up maybe scheduled
out from dw_pcie_valid_config.isra...
About details, please see the following logs.

solution: replace the usleep_range(1000, 2000) by udelay(10) and
enlarge the loop counter.

logs:
[   50.643062] xhci_hcd 0000:01:00.0: Refused to change power state, currently in D3
[   50.653390]
[   50.654898] =========================================================
[   50.661343] [ INFO: possible irq lock inversion dependency detected ]
[   50.667792] 3.17.0-rc2-01341-gfc43ff7-dirty #101 Not tainted
[   50.673454] ---------------------------------------------------------
[   50.679898] kworker/u2:2/48 just changed the state of lock:
[   50.685477]  (pci_lock){+.....}, at: [<802d650c>] pci_bus_read_config_dword+0x44/0x94
[   50.693394] but this lock was taken by another, HARDIRQ-safe lock in the past:
[   50.700619]  (&irq_desc_lock_class){-.-...}

and interrupts could create inverse lock ordering between them.

[   50.710843]
[   50.710843] other info that might help us debug this:
[   50.717377]  Possible interrupt unsafe locking scenario:
[   50.717377]
[   50.724169]        CPU0                    CPU1
[   50.728702]        ----                    ----
[   50.733234]   lock(pci_lock);
[   50.736232]                                local_irq_disable();
[   50.742154]                                lock(&irq_desc_lock_class);
[   50.748713]                                lock(pci_lock);
[   50.754229]   <Interrupt>
[   50.756852]     lock(&irq_desc_lock_class);
[   50.761065]
[   50.761065]  *** DEADLOCK ***
...

[   52.119515] [<806e8ad0>] (schedule_hrtimeout_range) from [<80077e90>] (usleep_range+0x50/0x58)
[   52.128141] [<80077e40>] (usleep_range) from [<802f3694>] (imx6_pcie_link_up+0x48/0x16c)
[   52.136242] [<802f364c>] (imx6_pcie_link_up) from [<802f1b74>] (dw_pcie_valid_config.isra.10+0x40/0x7c)
[   52.145637]  r6:ae72606d r5:ae72606c r4:ae711228
[   52.150311] [<802f1b34>] (dw_pcie_valid_config.isra.10) from [<802f1ca8>] (dw_pcie_rd_conf+0x4c/0x154)
[   52.159620]  r7:00000000 r6:00000000 r5:ae711228 r4:ae726000
[   52.165355] [<802f1c5c>] (dw_pcie_rd_conf) from [<802d6534>] (pci_bus_read_config_dword+0x6c/0x94)
[   52.174316]  r9:adf4e910 r8:809bc51c r7:00000000 r6:60000153 r5:adc3fd5c r4:ae726000
[   52.182152] [<802d64c8>] (pci_bus_read_config_dword) from [<802db588>] (pci_restore_config_dword+0x54/0xa4)
[   52.191894]  r6:00000024 r5:0000000a r4:ae61e000
[   52.196570] [<802db534>] (pci_restore_config_dword) from [<802dd150>] (pci_restore_state.part.37+0x7c/0x1f8)
[   52.206399]  r8:802e086c r7:ae61dfe8 r6:519e2024 r5:ae61e000 r4:ae61dffc
[   52.213187] [<802dd0d4>] (pci_restore_state.part.37) from [<802dd2e8>] (pci_restore_state+0x1c/0x20)
[   52.222322]  r7:adc3fea8 r6:809d90e0 r5:ae61e000 r4:ae61e068
[   52.228056] [<802dd2cc>] (pci_restore_state) from [<802e0894>] (pci_pm_resume_noirq+0x28/0xa4)
[   52.236683] [<802e086c>] (pci_pm_resume_noirq) from [<8037ea1c>] (dpm_run_callback.isra.12+0x34/0x7c)

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/pci/host/pci-imx6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index c74e87d..4334de6 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -519,7 +519,7 @@ static void imx6_pcie_reset_phy(struct pcie_port *pp)
 static int imx6_pcie_link_up(struct pcie_port *pp)
 {
 	u32 rc, debug_r0, rx_valid;
-	int count = 5;
+	int count = 500;
 
 	/*
 	 * Test if the PHY reports that the link is up and also that the LTSSM
@@ -550,7 +550,7 @@ static int imx6_pcie_link_up(struct pcie_port *pp)
 		 * Wait a little bit, then re-check if the link finished
 		 * the training.
 		 */
-		usleep_range(1000, 2000);
+		udelay(10);
 	}
 	/*
 	 * From L0, initiate MAC entry to gen2 if EP/RC supports gen2.
-- 
1.9.1

