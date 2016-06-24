Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
To: wim@djo.tudelft.nl
References: <2999417.fp4mqtxYS2@vostro.rjw.lan>
 <20160620212507.GA24086@localhost> <57686D67.8010201@codeaurora.org>
 <20160621124715.GB3528@djo.tudelft.nl> <576943BA.1000001@codeaurora.org>
 <20160621221347.GA28603@djo.tudelft.nl>
 <72eb7b76d449f906d9b2b1bb15d995bf@codeaurora.org>
 <20160623141234.GA14662@djo.tudelft.nl> <576BF86E.8060302@codeaurora.org>
 <576C042B.20507@codeaurora.org> <20160623232533.GA14984@djo.tudelft.nl>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f85fb7c7-53aa-3a1e-0635-bb245d08e804@codeaurora.org>
Date: Fri, 24 Jun 2016 02:09:15 -0400
MIME-Version: 1.0
In-Reply-To: <20160623232533.GA14984@djo.tudelft.nl>
Content-Type: multipart/mixed;
 boundary="------------A185EFCCD04DA26A1BD169FB"
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------A185EFCCD04DA26A1BD169FB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 6/23/2016 7:25 PM, Wim Osterholt wrote:
> On Thu, Jun 23, 2016 at 11:45:47AM -0400, Sinan Kaya wrote:
>>>
>>> Sure, let me get a patch for you.
>>
>> Here it is
> 
> http://webserver.djo.tudelft.nl/dmesg460+printpatch2
> 

Thanks, this was very helpful. I was able to fix the problem by using
the values in your log.

Can you give it a try?


> 
>> I am trying to find a system with similar characteristics for debug
> 
> All from the same laptop, Dell Inspiron 4100.
> The same problem arises at a Dell Inspiron 510m.
> I've not seen it on a workstation Dell XW4300.
> 
> 
> 
> Groeten, Wim.
> 
> 
> ----- wim@djo.tudelft.nl -----
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

--------------A185EFCCD04DA26A1BD169FB
Content-Type: text/plain; charset=UTF-8;
 name="0002-Revert-ACPI-PCI-IRQ-remove-redundant-code-in-acpi_ir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-Revert-ACPI-PCI-IRQ-remove-redundant-code-in-acpi_ir.pa";
 filename*1="tch"

>From 44dabd4b7413a4edee4b7399f95f6ce10c8bbd27 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 24 Jun 2016 01:04:05 -0400
Subject: [PATCH 2/4] Revert "ACPI,PCI,IRQ: remove redundant code in
 acpi_irq_penalty_init()"

Trying to make the ISA and PCI init functionality common turned out to be
a bad idea. ISA path depends on external functionality. Restoring the
previous behavior and limiting the refactoring to PCI interrupts only.

This reverts commit 1fcb6a813c4f ("ACPI,PCI,IRQ: remove redundant code in
acpi_irq_penalty_init()").

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/pci/acpi.c         |  1 +
 drivers/acpi/pci_link.c     | 36 ++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_drivers.h |  1 +
 3 files changed, 38 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index b2a4e2a..3cd6983 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -396,6 +396,7 @@ int __init pci_acpi_init(void)
 		return -ENODEV;
 
 	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
+	acpi_irq_penalty_init();
 	pcibios_enable_irq = acpi_pci_irq_enable;
 	pcibios_disable_irq = acpi_pci_irq_disable;
 	x86_init.pci.init_irq = x86_init_noop;
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index f2b69e3..714ba4d 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -517,6 +517,42 @@ static int acpi_irq_get_penalty(int irq)
 	return penalty;
 }
 
+int __init acpi_irq_penalty_init(void)
+{
+	struct acpi_pci_link *link;
+	int i;
+
+	/*
+	 * Update penalties to facilitate IRQ balancing.
+	 */
+	list_for_each_entry(link, &acpi_link_list, list) {
+
+		/*
+		 * reflect the possible and active irqs in the penalty table --
+		 * useful for breaking ties.
+		 */
+		if (link->irq.possible_count) {
+			int penalty =
+			    PIRQ_PENALTY_PCI_POSSIBLE /
+			    link->irq.possible_count;
+
+			for (i = 0; i < link->irq.possible_count; i++) {
+				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQS)
+					acpi_isa_irq_penalty[link->irq.
+							 possible[i]] +=
+					    penalty;
+			}
+
+		} else if (link->irq.active &&
+				(link->irq.active < ACPI_MAX_ISA_IRQS)) {
+			acpi_isa_irq_penalty[link->irq.active] +=
+			    PIRQ_PENALTY_PCI_POSSIBLE;
+		}
+	}
+
+	return 0;
+}
+
 static int acpi_irq_balance = -1;	/* 0: static, 1: balance */
 
 static int acpi_pci_link_allocate(struct acpi_pci_link *link)
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 797ae2e..29c6912 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -78,6 +78,7 @@
 
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
+int acpi_irq_penalty_init(void);
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 			       int *polarity, char **name);
 int acpi_pci_link_free_irq(acpi_handle handle);
