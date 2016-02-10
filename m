Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:16032 "EHLO
	ausc60pc101.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbcBJPAP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2016 10:00:15 -0500
From: <Jordan_Hargrave@Dell.com>
To: <jharg93@gmail.com>
CC: <linux-pci@vger.kernel.org>
Subject: [PATCH] Create pci slot files for SMBIOS Type 9 entries
Date: Wed, 10 Feb 2016 14:50:34 +0000
Message-ID: <1455115834664.14871@Dell.com>
References: <1448678755-14779-1-git-send-email-jordan_hargrave@dell.com>,<1455058433803.44638@Dell.com>
In-Reply-To: <1455058433803.44638@Dell.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The following diff builds on the "[PATCHv3] Save SMBIOS Type 9 System Slots"

This will create a /sys/bus/pci/slots/XXX file for each Type 9 entry.  This will be used for systemd enumeration of NICs.

Signed-off-by: Jordan Hargrave <Jordan_Hargrave@dell.com>
---
 arch/x86/pci/common.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index eccd4d9..fc5bc49 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -173,6 +173,23 @@ void pcibios_fixup_bus(struct pci_bus *b)

 void pcibios_add_bus(struct pci_bus *bus)
 {
+       const struct dmi_device *dmi;
+       struct dmi_dev_onboard *dslot;
+
+       dmi = NULL;
+       while ((dmi = dmi_find_device(DMI_DEV_TYPE_DEV_SLOT,
+                                     NULL, dmi)) != NULL) {
+               dslot = dmi->device_data;
+               if (dslot->segment == pci_domain_nr(bus) &&
+                   dslot->bus == bus->number) {
+                       dev_info(&bus->dev, "Found SMBIOS Slot %s\n",
+                                dslot->dev.name);
+                       pci_create_slot(bus, dslot->devfn,
+                                       dslot->dev.name,
+                                       NULL);
+               }
+       }
+
        acpi_pci_add_bus(bus);
 }

--
1.7.1
