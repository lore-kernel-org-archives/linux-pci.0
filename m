Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <55125679.1080201@intel.com>
Date: Wed, 25 Mar 2015 14:32:25 +0800
From: Aaron Lu <aaron.lu@intel.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v3 2/3] PCI: rename find_pci_host_bridge and export it
References: <54FD4FB9.2060802@intel.com> <55125611.8040507@intel.com>
In-Reply-To: <55125611.8040507@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The find_pci_host_bridge function can be useful to other PCI code so
export it. In the meantime, change its name to more like other interfaces
as pci_find_host_bridge.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/pci/host-bridge.c | 6 +++---
 drivers/pci/pci.h         | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host-bridge.c b/drivers/pci/host-bridge.c
index 3e5bbf9e8889..5f4a2e04c8d7 100644
--- a/drivers/pci/host-bridge.c
+++ b/drivers/pci/host-bridge.c
@@ -16,7 +16,7 @@ static struct pci_bus *find_pci_root_bus(struct pci_bus *bus)
 	return bus;
 }
 
-static struct pci_host_bridge *find_pci_host_bridge(struct pci_bus *bus)
+struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus)
 {
 	struct pci_bus *root_bus = find_pci_root_bus(bus);
 
@@ -48,7 +48,7 @@ void pci_set_host_bridge_release(struct pci_host_bridge *bridge,
 void pcibios_resource_to_bus(struct pci_bus *bus, struct pci_bus_region *region,
 			     struct resource *res)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
 	resource_size_t offset = 0;
 
@@ -73,7 +73,7 @@ static bool region_contains(struct pci_bus_region *region1,
 void pcibios_bus_to_resource(struct pci_bus *bus, struct resource *res,
 			     struct pci_bus_region *region)
 {
-	struct pci_host_bridge *bridge = find_pci_host_bridge(bus);
+	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
 	struct resource_entry *window;
 	resource_size_t offset = 0;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4091f82239cd..d72f849174a4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -321,4 +321,6 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, int probe)
 }
 #endif
 
+struct pci_host_bridge *pci_find_host_bridge(struct pci_bus *bus);
+
 #endif /* DRIVERS_PCI_H */
-- 
2.1.0

