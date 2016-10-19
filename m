Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com
Subject: [PATCH V4 1/3] ACPI, PCI,
 IRQ: assign ISA IRQ directly during early boot stages
Date: Wed, 19 Oct 2016 18:21:02 -0400
Message-Id: <1476915664-27231-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
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

The penalty determination of ISA IRQ goes through 4 paths.
1. assign PCI_USING during power up via acpi_irq_penalty_init.
2. update the penalty with acpi_penalize_isa_irq function based on the
active parameter.
3. kernel command line penalty update via acpi_irq_penalty_update function.
4. increment the penalty as USING right after the IRQ is assign to PCI.

acpi_penalize_isa_irq and acpi_irq_penalty_update functions get called
before the ACPI subsystem is started.

These API need to bypass the acpi_irq_get_penalty function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..4f37938 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -849,7 +849,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 			continue;
 
 		if (used)
-			new_penalty = acpi_irq_get_penalty(irq) +
+			new_penalty = acpi_isa_irq_penalty[irq] +
 					PIRQ_PENALTY_ISA_USED;
 		else
 			new_penalty = 0;
@@ -871,7 +871,7 @@ static int __init acpi_irq_penalty_update(char *str, int used)
 void acpi_penalize_isa_irq(int irq, int active)
 {
 	if ((irq >= 0) && (irq < ARRAY_SIZE(acpi_isa_irq_penalty)))
-		acpi_isa_irq_penalty[irq] = acpi_irq_get_penalty(irq) +
+		acpi_isa_irq_penalty[irq] = acpi_isa_irq_penalty[irq] +
 		  (active ? PIRQ_PENALTY_ISA_USED : PIRQ_PENALTY_PCI_USING);
 }
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
