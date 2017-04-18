Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam03on0051.outbound.protection.outlook.com ([104.47.42.51]:52960
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753775AbdDRBTq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Apr 2017 21:19:46 -0400
From: Himanshu Madhani <himanshu.madhani@cavium.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <hch@lst.de>
CC: <himanshu.madhani@cavium.com>
Subject: [PATCH] PCI/MSI: Only disable affinity settings if pre and post vector count is equal to max_vecs and not min_vecs
Date: Mon, 17 Apr 2017 18:19:25 -0700
Message-ID: <20170418011925.19173-1-himanshu.madhani@cavium.com>
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
v4 --> v5
o Fixed Zero day kernel build failure.

v3 --> v4
o Moved pre/post reserved vector range checks to affinity.c as per
  comments from Bjorn Helgaas.

v2 --> v3
o fixed code as per review comments.

v1 --> v2
o Moved the check from pci_alloc_irq_vectors_affinity() to
  __pci_enable_{msi|msix}_range()


 drivers/pci/msi.c         | 14 ++------------
 include/linux/interrupt.h |  4 ++--
 kernel/irq/affinity.c     | 12 +++++++++++-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index d571bc330686..8adf22f41cf9 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1072,7 +1072,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	for (;;) {
 		if (affd) {
-			nvec = irq_calc_affinity_vectors(nvec, affd);
+			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
@@ -1111,7 +1111,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affd) {
-			nvec = irq_calc_affinity_vectors(nvec, affd);
+			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
@@ -1179,16 +1179,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
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
index 53144e78a369..63b246dd8258 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -291,7 +291,7 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
-int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd);
+int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
 
@@ -331,7 +331,7 @@ irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
 }
 
 static inline int
-irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
+irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd)
 {
 	return maxvec;
 }
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index d052947fe785..59645fa66385 100644
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
@@ -143,12 +150,15 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
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
