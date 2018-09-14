Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mta-01.yadro.com ([89.207.88.251]:60238 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbeINVgo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Sep 2018 17:36:44 -0400
From: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To: <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 4/4] PCI: Fix writing invalid BARs during pci_restore_state()
Date: Fri, 14 Sep 2018 19:14:04 +0300
Message-ID: <20180914161404.4685-5-s.miroshnichenko@yadro.com>
In-Reply-To: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
References: <20180914161404.4685-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If BAR movement has happened (due to PCIe hotplug) after pci_save_state(),
the saved addresses will become outdated. Restore them the most recently
calculated values, not the ones stored in an arbitrary moment.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5f07a59b5924..154130959443 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1328,7 +1328,7 @@ static void pci_restore_config_space(struct pci_dev *pdev)
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
 		pci_restore_config_space_range(pdev, 10, 15, 0);
 		/* Restore BARs before the command register. */
-		pci_restore_config_space_range(pdev, 4, 9, 10);
+		pci_restore_bars(pdev);
 		pci_restore_config_space_range(pdev, 0, 3, 0);
 	} else {
 		pci_restore_config_space_range(pdev, 0, 15, 0);
-- 
2.17.1
