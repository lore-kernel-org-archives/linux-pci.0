Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Keith Busch <keith.busch@intel.com>
To: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
	Jon Derrick <jonathan.derrick@intel.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCHv3 1/4] pci: skip child bus with conflicting resources
Date: Tue, 27 Oct 2015 11:34:04 -0600
Message-Id: <1445967247-24310-2-git-send-email-keith.busch@intel.com>
In-Reply-To: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
References: <1445967247-24310-1-git-send-email-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

And use the max bus resource from the parent rather than assume 255.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/probe.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8361d27..1cb3be7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -856,7 +856,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			if (!child)
 				goto out;
 			child->primary = primary;
-			pci_bus_insert_busn_res(child, secondary, subordinate);
+			if (!pci_bus_insert_busn_res(child, secondary, subordinate)) {
+				pci_remove_bus(child);
+				goto out;
+			}
 			child->bridge_ctl = bctl;
 		}
 
@@ -896,7 +899,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
 			child = pci_add_new_bus(bus, dev, max+1);
 			if (!child)
 				goto out;
-			pci_bus_insert_busn_res(child, max+1, 0xff);
+			if (!pci_bus_insert_busn_res(child, max+1, bus->busn_res.end)) {
+				pci_remove_bus(child);
+				goto out;
+			}
 		}
 		max++;
 		buses = (buses & 0xff000000)
-- 
1.7.10.4

