Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44005 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751301AbdLIXoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Dec 2017 18:44:02 -0500
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/3] r8169: remove netif_napi_del in probe error path
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <9eee5aba-a739-a609-fd65-76666f377ed1@gmail.com>
Message-ID: <9b78225d-f1dd-a078-aaa8-cddf2998855b@gmail.com>
Date: Sun, 10 Dec 2017 00:43:53 +0100
MIME-Version: 1.0
In-Reply-To: <9eee5aba-a739-a609-fd65-76666f377ed1@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

netif_napi_del is called implicitely by free_netdev, therefore we
don't have to do it explicitely.

When the probe error path is reached, the net_device isn't
registered yet. Therefore reordering the call to netif_napi_del
shouldn't cause any issues.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
index 3c7d90d3a..857f67beb 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -8672,14 +8672,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
 					    &tp->counters_phys_addr,
 					    GFP_KERNEL);
-	if (!tp->counters) {
-		rc = -ENOMEM;
-		goto err_out_msi_5;
-	}
+	if (!tp->counters)
+		return -ENOMEM;
 
 	rc = register_netdev(dev);
 	if (rc < 0)
-		goto err_out_msi_5;
+		return rc;
 
 	pci_set_drvdata(pdev, dev);
 
@@ -8709,11 +8707,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netif_carrier_off(dev);
 
 	return 0;
-
-err_out_msi_5:
-	netif_napi_del(&tp->napi);
-
-	return rc;
 }
 
 static struct pci_driver rtl8169_pci_driver = {
-- 
2.15.1
