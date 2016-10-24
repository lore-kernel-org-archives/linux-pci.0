Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com
Cc: net147@gmail.com, linux-pci@vger.kernel.org, agross@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Sinan Kaya <okaya@codeaurora.org>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/3] ACPI: pci_link: Include PIRQ_PENALTY_PCI_USING for ISA IRQs
Date: Mon, 24 Oct 2016 00:31:32 -0400
Message-Id: <1477283492-26657-4-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
References: <1477283492-26657-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Commit 103544d86976 ("ACPI,PCI,IRQ: reduce resource requirements")
replaced the addition of PIRQ_PENALTY_PCI_USING in acpi_pci_link_allocate()
with an addition in acpi_irq_pci_sharing_penalty(), but f7eca374f000
("ACPI,PCI,IRQ: separate ISA penalty calculation") removed the use
of acpi_irq_pci_sharing_penalty() for ISA IRQs.

Therefore, PIRQ_PENALTY_PCI_USING is missing from ISA IRQs used by
interrupt links.  Include that penalty by adding it in the
acpi_pci_link_allocate() path.

Fixes: f7eca374f000 ("ACPI,PCI,IRQ: separate ISA penalty calculation")
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/pci_link.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 74bf96e..bc3d914 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -608,6 +608,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
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

