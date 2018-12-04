Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CA8C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57FD2081C
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfsJ8gzm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D57FD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLDPwH (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:52:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37412 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeLDPwG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 10:52:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so8421213pfb.4;
        Tue, 04 Dec 2018 07:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ycjN0XZKSqKeo48kxtJsjHK53d+rsTlTqVtiUeLajJk=;
        b=MfsJ8gzmNAs6Z5K4uxx18QM1y1qYdeCQCDYYpC3YQ2FPd3xE3nkB4Wrmd8OrEZalBt
         Mw4EG3dDgJBfgJfcIzdBr96J+0EPEtws64SZMUYgOh+87GeTESh+sAlvoNeeAfIOuFar
         j+r+JKpzK509XzFcZ11c9RLBc7ZNX7Z/2fIXIjsdXaJDunUFPC8oqCvpLSNU5F2gkCpJ
         fzIAtunHvSSyCZ8RoajnDwf0w9aE7HWd3HjAUWuhuLy3U8+dZCMsmZKdnD/IYLpRJt6E
         ad9vA668Od/J0HtNXB0XPy5EJ3zMwiJ0Gpt4hqa/eKfGMnQLo0xe2jjugrm+anjgYGQF
         d1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ycjN0XZKSqKeo48kxtJsjHK53d+rsTlTqVtiUeLajJk=;
        b=UbmDHRCB8Hm37RWvnxzzBb2t6TX9JBFVgSV5XPa619JPPMBRj95QZfhB/Cep7vqImH
         crqi+iPVWW8N5H5LcCC7yDut6v+JnfDYVUvVODcHfMigOHA/Q2lJ+waPfdZqBvYo3xz4
         3/iM9Y8KpeF5OONWGA/Ab6UqKXoAxwA/lN0X4qOkEGQtd0vQg4z10fsZmO0/855LVoyl
         ob8fNJLmU2MunJFpdtLz9tEEI7+e8pFghuKJN4i0L68ri5+Gg++//sZX1i+dnE23CXTr
         0qS4D6Cb7BqVqW+qYLfQbny7YcZgHHzlS+EdjdyJc7IaORlH3wBzmCPHGkOUpPtTgJXY
         ji2A==
X-Gm-Message-State: AA+aEWaNX+uSdW/PbzozK5sI7aACQU60SJmTd5vZn2YeQZ3Y//Hs00lb
        xPCWrnkIc6fdU4wECaboyUC3CfRTwPo=
X-Google-Smtp-Source: AFSGD/Vwc0QZobHZ/bPb73hTLpx3VR7b5cttXuiFIKDFVZwwsesQg4w4aqZp3k+sxGiReM/bxui5zA==
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr17531989pgf.302.1543938725208;
        Tue, 04 Dec 2018 07:52:05 -0800 (PST)
Received: from localhost.localdomain ([104.238.160.83])
        by smtp.gmail.com with ESMTPSA id u78sm40653444pfi.2.2018.12.04.07.51.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 07:52:04 -0800 (PST)
From:   Dou Liyang <douliyangs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     tglx@linutronix.de, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, sumit.saxena@broadcom.com,
        ming.lei@redhat.com, hch@lst.de, bhelgaas@google.com,
        douliyang1@huawei.com, Dou Liyang <douliyangs@gmail.com>
Subject: [PATCH 1/3] genirq/core: Add a new interrupt affinity descriptor
Date:   Tue,  4 Dec 2018 23:51:20 +0800
Message-Id: <20181204155122.6327-2-douliyangs@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181204155122.6327-1-douliyangs@gmail.com>
References: <20181204155122.6327-1-douliyangs@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now, Linux just spreads the interrupt affinity info by a cpumask pointer
and mark it as managed interrupt if its cpumask is not NULL.

if there are some other info should be passed, this design is not good
to expand, adding new arguments is the most staightforward method, But
this will break many functions.

So, add a new interrupt affinity descriptor, replace the cpumask pointer
with its pointer which allows to expand this in the future without touching
all the functions ever again, Just modify the data irq_affinity_desc
structure.

No functional change, just prepares for support of spreading managed
flags.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Dou Liyang <douliyangs@gmail.com>
---
 drivers/pci/msi.c         |  9 ++++-----
 include/linux/interrupt.h | 14 ++++++++++++--
 include/linux/irq.h       |  6 ++++--
 include/linux/irqdomain.h |  6 ++++--
 include/linux/msi.h       |  4 ++--
 kernel/irq/affinity.c     | 22 ++++++++++++----------
 kernel/irq/devres.c       |  4 ++--
 kernel/irq/irqdesc.c      | 16 ++++++++++------
 kernel/irq/irqdomain.c    |  4 ++--
 kernel/irq/msi.c          |  7 ++++---
 10 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 265ed3e4c920..7a1c8a09efa5 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -534,14 +534,13 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 static struct msi_desc *
 msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
 {
-	struct cpumask *masks = NULL;
+	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
 	u16 control;
 
 	if (affd)
 		masks = irq_create_affinity_masks(nvec, affd);
 
-
 	/* MSI Entry Initialization */
 	entry = alloc_msi_entry(&dev->dev, nvec, masks);
 	if (!entry)
@@ -672,7 +671,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
 			      const struct irq_affinity *affd)
 {
-	struct cpumask *curmsk, *masks = NULL;
+	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
 	int ret, i;
 
@@ -1264,7 +1263,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 
 		for_each_pci_msi_entry(entry, dev) {
 			if (i == nr)
-				return entry->affinity;
+				return &entry->affinity->mask;
 			i++;
 		}
 		WARN_ON_ONCE(1);
@@ -1276,7 +1275,7 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 				 nr >= entry->nvec_used))
 			return NULL;
 
-		return &entry->affinity[nr];
+		return &entry->affinity[nr].mask;
 	} else {
 		return cpu_possible_mask;
 	}
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ca397ff40836..71be303231e9 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -257,6 +257,14 @@ struct irq_affinity {
 	int	*sets;
 };
 
+/**
+ * struct irq_affinity_desc - Interrupt affinity descriptor
+ * @mask:	It's one cpumask per descriptor.
+ */
+struct irq_affinity_desc {
+	struct cpumask	mask;
+};
+
 #if defined(CONFIG_SMP)
 
 extern cpumask_var_t irq_default_affinity;
@@ -303,7 +311,9 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
-struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+struct irq_affinity_desc *
+irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+
 int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
@@ -337,7 +347,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	return 0;
 }
 
-static inline struct cpumask *
+static inline struct irq_affinity_desc *
 irq_create_affinity_masks(int nvec, const struct irq_affinity *affd)
 {
 	return NULL;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index c9bffda04a45..def2b2aac8b1 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -27,6 +27,7 @@
 struct seq_file;
 struct module;
 struct msi_msg;
+struct irq_affinity_desc;
 enum irqchip_irq_state;
 
 /*
@@ -834,11 +835,12 @@ struct cpumask *irq_data_get_effective_affinity_mask(struct irq_data *d)
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		      struct module *owner, const struct cpumask *affinity);
+		      struct module *owner,
+		      const struct irq_affinity_desc *affinity);
 
 int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
-			   const struct cpumask *affinity);
+			   const struct irq_affinity_desc *affinity);
 
 /* use macros to avoid needing export.h for THIS_MODULE */
 #define irq_alloc_descs(irq, from, cnt, node)	\
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 068aa46f0d55..35965f41d7be 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -43,6 +43,7 @@ struct irq_chip;
 struct irq_data;
 struct cpumask;
 struct seq_file;
+struct irq_affinity_desc;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -266,7 +267,7 @@ extern bool irq_domain_check_msi_remap(void);
 extern void irq_set_default_host(struct irq_domain *host);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 				  irq_hw_number_t hwirq, int node,
-				  const struct cpumask *affinity);
+				  const struct irq_affinity_desc *affinity);
 
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 {
@@ -449,7 +450,8 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 
 extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 				   unsigned int nr_irqs, int node, void *arg,
-				   bool realloc, const struct cpumask *affinity);
+				   bool realloc,
+				   const struct irq_affinity_desc *affinity);
 extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 0e9c50052ff3..7ba4c230181c 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -76,7 +76,7 @@ struct msi_desc {
 	unsigned int			nvec_used;
 	struct device			*dev;
 	struct msi_msg			msg;
-	struct cpumask			*affinity;
+	struct irq_affinity_desc	*affinity;
 
 	union {
 		/* PCI MSI/X specific data */
@@ -136,7 +136,7 @@ static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
 #endif /* CONFIG_PCI_MSI */
 
 struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
-				 const struct cpumask *affinity);
+				 const struct irq_affinity_desc *affinity);
 void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 08c904eb7279..1562a36e7c0f 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -99,7 +99,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 				    cpumask_var_t *node_to_cpumask,
 				    const struct cpumask *cpu_mask,
 				    struct cpumask *nmsk,
-				    struct cpumask *masks)
+				    struct irq_affinity_desc *masks)
 {
 	int n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	int last_affv = firstvec + numvecs;
@@ -117,7 +117,9 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(masks + curvec, masks + curvec, node_to_cpumask[n]);
+			cpumask_or(&masks[curvec].mask,
+					&masks[curvec].mask,
+					node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				curvec = firstvec;
 		}
@@ -150,7 +152,8 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 				cpus_per_vec++;
 				--extra_vecs;
 			}
-			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
+			irq_spread_init_one(&masks[curvec].mask, nmsk,
+						cpus_per_vec);
 		}
 
 		done += v;
@@ -173,7 +176,7 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs, int firstvec,
 				    cpumask_var_t *node_to_cpumask,
-				    struct cpumask *masks)
+				    struct irq_affinity_desc *masks)
 {
 	int curvec = startvec, nr_present, nr_others;
 	int ret = -ENOMEM;
@@ -226,15 +229,15 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
  * @nvecs:	The total number of vectors
  * @affd:	Description of the affinity requirements
  *
- * Returns the masks pointer or NULL if allocation failed.
+ * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
-struct cpumask *
+struct irq_affinity_desc *
 irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
 	cpumask_var_t *node_to_cpumask;
-	struct cpumask *masks = NULL;
+	struct irq_affinity_desc *masks = NULL;
 	int i, nr_sets;
 
 	/*
@@ -254,8 +257,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
-
+		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 	/*
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
@@ -285,7 +287,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	else
 		curvec = affd->pre_vectors + usedvecs;
 	for (; curvec < nvecs; curvec++)
-		cpumask_copy(masks + curvec, irq_default_affinity);
+		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
 outnodemsk:
 	free_node_to_cpumask(node_to_cpumask);
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index 6a682c229e10..5d5378ea0afe 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -169,7 +169,7 @@ static void devm_irq_desc_release(struct device *dev, void *res)
  * @cnt:	Number of consecutive irqs to allocate
  * @node:	Preferred node on which the irq descriptor should be allocated
  * @owner:	Owning module (can be NULL)
- * @affinity:	Optional pointer to an affinity mask array of size @cnt
+ * @affinity:	Optional pointer to an irq_affinity_desc array of size @cnt
  *		which hints where the irq descriptors should be allocated
  *		and which default affinities to use
  *
@@ -179,7 +179,7 @@ static void devm_irq_desc_release(struct device *dev, void *res)
  */
 int __devm_irq_alloc_descs(struct device *dev, int irq, unsigned int from,
 			   unsigned int cnt, int node, struct module *owner,
-			   const struct cpumask *affinity)
+			   const struct irq_affinity_desc *affinity)
 {
 	struct irq_desc_devres *dr;
 	int base;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 578d0e5f1b5b..f87fa2b9935a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -449,8 +449,10 @@ static void free_desc(unsigned int irq)
 }
 
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
-		       const struct cpumask *affinity, struct module *owner)
+		       const struct irq_affinity_desc *affinity,
+		       struct module *owner)
 {
+	const struct irq_affinity_desc *cur_affinity= affinity;
 	const struct cpumask *mask = NULL;
 	struct irq_desc *desc;
 	unsigned int flags;
@@ -458,9 +460,11 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 
 	/* Validate affinity mask(s) */
 	if (affinity) {
-		for (i = 0, mask = affinity; i < cnt; i++, mask++) {
+		for (i = 0; i < cnt; i++) {
+			mask = &cur_affinity->mask;
 			if (cpumask_empty(mask))
 				return -EINVAL;
+			cur_affinity++;
 		}
 	}
 
@@ -469,8 +473,8 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 
 	for (i = 0; i < cnt; i++) {
 		if (affinity) {
-			node = cpu_to_node(cpumask_first(affinity));
-			mask = affinity;
+			mask = &affinity->mask;
+			node = cpu_to_node(cpumask_first(mask));
 			affinity++;
 		}
 		desc = alloc_desc(start + i, node, flags, mask, owner);
@@ -575,7 +579,7 @@ static void free_desc(unsigned int irq)
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
-			      const struct cpumask *affinity,
+			      const struct irq_affinity_desc *affinity,
 			      struct module *owner)
 {
 	u32 i;
@@ -705,7 +709,7 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  */
 int __ref
 __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner, const struct cpumask *affinity)
+		  struct module *owner, const struct irq_affinity_desc *affinity)
 {
 	int start, ret;
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3366d11c3e02..8b0be4bd6565 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -969,7 +969,7 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
 int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
-			   int node, const struct cpumask *affinity)
+			   int node, const struct irq_affinity_desc *affinity)
 {
 	unsigned int hint;
 
@@ -1281,7 +1281,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
  */
 int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    unsigned int nr_irqs, int node, void *arg,
-			    bool realloc, const struct cpumask *affinity)
+			    bool realloc, const struct irq_affinity_desc *affinity)
 {
 	int i, ret, virq;
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4ca2fd46645d..36b7f92fcff0 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -23,11 +23,12 @@
  * @nvec:	The number of vectors used in this entry
  * @affinity:	Optional pointer to an affinity mask array size of @nvec
  *
- * If @affinity is not NULL then a an affinity array[@nvec] is allocated
- * and the affinity masks from @affinity are copied.
+ * If @affinity is not NULL then an affinity array[@nvec] is allocated
+ * and the affinity masks and flags from @affinity are copied.
  */
 struct msi_desc *
-alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
+alloc_msi_entry(struct device *dev, int nvec,
+		const struct irq_affinity_desc *affinity)
 {
 	struct msi_desc *desc;
 
-- 
2.17.2

