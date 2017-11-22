Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 15/29] pch_gbe: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:10 -0500
Message-Id: <1511390964-9979-16-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Use the domain information from pdev while calling into
pci_get_domain_bus_and_slot() function.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 5ae9681..4be7806 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2603,8 +2603,10 @@ static int pch_gbe_probe(struct pci_dev *pdev,
 	if (adapter->pdata && adapter->pdata->platform_init)
 		adapter->pdata->platform_init(pdev);
 
-	adapter->ptp_pdev = pci_get_bus_and_slot(adapter->pdev->bus->number,
-					       PCI_DEVFN(12, 4));
+	adapter->ptp_pdev =
+		pci_get_domain_bus_and_slot(pci_domain_nr(adapter->pdev->bus),
+					    adapter->pdev->bus->number,
+					    PCI_DEVFN(12, 4));
 
 	netdev->netdev_ops = &pch_gbe_netdev_ops;
 	netdev->watchdog_timeo = PCH_GBE_WATCHDOG_PERIOD;
-- 
1.9.1
