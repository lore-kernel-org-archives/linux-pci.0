Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org
Cc: linux-pci@vger.kernel.org, ravikanth.nalla@hpe.com,
	lenb@kernel.org, harish.k@hpe.com, ashwin.reghunandanan@hpe.com,
	bhelgaas@google.com, rjw@rjwysocki.net,
	Sinan Kaya <okaya@codeaurora.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Robert Moore <robert.moore@intel.com>,
	Lv Zheng <lv.zheng@intel.com>, linux-kernel@vger.kernel.org,
	devel@acpica.org
Subject: [PATCH V2 2/3] acpi,pci,irq: remove redundant code in acpi_irq_penalty_init
Date: Fri,  8 Apr 2016 21:26:31 -0400
Message-Id: <1460165192-4526-3-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1460165192-4526-1-git-send-email-okaya@codeaurora.org>
References: <1460165192-4526-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

acpi_irq_get_penalty is now calculating the penalty on the fly now.
No need to maintain global list of penalties or calculate them
at the init time. Removing duplicate code in acpi_irq_penalty_init.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 arch/x86/pci/acpi.c         |  1 -
 drivers/acpi/pci_link.c     | 36 ------------------------------------
 include/acpi/acpi_drivers.h |  1 -
 3 files changed, 38 deletions(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 3cd6983..b2a4e2a 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -396,7 +396,6 @@ int __init pci_acpi_init(void)
 		return -ENODEV;
 
 	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
-	acpi_irq_penalty_init();
 	pcibios_enable_irq = acpi_pci_irq_enable;
 	pcibios_disable_irq = acpi_pci_irq_disable;
 	x86_init.pci.init_irq = x86_init_noop;
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index 25695ea..63dae95 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -580,42 +580,6 @@ static int acpi_irq_get_penalty(int irq)
 	return penalty;
 }
 
-int __init acpi_irq_penalty_init(void)
-{
-	struct acpi_pci_link *link;
-	int i;
-
-	/*
-	 * Update penalties to facilitate IRQ balancing.
-	 */
-	list_for_each_entry(link, &acpi_link_list, list) {
-
-		/*
-		 * reflect the possible and active irqs in the penalty table --
-		 * useful for breaking ties.
-		 */
-		if (link->irq.possible_count) {
-			int penalty =
-			    PIRQ_PENALTY_PCI_POSSIBLE /
-			    link->irq.possible_count;
-
-			for (i = 0; i < link->irq.possible_count; i++) {
-				if (link->irq.possible[i] < ACPI_MAX_ISA_IRQ)
-					acpi_isa_irq_penalty[link->irq.
-							     possible[i]] +=
-					    penalty;
-			}
-
-		} else if (link->irq.active &&
-			   (link->irq.active < ACPI_MAX_ISA_IRQ)) {
-			acpi_isa_irq_penalty[link->irq.active] +=
-			    PIRQ_PENALTY_PCI_POSSIBLE;
-		}
-	}
-
-	return 0;
-}
-
 static int acpi_irq_balance = -1;	/* 0: static, 1: balance */
 
 static int acpi_pci_link_allocate(struct acpi_pci_link *link)
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index 29c6912..797ae2e 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -78,7 +78,6 @@
 
 /* ACPI PCI Interrupt Link (pci_link.c) */
 
-int acpi_irq_penalty_init(void);
 int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 			       int *polarity, char **name);
 int acpi_pci_link_free_irq(acpi_handle handle);
-- 
1.8.2.1

