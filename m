Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 04/10] PCI, frv: clip firmware assigned resource under parent bridge's
Date: Mon, 12 Jan 2015 11:23:14 -0800
Message-Id: <1421090600-9750-5-git-send-email-yinghai@kernel.org>
In-Reply-To: <1421090600-9750-1-git-send-email-yinghai@kernel.org>
References: <1421090600-9750-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some bios put range that is not fully coverred by root bus resources.
Try to clip them and update them in pci bridge bars.

We'd like to fix other arches instead of just x86.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
Reported-by: Marek Kordik <kordikmarek@gmail.com>
Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/frv/mb93090-mb00/pci-frv.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/frv/mb93090-mb00/pci-frv.c b/arch/frv/mb93090-mb00/pci-frv.c
index 67b1d16..f4e36f6 100644
--- a/arch/frv/mb93090-mb00/pci-frv.c
+++ b/arch/frv/mb93090-mb00/pci-frv.c
@@ -90,12 +90,26 @@ static void __init pcibios_allocate_bus_resources(struct list_head *bus_list)
 	for (ln=bus_list->next; ln != bus_list; ln=ln->next) {
 		bus = list_entry(ln, struct pci_bus, node);
 		if ((dev = bus->self)) {
+			bool changed = false;
+
 			for (idx = PCI_BRIDGE_RESOURCES; idx < PCI_NUM_RESOURCES; idx++) {
 				r = &dev->resource[idx];
 				if (!r->start)
 					continue;
-				pci_claim_resource(dev, idx);
+
+				if (pci_claim_resource(dev, idx) >= 0)
+					continue;
+
+				/* try again after clip for pci bridge*/
+				if ((dev->class >> 8) == PCI_CLASS_BRIDGE_PCI &&
+				    pci_bus_clip_resource(dev, r)) {
+					changed = true;
+					pci_claim_resource(dev, idx);
+				}
 			}
+
+			if (changed)
+				pci_setup_bridge(bus);
 		}
 		pcibios_allocate_bus_resources(&bus->children);
 	}
@@ -123,11 +137,20 @@ static void __init pcibios_allocate_resources(int pass)
 			if (pass == disabled) {
 				DBG("PCI: Resource %08lx-%08lx (f=%lx, d=%d, p=%d)\n",
 				    r->start, r->end, r->flags, disabled, pass);
-				if (pci_claim_resource(dev, idx) < 0) {
-					/* We'll assign a new address later */
-					r->end -= r->start;
-					r->start = 0;
+
+				if (pci_claim_resource(dev, idx) >= 0)
+					continue;
+
+				/* try again with clip */
+				if (pci_bus_clip_resource(dev, r)) {
+					pci_update_resource(dev, idx);
+					if (pci_claim_resource(dev, idx) >= 0)
+						continue;
 				}
+
+				/* We'll assign a new address later */
+				r->end -= r->start;
+				r->start = 0;
 			}
 		}
 		if (!pass) {
-- 
1.8.4.5

