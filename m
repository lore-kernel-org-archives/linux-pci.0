Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbeCGGNl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 01:13:41 -0500
Subject: [PATCH v1 3/9] PCI/PM: Clear PCIe PME Status bit for Root Complex
 Event Collectors
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Lukas Wunner <lukas@wunner.de>
Date: Wed, 07 Mar 2018 00:13:40 -0600
Message-ID: <152040322027.240786.13965159319024774656.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152040297576.240786.1532465558381209070.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Per PCIe r4.0, sec 6.1.6, Root Complex Event Collectors can generate PME
interrupts on behalf of Root Complex Integrated Endpoints.

Linux does not currently enable PME interrupts from RC Event Collectors,
but fe31e69740ed ("PCI/PCIe: Clear Root PME Status bits early during system
resume") suggests PME interrupts may be enabled by the platform for ACPI-
based runtime wakeup.

Clear the PCIe PME Status bit for Root Complex Event Collectors during
resume, just like we already do for Root Ports.

If the BIOS enables PME interrupts for an event collector and neglects to
clear the status bit on resume, this change should fix the same bug as
fe31e69740ed (PMEs not working after waking from a sleep state), but for
Root Complex Integrated Endpoints.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-driver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index bf0704b75f79..38ee7c8b4d1a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -533,7 +533,8 @@ static void pcie_resume_early(struct pci_dev *pci_dev)
 	 * bits now just in case (shouldn't hurt).
 	 */
 	if (pci_is_pcie(pci_dev) &&
-	    pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT)
+	    (pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT ||
+	     pci_pcie_type(pci_dev) == PCI_EXP_TYPE_RC_EC))
 		pcie_clear_root_pme_status(pci_dev);
 }
 
