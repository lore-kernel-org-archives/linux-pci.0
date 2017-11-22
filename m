Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbdKVWum (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Nov 2017 17:50:42 -0500
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org, timur@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org (open list:SPARC + UltraSPARC
        (sparc/sparc64)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 21/29] openprom: deprecate pci_get_bus_and_slot()
Date: Wed, 22 Nov 2017 17:49:16 -0500
Message-Id: <1511390964-9979-22-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
References: <1511390964-9979-1-git-send-email-okaya@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Hard-coding the domain as 0 since domain information is not available.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/sbus/char/openprom.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/sbus/char/openprom.c b/drivers/sbus/char/openprom.c
index 2c2e6a3..7b31f19 100644
--- a/drivers/sbus/char/openprom.c
+++ b/drivers/sbus/char/openprom.c
@@ -251,8 +251,9 @@ static int oprompci2node(void __user *argp, struct device_node *dp, struct openp
 		struct pci_dev *pdev;
 		struct device_node *dp;
 
-		pdev = pci_get_bus_and_slot (((int *) op->oprom_array)[0],
-				      ((int *) op->oprom_array)[1]);
+		pdev = pci_get_domain_bus_and_slot(0,
+						((int *) op->oprom_array)[0],
+						((int *) op->oprom_array)[1]);
 
 		dp = pci_device_to_OF_node(pdev);
 		data->current_node = dp;
-- 
1.9.1
