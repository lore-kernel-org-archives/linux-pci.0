Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeCaQkb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Mar 2018 12:40:31 -0400
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Sun,  1 Apr 2018 00:40:22 +0800
Message-Id: <20180331164022.24220-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
core: Drop run_wake flag from struct dev_pm_info").

The device in question is not power managed by platform firmware,
furthermore, it only supports PME# from D3cold:
Capabilities: [78] Power Management version 3
       Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
       Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Before commit de3ef1eb1cd0, the device never gets runtime suspended.
After that commit, the device gets runtime suspended, so it does not
respond to any PME#.

usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
device_can_wakeup() in pci_dev_run_wake() always returns true.

So pci_dev_run_wake() needs to check PME wakeup capability as its first
condition.

In addition, change wakeup flag passed to pci_target_state() from false
to true, because we want to find the deepest state that the device can
still generate PME#.

Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
Cc: stable@vger.kernel.org # 4.13+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3: State the reason why the wakeup flag gets changed.

v2: Explicitly check dev->pme_support.

 drivers/pci/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd10d9b0..52821a21fc07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
 
-	if (device_can_wakeup(&dev->dev))
-		return true;
-
 	if (!dev->pme_support)
 		return false;
 
 	/* PME-capable in principle, but not from the target power state */
-	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
+	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
 		return false;
 
+	if (device_can_wakeup(&dev->dev))
+		return true;
+
 	while (bus->parent) {
 		struct pci_dev *bridge = bus->self;
 
-- 
2.15.1
