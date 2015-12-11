Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>,
	Khalid Aziz <khalid.aziz@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v9 08/60] powerpc/PCI: Keep resource idx order with bridge register number
Date: Thu, 10 Dec 2015 21:06:04 -0800
Message-Id: <1449810416-2950-9-git-send-email-yinghai@kernel.org>
In-Reply-To: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
References: <1449810416-2950-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Same as sparc version.

Make resource with consistent sequence
like other arch or directly from pci_read_bridge_bases(),
even non-pref mmio is missing, or out of ordering in firmware reporting.

So hold i = 1 for non pref mmio, and i = 2 for pref mmio.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/powerpc/kernel/pci_of_scan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 2e710c1..349ed11 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -255,7 +255,7 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 		bus->resource[i] = res;
 		++res;
 	}
-	i = 1;
+	i = 3;
 	for (; len >= 32; len -= 32, ranges += 8) {
 		flags = pci_parse_of_flags(of_read_number(ranges, 1), 1);
 		size = of_read_number(&ranges[6], 2);
@@ -268,6 +268,12 @@ void of_scan_pci_bridge(struct pci_dev *dev)
 				       " for bridge %s\n", node->full_name);
 				continue;
 			}
+		} else if ((flags & IORESOURCE_PREFETCH) &&
+			   !bus->resource[2]->flags) {
+			res = bus->resource[2];
+		} else if (((flags & (IORESOURCE_MEM | IORESOURCE_PREFETCH)) ==
+			    IORESOURCE_MEM) && !bus->resource[1]->flags) {
+			res = bus->resource[1];
 		} else {
 			if (i >= PCI_NUM_RESOURCES - PCI_BRIDGE_RESOURCES) {
 				printk(KERN_ERR "PCI: too many memory ranges"
-- 
1.8.4.5

