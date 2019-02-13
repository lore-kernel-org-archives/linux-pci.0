Return-Path: <SRS0=kgfr=QU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D741C00319
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2777206C0
	for <linux-pci@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbfBMVdV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:21 -0500
Received: from xes-mad.com ([162.248.234.2]:35059 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436780AbfBMVcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:45 -0500
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id 0260A20200;
        Wed, 13 Feb 2019 15:32:43 -0600 (CST)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v3] PCI/ACPI: Improve _OSC control request granularity
Date:   Wed, 13 Feb 2019 15:32:42 -0600
Message-Id: <20190213213242.21920-1-asierra@xes-inc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
References: <1540483292-24049-1-git-send-email-asierra@xes-inc.com>
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

New output:

  acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
  acpi PNP0A08:00: _OSC: platform granted [PME AER PCIeCapability LTR]

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---

v3:
  * Dropped patch moving the pcie_ports_disabled check
  * Removed underscore prefix from new inline functions
  * Defined ASPM_OSC_CONTROL_BITS and removed __osc_have_aspm_control()
  * Refactored OSC control bit-setting functions to return the bits they want
    to set, instead of an ignored error code, and converted most conditionals
    from inverted logic, (!x || !y), to positive logic, (x && y)
  * Renamed OSC control bit-setting functions from __osc_set_X_control()
    to osc_get_X_control_bits()

v2:
  * Rebased from the mainline kernel (4.19-rc7) to Bjorn Helgaas's
    pci/aspm branch [1]
  * Factored moving the pcie_ports_disabled check to the top of
    negotiate_os_control into its own patch
  * Simplified new __osc_check_support function and renamed it to
    __osc_have_support
  * No longer messes with _OSC general availability test and related
    error message (i.e. _OSC failed ... disabling ASPM)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git

 drivers/acpi/pci_root.c | 111 ++++++++++++++++++++++++++++++----------
 1 file changed, 83 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..ac74bd42399d 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -53,9 +53,13 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
 }
 
 #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
-				| OSC_PCI_ASPM_SUPPORT \
-				| OSC_PCI_CLOCK_PM_SUPPORT \
 				| OSC_PCI_MSI_SUPPORT)
+#define ACPI_PCIE_ASPM_SUPPORT (ACPI_PCIE_REQ_SUPPORT \
+				| OSC_PCI_ASPM_SUPPORT \
+				| OSC_PCI_CLOCK_PM_SUPPORT)
+#define OSC_CONTROL_BITS_ASPM (OSC_PCI_EXPRESS_CAPABILITY_CONTROL \
+				| OSC_PCI_EXPRESS_LTR_CONTROL \
+				| OSC_PCI_EXPRESS_PME_CONTROL)
 
 static const struct acpi_device_id root_device_ids[] = {
 	{"PNP0A03", 0},
@@ -421,6 +425,67 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
 }
 EXPORT_SYMBOL(acpi_pci_osc_control_set);
 
+static inline bool osc_have_support(u32 support, u32 required)
+{
+	return ((support & required) == required);
+}
+
+static inline u32 osc_get_aspm_control_bits(struct acpi_pci_root *root,
+					    u32 support)
+{
+	u32 control = 0;
+
+	if (IS_ENABLED(CONFIG_PCIEASPM) &&
+	    osc_have_support(support, ACPI_PCIE_ASPM_SUPPORT)) {
+		control = OSC_CONTROL_BITS_ASPM;
+	}
+
+	return control;
+}
+
+static inline u32 osc_get_pciehp_control_bits(struct acpi_pci_root *root,
+					      u32 support)
+{
+	u32 control = 0;
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE) &&
+	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
+		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+			  OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
+	}
+
+	return control;
+}
+
+static inline u32 osc_get_shpchp_control_bits(struct acpi_pci_root *root,
+					      u32 support)
+{
+	u32 control = 0;
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC) &&
+	    osc_have_support(support, ACPI_PCIE_REQ_SUPPORT)) {
+		control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL |
+			  OSC_PCI_SHPC_NATIVE_HP_CONTROL;
+	}
+
+	return control;
+}
+
+static inline u32 osc_get_aer_control_bits(struct acpi_pci_root *root,
+					   u32 support)
+{
+	if (!pci_aer_available() ||
+	    !osc_have_support(support, ACPI_PCIE_REQ_SUPPORT))
+		return 0;
+
+	if (aer_acpi_firmware_first()) {
+		dev_info(&root->device->dev, "PCIe AER handled by firmware\n");
+		return 0;
+	}
+
+	return OSC_PCI_EXPRESS_CAPABILITY_CONTROL | OSC_PCI_EXPRESS_AER_CONTROL;
+}
+
 static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 				 bool is_pcie)
 {
@@ -479,31 +544,24 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
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
+	control = osc_get_aspm_control_bits(root, support);
+	if (!control)
+		*no_aspm = 1;
 
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
+	control |= osc_get_pciehp_control_bits(root, support);
+	control |= osc_get_shpchp_control_bits(root, support);
+	control |= osc_get_aer_control_bits(root, support);
+	if (!control) {
+		dev_info(&device->dev, "_OSC: not requesting OS control\n");
+		return;
 	}
 
 	requested = control;
-	status = acpi_pci_osc_control_set(handle, &control,
-					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
-	if (ACPI_SUCCESS(status)) {
-		decode_osc_control(root, "OS now controls", control);
+	acpi_pci_osc_control_set(handle, &control, 0);
+	decode_osc_control(root, "OS requested", requested);
+	decode_osc_control(root, "platform granted", control);
+
+	if (osc_have_support(control, OSC_CONTROL_BITS_ASPM)) {
 		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
 			/*
 			 * We have ASPM control, but the FADT indicates that
@@ -513,11 +571,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
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
2.17.1

