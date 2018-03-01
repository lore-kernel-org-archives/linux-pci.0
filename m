Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:59496 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752427AbeCABRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Feb 2018 20:17:17 -0500
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] PCI: Fix possible NULL pointer dereference for of_pci_bus_find_domain_nr
Date: Thu,  1 Mar 2018 09:11:25 +0800
Message-Id: <1519866685-26271-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If the "parent" pointer passed to of_pci_bus_find_domain_nr() is NULL,
don't dereference it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- Convert to use pr_err and only print valid device node if 'parent'
isn't NULL.

 drivers/pci/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ae654e2..06f7f9d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5607,8 +5607,9 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 		use_dt_domains = 0;
 		domain = pci_get_new_domain_nr();
 	} else {
-		dev_err(parent, "Node %pOF has inconsistent \"linux,pci-domain\" property in DT\n",
-			parent->of_node);
+		if (parent)
+			pr_err("Node %pOF has ", parent->of_node)
+		pr_err("Inconsistent \"linux,pci-domain\" property in DT\n");
 		domain = -1;
 	}
 
-- 
1.9.1
