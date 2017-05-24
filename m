Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 1/7] PCI: Move ATS declarations outside of CONFIG_PCI
Date: Wed, 24 May 2017 19:01:37 +0100
Message-Id: <20170524180143.19855-2-jean-philippe.brucker@arm.com>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com,
 joro@8bytes.org, thunder.leizhen@huawei.com, rjw@rjwysocki.net,
 okaya@codeaurora.org, robh+dt@kernel.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, robin.murphy@arm.com, lenb@kernel.org
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 33c2b0b77429..775d495ef8d7 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1415,19 +1415,6 @@ int  ht_create_irq(struct pci_dev *dev, int idx);
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
@@ -1613,6 +1600,19 @@ static inline int pci_get_new_domain_nr(void) { return -ENOSYS; }
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
2.12.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
