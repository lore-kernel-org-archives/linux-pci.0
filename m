Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        ravikanth.nalla@hpe.com, linux@rainbow-software.org,
        timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com,
        alex.williamson@redhat.com
Cc: linux-pci@vger.kernel.org, agross@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
        Sinan Kaya <okaya@codeaurora.org>, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA interrupts
Date: Tue,  4 Oct 2016 17:15:18 -0400
Message-Id: <1475615720-31047-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
resource requirements") removed PCI_USING penalty from
acpi_pci_link_allocate function as there is no longer a fixed size penalty
array for both PCI and IRQ interrupts.

We need to add the PCI_USING penalty for ISA interrupts too if the link is
in use and matches our ISA IRQ number.

Tested-by: Jonathan Liu <net147@gmail.com>
Tested-by: Ondrej Zary <linux@rainbow-software.org>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/pci_link.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index f3792f4..06c2a11 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -620,6 +620,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
 			    acpi_device_bid(link->device));
 		return -ENODEV;
 	} else {
+		if (link->irq.active < ACPI_MAX_IRQS)
+			acpi_irq_penalty[link->irq.active] +=
+				PIRQ_PENALTY_PCI_USING;
+
 		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
 		       acpi_device_name(link->device),
 		       acpi_device_bid(link->device), link->irq.active);
-- 
1.9.1

