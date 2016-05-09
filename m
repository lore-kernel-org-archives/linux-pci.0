Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbcEISXT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 May 2016 14:23:19 -0400
From: Prarit Bhargava <prarit@redhat.com>
To: linux-pci@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Myron Stowe <mstowe@redhat.com>,
	x86@kernel.org
Subject: [PATCH] x86/PCI: Fix Broadwell-EP Home Agent & PCU non-compliant BARs
Date: Mon,  9 May 2016 14:23:15 -0400
Message-Id: <1462818195-6533-1-git-send-email-prarit@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

commit b894157 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having
non-compliant BARs") marks Home Agent 0 & PCU has having non-compliant
BARs.

Before commit b894157,

pci 0000:ff:12.0: BAR 2: failed to assign [mem size 0x00000040]
pci 0000:ff:12.0: BAR 4: failed to assign [mem size 0x00000040]
pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
pci 0000:ff:12.0: BAR 1: failed to assign [mem size 0x00000010]
pci 0000:ff:12.0: BAR 3: failed to assign [mem size 0x00000010]
pci 0000:ff:12.0: BAR 5: failed to assign [mem size 0x00000010]
pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
pci 0000:7f:12.0: BAR 2: failed to assign [mem size 0x00000040]
pci 0000:7f:12.0: BAR 4: failed to assign [mem size 0x00000040]
pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
pci 0000:7f:12.0: BAR 1: failed to assign [mem size 0x00000010]
pci 0000:7f:12.0: BAR 3: failed to assign [mem size 0x00000010]
pci 0000:7f:12.0: BAR 5: failed to assign [mem size 0x00000010]
pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]

After commit b894157, there are still "failed to assign" messages,
as well as new "failed to assign" messages for ff:12.0, ff:1e.3,
7f:12.0, and 7f:1e.3.

 pci 0000:ff:12.4: BAR 2: failed to assign [mem size 0x00000040]
 pci 0000:ff:12.4: BAR 4: failed to assign [mem size 0x00000040]
 pci 0000:ff:12.4: BAR 1: failed to assign [mem size 0x00000010]
 pci 0000:ff:12.4: BAR 3: failed to assign [mem size 0x00000010]
 pci 0000:ff:12.4: BAR 5: failed to assign [mem size 0x00000010]
 pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
 pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
 pci 0000:7f:12.4: BAR 2: failed to assign [mem size 0x00000040]
 pci 0000:7f:12.4: BAR 4: failed to assign [mem size 0x00000040]
 pci 0000:7f:12.4: BAR 1: failed to assign [mem size 0x00000010]
 pci 0000:7f:12.4: BAR 3: failed to assign [mem size 0x00000010]
 pci 0000:7f:12.4: BAR 5: failed to assign [mem size 0x00000010]
 pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
 pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]

There are two issues with commit b894157.

The first is that there is another device, Home Agent 1 & PCU, that must
also be quirked in the same way.

\# lspci -n -s 7f:12.4
7f:12.4 0880: 8086:6f60 (rev 01)

After applying the quirk patch, we end up with:

pci 0000:ff:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:ff:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:ff:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:7f:12.0: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:7f:12.4: BAR 6: failed to assign [mem size 0x00000001 pref]
pci 0000:7f:1e.3: BAR 6: failed to assign [mem size 0x00000001 pref]

which drives us to the second issue.  Since the PCI devices now
have unnassigned resources (BARs), pcibios_assign_resources()
call pci_assign_unassigned_root_bus_resources().  This results in the
messages above.  I have added a non_compliant_bars check in
pbus_assign_resources_sorted() to avoid the unassigned device's resources
from being added to the failed resources list for the bus.

Successfully tested by me on a three vendor's Broadwell-EP systems which
no longer show the above false errors messages.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Myron Stowe <mstowe@redhat.com>
Cc: x86@kernel.org
Fixes: b894157 ("x86/PCI: Mark Broadwell-EP Home Agent & PCU as having non-compliant BARs")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 arch/x86/pci/fixup.c    |    1 +
 drivers/pci/setup-bus.c |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b7de192..59a79e6 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -556,5 +556,6 @@ static void pci_bdwep_bar(struct pci_dev *dev)
 {
 	dev->non_compliant_bars = 1;
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6f60, pci_bdwep_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fa0, pci_bdwep_bar);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x6fc0, pci_bdwep_bar);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 55641a3..78b6b69 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -515,8 +515,10 @@ static void pbus_assign_resources_sorted(const struct pci_bus *bus,
 	struct pci_dev *dev;
 	LIST_HEAD(head);
 
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		__dev_sort_resources(dev, &head);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!dev->non_compliant_bars)
+			__dev_sort_resources(dev, &head);
+	}
 
 	__assign_resources_sorted(&head, realloc_head, fail_head);
 }
-- 
1.7.9.3

