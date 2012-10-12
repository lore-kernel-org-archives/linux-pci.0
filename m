Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:40039 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756618Ab2JKJN4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 11 Oct 2012 05:13:56 -0400
From: Feng Tang <feng.tang@intel.com>
To: Len Brown <len.brown@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] x86/PCI: Add quirk for "CheckPoint P-20-00" to not use bridge _CRS_ info
Date: Fri, 12 Oct 2012 09:15:09 +0800
Message-Id: <1350004509-17414-1-git-send-email-feng.tang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is to fix a regression https://bugzilla.kernel.org/show_bug.cgi?id=47981

The CheckPoint P-20-00 works ok before new machines (2008 and later) are
forced to use the bridge _CRS info by default in 2.6.34. Add this quirk
to restore its old way of working: not using bridge _CRS info.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/pci/acpi.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 192397c..7010c19 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -98,6 +98,16 @@ static const struct dmi_system_id pci_use_crs_table[] __initconst = {
 			DMI_MATCH(DMI_BIOS_VERSION, "6JET85WW (1.43 )"),
 		},
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=47981 */
+	{
+		.callback = set_nouse_crs,
+		.ident = "CheckPoint P-20-00",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "CheckPoint"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P-20-00"),
+			DMI_MATCH(DMI_BOARD_NAME, "Bridgeport"),
+		},
+	},
 	{}
 };
 
-- 
1.7.9.5

