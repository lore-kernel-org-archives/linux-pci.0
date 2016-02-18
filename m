Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from AUSXIPPS310.us.dell.com ([143.166.148.211]:45708 "EHLO
	ausxipps310.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1948070AbcBRUke convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 18 Feb 2016 15:40:34 -0500
From: <Jordan_Hargrave@Dell.com>
To: <bhelgaas@google.com>, <helgaas@kernel.org>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<x86@kernel.org>, <jharg93@gmail.com>
Subject: [PATCH v3] Create pci slot files for SMBIOS Type 9 entries
Date: Thu, 18 Feb 2016 20:40:32 +0000
Message-ID: <1455827823254.98505@Dell.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following diff builds on the "[PATCHv3] Save SMBIOS Type 9 System Slots"

This will create a /sys/bus/pci/slots/XXX file for each Type 9 entry.  This will be \
used for systemd enumeration of NICs.

Only build if CONFIG_DMI is set

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
---
 arch/x86/pci/common.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index eccd4d9..bfa3c85 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -173,6 +173,27 @@ void pcibios_fixup_bus(struct pci_bus *b)
 
 void pcibios_add_bus(struct pci_bus *bus)
 {
+#ifdef CONFIG_DMI
+	const struct dmi_device *dmi;
+	struct dmi_dev_onboard *dslot;
+	char sname[128];
+
+	dmi = NULL;
+	while ((dmi = dmi_find_device(DMI_DEV_TYPE_DEV_SLOT,
+				      NULL, dmi)) != NULL) {
+		dslot = dmi->device_data;
+		if (dslot->segment == pci_domain_nr(bus) &&
+		    dslot->bus == bus->number) {
+			dev_info(&bus->dev, "Found SMBIOS Slot %s\n",
+				 dslot->dev.name);
+			snprintf(sname, sizeof(sname), "%s-%d",
+				 dslot->dev.name,
+				 dslot->instance);
+			pci_create_slot(bus, dslot->devfn,
+					sname, NULL);
+		}
+	}
+#endif
 	acpi_pci_add_bus(bus);
 }
 
-- 
2.5.0






 
--jordan hargrave
 Dell Enterprise Linux Engineering  