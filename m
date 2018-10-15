Return-Path: <SRS0=/yaj=M3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BA4C04EB9
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 22:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27F5208D9
	for <linux-pci@archiver.kernel.org>; Mon, 15 Oct 2018 22:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27F5208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xes-inc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbeJPGTE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:19:04 -0400
Received: from xes-mad.com ([162.248.234.2]:3145 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbeJPGTE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Oct 2018 02:19:04 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2018 02:19:03 EDT
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 2A27920252;
        Mon, 15 Oct 2018 17:23:06 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH] PCI/ACPI: Improve _OSC control request granularity
Date:   Mon, 15 Oct 2018 17:23:06 -0500
Message-Id: <1539642186-12821-1-git-send-email-asierra@xes-inc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch reorganizes negotiate_os_control() to be less ASPM-centric in
order to:

    1. allow other features (notably AER) to work without enabling ASPM
    2. better isolate feature-specific tests for readability/maintenance

Each feature (ASPM, PCIe hotplug, SHPC hotplug, and AER) now has its own
inline function for setting its _OSC control requests.

Part of making this function more generic, required eliminating a test
for overall success/failure that previously caused two different types
of messages to be printed. Now, printed messages are streamlined to
always show requested _OSC control versus what was granted.

Previous output (success):

  acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]

Previous output (failure):

  acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
  acpi PNP0A08:00: _OSC: platform willing to grant []

Now:

  acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
  acpi PNP0A08:00: _OSC: platform granted [PME AER PCIeCapability LTR]

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/acpi/pci_root.c | 161 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 116 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 7433035..8dd6720 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -53,9 +53,10 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 }
 
 #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
-				| OSC_PCI_ASPM_SUPPORT \
-				| OSC_PCI_CLOCK_PM_SUPPORT \
 				| OSC_PCI_MSI_SUPPORT)
+#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
+				| OSC_PCI_ASPM_SUPPORT \
+				| OSC_PCI_CLOCK_PM_SUPPORT)
 
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
@@ -421,10 +422,101 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
+static int __osc_check_support(struct acpi_pci_root *root, u32 support,
+			       u32 required, const char *feature)
+{
+	acpi_status status;
+
+	if ((support & required) != required)
+		return -ENODEV;
+
+	status = acpi_pci_osc_support(root, support);
+	if (ACPI_FAILURE(status)) {
+		dev_info(&root->device->dev, "_OSC failed (%s); disabling %s\n",
+			 acpi_format_exception(status), feature);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static inline int __osc_set_aspm_control(struct acpi_pci_root *root,
+					 u32 support, u32 *control)
+{
+	int rc;
+
+	if (!IS_ENABLED(CONFIG_PCIEASPM))
+		return -ENODEV;
+
+	rc = __osc_check_support(root, support, ACPI_PCIE_ASPM_SUPPORT, "ASPM");
+	if (rc)
+		return rc;
+
+	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+		    OSC_PCI_EXPRESS_LTR_CONTROL |
+		    OSC_PCI_EXPRESS_PME_CONTROL;
+
+	return 0;
+}
+
+static inline bool __osc_have_aspm_control(u32 control)
+{
+	u32 required = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+		       OSC_PCI_EXPRESS_LTR_CONTROL |
+		       OSC_PCI_EXPRESS_PME_CONTROL;
+
+	return (control & required) == required;
+}
+
+static inline void __osc_set_pciehp_control(struct acpi_pci_root *root,
+					    u32 support, u32 *control)
+{
+	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+		return;
+
+	if (__osc_check_support(root, support, ACPI_PCIE_REQ_SUPPORT,
+				"PCIeHotplug"))
+		return;
+
+	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+		    OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+}
+
+static inline void __osc_set_shpchp_control(struct acpi_pci_root *root,
+					    u32 support, u32 *control)
+{
+	if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
+		return;
+
+	if (__osc_check_support(root, support, ACPI_PCIE_REQ_SUPPORT,
+				"SHPCHotplug"))
+		return;
+
+	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+		    OSC_PCI_SHPC_NATIVE_HP_CONTROL;
+}
+
+static inline void __osc_set_aer_control(struct acpi_pci_root *root,
+					 u32 support, u32 *control)
+{
+	if (!pci_aer_available())
+		return;
+
+	if (aer_acpi_firmware_first()) {
+		dev_info(&root->device->dev, "PCIe AER handled by firmware\n");
+		return;
+	}
+
+	if (__osc_check_support(root, support, ACPI_PCIE_REQ_SUPPORT, "AER"))
+		return;
+
+	*control |= OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+		    OSC_PCI_EXPRESS_AER_CONTROL;
+}
+
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 {
 	u32 support, control, requested;
-	acpi_status status;
 	struct acpi_device *device = root->device;
 	acpi_handle handle = device->handle;
 
@@ -440,6 +532,12 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 		return;
 	}
 
+	if (pcie_ports_disabled) {
+		dev_info(&device->dev,
+			 "PCIe port services disabled; not requesting _OSC control\n");
+		return;
+	}
+
 	/*
 	 * All supported architectures that use ACPI have support for
 	 * PCI domains, so we indicate this in _OSC support capabilities.
@@ -453,50 +551,26 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 		support |= OSC_PCI_MSI_SUPPORT;
 
 	decode_osc_support(root, "OS supports", support);
-	status = acpi_pci_osc_support(root, support);
-	if (ACPI_FAILURE(status)) {
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			 acpi_format_exception(status));
+
+	control = 0;
+	if (__osc_set_aspm_control(root, support, &control))
 		*no_aspm = 1;
-		return;
-	}
 
-	if (pcie_ports_disabled) {
-		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
-		return;
-	}
+	__osc_set_pciehp_control(root, support, &control);
+	__osc_set_shpchp_control(root, support, &control);
+	__osc_set_aer_control(root, support, &control);
 
-	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
-		decode_osc_support(root, "not requesting OS control; OS requires",
-				   ACPI_PCIE_REQ_SUPPORT);
+	if (!control) {
+		dev_info(&device->dev, "_OSC: not requesting OS control\n");
 		return;
 	}
 
-	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
-		| OSC_PCI_EXPRESS_PME_CONTROL;
-
-	if (IS_ENABLED(CONFIG_PCIEASPM))
-		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
-
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
-		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
-
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
-	}
-
 	requested = control;
-	status = acpi_pci_osc_control_set(handle, &control,
-					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
-	if (ACPI_SUCCESS(status)) {
-		decode_osc_control(root, "OS now controls", control);
+	acpi_pci_osc_control_set(handle, &control, 0);
+	decode_osc_control(root, "OS requested", requested);
+	decode_osc_control(root, "platform granted", control);
+
+	if (__osc_have_aspm_control(control)) {
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
 			 * We have ASPM control, but the FADT indicates that
@@ -506,11 +580,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
 			*no_aspm = 1;
 		}
-	} else {
-		decode_osc_control(root, "OS requested", requested);
-		decode_osc_control(root, "platform willing to grant", control);
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			acpi_format_exception(status));
+	} else if (!*no_aspm) {
+		dev_info(&device->dev, "_OSC failed; disabling ASPM\n");
 
 		/*
 		 * We want to disable ASPM here, but aspm_disabled
-- 
2.7.4

