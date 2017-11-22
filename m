Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39402 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdKVFcR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 00:32:17 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Tobias Klauser <tklauser@distanz.ch>,
        Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 16/30] pch_gbe: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 00:31:01 -0500
Message-Id: <1511328675-21981-17-git-send-email-okaya@codeaurora.org>
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
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 5ae9681..0df94ac 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2560,6 +2560,7 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 {
 	struct net_device *netdev;
 	struct pch_gbe_adapter *adapter;
+	int domainnr, busnr;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -2603,8 +2604,10 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 	if (adapter->pdata && adapter->pdata->platform_init)
 		adapter->pdata->platform_init(pdev);
 
-	adapter->ptp_pdev = pci_get_bus_and_slot(adapter->pdev->bus->number,
-					       PCI_DEVFN(12, 4));
+	domainnr = pci_domain_nr(adapter->pdev->bus);
+	busnr = adapter->pdev->bus->number
+	adapter->ptp_pdev = pci_get_domain_bus_and_slot(domainnr, busnr,
+							PCI_DEVFN(12, 4));
 
 	netdev->netdev_ops = &pch_gbe_netdev_ops;
 	netdev->watchdog_timeo = PCH_GBE_WATCHDOG_PERIOD;
-- 
1.9.1
