Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org
Subject: [PATCH V3 4/6] PCI: Deprecate pci_reset_bus() and pci_reset_slot()
 functions
Date: Thu, 28 Jun 2018 14:28:24 -0400
Message-Id: <1530210507-9287-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
References: <1530210507-9287-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, open list <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

pci_reset_bus() and pci_reset_slot() functions are not being used by
any code. Remove them from the kernel in favor of pci_try_reset_bus()
and pci_try_reset_slot() functions.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c   | 55 ++---------------------------------------------------
 include/linux/pci.h |  2 --
 2 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 79a1566..6cec722 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4784,9 +4784,9 @@ int pci_probe_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
 
 /**
- * pci_reset_slot - reset a PCI slot
+ * __pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
- *
+ *`
  * A PCI bus may host multiple slots, each slot may support a reset mechanism
  * independent of other slots.  For instance, some slots may support slot power
  * control.  In the case of a 1:1 bus to slot architecture, this function may
@@ -4796,30 +4796,6 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  * through this function.  PCI config space of all devices in the slot and
  * behind the slot is saved before and restored after reset.
  *
- * Return 0 on success, non-zero on error.
- */
-int pci_reset_slot(struct pci_slot *slot)
-{
-	int rc;
-
-	rc = pci_slot_reset(slot, 1);
-	if (rc)
-		return rc;
-
-	pci_slot_save_and_disable(slot);
-
-	rc = pci_slot_reset(slot, 0);
-
-	pci_slot_restore(slot);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_reset_slot);
-
-/**
- * __pci_try_reset_slot - Try to reset a PCI slot
- * @slot: PCI slot to reset
- *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
 static int __pci_try_reset_slot(struct pci_slot *slot)
@@ -4878,33 +4854,6 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
 /**
- * pci_reset_bus - reset a PCI bus
- * @bus: top level PCI bus to reset
- *
- * Do a bus reset on the given bus and any subordinate buses, saving
- * and restoring state of all devices.
- *
- * Return 0 on success, non-zero on error.
- */
-int pci_reset_bus(struct pci_bus *bus)
-{
-	int rc;
-
-	rc = pci_bus_reset(bus, 1);
-	if (rc)
-		return rc;
-
-	pci_bus_save_and_disable(bus);
-
-	rc = pci_bus_reset(bus, 0);
-
-	pci_bus_restore(bus);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_reset_bus);
-
-/**
  * __pci_try_reset_bus - Try to reset a PCI bus
  * @bus: top level PCI bus to reset
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f5c85b6..ad0c89a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1095,9 +1095,7 @@ int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
-int pci_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-int pci_reset_bus(struct pci_bus *bus);
 int pci_try_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
