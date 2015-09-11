Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from o1.f.az.sendgrid.net ([208.117.55.132]:32963 "EHLO
	o1.f.az.sendgrid.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbIKAJn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 20:09:43 -0400
From: jakeo@microsoft.com
To: gregkh@linuxfoundation.org, kys@microsoft.com,
	linux-kernel@vger.kernel.org, devel@linuxdriverproject.org,
	olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
	linux-pci@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de
Cc: Jake Oshins <jakeo@microsoft.com>
Subject: [PATCH v2 01/12] kernel:irq:  Change signature of irq_domain_ops match() method, adding *bus_data
Date: Fri, 11 Sep 2015 00:01:00 +0000
Message-Id: <1441929670-10058-2-git-send-email-jakeo@microsoft.com>
In-Reply-To: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
References: <1441929670-10058-1-git-send-email-jakeo@microsoft.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Jake Oshins <jakeo@microsoft.com>

The current irq_domain_ops allows an IRQ domain to match on bus type, but not
a specific PCI bus heirarchy.  This patch introduces a bus_data parameter,
intended to allow a more specific match.  This patch does nothing more than 
introduce that parameter and change all the implementations' signatures.

Signed-off-by: Jake Oshins <jakeo@microsoft.com>
---
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   | 2 +-
 arch/powerpc/platforms/cell/interrupt.c          | 2 +-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 3 ++-
 arch/powerpc/platforms/powermac/pic.c            | 3 ++-
 arch/powerpc/platforms/powernv/opal-irqchip.c    | 2 +-
 arch/powerpc/platforms/ps3/interrupt.c           | 2 +-
 arch/powerpc/sysdev/ehv_pic.c                    | 3 ++-
 arch/powerpc/sysdev/i8259.c                      | 2 +-
 arch/powerpc/sysdev/ipic.c                       | 2 +-
 arch/powerpc/sysdev/mpic.c                       | 2 +-
 arch/powerpc/sysdev/qe_lib/qe_ic.c               | 2 +-
 arch/powerpc/sysdev/xics/xics-common.c           | 2 +-
 include/linux/irqdomain.h                        | 2 +-
 kernel/irq/irqdomain.c                           | 2 +-
 14 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index 11090ab..1d12a63 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -124,7 +124,7 @@ cpld_pic_cascade(unsigned int irq, struct irq_desc *desc)
 
 static int
 cpld_pic_host_match(struct irq_domain *h, struct device_node *node,
-		    enum irq_domain_bus_token bus_token)
+		    enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	return cpld_pic_node == node;
 }
diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index a15f1ef..3450bb8 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -223,7 +223,7 @@ void iic_request_IPIs(void)
 
 
 static int iic_host_match(struct irq_domain *h, struct device_node *node,
-			  enum irq_domain_bus_token bus_token)
+			  enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	return of_device_is_compatible(node,
 				    "IBM,CBEA-Internal-Interrupt-Controller");
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index b7866e0..1615990 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -109,7 +109,8 @@ static int flipper_pic_map(struct irq_domain *h, unsigned int virq,
 }
 
 static int flipper_pic_match(struct irq_domain *h, struct device_node *np,
-			     enum irq_domain_bus_token bus_token)
+			     enum irq_domain_bus_token bus_token,
+			     void *bus_data)
 {
 	return 1;
 }
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 6f4f8b0..035766a 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -269,7 +269,8 @@ static struct irqaction gatwick_cascade_action = {
 };
 
 static int pmac_pic_host_match(struct irq_domain *h, struct device_node *node,
-			       enum irq_domain_bus_token bus_token)
+			       enum irq_domain_bus_token bus_token,
+			       void *bus_data)
 {
 	/* We match all, we don't always have a node anyway */
 	return 1;
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index 2c91ee7..f83097e 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -135,7 +135,7 @@ static void opal_handle_irq_work(struct irq_work *work)
 }
 
 static int opal_event_match(struct irq_domain *h, struct device_node *node,
-			    enum irq_domain_bus_token bus_token)
+			    enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	return h->of_node == node;
 }
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 638c406..049fb23 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -679,7 +679,7 @@ static int ps3_host_map(struct irq_domain *h, unsigned int virq,
 }
 
 static int ps3_host_match(struct irq_domain *h, struct device_node *np,
-			  enum irq_domain_bus_token bus_token)
+			  enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	/* Match all */
 	return 1;
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index eca0b00..4d10a2c 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -178,7 +178,8 @@ unsigned int ehv_pic_get_irq(void)
 }
 
 static int ehv_pic_host_match(struct irq_domain *h, struct device_node *node,
-			      enum irq_domain_bus_token bus_token)
+			      enum irq_domain_bus_token bus_token,
+			      void *bus_data)
 {
 	/* Exact match, unless ehv_pic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index e1a9c2c..78360fe 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -163,7 +163,7 @@ static struct resource pic_edgectrl_iores = {
 };
 
 static int i8259_host_match(struct irq_domain *h, struct device_node *node,
-			    enum irq_domain_bus_token bus_token)
+			    enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	return h->of_node == NULL || h->of_node == node;
 }
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 6b2b689..93eca76 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -672,7 +672,7 @@ static struct irq_chip ipic_edge_irq_chip = {
 };
 
 static int ipic_host_match(struct irq_domain *h, struct device_node *node,
-			   enum irq_domain_bus_token bus_token)
+			   enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	/* Exact match, unless ipic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 97a8ae8..24be672 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1008,7 +1008,7 @@ static struct irq_chip mpic_irq_ht_chip = {
 
 
 static int mpic_host_match(struct irq_domain *h, struct device_node *node,
-			   enum irq_domain_bus_token bus_token)
+			   enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	/* Exact match, unless mpic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 47b352e..dadc286 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -245,7 +245,7 @@ static struct irq_chip qe_ic_irq_chip = {
 };
 
 static int qe_ic_host_match(struct irq_domain *h, struct device_node *node,
-			    enum irq_domain_bus_token bus_token)
+			    enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	/* Exact match, unless qe_ic node is NULL */
 	return h->of_node == NULL || h->of_node == node;
diff --git a/arch/powerpc/sysdev/xics/xics-common.c b/arch/powerpc/sysdev/xics/xics-common.c
index 47e43b7..fae4901 100644
--- a/arch/powerpc/sysdev/xics/xics-common.c
+++ b/arch/powerpc/sysdev/xics/xics-common.c
@@ -299,7 +299,7 @@ int xics_get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 #endif /* CONFIG_SMP */
 
 static int xics_host_match(struct irq_domain *h, struct device_node *node,
-			   enum irq_domain_bus_token bus_token)
+			   enum irq_domain_bus_token bus_token, void *bus_data)
 {
 	struct ics *ics;
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d3ca792..4d89f98 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -76,7 +76,7 @@ enum irq_domain_bus_token {
  */
 struct irq_domain_ops {
 	int (*match)(struct irq_domain *d, struct device_node *node,
-		     enum irq_domain_bus_token bus_token);
+		     enum irq_domain_bus_token bus_token, void *bus_data);
 	int (*map)(struct irq_domain *d, unsigned int virq, irq_hw_number_t hw);
 	void (*unmap)(struct irq_domain *d, unsigned int virq);
 	int (*xlate)(struct irq_domain *d, struct device_node *node,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 79baaf8..8a8ef31 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -209,7 +209,7 @@ struct irq_domain *irq_find_matching_host(struct device_node *node,
 	mutex_lock(&irq_domain_mutex);
 	list_for_each_entry(h, &irq_domain_list, link) {
 		if (h->ops->match)
-			rc = h->ops->match(h, node, bus_token);
+			rc = h->ops->match(h, node, bus_token, NULL);
 		else
 			rc = ((h->of_node != NULL) && (h->of_node == node) &&
 			      ((bus_token == DOMAIN_BUS_ANY) ||
-- 
1.9.1

