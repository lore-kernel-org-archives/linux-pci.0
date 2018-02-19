Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932169AbeBSXOH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Feb 2018 18:14:07 -0500
Subject: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Peter Wu <peter@lekensteyn.nl>,
        Qipeng Zha <qipeng.zha@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Date: Mon, 19 Feb 2018 17:14:06 -0600
Message-ID: <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Previously "pcie_port_pm=force" enabled power management of PCI bridges,
but only for PCIe ports (not conventional PCI bridges) and only for ports
that do not support hotplug.  Those limitations are there because we're not
confident that all those configurations work, not because the spec requires
them.

Change "pcie_port_pm=force" to enable power management of conventional PCI
bridges and hotplug bridges as well as PCIe ports.  As with the previous
PCIe port-only behavior, this is not expected to work in all systems.

Add a "pci=bridge_pm" parameter to reflect the increased scope.  For
backward compatibility, retain "pcie_port_pm=force" as an undocumented
equivalent.

Add "pci=no_bridge_pm" as an equivalent to "pcie_port_pm=off".  This
disables power management for all PCI bridges, which is results in the same
behavior as before, since we always disabled power management of
conventional PCI bridges, and "pcie_port_pm=off" disabled it for PCIe
ports.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    8 ++++----
 drivers/pci/pci.c                               |   21 ++++++++++++---------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f85ddd..4660105ec851 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3117,6 +3117,10 @@
 		pcie_scan_all	Scan all possible PCIe devices.  Otherwise we
 				only look for one device below a PCIe downstream
 				port.
+		bridge_pm	Enable runtime power management of all bridges,
+				including conventional PCI bridges, PCIe ports,
+				and hotplug bridges.
+		no_bridge_pm	Disable runtime power management of all bridges.
 		big_root_window	Try to add a big 64bit memory window to the PCIe
 				root complex on AMD CPUs. Some GFX hardware
 				can resize a BAR to allow access to all VRAM.
@@ -3143,10 +3147,6 @@
 		compat	Treat PCIe ports as PCI-to-PCI bridges, disable the PCIe
 			ports driver.
 
-	pcie_port_pm=	[PCIE] PCIe port power management handling:
-		off	Disable power management of all PCIe ports
-		force	Forcibly enable power management of all PCIe ports
-
 	pcie_pme=	[PCIE,PM] Native PCIe PME signaling options:
 		nomsi	Do not use MSI for native PCIe PME signaling (this makes
 			all PCIe root ports use INTx for all services).
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 75db77cf3f8f..2aa1ae9c4afa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -111,10 +111,8 @@ unsigned int pcibios_max_latency = 255;
 /* If set, the PCIe ARI capability will not be used. */
 static bool pcie_ari_disabled;
 
-/* Disable bridge_d3 for all PCIe ports */
-static bool pci_bridge_d3_disable;
-/* Force bridge_d3 for all PCIe ports */
-static bool pci_bridge_d3_force;
+static bool pci_bridge_d3_disable;	/* Disable D3 for all bridges */
+static bool pci_bridge_d3_force;	/* Enable D3 for all bridges */
 
 static int __init pcie_port_pm_setup(char *str)
 {
@@ -2260,6 +2258,12 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
 	unsigned int year;
 
+	if (pci_bridge_d3_disable)
+		return false;
+
+	if (pci_bridge_d3_force)
+		return true;
+
 	/*
 	 * In principle we should be able to put conventional PCI bridges
 	 * into D3.  We only support it for PCIe because (a) we want to
@@ -2274,8 +2278,6 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	case PCI_EXP_TYPE_ROOT_PORT:
 	case PCI_EXP_TYPE_UPSTREAM:
 	case PCI_EXP_TYPE_DOWNSTREAM:
-		if (pci_bridge_d3_disable)
-			return false;
 
 		/*
 		 * Hotplug interrupts cannot be delivered if the link is down,
@@ -2295,9 +2297,6 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 		if (bridge->is_hotplug_bridge)
 			return false;
 
-		if (pci_bridge_d3_force)
-			return true;
-
 		/*
 		 * It should be safe to put PCIe ports from 2015 or newer
 		 * to D3.  We have vague reports of possible hardware
@@ -5708,6 +5707,10 @@ static int __init pci_setup(char *str)
 				pcie_bus_config = PCIE_BUS_PEER2PEER;
 			} else if (!strncmp(str, "pcie_scan_all", 13)) {
 				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
+			} else if (!strncmp(str, "bridge_pm", 9)) {
+				pci_bridge_d3_force = true;
+			} else if (!strncmp(str, "no_bridge_pm", 12)) {
+				pci_bridge_d3_disable = true;
 			} else {
 				printk(KERN_ERR "PCI: Unknown option `%s'\n",
 						str);
