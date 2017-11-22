Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdKVFcW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 00:32:22 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 19/30] PCI/quirks: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:31:04 -0500
Message-Id: <1511328675-21981-20-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 911b3b6..85a5308 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2699,7 +2699,7 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
 	 * HT MSI mapping should be disabled on devices that are below
 	 * a non-Hypertransport host bridge. Locate the host bridge...
 	 */
-	host_bridge = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
+	host_bridge = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
 	if (host_bridge == NULL) {
 		dev_warn(&dev->dev, "nv_msi_ht_cap_quirk didn't locate host bridge\n");
 		return;
-- 
1.9.1
