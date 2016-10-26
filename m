Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/5] PCI: Make pci_std_enable_acs() non-static
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date: Wed, 26 Oct 2016 12:01:16 -0600
Message-ID: <20161026180116.23495.77322.stgit@gimli.home>
In-Reply-To: <20161026175156.23495.12980.stgit@gimli.home>
References: <20161026175156.23495.12980.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

For use by quirks.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/pci.c   |    2 +-
 include/linux/pci.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aab9d51..b901ee7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2728,7 +2728,7 @@ void pci_request_acs(void)
  * pci_std_enable_acs - enable ACS on devices using standard ACS capabilites
  * @dev: the PCI device
  */
-static void pci_std_enable_acs(struct pci_dev *dev)
+void pci_std_enable_acs(struct pci_dev *dev)
 {
 	int pos;
 	u16 cap;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ab8359..c3248d5 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1900,6 +1900,7 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
 bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
 bool pci_acs_path_enabled(struct pci_dev *start,
 			  struct pci_dev *end, u16 acs_flags);
+void pci_std_enable_acs(struct pci_dev *dev);
 
 #define PCI_VPD_LRDT			0x80	/* Large Resource Data Type */
 #define PCI_VPD_LRDT_ID(x)		((x) | PCI_VPD_LRDT)
