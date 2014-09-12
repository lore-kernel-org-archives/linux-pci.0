Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: [PATCH v1 05/13] PCI: pciehp: Remove pci_configure_slot() usage
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rajat Jain <rajatxjain@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Date: Fri, 12 Sep 2014 12:03:21 -0600
Message-ID: <20140912180321.1630.88175.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We now configure each PCI device as it is enumerated, in pci_device_add(),
so remove the configuration done in pciehp.

That configuration, in pci_configure_device(), does not include the
MPS/MRRS configuration done by pcie_bus_configure_settings(), so keep
that here.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_pci.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index b66812703415..9e69403be632 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -65,10 +65,7 @@ int pciehp_configure_device(struct slot *p_slot)
 			pci_hp_add_bridge(dev);
 
 	pci_assign_unassigned_bridge_resources(bridge);
-
-	list_for_each_entry(dev, &parent->devices, bus_list)
-		pci_configure_slot(dev);
-
+	pcie_bus_configure_settings(parent);
 	pci_bus_add_devices(parent);
 
  out:

