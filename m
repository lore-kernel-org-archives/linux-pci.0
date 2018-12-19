Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14952C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 10:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4AC20866
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 10:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeLSKxK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:53:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58323 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeLSKxK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Dec 2018 05:53:10 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gZZTM-0001og-HS; Wed, 19 Dec 2018 11:53:04 +0100
Date:   Wed, 19 Dec 2018 11:53:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dou Liyang <douliyangs@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com
Subject: Re: [PATCH 0/3] irq/core: Fix and expand the irq affinity
 descriptor
In-Reply-To: <20181204155122.6327-1-douliyangs@gmail.com>
Message-ID: <alpine.DEB.2.21.1812191136550.1651@nanos.tec.linutronix.de>
References: <20181204155122.6327-1-douliyangs@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 Dec 2018, Dou Liyang wrote:

> Now,  Spreading the interrupt affinity info by a cpumask pointer is not
> enough, meets a problem[1] and hard to expand in the future.
> 
> Fix it by:
> 
>      +-----------------------------------+
>      |                                   |
>      |     struct cpumask *affinity      |
>      |                                   |
>      +-----------------------------------+
>                        |
>     +------------------v-------------------+
>     |                                      |
>     | struct irq_affinity_desc {           |
>     |     struct cpumask   mask;           |
>     |     unsigned int     is_managed : 1; |
>     | };                                   |
>     |                                      |
>     +--------------------------------------+
> 

So, I've applied that lot for 4.21 (or whatever number it will be). That's
only the first step for solving Kashyap's problem.

IIRC, then Kashap wanted to get initial interrupt spreading for these extra
magic interrupts as well, but not have them marked managed.

That's trivial to do now with the two queued changes in that area:

  - The rework above
  
  - The support for interrupt sets from Jens

Just adding a small bitfield to struct irq_affinity which allows to tell
the core that a particular interrupt set is not managed does the trick.

Untested patch below.

Kashyap, is that what you were looking for and if so, does it work?

Thanks,

	tglx

8<-----------------

Subject: genirq/affinity: Add support for non-managed affinity sets
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 18 Dec 2018 16:46:47 +0100

Some drivers need an extra set of interrupts which are not marked managed,
but should get initial interrupt spreading.

Add a bitmap to struct irq_affinity which allows the driver to mark a
particular set of interrupts as non managed. Check the bitmap during
spreading and use the result to mark the interrupts in the sets
accordingly.

The unmanaged interrupts get initial spreading, but user space can change
their affinity later on.

Usage example:

      struct irq_affinity affd = { .pre_vectors	= 2 };
      int sets[2];

      /* Fill in sets[] */

      affd.nr_sets = 2;
      affd.sets = &sets;
      affd.unmanaged_sets = 0x02;

      ......

So both sets are properly spread out, but the second set is not marked
managed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |   10 ++++++----
 kernel/irq/affinity.c     |   24 ++++++++++++++----------
 2 files changed, 20 insertions(+), 14 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -99,7 +99,8 @@ static int __irq_build_affinity_masks(co
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
-				      struct irq_affinity_desc *masks)
+				      struct irq_affinity_desc *masks,
+				      bool managed)
 {
 	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	int last_affv = firstvec + numvecs;
@@ -154,6 +155,7 @@ static int __irq_build_affinity_masks(co
 			}
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
 						cpus_per_vec);
+			masks[curvec].is_managed = managed;
 		}
 
 		done += v;
@@ -176,7 +178,8 @@ static int __irq_build_affinity_masks(co
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs, int firstvec,
 				    cpumask_var_t *node_to_cpumask,
-				    struct irq_affinity_desc *masks)
+				    struct irq_affinity_desc *masks,
+				    bool managed)
 {
 	int curvec = startvec, nr_present, nr_others;
 	int ret = -ENOMEM;
@@ -196,7 +199,8 @@ static int irq_build_affinity_masks(cons
 	/* Spread on present CPUs starting from affd->pre_vectors */
 	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
 						firstvec, node_to_cpumask,
-						cpu_present_mask, nmsk, masks);
+						cpu_present_mask, nmsk, masks,
+						managed);
 
 	/*
 	 * Spread on non present CPUs starting from the next vector to be
@@ -211,7 +215,7 @@ static int irq_build_affinity_masks(cons
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
 	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
 					       firstvec, node_to_cpumask,
-					       npresmsk, nmsk, masks);
+					       npresmsk, nmsk, masks, managed);
 	put_online_cpus();
 
 	if (nr_present < numvecs)
@@ -268,10 +272,11 @@ irq_create_affinity_masks(int nvecs, con
 
 	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
 		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		bool managed = !test_bit(i, &affd->unmanaged_sets);
 		int ret;
 
-		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-						curvec, node_to_cpumask, masks);
+		ret = irq_build_affinity_masks(affd, curvec, this_vecs, curvec,
+					       node_to_cpumask, masks, managed);
 		if (ret) {
 			kfree(masks);
 			masks = NULL;
@@ -289,10 +294,6 @@ irq_create_affinity_masks(int nvecs, con
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
-	/* Mark the managed interrupts */
-	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
-		masks[i].is_managed = 1;
-
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
 	return masks;
@@ -316,6 +317,9 @@ int irq_calc_affinity_vectors(int minvec
 	if (affd->nr_sets) {
 		int i;
 
+		if (WARN_ON_ONCE(affd->nr_sets > BITS_PER_LONG))
+			return 0;
+
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
 			set_vecs += affd->sets[i];
 	} else {
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -249,12 +249,14 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @sets:		Number of affinitized sets
+ * @unmanaged_sets:	Bitmap to mark members of @sets as unmanaged
  */
 struct irq_affinity {
-	int	pre_vectors;
-	int	post_vectors;
-	int	nr_sets;
-	int	*sets;
+	int		pre_vectors;
+	int		post_vectors;
+	int		nr_sets;
+	int		*sets;
+	unsigned long	unmanaged_sets;
 };
 
 /**
