Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
To: Ondrej Zary <linux@rainbow-software.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609281032.35190.linux@rainbow-software.org>
 <b404278b-d8e1-2b16-e044-c30d27ba8c25@codeaurora.org>
 <201609281902.31500.linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <76303bb8-7ae2-9a6b-8e5d-a144ae7c6009@codeaurora.org>
Date: Wed, 28 Sep 2016 14:22:40 -0400
MIME-Version: 1.0
In-Reply-To: <201609281902.31500.linux@rainbow-software.org>
Content-Type: multipart/mixed;
 boundary="------------9D3701B128FA71C9F7B9780B"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------9D3701B128FA71C9F7B9780B
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

On 9/28/2016 1:02 PM, Ondrej Zary wrote:
>> Thanks, It sounds like you have more than one machine with similar
>> > problems. Can you collect the log from the other machines with 4.8-rc8?
>> >
>> > and also a boot log with 4.6 kernel where things are working?
> The attached logs are from another machine:
> 
> dmesg-bad-debug.txt: 4.8-rc8 with your debug patch - bad
> 
> dmesg-reverted.txt: 4.8-rc8 with patches (as per Rafael's suggestion) 
> reverted - good
> 
> dmesg-3.6.txt: 4.6 (Debian kernel) - good

I think I see a race condition for the SCI interrupt. I need another dump from
4.8-rc8 with the attached patch to confirm. Let's remove the previous one and
apply this one.



-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.

--------------9D3701B128FA71C9F7B9780B
Content-Type: text/plain; charset=UTF-8;
 name="0001-acpi-pci_link-debug-aids-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-acpi-pci_link-debug-aids-v2.patch"

>From 3545aba9f138bd233264c151d8c32cd417bfb09f Mon Sep 17 00:00:00 2001
From: Sinan Kaya <okaya@codeaurora.org>
Date: Tue, 27 Sep 2016 18:35:15 -0400
Subject: [PATCH] acpi: pci_link: debug aids v2

Change-Id: I6c459cb5888d95f5f1ef7c0e2f138fb9c65f40e5
---
 drivers/acpi/pci_link.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..92a6506 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -508,6 +508,8 @@ static int acpi_irq_get_penalty(int irq)
 			penalty += PIRQ_PENALTY_ISA_ALWAYS;
 		else
 			penalty += PIRQ_PENALTY_PCI_USING;
+
+		pr_info("%s:%d adding SCI penalty: 0x%x \n", __func__, __LINE__, penalty);
 	}
 
 	if (irq < ACPI_MAX_ISA_IRQS)
@@ -592,6 +594,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 	else
 		irq = link->irq.possible[link->irq.possible_count - 1];
 
+	pr_info("irq : %d\n", irq);
+	pr_info("acpi_irq_balance : %d\n", acpi_irq_balance);
+	pr_info("link->irq.active : %d\n", link->irq.active);
+	pr_info("acpi_gbl_FADT.sci_interrupt : %d\n", acpi_gbl_FADT.sci_interrupt);
 	if (acpi_irq_balance || !link->irq.active) {
 		/*
 		 * Select the best IRQ.  This is done in reverse to promote
@@ -599,11 +605,22 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 		 */
 		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
 			if (acpi_irq_get_penalty(irq) >
-			    acpi_irq_get_penalty(link->irq.possible[i]))
+			    acpi_irq_get_penalty(link->irq.possible[i])) {
+				pr_info("acpi_irq_get_penalty(%d) : 0x%x\n", link->irq.possible[i], acpi_irq_get_penalty(link->irq.possible[i]));
+				pr_info("acpi_irq_get_penalty(%d) : 0x%x\n", irq, acpi_irq_get_penalty(irq));
 				irq = link->irq.possible[i];
+			    }
 		}
 	}
 	if (acpi_irq_get_penalty(irq) >= PIRQ_PENALTY_ISA_ALWAYS) {
+		for (i = (link->irq.possible_count - 1); i >= 0; i--) {
+			pr_info("penalty[%d] = 0x%x\n",
+					link->irq.possible[i],
+			    acpi_irq_get_penalty(link->irq.possible[i]));
+		}
+		pr_info("irq : %d\n", irq);
+		pr_info("acpi_gbl_FADT.sci_interrupt : %d\n", acpi_gbl_FADT.sci_interrupt);
+
 		printk(KERN_ERR PREFIX "No IRQ available for %s [%s]. "
 			    "Try pci=noacpi or acpi=off\n",
 			    acpi_device_name(link->device),
@@ -870,9 +887,12 @@ static int __init acpi_irq_penalty_update(char *str, int used)
  */
 void acpi_penalize_isa_irq(int irq, int active)
 {
-	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
+	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty))) {
 		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
 		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
+		pr_info("%s:%d acpi_isa_irq_penalty[%d]=0x%x active = %d\n", __func__,
+				__LINE__, irq,  acpi_irq_get_penalty(irq), active);
+	}
 }
 
 bool acpi_isa_irq_available(int irq)
-- 
1.9.1


--------------9D3701B128FA71C9F7B9780B--
