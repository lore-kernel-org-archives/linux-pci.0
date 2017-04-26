Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [RFC/RFT PATCH 2/3] PCI: Add call to set-up NUMA node for struct pci_bus devices
Date: Wed, 26 Apr 2017 11:06:18 +0100
Message-Id: <20170426100619.31758-2-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170426100619.31758-1-lorenzo.pieralisi@arm.com>
References: <20170426100619.31758-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The member dev in struct pci_bus represents the kernel struct
device representation of a PCI bus, inclusive of its NUMA node.
When a PCI host bridge is registered, initialize the corresponding
struct pci_bus.dev member NUMA node and add code in
pci_alloc_child_bus() to propagate the NUMA node set-up through the PCI
bus hierarchy (ie child nodes are in the same NUMA node as the parent).

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index dfc9a27..5739a993 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -770,6 +770,7 @@ int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
 	pci_set_bus_msi_domain(bus);
+	set_dev_node(&bus->dev, pci_bus_find_numa_node(bus));
 
 	if (!parent)
 		set_dev_node(bus->bridge, pcibus_to_node(bus));
@@ -861,7 +862,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	 */
 	child->dev.class = &pcibus_class;
 	dev_set_name(&child->dev, "%04x:%02x", pci_domain_nr(child), busnr);
-
+	set_dev_node(&child->dev, dev_to_node(&parent->dev));
 	/*
 	 * Set up the primary, secondary and subordinate
 	 * bus numbers.
-- 
2.10.0

