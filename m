Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Tony Luck <tony.luck@intel.com>,
	David Miller <davem@davemloft.net>, x86 <x86@kernel.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 07/21] PCI: print conflicting entry in busn_res inserting
Date: Mon,  7 May 2012 13:29:52 -0700
Message-Id: <1336422606-4244-8-git-send-email-yinghai@kernel.org>
In-Reply-To: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Print conflicting entry if insertion fails.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/probe.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bfbf064..7662ab7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1717,8 +1717,7 @@ err_out:
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 {
 	struct resource *res = &b->busn_res;
-	struct resource *parent_res;
-	int ret;
+	struct resource *parent_res, *conflict;
 
 	res->start = bus;
 	res->end = bus_max;
@@ -1731,14 +1730,20 @@ int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
 		res->flags |= IORESOURCE_PCI_FIXED;
 	}
 
-	ret = insert_resource(parent_res, res);
+	conflict = insert_resource_conflict(parent_res, res);
 
-	dev_printk(KERN_DEBUG, &b->dev,
-			"busn_res: %pR %s inserted under %s %pR\n",
-			res, ret ? "can not be" : "is",
-			pci_is_root_bus(b) ? "domain":"", parent_res);
+	if (conflict)
+		dev_printk(KERN_DEBUG, &b->dev,
+			   "busn_res: can not insert %pR under %s%pR (conflicts with %s %pR)\n",
+			    res, pci_is_root_bus(b) ? "domain " : "",
+			    parent_res, conflict->name, conflict);
+	else
+		dev_printk(KERN_DEBUG, &b->dev,
+			   "busn_res: %pR is inserted under %s%pR\n",
+			   res, pci_is_root_bus(b) ? "domain " : "",
+			   parent_res);
 
-	return ret;
+	return conflict == NULL;
 }
 
 int pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
-- 
1.7.7

