Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7847 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbIORLh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2015 13:11:37 -0400
From: Will Davis <wdavis@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	Konrad Wilk <konrad.wilk@oracle.com>,
	Mark Hounschell <markh@compro.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Terence Ripperda <tripperda@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jerome Glisse <jglisse@redhat.com>,
	Will Davis <wdavis@nvidia.com>
Subject: [PATCH 08/22] PCI: Add pci_find_common_upstream_dev()
Date: Tue, 15 Sep 2015 12:10:53 -0500
Message-ID: <1442337067-22964-9-git-send-email-wdavis@nvidia.com>
In-Reply-To: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add an interface to find the first device which is upstream of both
devices.

Signed-off-by: Will Davis <wdavis@nvidia.com>
---
 drivers/pci/search.c | 25 +++++++++++++++++++++++++
 include/linux/pci.h  |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index a20ce7d..b6ed554 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -384,3 +384,28 @@ int pci_dev_present(const struct pci_device_id *ids)
 	return 0;
 }
 EXPORT_SYMBOL(pci_dev_present);
+
+/**
+ * pci_find_common_upstream_dev - Returns the first common upstream device
+ * @dev: the PCI device from which the bus hierarchy walk will start
+ * @other: the PCI device whose bus number will be used for the search
+ *
+ * Walks up the bus hierarchy from the @dev device, looking for the first bus
+ * which the @other device is downstream of. Returns %NULL if the devices do
+ * not share any upstream devices.
+ */
+struct pci_dev *pci_find_common_upstream_dev(struct pci_dev *dev,
+					     struct pci_dev *other)
+{
+	struct pci_dev *pdev = dev;
+
+	while (pdev != NULL) {
+		if ((other->bus->number >= pdev->bus->busn_res.start) &&
+		    (other->bus->number <= pdev->bus->busn_res.end))
+			return pdev;
+		pdev = pci_upstream_bridge(pdev);
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(pci_find_common_upstream_dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d58063e..8262b9e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -860,6 +860,8 @@ static inline struct pci_dev *pci_get_bus_and_slot(unsigned int bus,
 }
 struct pci_dev *pci_get_class(unsigned int class, struct pci_dev *from);
 int pci_dev_present(const struct pci_device_id *ids);
+struct pci_dev *pci_find_common_upstream_dev(struct pci_dev *from,
+					     struct pci_dev *to);
 
 int pci_bus_read_config_byte(struct pci_bus *bus, unsigned int devfn,
 			     int where, u8 *val);
-- 
2.5.1

