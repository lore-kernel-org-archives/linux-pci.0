Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Bodo-Merle Sandor <esndbod@gmail.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH] PCI: iproc: Allow allocation of multiple MSIs
Date: Sat,  7 Oct 2017 14:08:44 +0200
Message-Id: <20171007120851.20230-1-sbodomerle@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 Bjorn Helgaas <bhelgaas@google.com>, Sandor Bodo-Merle <sbodomerle@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Sandor Bodo-Merle <sbodomerle@gmail.com>

Add support for allocating multiple MSIs at the same time, so that the
MSI_FLAG_MULTI_PCI_MSI flag can be added to the msi_domain_info
structure.

Avoid storing the hwirq in the low 5 bits of the message data, as it is
used by the device. Also fix an endianness problem by using readl().

Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
---
 drivers/pci/host/pcie-iproc-msi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc-msi.c b/drivers/pci/host/pcie-iproc-msi.c
index 2d0f535a2f69..990fc906d73d 100644
--- a/drivers/pci/host/pcie-iproc-msi.c
+++ b/drivers/pci/host/pcie-iproc-msi.c
@@ -179,7 +179,7 @@ static struct irq_chip iproc_msi_irq_chip = {
 
 static struct msi_domain_info iproc_msi_domain_info = {
 	.flags = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		MSI_FLAG_PCI_MSIX,
+		MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
 	.chip = &iproc_msi_irq_chip,
 };
 
@@ -237,7 +237,7 @@ static void iproc_msi_irq_compose_msi_msg(struct irq_data *data,
 	addr = msi->msi_addr + iproc_msi_addr_offset(msi, data->hwirq);
 	msg->address_lo = lower_32_bits(addr);
 	msg->address_hi = upper_32_bits(addr);
-	msg->data = data->hwirq;
+	msg->data = data->hwirq << 5;
 }
 
 static struct irq_chip iproc_msi_bottom_irq_chip = {
@@ -251,7 +251,7 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 				      void *args)
 {
 	struct iproc_msi *msi = domain->host_data;
-	int hwirq;
+	int hwirq, i;
 
 	mutex_lock(&msi->bitmap_lock);
 
@@ -267,10 +267,14 @@ static int iproc_msi_irq_domain_alloc(struct irq_domain *domain,
 
 	mutex_unlock(&msi->bitmap_lock);
 
-	irq_domain_set_info(domain, virq, hwirq, &iproc_msi_bottom_irq_chip,
-			    domain->host_data, handle_simple_irq, NULL, NULL);
+	for (i = 0; i < nr_irqs; i++) {
+		irq_domain_set_info(domain, virq + i, hwirq + i,
+				    &iproc_msi_bottom_irq_chip,
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
+	}
 
-	return 0;
+	return hwirq;
 }
 
 static void iproc_msi_irq_domain_free(struct irq_domain *domain,
@@ -302,7 +306,8 @@ static inline u32 decode_msi_hwirq(struct iproc_msi *msi, u32 eq, u32 head)
 
 	offs = iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
 	msg = (u32 *)(msi->eq_cpu + offs);
-	hwirq = *msg & IPROC_MSI_EQ_MASK;
+	hwirq = readl(msg);
+	hwirq = (hwirq >> 5) + (hwirq & 0x1f);
 
 	/*
 	 * Since we have multiple hwirq mapped to a single MSI vector,
-- 
2.15.0.rc0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
