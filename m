Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH v1 09/13] PCI/AER: Move aer_irq() declaration to portdrv.h
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Date: Fri, 08 Jun 2018 15:05:41 -0500
Message-ID: <152848834128.11888.12263280185471104825.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152848785553.11888.12243539903985770441.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The aer_irq() declaration is the only thing needed by aer_inject.c.  Move
it to portdrv.h so we eventually get rid of aerdrv.h completely.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aer_inject.c |    3 ++-
 drivers/pci/pcie/aer/aerdrv.h     |    2 --
 drivers/pci/pcie/portdrv.h        |    4 ++++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index a49090935303..6c5fda96778a 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -21,7 +21,8 @@
 #include <linux/uaccess.h>
 #include <linux/stddef.h>
 #include <linux/device.h>
-#include "aerdrv.h"
+
+#include "../portdrv.h"
 
 /* Override the existing corrected and uncorrected error masks */
 static bool aer_mask_override;
diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
index b0c4aaa79d9c..9867950635df 100644
--- a/drivers/pci/pcie/aer/aerdrv.h
+++ b/drivers/pci/pcie/aer/aerdrv.h
@@ -76,6 +76,4 @@ struct aer_rpc {
 					 */
 };
 
-irqreturn_t aer_irq(int irq, void *context);
-
 #endif /* _AERDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 6a261dc7cd4c..6ffc797a0dc1 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -121,6 +121,10 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 }
 #endif
 
+#ifdef CONFIG_PCIEAER
+irqreturn_t aer_irq(int irq, void *context);
+#endif
+
 struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
 							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
