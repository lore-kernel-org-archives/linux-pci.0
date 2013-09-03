Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:32793 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab3ICCCm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2013 22:02:42 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, Yijing Wang <wangyijing@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] PCI: remove obsolete "is_pcie" from pci_dev structure
Date: Tue, 3 Sep 2013 10:02:09 +0800
Message-ID: <1378173729-20700-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

No one uses "is_pcie" now, remove this obsolete member.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/probe.c |    1 -
 include/linux/pci.h |    2 --
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index eeb50bd..70f6e75 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -983,7 +983,6 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pos = pci_find_capability(pdev, PCI_CAP_ID_EXP);
 	if (!pos)
 		return;
-	pdev->is_pcie = 1;
 	pdev->pcie_cap = pos;
 	pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
 	pdev->pcie_flags_reg = reg16;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 186540d..be06125 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -317,8 +317,6 @@ struct pci_dev {
 	unsigned int	msix_enabled:1;
 	unsigned int	ari_enabled:1;	/* ARI forwarding */
 	unsigned int	is_managed:1;
-	unsigned int	is_pcie:1;	/* Obsolete. Will be removed.
-					   Use pci_is_pcie() instead */
 	unsigned int    needs_freset:1; /* Dev requires fundamental reset */
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
-- 
1.7.1


