Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:6180 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbbIKAJj (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 20:09:39 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 03/12] kernel:irq: Allow for ranked matches on IRQ domains
Date: Fri, 11 Sep 2015 00:01:02 +0000
Message-Id: <1441929670-10058-4-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The existing IRQ domain match code cycles through all the IRQ domains looking
for the first one to return a non-zero value from its match() function.  There's
even a comment that says "this isn't a problem so far..."

This patch changes the semantics on the match() function so that the value
returned is a ranking, where zero means "no match."  The function now runs the
list of IRQ domains twice, finding the highest ranked matches on the first pass
and returning the first one of those (to preserve existing behavior, where there
might have been multiple matches) on the second pass.

This allows for a situation where a default IRQ domain (specifically the one
for message-signaled interrupts on x86 PCs) is always present, but where it can
be overriden by an IRQ domain implementation that is targeted at specific PCIe
root complexes.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 include/linux/irqdomain.h |  2 +-
 kernel/irq/irqdomain.c    | 44 ++++++++++++++++++++++++++++++--------------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 12acddb..2d48deb 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -62,7 +62,7 @@ enum irq_domain_bus_token {
 /**
  * struct irq_domain_ops - Methods for irq_domain objects
  * @match: Match an interrupt controller device node to a host, returns
- *         1 on a match
+ *         a ranking (non-zero) on a match
  * @map: Create or update a mapping between a virtual irq number and a hw
  *       irq number. This is called only once for a given mapping.
  * @unmap: Dispose of such a mapping
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index b4c15af..385c16e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -197,30 +197,46 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
 					  void *bus_data)
 {
 	struct irq_domain *h, *found = NULL;
-	int rc;
+	int match_rank = 0x7fffffff;
+	int found_rank = 0;
+	int rank;
+	int pass;
 
 	/* We might want to match the legacy controller last since
 	 * it might potentially be set to match all interrupts in
-	 * the absence of a device node. This isn't a problem so far
-	 * yet though...
+	 * the absence of a device node.  In this case, the match
+	 * of highest rank is returned.
 	 *
 	 * bus_token == DOMAIN_BUS_ANY matches any domain, any other
 	 * values must generate an exact match for the domain to be
 	 * selected.
 	 */
 	mutex_lock(&irq_domain_mutex);
-	list_for_each_entry(h, &irq_domain_list, link) {
-		if (h->ops->match)
-			rc = h->ops->match(h, node, bus_token, bus_data);
-		else
-			rc = ((h->of_node != NULL) && (h->of_node == node) &&
-			      ((bus_token == DOMAIN_BUS_ANY) ||
-			       (h->bus_token == bus_token)));
-
-		if (rc) {
-			found = h;
-			break;
+	for (pass = 0; pass < 2; pass++) {
+		list_for_each_entry(h, &irq_domain_list, link) {
+			if (h->ops->match)
+				rank = h->ops->match(h, node, bus_token,
+						     bus_data);
+			else
+				if ((h->of_node != NULL) &&
+				    (h->of_node == node) &&
+				    ((bus_token == DOMAIN_BUS_ANY) ||
+				       (h->bus_token == bus_token)))
+					rank = 1;
+				else
+					rank = 0;
+
+			if (rank > found_rank)
+				found_rank = rank;
+
+			if (found_rank == match_rank) {
+				found = h;
+				break;
+			}
 		}
+
+		if (found_rank != 0)
+			match_rank = found_rank;
 	}
 	mutex_unlock(&irq_domain_mutex);
 	return found;
-- 
1.9.1

