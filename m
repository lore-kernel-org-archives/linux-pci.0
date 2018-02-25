Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:51322 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751481AbeBYCvp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Feb 2018 21:51:45 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: Fix possible NULL pointer dereference for of_pci_bus_find_domain_nr
Date: Sun, 25 Feb 2018 10:46:02 +0800
Message-Id: <1519526762-136838-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pci_register_host_bridge records bus->domain_nr from
pci_bus_find_domain_nr but not guarantee not to pass a NULL
struct device *parent to it which could be explained by the hint
of checkcing for parent device before calling set_dev_node(),
just lines after that. So of_pci_bus_find_domain_nr wisely check
the parent pointer at the very beginning, but forgot to check it
again when trying to get of_node from parent, which could causes
a NULL pointer dereference. Fix it by dumping the NULL pointer
address simply, if no parent available.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index f6a4dd1..ef18c48 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5612,7 +5612,7 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 		domain = pci_get_new_domain_nr();
 	} else {
 		dev_err(parent, "Node %pOF has inconsistent \"linux,pci-domain\" property in DT\n",
-			parent->of_node);
+			parent ? parent->of_node : NULL);
 		domain = -1;
 	}
 
-- 
1.9.1
