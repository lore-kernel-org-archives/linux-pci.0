Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 08/13] PCI/AER: Move pcie_aer_get_firmware_first() to
 portdrv.h
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:35 -0500
Message-ID: <152848833510.11888.13834530632280301120.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Move pcie_aer_get_firmware_first() to portdrv.h, where it can be more
easily shared between AER and DPC.  Then DPC no longer needs to include
aer/aerdrv.h.  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv.h |   10 ----------
 drivers/pci/pcie/dpc.c        |    1 -
 drivers/pci/pcie/portdrv.h    |   11 +++++++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index f4fc71119cf2..b0c4aaa79d9c 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -78,14 +78,4 @@ struct aer_rpc {
 
 irqreturn_t aer_irq(int irq, void *context);
 
-#ifdef CONFIG_ACPI_APEI
-int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
-#else
-static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
-{
-	if (pci_dev->__aer_firmware_first_valid)
-		return pci_dev->__aer_firmware_first;
-	return 0;
-}
-#endif
 #endif /* _AERDRV_H_ */
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index d6436681c535..921ed979109d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -13,7 +13,6 @@
 
 #include "portdrv.h"
 #include "../pci.h"
-#include "aer/aerdrv.h"
 
 struct dpc_dev {
 	struct pcie_device	*dev;
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 2bb5db7b53e6..6a261dc7cd4c 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -110,6 +110,17 @@ static inline bool pcie_pme_no_msi(void) { return false; }
 static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
 #endif /* !CONFIG_PCIE_PME */
 
+#ifdef CONFIG_ACPI_APEI
+int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
+#else
+static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
+{
+	if (pci_dev->__aer_firmware_first_valid)
+		return pci_dev->__aer_firmware_first;
+	return 0;
+}
+#endif
+
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
