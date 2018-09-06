Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47546 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730291AbeIFU0c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Sep 2018 16:26:32 -0400
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 03/10] PCI: pciehp: Disable hotplug interrupt during suspend
Date: Thu,  6 Sep 2018 18:50:13 +0300
Message-Id: <20180906155020.51700-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

When PCIe hotplug port is transitioned into D3hot link to the downstream
component will go down. If hotplug interrupt generation is enabled when
that happens it will trigger immediately waking up the system and
bringing the link back up.

To prevent this disable hotplug interrupt generation when system suspend
is entered. This does not prevent wakeup from low power states according
to PCIe 4.0 spec section 6.7.3.4:

  Software enables a hot-plug event to generate a wakeup event by
  enabling software notification of the event as described in Section
  6.7.3.1. Note that in order for software to disable interrupt generation
  while keeping wakeup generation enabled, the Hot-Plug Interrupt Enable
  bit must be cleared.

So as long as we have set the slot event mask accordingly wakeup should
work even if slot interrupt is disabled. The port should trigger wake
and then send PME to the root port when the PCIe hierarchy is brought
back up.

Limit this to systems using native PME mechanism to make sure older
Apple systems depending on commit e3354628c376 ("PCI: pciehp: Support
interrupts sent from D3hot") still continue working.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_core.c | 18 ++++++++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c  | 10 ++++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 811cf83f956d..58bddeb3c5a9 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -187,6 +187,8 @@ struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
 void pcie_shutdown_notification(struct controller *ctrl);
 void pcie_clear_hotplug_events(struct controller *ctrl);
+void pcie_enable_interrupt(struct controller *ctrl);
+void pcie_disable_interrupt(struct controller *ctrl);
 int pciehp_power_on_slot(struct slot *slot);
 void pciehp_power_off_slot(struct slot *slot);
 void pciehp_get_power_status(struct slot *slot, u8 *status);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ec48c9433ae5..c9cf9c3b5f7f 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -302,8 +302,23 @@ static void pciehp_remove(struct pcie_device *dev)
 }
 
 #ifdef CONFIG_PM
+static bool pme_is_native(struct pcie_device *dev)
+{
+	const struct pci_host_bridge *host;
+
+	host = pci_find_host_bridge(dev->port->bus);
+	return pcie_ports_native || host->native_pme;
+}
+
 static int pciehp_suspend(struct pcie_device *dev)
 {
+	/*
+	 * Disable hotplug interrupt so that it does not trigger
+	 * immediately when the downstream link goes down.
+	 */
+	if (pme_is_native(dev))
+		pcie_disable_interrupt(get_service_data(dev));
+
 	return 0;
 }
 
@@ -327,6 +342,9 @@ static int pciehp_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
 
+	if (pme_is_native(dev))
+		pcie_enable_interrupt(ctrl);
+
 	pciehp_check_presence(ctrl);
 
 	return 0;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 7136e3430925..2249c4d06efd 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -748,6 +748,16 @@ void pcie_clear_hotplug_events(struct controller *ctrl)
 				   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC);
 }
 
+void pcie_enable_interrupt(struct controller *ctrl)
+{
+	pcie_write_cmd(ctrl, PCI_EXP_SLTCTL_HPIE, PCI_EXP_SLTCTL_HPIE);
+}
+
+void pcie_disable_interrupt(struct controller *ctrl)
+{
+	pcie_write_cmd(ctrl, 0, PCI_EXP_SLTCTL_HPIE);
+}
+
 /*
  * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
  * bus reset of the bridge, but at the same time we want to ensure that it is
-- 
2.18.0
