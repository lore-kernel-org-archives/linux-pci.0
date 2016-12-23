Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCHv2 3/3] of: pci: remove unused MSI controller helpers
Date: Fri, 23 Dec 2016 10:20:54 +0100
Message-Id: <1482484854-26418-4-git-send-email-thomas.petazzoni@free-electrons.com>
In-Reply-To: <1482484854-26418-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482484854-26418-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

All the users of the small MSI controller API have been migrated to use
the generic MSI infrastructure instead. We no longer need a global
chained list of msi_controller. Instead, MSI controllers are now
represented as irq domains attached to OF nodes, and the resolution
between a device requesting an MSI and the corresponding MSI controller
is done by the generic interrupt resolution logic.

Therefore, this API is now completely useless, and can be removed from
the kernel.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v1:
 - Rebased on v4.9.
 - Added ACKs from Marc Zyngier and Rob Herring, given on the v1 (the
   patch hasn't changed except from resolving the conflicts when
   rebasing on v4.9, and those conflicts were trivial since this patch
   only removes code).
---
 drivers/of/of_pci.c    | 45 ---------------------------------------------
 include/linux/of_pci.h | 11 -----------
 2 files changed, 56 deletions(-)

diff --git a/drivers/of/of_pci.c b/drivers/of/of_pci.c
index b58be12..3ea9631 100644
--- a/drivers/of/of_pci.c
+++ b/drivers/of/of_pci.c
@@ -264,51 +264,6 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
 EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
 #endif /* CONFIG_OF_ADDRESS */
 
-#ifdef CONFIG_PCI_MSI
-
-static LIST_HEAD(of_pci_msi_chip_list);
-static DEFINE_MUTEX(of_pci_msi_chip_mutex);
-
-int of_pci_msi_chip_add(struct msi_controller *chip)
-{
-	if (!of_property_read_bool(chip->of_node, "msi-controller"))
-		return -EINVAL;
-
-	mutex_lock(&of_pci_msi_chip_mutex);
-	list_add(&chip->list, &of_pci_msi_chip_list);
-	mutex_unlock(&of_pci_msi_chip_mutex);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(of_pci_msi_chip_add);
-
-void of_pci_msi_chip_remove(struct msi_controller *chip)
-{
-	mutex_lock(&of_pci_msi_chip_mutex);
-	list_del(&chip->list);
-	mutex_unlock(&of_pci_msi_chip_mutex);
-}
-EXPORT_SYMBOL_GPL(of_pci_msi_chip_remove);
-
-struct msi_controller *of_pci_find_msi_chip_by_node(struct device_node *of_node)
-{
-	struct msi_controller *c;
-
-	mutex_lock(&of_pci_msi_chip_mutex);
-	list_for_each_entry(c, &of_pci_msi_chip_list, list) {
-		if (c->of_node == of_node) {
-			mutex_unlock(&of_pci_msi_chip_mutex);
-			return c;
-		}
-	}
-	mutex_unlock(&of_pci_msi_chip_mutex);
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(of_pci_find_msi_chip_by_node);
-
-#endif /* CONFIG_PCI_MSI */
-
 /**
  * of_pci_map_rid - Translate a requester ID through a downstream mapping.
  * @np: root complex device node.
diff --git a/include/linux/of_pci.h b/include/linux/of_pci.h
index 7fd5cfc..77471bf 100644
--- a/include/linux/of_pci.h
+++ b/include/linux/of_pci.h
@@ -78,15 +78,4 @@ static inline int of_pci_get_host_bridge_resources(struct device_node *dev,
 }
 #endif
 
-#if defined(CONFIG_OF) && defined(CONFIG_PCI_MSI)
-int of_pci_msi_chip_add(struct msi_controller *chip);
-void of_pci_msi_chip_remove(struct msi_controller *chip);
-struct msi_controller *of_pci_find_msi_chip_by_node(struct device_node *of_node);
-#else
-static inline int of_pci_msi_chip_add(struct msi_controller *chip) { return -EINVAL; }
-static inline void of_pci_msi_chip_remove(struct msi_controller *chip) { }
-static inline struct msi_controller *
-of_pci_find_msi_chip_by_node(struct device_node *of_node) { return NULL; }
-#endif
-
 #endif
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
