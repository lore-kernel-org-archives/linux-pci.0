Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V2 5/5] PCI: Unify slot and bus reset API
Date: Wed, 20 Jun 2018 00:12:58 -0400
Message-Id: <1529467995-28780-5-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
References: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
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

Drivers are expected to call pci_reset_slot() or pci_reset_bus() by
querying if a system supports hotplug or not. A survey showed that most
drivers don't do this and we are leaking hotplug capability to the
user.

Hide pci_slot_reset() from drivers and embed into pci_bus_reset().
Change pci_reset_bus() parameter from struct pci_bus to struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c   | 27 +++++++++++++++++++++++----
 include/linux/pci.h |  3 +--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 79a1566..a44b948 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4798,7 +4798,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  *
  * Return 0 on success, non-zero on error.
  */
-int pci_reset_slot(struct pci_slot *slot)
+static int __pci_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
@@ -4814,7 +4814,6 @@ int pci_reset_slot(struct pci_slot *slot)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(pci_reset_slot);
 
 /**
  * __pci_try_reset_slot - Try to reset a PCI slot
@@ -4878,7 +4877,7 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
 /**
- * pci_reset_bus - reset a PCI bus
+ * __pci_reset_bus - reset a PCI bus
  * @bus: top level PCI bus to reset
  *
  * Do a bus reset on the given bus and any subordinate buses, saving
@@ -4886,7 +4885,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Return 0 on success, non-zero on error.
  */
-int pci_reset_bus(struct pci_bus *bus)
+static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
@@ -4902,6 +4901,26 @@ int pci_reset_bus(struct pci_bus *bus)
 
 	return rc;
 }
+
+/**
+ * pci_reset_bus - reset a PCI bus
+ * @pdev: top level PCI device to reset via slot/bus
+ *
+ * Do a slot/bus reset on the given bus and any subordinate buses, saving
+ * and restoring state of all devices.
+ *
+ * Return 0 on success, non-zero on error.
+ */
+int pci_reset_bus(struct pci_dev *pdev)
+{
+	bool slot = false;
+
+	if (!pci_probe_reset_slot(pdev->slot))
+		slot = true;
+
+	return slot ? __pci_reset_slot(pdev->slot) :
+			__pci_reset_bus(pdev->bus);
+}
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f5c85b6..e68ca2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1095,9 +1095,8 @@ int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
-int pci_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-int pci_reset_bus(struct pci_bus *bus);
+int pci_reset_bus(struct pci_dev *dev);
 int pci_try_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
