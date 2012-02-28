Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
	Kyle McMartin <kyle@mcmartin.ca>, Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org
Subject: [PATCH 09/18] PCI, parisc: Register busn_res for root buses
Date: Mon, 27 Feb 2012 18:10:00 -0800
Message-Id: <1330395009-29260-10-git-send-email-yinghai@kernel.org>
In-Reply-To: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
References: <1330395009-29260-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 drivers/parisc/dino.c    |    2 ++
 drivers/parisc/lba_pci.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/parisc/dino.c b/drivers/parisc/dino.c
index 0610e91..ea3f483 100644
--- a/drivers/parisc/dino.c
+++ b/drivers/parisc/dino.c
@@ -999,7 +999,9 @@ static int __init dino_probe(struct parisc_device *dev)
 		return 0;
 	}
 
+	pci_bus_insert_busn_res(bus, dino_current_bus, 255);
 	bus->subordinate = pci_scan_child_bus(bus);
+	pci_bus_update_busn_res_end(bus, bus->subordinate);
 
 	/* This code *depends* on scanning being single threaded
 	 * if it isn't, this global bus number count will fail
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index e885764..84fa239 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1512,6 +1512,9 @@ lba_driver_probe(struct parisc_device *dev)
 		return 0;
 	}
 
+	pci_bus_insert_busn_res(lba_bus, lba_dev->hba.bus_num.start,
+				lba_dev->hba.bus_num.end);
+
 	lba_bus->subordinate = pci_scan_child_bus(lba_bus);
 
 	/* This is in lieu of calling pci_assign_unassigned_resources() */
-- 
1.7.7

