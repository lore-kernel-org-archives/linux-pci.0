Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2nam01on0055.outbound.protection.outlook.com ([104.47.34.55]:30336
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753726AbdDQV0s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Apr 2017 17:26:48 -0400
From: Himanshu Madhani <himanshu.madhani@cavium.com>
To: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <hch@lst.de>
CC: <himanshu.madhani@cavium.com>
Subject: [PATCH] PCI/MSI: Only disable affinity settings if pre and post vector count is equal to max_vecs and not min_vecs
Date: Mon, 17 Apr 2017 14:26:25 -0700
Message-ID: <20170417212625.14309-1-himanshu.madhani@cavium.com>
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
This patch has been compile on linux-next tree 

commit f4fa27cbc0b6b9f3f41a8fbd771af3abbc480f13
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Apr 13 15:35:23 2017 +1000

    Add linux-next specific files for 20170413

    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Also has compiled on pci tree next branch with following commit

commit 9c5579a1a10f29c1491b38cfe8a16bf2d0a68aa1
Merge: 22e2495b76db b8e82c1bdd28
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed Apr 12 12:25:43 2017 -0500

    Merge branch 'pci/host-mvebu' into next

    * pci/host-mvebu:
      PCI: mvebu: Avoid changing the SCC bit in the Link Status register

 drivers/pci/msi.c         | 14 ++------------
 include/linux/interrupt.h |  2 +-
 kernel/irq/affinity.c     | 12 +++++++++++-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ba44fdfda66b..9e1569107cd6 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1058,7 +1058,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	for (;;) {
 		if (affd) {
-			nvec = irq_calc_affinity_vectors(nvec, affd);
+			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
@@ -1097,7 +1097,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affd) {
-			nvec = irq_calc_affinity_vectors(nvec, affd);
+			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
@@ -1165,16 +1165,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
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
index dc529116f7e6..e545e7a96270 100644
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
