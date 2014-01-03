Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v5 25/33] PCI, x86: Make ioapic hotplug support built-in
Date: Thu,  2 Jan 2014 16:05:57 -0800
Message-Id: <1388707565-16535-26-git-send-email-yinghai@kernel.org>
In-Reply-To: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

ioapic hotplug should be built-in like pci root bus hotplug.

Also need to make it depends on X86_IO_APIC.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/Kconfig  | 3 ++-
 drivers/pci/ioapic.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index b6a99f7..893503f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -105,9 +105,10 @@ config PCI_PASID
 	  If unsure, say N.
 
 config PCI_IOAPIC
-	tristate "PCI IO-APIC hotplug support" if X86
+	bool "PCI IO-APIC hotplug support" if X86
 	depends on PCI
 	depends on ACPI
+	depends on X86_IO_APIC
 	default !X86
 
 config PCI_LABEL
diff --git a/drivers/pci/ioapic.c b/drivers/pci/ioapic.c
index 50ce680..2c2930e 100644
--- a/drivers/pci/ioapic.c
+++ b/drivers/pci/ioapic.c
@@ -113,6 +113,10 @@ static struct pci_driver ioapic_driver = {
 	.remove		= ioapic_remove,
 };
 
-module_pci_driver(ioapic_driver);
+static int __init ioapic_init(void)
+{
+	return pci_register_driver(&ioapic_driver);
+}
+module_init(ioapic_init);
 
 MODULE_LICENSE("GPL");
-- 
1.8.4

