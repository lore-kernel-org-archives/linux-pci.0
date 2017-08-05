Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 03/10] PCI: export symbol for PCI_TEST module
Date: Fri,  4 Aug 2017 23:37:54 -0700
Message-Id: <20170805063801.15880-4-yinghai@kernel.org>
In-Reply-To: <20170805063801.15880-1-yinghai@kernel.org>
References: <20170805063801.15880-1-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to use them from pci_test module, so expose them.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/pci/i386.c     | 1 +
 drivers/pci/setup-bus.c | 1 +
 kernel/resource.c       | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index 7b43071..9065c58 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -383,6 +383,7 @@ void pcibios_resource_survey_bus(struct pci_bus *bus)
 	if (!(pci_probe & PCI_ASSIGN_ROMS))
 		pcibios_allocate_rom_resources(bus);
 }
+EXPORT_SYMBOL_GPL(pcibios_resource_survey_bus);
 
 void __init pcibios_resource_survey(void)
 {
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 1c30102..24292e9 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1839,6 +1839,7 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	/* dump the resource on buses */
 	pci_bus_dump_resources(bus);
 }
+EXPORT_SYMBOL_GPL(pci_assign_unassigned_root_bus_resources);
 
 void __init pci_assign_unassigned_resources(void)
 {
diff --git a/kernel/resource.c b/kernel/resource.c
index 4174020..0d40d9a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -301,6 +301,8 @@ void release_child_resources(struct resource *r)
 	write_unlock(&resource_lock);
 }
 
+EXPORT_SYMBOL_GPL(release_child_resources);
+
 /**
  * request_resource_conflict - request and reserve an I/O or memory resource
  * @root: root resource descriptor
-- 
2.9.4
