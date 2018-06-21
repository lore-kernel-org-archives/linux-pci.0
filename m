Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35135 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932466AbeFUIav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jun 2018 04:30:51 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: davem@davemloft.net
Cc: ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        acelan.kao@canonical.com, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH net-next v4 1/2] r8169: Don't disable ASPM in the driver
Date: Thu, 21 Jun 2018 16:30:38 +0800
Message-Id: <20180621083039.22545-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable or disable ASPM should be done in PCI core instead of in the
device driver.

Commit ba04c7c93bbc ("r8169: disable ASPM") uses
pci_disable_link_state() to disable ASPM, but it's not the best way to
do it. If the device really wants to disable ASPM, we can use a quirk in
PCI core to prevent the PCI core from setting ASPM before probe.

Let's remove pci_disable_link_state() for now. Use PCI core quirks if
any regression happens.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
- Improve commit message.
- Move the empty line to where it belongs.

v3:
- Change commit message wording.
- Rename the function to rtl_hw_aspm_clkreq_enable().

v2:
- Remove module parameter.
- Remove pci_disable_link_state().

 drivers/net/ethernet/realtek/r8169.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 75dfac0248f4..2bdfd25acd58 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -25,7 +25,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/pm_runtime.h>
 #include <linux/firmware.h>
-#include <linux/pci-aspm.h>
 #include <linux/prefetch.h>
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
@@ -7647,11 +7646,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mii->reg_num_mask = 0x1f;
 	mii->supports_gmii = cfg->has_gmii;
 
-	/* disable ASPM completely as that cause random device stop working
-	 * problems as well as full system hangs for some PCIe devices users */
-	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
-				     PCIE_LINK_STATE_CLKPM);
-
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pcim_enable_device(pdev);
 	if (rc < 0) {
-- 
2.17.0
