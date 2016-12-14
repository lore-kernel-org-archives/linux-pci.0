Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45589 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753518AbcLNSBi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Dec 2016 13:01:38 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBEHrtaT123593
        for <linux-pci@vger.kernel.org>; Wed, 14 Dec 2016 13:01:37 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27b5w1dvk0-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Wed, 14 Dec 2016 13:01:36 -0500
Received: from localhost
        by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gpiccoli@linux.vnet.ibm.com>;
        Wed, 14 Dec 2016 16:01:34 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc: gabriel@krisman.be, hch@lst.de, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, gpiccoli@linux.vnet.ibm.com,
        stable@vger.kernel.org.#.v4.9+
Subject: [PATCH] genirq/affinity: fix node generation from cpumask
Date: Wed, 14 Dec 2016 16:01:12 -0200
Message-Id: <1481738472-2671-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading
infrastructure") introduced a better IRQ spreading mechanism, taking
account of the available NUMA nodes in the machine.

Problem is that the algorithm of retrieving the nodemask iterates
"linearly" based on the number of online nodes - some architectures
present non-linear node distribution among the nodemask, like PowerPC.
If this is the case, the algorithm lead to a wrong node count number
and therefore to a bad/incomplete IRQ affinity distribution.

For example, this problem were found in a machine with 128 CPUs and two
nodes, namely nodes 0 and 8 (instead of 0 and 1, if it was linearly
distributed). This led to a wrong affinity distribution which then led to
a bad mq allocation for nvme driver.

Finally, we take the opportunity to fix a comment regarding the affinity
distribution when we have _more_ nodes than vectors.

Fixes: 34c3d9819fda ("genirq/affinity: Provide smarter irq spreading infrastructure")
Reported-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org # v4.9+
Cc: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org
---
 kernel/irq/affinity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 9be9bda..464eaf0 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -37,15 +37,15 @@ static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 
 static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
 {
-	int n, nodes;
+	int n, nodes = 0;
 
 	/* Calculate the number of nodes in the supplied affinity mask */
-	for (n = 0, nodes = 0; n < num_online_nodes(); n++) {
+	for_each_online_node(n)
 		if (cpumask_intersects(mask, cpumask_of_node(n))) {
 			node_set(n, *nodemsk);
 			nodes++;
 		}
-	}
+
 	return nodes;
 }
 
@@ -82,7 +82,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
 
 	/*
-	 * If the number of nodes in the mask is less than or equal the
+	 * If the number of nodes in the mask is greater than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
 	if (affv <= nodes) {
-- 
2.1.0