-- 
1.8.2.1


--------------A185EFCCD04DA26A1BD169FB
Content-Type: text/plain; charset=UTF-8;
 name="0003-ACPI-PCI-IRQ-separate-ISA-penalty-calculation.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-ACPI-PCI-IRQ-separate-ISA-penalty-calculation.patch"

>From 81acb01ea4950d5f87c9f1b43f396f798d512b89 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 24 Jun 2016 01:31:04 -0400
Subject: [PATCH 3/4] ACPI,PCI,IRQ: separate ISA penalty calculation

Since commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
the penalty values are calculated on the fly rather than boot time.

This works fine for PCI interrupts but not so well for the ISA interrupts.
Whether an ISA interrupt is in use or not information is not available
inside the pci_link.c file. This information gets sent externally via
acpi_penalize_isa_irq function. If active is true, then the IRQ is in use
by ISA. Otherwise, IRQ is in use by PCI.

Since the current code relies on PCI Link object for determination of
penalties, we are factoring in the PCI penalty twice after
acpi_penalize_isa_irq function is called.

This change is limiting the newly added functionality to just PCI
interrupts so that old behavior is still maintained.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 714ba4d..c2f22c9 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -497,7 +497,7 @@ static int acpi_irq_get_penalty(int irq)
 	int penalty = 0;
 
 	if (irq < ACPI_MAX_ISA_IRQS)
-		penalty += acpi_isa_irq_penalty[irq];
+		return acpi_isa_irq_penalty[irq];
 
 	/*
 	* Penalize IRQ used by ACPI SCI. If ACPI SCI pin attributes conflict
-- 
1.8.2.1


--------------A185EFCCD04DA26A1BD169FB
Content-Type: text/plain; charset=UTF-8;
 name="0004-ACPI-PCI-IRQ-correct-operator-precedence.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0004-ACPI-PCI-IRQ-correct-operator-precedence.patch"

>From e45079330af06a0e697ed0c280d8e8c27100b5b7 Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 24 Jun 2016 01:31:44 -0400
Subject: [PATCH 4/4] ACPI,PCI,IRQ: correct operator precedence

The omitted parenthesis prevents the addition operation when
acpi_penalize_isa_irq function is called.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c2f22c9..fcd1267 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -872,7 +872,7 @@ void acpi_penalize_isa_irq(int irq, int active)
 {
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
 		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
-			active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING;
+		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
 
 bool acpi_isa_irq_available(int irq)
-- 
1.8.2.1


--------------A185EFCCD04DA26A1BD169FB
Content-Type: text/plain; charset=UTF-8;
 name="0001-ACPI-PCI-IRQ-factor-in-PCI-possible.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ACPI-PCI-IRQ-factor-in-PCI-possible.patch"

>From c78fa07940f71dfd907e20304df5c8ce7e36dafa Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Fri, 24 Jun 2016 01:27:54 -0400
Subject: [PATCH 1/4] ACPI,PCI,IRQ: factor in PCI possible

The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") omitted the initially assigned POSSIBLE penalty
when the IRQ is active.

The original code would assign the POSSIBLE value divided by the number
of possible IRQs during initialization.

Later, if the IRQ is chosen as the active IRQ or if the IRQ is in use
by ISA; additional penalties get added.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 8fc7323..f2b69e3 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -470,6 +470,7 @@ static int acpi_irq_pci_sharing_penalty(int irq)
 {
 	struct acpi_pci_link *link;
 	int penalty = 0;
+	int i;
 
 	list_for_each_entry(link, &acpi_link_list, list) {
 		/*
@@ -478,18 +479,14 @@ static int acpi_irq_pci_sharing_penalty(int irq)
 		 */
 		if (link->irq.active && link->irq.active == irq)
 			penalty += PIRQ_PENALTY_PCI_USING;
-		else {
-			int i;
-
-			/*
-			 * If a link is inactive, penalize the IRQs it
-			 * might use, but not as severely.
-			 */
-			for (i = 0; i < link->irq.possible_count; i++)
-				if (link->irq.possible[i] == irq)
-					penalty += PIRQ_PENALTY_PCI_POSSIBLE /
-						link->irq.possible_count;
-		}
+
+		/*
+		 * penalize the IRQs PCI might use, but not as severely.
+		 */
+		for (i = 0; i < link->irq.possible_count; i++)
+			if (link->irq.possible[i] == irq)
+				penalty += PIRQ_PENALTY_PCI_POSSIBLE /
+					link->irq.possible_count;
 	}
 
 	return penalty;
-- 
1.8.2.1


--------------A185EFCCD04DA26A1BD169FB--
