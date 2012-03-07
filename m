Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: [PATCH v3 21/34] ia64/PCI: SN: convert to pci_scan_root_bus() for
	correct root bus resources
To: Jesse Barnes <jbarnes@virtuousgeek.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arch@vger.kernel.org, linux-pci@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Jack Steiner <steiner@sgi.com>
Date: Wed, 07 Mar 2012 15:33:51 -0700
Message-ID: <20120307223351.25669.74415.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Convert from pci_scan_bus() to pci_scan_root_bus().  Supply the root
bus resources from bussoft.  When we move the resource adjustment from
pcibios_fixup_resources() to the PCI core, it will be important to have
the root bus resources correct from the beginning.

CC: Tony Luck <tony.luck@intel.com>
CC: Jack Steiner <steiner@sgi.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/ia64/sn/kernel/io_init.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_init.c b/arch/ia64/sn/kernel/io_init.c
index 0a36f08..c99c2ca 100644
--- a/arch/ia64/sn/kernel/io_init.c
+++ b/arch/ia64/sn/kernel/io_init.c
@@ -297,7 +297,8 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
 	s64 status = 0;
 	struct pci_controller *controller;
 	struct pcibus_bussoft *prom_bussoft_ptr;
-
+	LIST_HEAD(resources);
+	int i;
 
  	status = sal_get_pcibus_info((u64) segment, (u64) busnum,
  				     (u64) ia64_tpa(&prom_bussoft_ptr));
@@ -315,7 +316,13 @@ sn_pci_controller_fixup(int segment, int busnum, struct pci_bus *bus)
 	 */
 	controller->platform_data = prom_bussoft_ptr;
 
-	bus = pci_scan_bus(busnum, &pci_root_ops, controller);
+	sn_legacy_pci_window_fixup(controller,
+				   prom_bussoft_ptr->bs_legacy_io,
+				   prom_bussoft_ptr->bs_legacy_mem);
+	for (i = 0; i < controller->windows; i++)
+		pci_add_resource(&resources, &controller->window[i].resource);
+	bus = pci_scan_root_bus(NULL, busnum, &pci_root_ops, controller,
+				&resources);
  	if (bus == NULL)
  		goto error_return; /* error, or bus already scanned */
 
@@ -348,9 +355,6 @@ sn_bus_fixup(struct pci_bus *bus)
 			return;
 		}
 		sn_common_bus_fixup(bus, prom_bussoft_ptr);
-		sn_legacy_pci_window_fixup(PCI_CONTROLLER(bus),
-					   prom_bussoft_ptr->bs_legacy_io,
-					   prom_bussoft_ptr->bs_legacy_mem);
         }
         list_for_each_entry(pci_dev, &bus->devices, bus_list) {
                 sn_io_slot_fixup(pci_dev);

