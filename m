Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: iommu@lists.linux-foundation.org
Subject: [RFC PATCH v2 02/15] drivers: irqchip: its: fix its_acpi_probe()
 prototype
Date: Tue,  7 Jun 2016 14:30:57 +0100
Message-Id: <1465306270-27076-3-git-send-email-lorenzo.pieralisi@arm.com>
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Tomasz Nowicki <tn@semihalf.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
 Hanjun Guo <hanjun.guo@linaro.org>, Jon Masters <jcm@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The empty stub for its_acpi_probe() on !CONFIG_ACPI systems has
a wrong prototype, which causes compilation errors:

drivers/irqchip/irq-gic-v3-its.c: In function 'its_init':
drivers/irqchip/irq-gic-v3-its.c:1762:3: error: too few arguments to
function 'its_acpi_probe'
   its_acpi_probe();
   ^
drivers/irqchip/irq-gic-v3-its.c:1749:27: note: declared here
 static inline void __init its_acpi_probe(struct irq_domain
*parent_domain) { }

This patch fixes the prototype and the corresponding compilation
errors.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c8f36a5..1846800 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1700,7 +1700,7 @@ void __init its_acpi_probe(void)
 		pr_info("No valid GIC ITS entries exist\n");
 }
 #else
-static inline void __init its_acpi_probe(struct irq_domain *parent_domain) { }
+static inline void __init its_acpi_probe(void) { }
 #endif
 
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
