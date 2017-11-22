Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753475AbdKVWuZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 17:50:25 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 18/29] PCI/quirks: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:13 -0500
Message-Id: <1511390964-9979-19-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Extract the domain number from pdev while calling into
pci_get_domain_bus_and_slot() function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 911b3b6..4c46cc5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2699,7 +2699,8 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
 	 * HT MSI mapping should be disabled on devices that are below
 	 * a non-Hypertransport host bridge. Locate the host bridge...
 	 */
-	host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
+	host_bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
+						  PCI_DEVFN(0, 0));
 	if (host_bridge == NULL) {
 		dev_warn(&dev->dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
 		return;
-- 
1.9.1
