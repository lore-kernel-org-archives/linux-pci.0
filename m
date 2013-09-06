Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:46357 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963Ab3IFRNf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2013 13:13:35 -0400
Received: by mail-yh0-f45.google.com with SMTP id i7so1006398yha.4
        for <linux-pci@vger.kernel.org>; Fri, 06 Sep 2013 10:13:35 -0700 (PDT)
Subject: [PATCH 01/14] ACPI: Write _OSC bit field definitions in hex
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
	Len Brown <lenb@kernel.org>
Date: Fri, 06 Sep 2013 11:13:32 -0600
Message-ID: <20130906171332.11482.45745.stgit@bhelgaas-glaptop>
In-Reply-To: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Update _OSC definition comments to correspond to the 1-based spec wording
(DWORD 1, etc.)  Write _OSC field #defines as hex to make clear that they
are bits in a 32-bit DWORD, not arbitrary values.  No functional change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/acpi.h |   54 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a5db4ae..285de6f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -304,39 +304,39 @@ struct acpi_osc_context {
 #define OSC_SUPPORT_TYPE 		1
 #define OSC_CONTROL_TYPE		2
 
-/* _OSC DW0 Definition */
-#define OSC_QUERY_ENABLE		1
-#define OSC_REQUEST_ERROR		2
-#define OSC_INVALID_UUID_ERROR		4
-#define OSC_INVALID_REVISION_ERROR	8
-#define OSC_CAPABILITIES_MASK_ERROR	16
+/* _OSC Capabilities DWORD 1: Query/Control and Error Returns (generic) */
+#define OSC_QUERY_ENABLE			0x00000001  /* input */
+#define OSC_REQUEST_ERROR			0x00000002  /* return */
+#define OSC_INVALID_UUID_ERROR			0x00000004  /* return */
+#define OSC_INVALID_REVISION_ERROR		0x00000008  /* return */
+#define OSC_CAPABILITIES_MASK_ERROR		0x00000010  /* return */
 
 acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 
-/* platform-wide _OSC bits */
-#define OSC_SB_PAD_SUPPORT		1
-#define OSC_SB_PPC_OST_SUPPORT		2
-#define OSC_SB_PR3_SUPPORT		4
-#define OSC_SB_HOTPLUG_OST_SUPPORT	8
-#define OSC_SB_APEI_SUPPORT		16
+/* Platform-Wide Capabilities _OSC: Capabilities DWORD 2: Support Field */
+#define OSC_SB_PAD_SUPPORT			0x00000001
+#define OSC_SB_PPC_OST_SUPPORT			0x00000002
+#define OSC_SB_PR3_SUPPORT			0x00000004
+#define OSC_SB_HOTPLUG_OST_SUPPORT		0x00000008
+#define OSC_SB_APEI_SUPPORT			0x00000010
+#define OSC_SB_CPC_SUPPORT			0x00000020
 
 extern bool osc_sb_apei_support_acked;
 
-/* PCI defined _OSC bits */
-/* _OSC DW1 Definition (OS Support Fields) */
-#define OSC_EXT_PCI_CONFIG_SUPPORT		1
-#define OSC_ACTIVE_STATE_PWR_SUPPORT 		2
-#define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	4
-#define OSC_PCI_SEGMENT_GROUPS_SUPPORT		8
-#define OSC_MSI_SUPPORT				16
-#define OSC_PCI_SUPPORT_MASKS			0x1f
-
-/* _OSC DW1 Definition (OS Control Fields) */
-#define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	1
-#define OSC_SHPC_NATIVE_HP_CONTROL 		2
-#define OSC_PCI_EXPRESS_PME_CONTROL		4
-#define OSC_PCI_EXPRESS_AER_CONTROL		8
-#define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	16
+/* PCI Host Bridge _OSC: Capabilities DWORD 2: Support Field */
+#define OSC_EXT_PCI_CONFIG_SUPPORT		0x00000001
+#define OSC_ACTIVE_STATE_PWR_SUPPORT 		0x00000002
+#define OSC_CLOCK_PWR_CAPABILITY_SUPPORT	0x00000004
+#define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
+#define OSC_MSI_SUPPORT				0x00000010
+#define OSC_PCI_SUPPORT_MASKS			0x0000001f
+
+/* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
+#define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
+#define OSC_SHPC_NATIVE_HP_CONTROL 		0x00000002
+#define OSC_PCI_EXPRESS_PME_CONTROL		0x00000004
+#define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
+#define OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL	0x00000010
 
 #define OSC_PCI_CONTROL_MASKS 	(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL | 	\
 				OSC_SHPC_NATIVE_HP_CONTROL | 		\

