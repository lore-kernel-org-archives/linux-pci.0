Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-co1nam03on0053.outbound.protection.outlook.com ([104.47.40.53]:43290
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752331AbdDFWpW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Apr 2017 18:45:22 -0400
From: Himanshu Madhani <himanshu.madhani@cavium.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <hch@lst.de>
CC: <himanshu.madhani@cavium.com>
Subject: [PATCH v4] PCI/MSI: Only disable affinity settings if pre and post vector count is equal to max_vecs and not min_vecs
Date: Thu, 6 Apr 2017 15:45:14 -0700
Message-ID: <20170406224514.21247-1-himanshu.madhani@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

min_vecs is the minimum amount of vectors needed to operate in MSI-X mode
which may just include the vectors that don't need affinity.

Disabling affinity settings causes the qla2xxx driver scsi_add_host
to fail when blk_mq is enabled as the blk_mq_pci_map_queues expects
affinity masks on each vector.

Fixes: dfef358bd1be ("PCI/MSI: Don't apply affinity if there aren't enough vectors left")
Signed-off-by: Michael Hernandez <michael.hernandez@cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: <stable@vger.kernel.org> # 4.10
---
v3 --> v4
o Moved pre/post reserved vector range checks to affinity.c as per
  comments from Bjorn Helgaas.

v2 --> v3
o fixed code as per review comments.

v1 --> v2
o Moved the check from pci_alloc_irq_vectors_affinity() to
  __pci_enable_{msi|msix}_range()

 drivers/pci/msi.c         | 14 ++------------
 include/linux/interrupt.h |  2 +-
 kernel/irq/affinity.c     | 12 +++++++++++-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 7f73bacf13ed..a5c13d052f18 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1091,7 +1091,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	for (;;) {
 		if (affd) {
-			nvec = irq_calc_affinity_vectors(nvec, affd);
+			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
@@ -1138,7 +1138,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affd) {
-			nvec = irq_calc_affinity_vectors(nvec, affd);
+			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
@@ -1206,16 +1206,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
 			affd = &msi_default_affd;
-
-		if (affd->pre_vectors + affd->post_vectors > min_vecs)
-			return -EINVAL;
-
-		/*
-		 * If there aren't any vectors left after applying the pre/post
-		 * vectors don't bother with assigning affinity.
-		 */
-		if (affd->pre_vectors + affd->post_vectors == min_vecs)
-			affd = NULL;
 	} else {
 		if (WARN_ON(affd))
 			affd = NULL;
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 53144e78a369..b3c569f7405b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -291,7 +291,7 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
-int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd);
+int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
 
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4544b115f5eb..13c15a419e4e 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -69,6 +69,13 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
+	/*
+	 * If there aren't any vectors left after applying the pre/post
+	 * vectors don't bother with assigning affinity.
+	 */
+	if (!affv)
+		return NULL;
+
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		goto out;
@@ -141,12 +148,15 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
  * @maxvec:	The maximum number of vectors available
  * @affd:	Description of the affinity requirements
  */
-int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
+int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
 {
 	int resv = affd->pre_vectors + affd->post_vectors;
 	int vecs = maxvec - resv;
 	int cpus;
 
+	if (resv > minvec)
+		return 0;
+
 	/* Stabilize the cpumasks */
 	get_online_cpus();
 	cpus = cpumask_weight(cpu_online_mask);
-- 
2.12.0
