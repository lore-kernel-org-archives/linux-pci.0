Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Ram Pai <linuxram@us.ibm.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 3/7] PCI: Skip reset cardbus assigned resource during pci bus rescan
Date: Fri, 10 Feb 2012 15:33:48 -0800
Message-Id: <1328916832-6588-4-git-send-email-yinghai@kernel.org>
In-Reply-To: <1328916832-6588-1-git-send-email-yinghai@kernel.org>
References: <1328916832-6588-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

otherwise when rescan is used for cardbus, assigned resource will get
cleared.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Dominik Brodowski <linux@dominikbrodowski.net>

---
 drivers/pci/setup-bus.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 3b3932a..2991a89 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -901,6 +901,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 	resource_size_t b_res_3_size = pci_cardbus_mem_size * 2;
 	u16 ctrl;
 
+	if (b_res[0].parent)
+		goto handle_b_res_1;
 	/*
 	 * Reserve some resources for CardBus.  We reserve
 	 * a fixed amount of bus space for CardBus bridges.
@@ -914,6 +916,9 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 				pci_cardbus_io_size);
 	}
 
+handle_b_res_1:
+	if (b_res[1].parent)
+		goto handle_b_res_2;
 	b_res[1].start = pci_cardbus_io_size;
 	b_res[1].end = b_res[1].start + pci_cardbus_io_size - 1;
 	b_res[1].flags |= IORESOURCE_IO | IORESOURCE_STARTALIGN;
@@ -923,6 +928,7 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 				 pci_cardbus_io_size);
 	}
 
+handle_b_res_2:
 	/* MEM1 must not be pref mmio */
 	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
 	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM1) {
@@ -942,6 +948,8 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
 	}
 
+	if (b_res[2].parent)
+		goto handle_b_res_3;
 	/*
 	 * If we have prefetchable memory support, allocate
 	 * two regions.  Otherwise, allocate one region of
@@ -962,6 +970,9 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 		b_res_3_size = pci_cardbus_mem_size;
 	}
 
+handle_b_res_3:
+	if (b_res[3].parent)
+		goto handle_done;
 	b_res[3].start = pci_cardbus_mem_size;
 	b_res[3].end = b_res[3].start + b_res_3_size - 1;
 	b_res[3].flags |= IORESOURCE_MEM | IORESOURCE_STARTALIGN;
@@ -970,6 +981,9 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 		add_to_list(realloc_head, bridge, b_res+3, b_res_3_size,
 				 pci_cardbus_mem_size);
 	}
+
+handle_done:
+	;
 }
 
 void __ref __pci_bus_size_bridges(struct pci_bus *bus,
-- 
1.7.7

