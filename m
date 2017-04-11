Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38416 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbdDKQd1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2017 12:33:27 -0400
Received: by mail-wm0-f46.google.com with SMTP id t189so5335084wmt.1
        for <linux-pci@vger.kernel.org>; Tue, 11 Apr 2017 09:33:26 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, tn@semihalf.com,
        graeme.gregory@linaro.org, leif.lindholm@linaro.org,
        okaya@codeaurora.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2] arm64: acpi/pci: invoke _DSM whether to preserve firmware PCI setup
Date: Tue, 11 Apr 2017 17:33:13 +0100
Message-Id: <20170411163313.18577-3-ard.biesheuvel@linaro.org>
In-Reply-To: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On arm64 ACPI systems, we unconditionally reconfigure the entire PCI
hierarchy at boot. This is a departure from what is customary on ACPI
systems, and may break assumptions in some places (e.g., EFIFB), that
the kernel will leave BARs of enabled PCI devices where they are.

Given that PCI already specifies a device specific ACPI method (_DSM)
for PCI root bridge nodes that tells us whether the firmware thinks
the configuration should be left alone, let's sidestep the entire
policy debate about whether the PCI configuration should be preserved
or not, and put it under the control of the firmware instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/pci.c  | 20 ++++++++++++++++++--
 include/linux/pci-acpi.h |  7 ++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3ebfea4b..c88e07e2eb84 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -185,6 +185,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	struct acpi_pci_generic_root_info *ri;
 	struct pci_bus *bus, *child;
 	struct acpi_pci_root_ops *root_ops;
+	union acpi_object *obj;
 
 	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
 	if (!ri)
@@ -208,8 +209,23 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!bus)
 		return NULL;
 
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
+	/*
+	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
+	 * Configuration', which tells us whether the firmware wants us to
+	 * preserve the configuration of the PCI resource tree for this root
+	 * bridge.
+	 */
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 1,
+				IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
+	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
+		/* preserve existing resource assignment */
+		pci_bus_claim_resources(bus);
+	} else {
+		/* reconfigure the resource tree from scratch */
+		pci_bus_size_bridges(bus);
+		pci_bus_assign_resources(bus);
+	}
+	ACPI_FREE(obj);
 
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 7a4e83a8c89c..308111489b83 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -106,9 +106,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 #endif
 
 extern const u8 pci_acpi_dsm_uuid[];
-#define DEVICE_LABEL_DSM	0x07
-#define RESET_DELAY_DSM		0x08
-#define FUNCTION_DELAY_DSM	0x09
+#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
+#define DEVICE_LABEL_DSM		0x07
+#define RESET_DELAY_DSM			0x08
+#define FUNCTION_DELAY_DSM		0x09
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
-- 
2.9.3
