Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54757 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcCCR3F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2016 12:29:05 -0500
Subject: Re: [PATCH V2] acpi, pci, irq: account for early penalty assignment
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1455801582-21595-1-git-send-email-okaya@codeaurora.org>
 <20160229192420.GC3653@localhost> <56D4A53A.1070708@codeaurora.org>
 <20160229223453.GA12162@localhost> <56D5E43E.7050406@codeaurora.org>
 <20160301194340.GA19783@localhost> <56D7317F.7090500@codeaurora.org>
 <56D7ABFB.3070302@codeaurora.org> <56D84EA9.3080900@codeaurora.org>
 <20160303151048.GA3290@localhost> <56D8546B.5040908@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, linux-pci@vger.kernel.org,
	ravikanth.nalla@hpe.com, lenb@kernel.org, harish.k@hpe.com,
	ashwin.reghunandanan@hpe.com, bhelgaas@google.com,
	rjw@rjwysocki.net, linux-kernel@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56D8745D.70509@codeaurora.org>
Date: Thu, 3 Mar 2016 12:29:01 -0500
MIME-Version: 1.0
In-Reply-To: <56D8546B.5040908@codeaurora.org>
Content-Type: multipart/mixed;
 boundary="------------040700060206040706070804"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040700060206040706070804
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 3/3/2016 10:12 AM, Sinan Kaya wrote:
> On 3/3/2016 10:10 AM, Bjorn Helgaas wrote:
>> That was my idea, but your minimal patch from last night looks awfully
>> attractive, and maybe it's not worth moving it to arch/x86.  I do think we
>> could simplify the code significantly by getting rid of the kzalloc and
>> acpi_irq_penalty_list from acpi_irq_set_penalty().  How about pushing on
>> that a little bit first, and see what it looks like then?
> 
> OK. Let me go that direction.
> 

How about this?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

--------------040700060206040706070804
Content-Type: text/plain; charset=UTF-8;
 name="0001-acpi-pci-irq-account-for-early-penalty-assignment.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-acpi-pci-irq-account-for-early-penalty-assignment.patch"

>From 6cc33747feb469fe4da2088f34e2c875a36f58f4 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Thu, 3 Mar 2016 10:14:22 -0500
Subject: [PATCH] acpi,pci,irq: account for early penalty assignment

---
 drivers/acpi/pci_link.c | 77 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index fa28635..09eea42 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -87,6 +87,7 @@ struct acpi_pci_link {

 static LIST_HEAD(acpi_link_list);
 static DEFINE_MUTEX(acpi_link_lock);
+static int sci_irq, sci_irq_penalty;

 /* --------------------------------------------------------------------------
                             PCI Link Device Management
@@ -466,56 +467,71 @@ static int acpi_irq_isa_penalty[ACPI_MAX_ISA_IRQ] = {
 	PIRQ_PENALTY_ISA_USED,		/* IRQ15 ide1 */
 };

-struct irq_penalty_info {
-	int irq;
-	int penalty;
-	struct list_head node;
-};
+static int acpi_irq_pci_sharing_penalty(int irq)
+{
+	struct acpi_pci_link *link;
+	int penalty = 0;
+	bool found = false;
+
+	list_for_each_entry(link, &acpi_link_list, list) {
+		/*
+		 * If a link is active, penalize its IRQ heavily
+		 * so we try to choose a different IRQ.
+		 */
+		if (link->irq.active && link->irq.active == irq) {
+			penalty += PIRQ_PENALTY_PCI_USING;
+			found = true;
+		} else {
+			int i;
+
+			/*
+			 * If a link is inactive, penalize the IRQs it
+			 * might, but not as severely.
+			 */
+			for (i = 0; i < link->irq.possible_count; i++) {
+				if (link->irq.possible[i] == irq) {
+					penalty += PIRQ_PENALTY_PCI_POSSIBLE /
+						link->irq.possible_count;
+					found = true;
+				}
+			}
+		}
+	}

-static LIST_HEAD(acpi_irq_penalty_list);
+	if (found)
+		return penalty;
+
+	return PIRQ_PENALTY_PCI_AVAILABLE;
+}

 static int acpi_irq_get_penalty(int irq)
 {
-	struct irq_penalty_info *irq_info;
-
 	if (irq < ACPI_MAX_ISA_IRQ)
 		return acpi_irq_isa_penalty[irq];

-	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
-		if (irq_info->irq == irq)
-			return irq_info->penalty;
-	}
+	if (irq == sci_irq)
+		return sci_irq_penalty;

-	return 0;
+	return acpi_irq_pci_sharing_penalty(irq);
 }

 static int acpi_irq_set_penalty(int irq, int new_penalty)
 {
-	struct irq_penalty_info *irq_info;
-
 	/* see if this is a ISA IRQ */
 	if (irq < ACPI_MAX_ISA_IRQ) {
 		acpi_irq_isa_penalty[irq] = new_penalty;
 		return 0;
 	}

-	/* next, try to locate from the dynamic list */
-	list_for_each_entry(irq_info, &acpi_irq_penalty_list, node) {
-		if (irq_info->irq == irq) {
-			irq_info->penalty  = new_penalty;
-			return 0;
-		}
+	if (irq == sci_irq) {
+		sci_irq_penalty = new_penalty;
+		return 0;
 	}

-	/* nope, let's allocate a slot for this IRQ */
-	irq_info = kzalloc(sizeof(*irq_info), GFP_KERNEL);
-	if (!irq_info)
-		return -ENOMEM;
-
-	irq_info->irq = irq;
-	irq_info->penalty = new_penalty;
-	list_add_tail(&irq_info->node, &acpi_irq_penalty_list);
-
+	/*
+	 * This is the remaining PCI IRQs. They are calculated on the
+	 * flight in acpi_irq_get_penalty function.
+	 */
 	return 0;
 }

@@ -900,6 +916,7 @@ void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
 	if (irq < 0)
 		return;

+	sci_irq = irq;
 	if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
 	    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
 		penalty = PIRQ_PENALTY_ISA_ALWAYS;
--
1.8.2.1


--------------040700060206040706070804--
