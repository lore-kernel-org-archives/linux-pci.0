Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:46527 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028AbcGGXy4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jul 2016 19:54:56 -0400
From: Peter Wu <peter@lekensteyn.nl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI: export pci_bridge_d3_possible
Date: Fri,  8 Jul 2016 01:54:48 +0200
Message-Id: <20160707235448.2622-1-peter@lekensteyn.nl>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Allow the nouveau driver to find out whether the bridge can put itself
in the D3cold state or whether it should use a specific DSM method to
achieve the same result.

Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
Since it is not yet merged in Linus tree, maybe the patch in pci/pm can be
amended? This is the follow-up patch I had in mind for nouveau:

    --- a/drivers/gpu/drm/nouveau/nouveau_acpi.c
    +++ b/drivers/gpu/drm/nouveau/nouveau_acpi.c
    @@ -223,6 +223,9 @@ static bool nouveau_pr3_present(struct pci_dev *pdev)
     	if (!parent_pdev)
     		return false;
     
    +	if (!pci_bridge_d3_possible(parent_pdev))
    +		return false;
    +
     	parent_adev = ACPI_COMPANION(&parent_pdev->dev);
     	if (!parent_adev)
     		return false;

Related nouveau patches were sent a few minutes ago, titled "[PATCH v2 0/4]
nouveau RPM fixes for Optimus".
---
 drivers/pci/pci.c   | 3 ++-
 include/linux/pci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 9ff7183..714701b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2178,7 +2178,7 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  * This function checks if it is possible to move the bridge to D3.
  * Currently we only allow D3 for recent enough PCIe ports.
  */
-static bool pci_bridge_d3_possible(struct pci_dev *bridge)
+bool pci_bridge_d3_possible(struct pci_dev *bridge)
 {
 	unsigned int year;
 
@@ -2207,6 +2207,7 @@ static bool pci_bridge_d3_possible(struct pci_dev *bridge)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(pci_bridge_d3_possible);
 
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0a1a9e3..f19761d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1088,6 +1088,7 @@ int pci_back_from_sleep(struct pci_dev *dev);
 bool pci_dev_run_wake(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
+bool pci_bridge_d3_possible(struct pci_dev *bridge);
 void pci_d3cold_enable(struct pci_dev *dev);
 void pci_d3cold_disable(struct pci_dev *dev);
 
-- 
2.9.0

