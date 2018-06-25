Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbeFYW7s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Jun 2018 18:59:48 -0400
Subject: [PATCH v1 2/4] PCI: shpchp: Separate existence of SHPC and
 permission to use it
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Marc Zyngier <marc.zyngier@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date: Mon, 25 Jun 2018 17:59:47 -0500
Message-ID: <152996758701.260522.15657867940504333468.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152996746234.260522.11381067633352986554.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The shpchp driver registers for all PCI bridge devices.  Its probe method
should fail if either (1) the bridge doesn't have an SHPC or (2) the OS
isn't allowed to use it (the platform firmware may be operating the SHPC
itself).

Separate these two tests into:

  - A new shpc_capable() that looks for the SHPC hardware and is applicable
    on all systems (ACPI and non-ACPI), and

  - A simplified acpi_get_hp_hw_control_from_firmware() that we call only
    when we already know an SHPC exists and there may be ACPI methods to
    either request permission to use it (_OSC) or transfer control to the
    OS (OSHP).

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpi_pcihp.c  |   36 +++++++++++++++++++-----------------
 drivers/pci/hotplug/shpchp_core.c |   21 +++++++++++++++++++++
 drivers/pci/pci-acpi.c            |   19 +------------------
 include/linux/pci.h               |    1 +
 4 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 5bd6c1573295..6b7c1ed58e7e 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -73,20 +73,6 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 	acpi_handle chandle, handle;
 	struct acpi_buffer string = { ACPI_ALLOCATE_BUFFER, NULL };
 
-	/*
-	 * Per PCI firmware specification, we should run the ACPI _OSC
-	 * method to get control of hotplug hardware before using it. If
-	 * an _OSC is missing, we look for an OSHP to do the same thing.
-	 * To handle different BIOS behavior, we look for _OSC on a root
-	 * bridge preferentially (according to PCI fw spec). Later for
-	 * OSHP within the scope of the hotplug controller and its parents,
-	 * up to the host bridge under which this controller exists.
-	 */
-	if (shpchp_is_native(pdev))
-		return 0;
-
-	/* If _OSC exists, we should not evaluate OSHP */
-
 	/*
 	 * If there's no ACPI host bridge (i.e., ACPI support is compiled
 	 * into the kernel but the hardware platform doesn't support ACPI),
@@ -97,9 +83,25 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 	if (!root)
 		return 0;
 
-	if (root->osc_support_set)
-		goto no_control;
+	/*
+	 * If _OSC exists, it determines whether we're allowed to manage
+	 * the SHPC.  We executed it while enumerating the host bridge.
+	 */
+	if (root->osc_support_set) {
+		if (host->native_shpc_hotplug)
+			return 0;
+		return -ENODEV;
+	}
 
+	/*
+	 * In the absence of _OSC, we're always allowed to manage the SHPC.
+	 * However, if an OSHP method is present, we must execute it so the
+	 * firmware can transfer control to the OS, e.g., direct interrupts
+	 * to the OS instead of to the firmware.
+	 *
+	 * N.B. The PCI Firmware Spec (r3.2, sec 4.8) does not endorse
+	 * searching up the ACPI hierarchy, so the loops below are suspect.
+	 */
 	handle = ACPI_HANDLE(&pdev->dev);
 	if (!handle) {
 		/*
@@ -128,7 +130,7 @@ int acpi_get_hp_hw_control_from_firmware(struct pci_dev *pdev)
 		if (ACPI_FAILURE(status))
 			break;
 	}
-no_control:
+
 	pci_info(pdev, "Cannot get control of SHPC hotplug\n");
 	kfree(string.pointer);
 	return -ENODEV;
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index e91be287f292..8e3c6ce12f31 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -270,11 +270,30 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	return 0;
 }
 
+static bool shpc_capable(struct pci_dev *bridge)
+{
+	/*
+	 * It is assumed that AMD GOLAM chips support SHPC but they do not
+	 * have SHPC capability.
+	 */
+	if (bridge->vendor == PCI_VENDOR_ID_AMD &&
+	    bridge->device == PCI_DEVICE_ID_AMD_GOLAM_7450)
+		return true;
+
+	if (pci_find_capability(bridge, PCI_CAP_ID_SHPC))
+		return true;
+
+	return false;
+}
+
 static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int rc;
 	struct controller *ctrl;
 
+	if (!shpc_capable(pdev))
+		return -ENODEV;
+
 	if (acpi_get_hp_hw_control_from_firmware(pdev))
 		return -ENODEV;
 
@@ -303,6 +322,7 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto err_cleanup_slots;
 
+	pdev->shpc_managed = 1;
 	return 0;
 
 err_cleanup_slots:
@@ -319,6 +339,7 @@ static void shpc_remove(struct pci_dev *dev)
 {
 	struct controller *ctrl = pci_get_drvdata(dev);
 
+	dev->shpc_managed = 0;
 	shpchp_remove_ctrl_files(ctrl);
 	ctrl->hpc_ops->release_ctlr(ctrl);
 	kfree(ctrl);
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 65113b6eed14..5100fd2d5a75 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -403,24 +403,7 @@ bool pciehp_is_native(struct pci_dev *bridge)
  */
 bool shpchp_is_native(struct pci_dev *bridge)
 {
-	const struct pci_host_bridge *host;
-
-	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
-		return false;
-
-	/*
-	 * It is assumed that AMD GOLAM chips support SHPC but they do not
-	 * have SHPC capability.
-	 */
-	if (bridge->vendor == PCI_VENDOR_ID_AMD &&
-	    bridge->device == PCI_DEVICE_ID_AMD_GOLAM_7450)
-		return true;
-
-	if (!pci_find_capability(bridge, PCI_CAP_ID_SHPC))
-		return false;
-
-	host = pci_find_host_bridge(bridge->bus);
-	return host->native_shpc_hotplug;
+	return bridge->shpc_managed;
 }
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..f776a1cce120 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -388,6 +388,7 @@ struct pci_dev {
 	unsigned int	is_virtfn:1;
 	unsigned int	reset_fn:1;
 	unsigned int	is_hotplug_bridge:1;
+	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
 	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
 	unsigned int	__aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
