Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35054 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeFLJ6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2018 05:58:09 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: davem@davemloft.net
Cc: ryankao@realtek.com, hayeswang@realtek.com, hau@realtek.com,
        hkallweit1@gmail.com, romieu@fr.zoreil.com, bhelgaas@google.com,
        netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] r8169: Don't disable ASPM in the driver
Date: Tue, 12 Jun 2018 17:57:58 +0800
Message-Id: <20180612095759.6828-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable or disable ASPM should be done in PCI core instead of in the
device driver.

Commit ba04c7c93bbc ("r8169: disable ASPM") uses
pci_disable_link_state() to disable ASPM. This is incorrect, if the
device really needs to disable ASPM, we should use a quirk in PCI core
to prevent the PCI core from setting ASPM altogether.

Let's remove pci_disable_link_state() for now. Use PCI core quirks if
any regression happens.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Remove module parameter.
- Remove pci_disable_link_state().

 drivers/net/ethernet/realtek/r8169.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 75dfac0248f4..9b55ce513a36 100644
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
@@ -7647,10 +7646,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	mii->reg_num_mask = 0x1f;
 	mii->supports_gmii = cfg->has_gmii;
 
-	/* disable ASPM completely as that cause random device stop working
-	 * problems as well as full system hangs for some PCIe devices users */
-	pci_disable_link_state(pdev, PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |
-				     PCIE_LINK_STATE_CLKPM);
 
 	/* enable device (incl. PCI PM wakeup and hotplug setup) */
 	rc = pcim_enable_device(pdev);
-- 
2.17.0
