Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:24408 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbbG0XmA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jul 2015 19:42:00 -0400
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v3 47/51] PCI: Claim fixed resource during remove/rescan path
Date: Mon, 27 Jul 2015 16:30:05 -0700
Message-Id: <1438039809-24957-48-git-send-email-yinghai@kernel.org>
In-Reply-To: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
References: <1438039809-24957-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We need to reserve them before pci_bus_add().

During driver loading kernel will check if those reource get reserved.

On remove/rescan path, we will leave those fixed resource
not reserved, as we don't call pcibios_resource_survery() before
pci_assign_unassigned_bus_resources(), and that is intentional
for us to get new resources for rescan.
We do have example to use rescan to make device get resource
allocated.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/quirks.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e9fd0e9..9efa983 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -324,6 +324,23 @@ static void quirk_s3_64M(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_868,		quirk_s3_64M);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_S3,	PCI_DEVICE_ID_S3_968,		quirk_s3_64M);
 
+/* for pci remove and rescan */
+static void quirk_allocate_fixed(struct pci_dev *dev)
+{
+	int i;
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *r = &dev->resource[i];
+
+		if (r->parent ||
+		    !(r->flags & IORESOURCE_PCI_FIXED) ||
+		    !(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
+			continue;
+
+		pci_claim_resource(dev, i);
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID,	PCI_ANY_ID,	quirk_allocate_fixed);
+
 static void quirk_io(struct pci_dev *dev, int pos, unsigned size,
 		     const char *name)
 {
-- 
1.8.4.5

