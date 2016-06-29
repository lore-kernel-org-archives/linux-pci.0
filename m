Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51254 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbcF2I2E (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2016 04:28:04 -0400
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-acpi@vger.kernel.org, timur@codeaurora.org,
	cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com,
	eric.auger@redhat.com
Cc: linux-pci@vger.kernel.org, agross@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, wim@djo.tudelft.nl,
	perex@perex.cz, tiwai@suse.com, Sinan Kaya <okaya@codeaurora.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] ACPI,PCI,IRQ: factor in PCI possible
Date: Wed, 29 Jun 2016 04:27:35 -0400
Message-Id: <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

