Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36995 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbcHSIXS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Aug 2016 04:23:18 -0400
From: Chen Yu <yu.c.chen@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH][RFC v3] PCI: Workaround to enable poweroff on Mac Pro 11
Date: Fri, 19 Aug 2016 16:30:25 +0800
Message-Id: <1471595425-1752-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

People reported that they can not do a poweroff nor a
suspend to ram on their Mac Pro 11. After some investigations
it was found that, once the PCI bridge 0000:00:1c.0 reassigns its
mm windows to ([mem 0x7fa00000-0x7fbfffff] and
[mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
io resource 0x1804 becomes unaccessible immediately, where the
ACPI Sleep register is located, as a result neither poweroff(S5)
nor suspend to ram(S3) works.

As suggested by Bjorn, further testing shows that, there is an
unreported device may be (using) conflict with above aperture,
which brings unpredictable result such as the failure of accessing
the io port, which blocks the poweroff(S5). Besides if we reassign
the memory aperture to the other place, the poweroff works again.

As we do not find any resource declared in _CRS which contain above
memory aperture, and Mac OS does not use this pci bridge neither, we
choose a simple workaround to clear the hotplug flag(suggested by
Yinghai Lu), thus do not allocate any resource for this pci bridge,
and thereby no conflict anymore.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/pci/quirks.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 37ff015..04bbdba 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2776,6 +2776,26 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
 
 /*
+ * Apple: Avoid programming the memory/io aperture of 00:1c.0
+ *
+ * BIOS does not declare any resource for 00:1c.0, but with
+ * hotplug flag set, thus the OS allocates:
+ * [mem 0x7fa00000 - 0x7fbfffff]
+ * [mem 0x7fc00000-0x7fdfffff 64bit pref]
+ * which is conflict with an unreported device, which
+ * causes unpredictable result such as accessing io port.
+ * So clear the hotplug flag to work around it.
+ */
+static void quirk_apple_mbp_poweroff(struct pci_dev *dev)
+{
+	if (dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") ||
+	    dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,5"))
+		dev->is_hotplug_bridge = 0;
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x8c10, quirk_apple_mbp_poweroff);
+
+/*
  * This is a quirk for the Ricoh MMC controller found as a part of
  * some mulifunction chips.
 
-- 
2.7.4

