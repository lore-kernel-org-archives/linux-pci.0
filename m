Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:61789 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752604AbcHSBIq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Aug 2016 21:08:46 -0400
From: Chen Yu <yu.c.chen@intel.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: [PATCH][RFC v2] PCI: Workaround to enable poweroff on Mac Pro 11
Date: Fri, 19 Aug 2016 09:16:39 +0800
Message-Id: <1471569399-19868-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

People reported that they can not do a poweroff nor a
suspend to memory on their Mac Pro 11. After some investigations
it was found that, once the PCI bridge 0000:00:1c.0 reassigns its
mm windows([mem 0x7fa00000-0x7fbfffff] and
[mem 0x7fc00000-0x7fdfffff 64bit pref]), the region of ACPI
io resource 0x1804 becomes unaccessible immediately, where the
ACPI Sleep register is located, as a result neither poweroff(S5)
nor suspend to memory(S3) works.

As suggested by Bjorn, further testing shows that, there is an
unreported device may be (using) conflict with above aperture,
so if we reassign the memory aperture to other place, the poweroff
works again.

As we did not find any resource declared in _CRS which contain above
memory aperture, thus we choose a simple workaround to clear the hotplug
flag(suggested by Yinghai Lu), thus do not allocate any resource for
this pci bridge.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=103211
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 37ff015..47b303a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2776,6 +2776,27 @@ static void quirk_hotplug_bridge(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HINT, 0x0020, quirk_hotplug_bridge);
 
 /*
+ * Apple: Avoid programming the memory/io aperture of 00:1c.0
+ *
+ * BIOS does not declare any resource for 00:1c.0, but with
+ * hotplug flag set, thus OS allocate:
+ * [mem 0x7fa00000 - 0x7fbfffff]
+ * [mem 0x7fc00000-0x7fdfffff 64bit pref]
+ * which is conflict with an unreported device, which
+ * causes unpredictable result such as accessing io port.
+ * So clear the hotplug flag to work around it.
+ */
+static void quirk_apple_mbp_poweroff(struct pci_dev *dev)
+{
+	if (dmi_match(DMI_BOARD_VENDOR, "Apple Inc.") &&
+	    dmi_match(DMI_PRODUCT_NAME, "MacBookPro11,4") ||
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

