Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:41297 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932871AbeFPTd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jun 2018 15:33:26 -0400
Message-Id: <f0917c7e8e6fba0c41f0e4d9ff33869394eae82c.1529173804.git.lukas@wunner.de>
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
References: <cover.1529173804.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 16 Jun 2018 21:25:00 +0200
Subject: [PATCH 05/32] PCI: pciehp: Drop unnecessary NULL pointer check
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pciehp_disable_slot() checks if the ctrl attribute of the slot is NULL
and bails out if so.  However the function is not called prior to the
attribute being set in pcie_init_slot(), and pcie_init_slot() is not
called if ctrl is NULL.  So the check is unnecessary.  Drop it.

It has been present ever since the driver was introduced in 2004, but it
was already unnecessary back then:
https://git.kernel.org/tglx/history/c/c16b4b14d980

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index c684faa43387..4a4639b7a479 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -412,9 +412,6 @@ int pciehp_disable_slot(struct slot *p_slot)
 	u8 getstatus = 0;
 	struct controller *ctrl = p_slot->ctrl;
 
-	if (!p_slot->ctrl)
-		return 1;
-
 	if (POWER_CTRL(p_slot->ctrl)) {
 		pciehp_get_power_status(p_slot, &getstatus);
 		if (!getstatus) {
-- 
2.17.1
