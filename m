Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	David Miller <davem@davemloft.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>, TJ <linux@iam.tj>,
	Yijing Wang <wangyijing@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH v4 48/52] PCI: Claim fixed resource during remove/rescan path
Date: Thu, 20 Aug 2015 23:21:03 -0700
Message-Id: <1440138067-4314-49-git-send-email-yinghai@kernel.org>
In-Reply-To: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
References: <1440138067-4314-1-git-send-email-yinghai@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

During driver loading kernel will check if resources get reserved.
so we need to make sure resources get reserved before pci_bus_add().

On remove/rescan path, we will leave those fixed resource
not reserved. In that path, We don't call pcibios_resource_survery()
before pci_assign_unassigned_bus_resources(), and that is intentional
for us to get new resources for rescan. We do need to use rescan to make
device get resource allocated while ignoring BIOS allocate resource.

But fixed resources are not allocated via
pci_assign_unassigned_bus_resources(), so we need to reserve them
explicitly.

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

