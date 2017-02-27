Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: 
Subject: [RFC PATCH 03/30] PCI: Move ATS declarations outside of CONFIG_PCI
Date: Mon, 27 Feb 2017 19:54:14 +0000
Message-Id: <20170227195441.5170-4-jean-philippe.brucker@arm.com>
In-Reply-To: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Currently ATS helpers like pci_enable_ats are only defined when CONFIG_PCI
is enabled. The ARM SMMU driver might get built with CONFIG_PCI disabled.
It would thus have to wrap any use of ATS helpers around #ifdef
CONFIG_PCI, which isn't ideal.

A nicer solution is to always define these helpers. Since CONFIG_PCI_ATS
is only enabled in association with CONFIG_PCI, move defines outside of
CONFIG_PCI to prevent build failure when PCI is disabled.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/linux/pci.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 282ed32244ce..e606f289bf5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1418,19 +1418,6 @@ int  ht_create_irq(struct pci_dev *dev, int idx);
 void ht_destroy_irq(unsigned int irq);
 #endif /* CONFIG_HT_IRQ */
 
-#ifdef CONFIG_PCI_ATS
-/* Address Translation Service */
-void pci_ats_init(struct pci_dev *dev);
-int pci_enable_ats(struct pci_dev *dev, int ps);
-void pci_disable_ats(struct pci_dev *dev);
-int pci_ats_queue_depth(struct pci_dev *dev);
-#else
-static inline void pci_ats_init(struct pci_dev *d) { }
-static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
-static inline void pci_disable_ats(struct pci_dev *d) { }
-static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
-#endif
-
 #ifdef CONFIG_PCIE_PTM
 int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
 #else
@@ -1616,6 +1603,19 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
 #define dev_is_pf(d) (false)
 #endif /* CONFIG_PCI */
 
+#ifdef CONFIG_PCI_ATS
+/* Address Translation Service */
+void pci_ats_init(struct pci_dev *dev);
+int pci_enable_ats(struct pci_dev *dev, int ps);
+void pci_disable_ats(struct pci_dev *dev);
+int pci_ats_queue_depth(struct pci_dev *dev);
+#else
+static inline void pci_ats_init(struct pci_dev *d) { }
+static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
+static inline void pci_disable_ats(struct pci_dev *d) { }
+static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
+#endif
+
 /* Include architecture-dependent settings and functions */
 
 #include <asm/pci.h>
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
