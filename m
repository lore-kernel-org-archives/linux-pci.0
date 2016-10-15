Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com
Subject: [PATCH V3 3/3] ACPI,PCI,IRQ: correct SCI penalty calculation
Date: Sat, 15 Oct 2016 00:31:07 -0400
Message-Id: <1476505867-24599-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
References: <1476505867-24599-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, agross@codeaurora.org,
 linux-kernel@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, wim@djo.tudelft.nl,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

It seems like the problem is that we removed acpi_penalize_sci_irq(),
which told us the polarity and trigger mode.  We tried to get that
information via irq_get_trigger_type(), but that didn't work in this
case because we use the acpi_irq_get_penalty() path before the SCI is
registered.

To fix this problem, we only need to fix the penalty for the SCI interrupt.
It seems better to add a single "sci_penalty" variable, set it to
PIRQ_PENALTY_PCI_USING if it's level/low or PIRQ_PENALTY_ISA_ALWAYS
otherwise, and add "sci_penalty" in when appropriate.  That should fix it
for *any* SCI IRQ, not just those less than 256, and we don't have to add
these extra penalty table entries that are all unused (except possibly for
one entry if we have an SCI in the 16-255 range).

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 1934e2a..34bf527 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -87,6 +87,7 @@ struct acpi_pci_link {
 
 static LIST_HEAD(acpi_link_list);
 static DEFINE_MUTEX(acpi_link_lock);
+static int sci_irq = -1, sci_penalty;
 
 /* --------------------------------------------------------------------------
                             PCI Link Device Management
@@ -494,10 +495,15 @@ static int acpi_irq_pci_sharing_penalty(int irq)
 
 static int acpi_irq_get_penalty(int irq)
 {
+	int penalty = 0;
+
+	if (irq == sci_irq)
+		penalty += sci_penalty;
+
 	if (irq < ACPI_MAX_ISA_IRQS)
-		return acpi_isa_irq_penalty[irq];
+		return penalty + acpi_isa_irq_penalty[irq];
 
-	return acpi_irq_pci_sharing_penalty(irq);
+	return penalty + acpi_irq_pci_sharing_penalty(irq);
 }
 
 int __init acpi_irq_penalty_init(void)
@@ -870,13 +876,13 @@ bool acpi_isa_irq_available(int irq)
 
 void acpi_penalize_sci_irq(int irq, int trigger, int polarity)
 {
-	if (irq >= 0 && irq < ARRAY_SIZE(acpi_isa_irq_penalty)) {
-		if (trigger != ACPI_MADT_TRIGGER_LEVEL ||
-		    polarity != ACPI_MADT_POLARITY_ACTIVE_LOW)
-			acpi_isa_irq_penalty[irq] += PIRQ_PENALTY_ISA_ALWAYS;
-		else
-			acpi_isa_irq_penalty[irq] += PIRQ_PENALTY_PCI_USING;
-	}
+	sci_irq = irq;
+
+	if (trigger == ACPI_MADT_TRIGGER_LEVEL &&
+	    polarity == ACPI_MADT_POLARITY_ACTIVE_LOW)
+		sci_penalty = PIRQ_PENALTY_PCI_USING;
+	else
+		sci_penalty = PIRQ_PENALTY_ISA_ALWAYS;
 }
 
 /*
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
