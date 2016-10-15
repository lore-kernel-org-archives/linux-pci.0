Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 ravikanth.nalla@hpe.com, linux@rainbow-software.org, timur@codeaurora.org,
 cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com
Subject: [PATCH V3 1/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
Date: Sat, 15 Oct 2016 00:31:05 -0400
Message-Id: <1476505867-24599-2-git-send-email-okaya@codeaurora.org>
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

The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed PCI_USING penalty from
acpi_pci_link_allocate function as there is no longer a fixed size penalty
array for both PCI interrupts greater than 16.

The array size has been reduced to 16 and array name got prefixed as ISA
since it only is accountable for the ISA interrupts.

The original change in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed penalty assignment in the code for PCI
thinking that we will add the penalty later in acpi_irq_pci_sharing_penalty
function.

However, this function only gets called if the IRQ number is greater than
16 and acpi_irq_get_penalty function gets called before ACPI start in
acpi_isa_irq_available and acpi_penalize_isa_irq functions. We can't rely
on iterating the link list.

We need to add the PCI_USING penalty for ISA interrupts too if the link is
in use and matches our ISA IRQ number.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index c983bf7..a212709 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -619,6 +619,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			    acpi_device_bid(link->device));
 		return -ENODEV;
 	} else {
+		if (link->irq.active < ACPI_MAX_ISA_IRQS)
+			acpi_isa_irq_penalty[link->irq.active] +=
+				PIRQ_PENALTY_PCI_USING;
+
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
