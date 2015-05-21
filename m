Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:4217 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937AbbEUHJc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2015 03:09:32 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v4 2/3] PCI/ASPM: Fix NULL pointer when find parent pcie_link_state
Date: Thu, 21 May 2015 15:05:03 +0800
Message-ID: <1432191904-16451-2-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1432191904-16451-1-git-send-email-wangyijing@huawei.com>
References: <1432191904-16451-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=94361 reported
in ATCA platform, system had unusual pcie topology:

(root port)   (downstream port)   (upstream port)
+-1c.0-[02-0a]----00.0-[03-0a]--+-00.0-[04]--
|                               +-01.0-[05]-- (downstream port)
|                               +-02.0-[06]--
|                               +-03.0-[07]--
|                               +-08.0-[08]--
|                               +-09.0-[09]--
|                               \-0a.0-[0a]--
We assumed root port and downstream port always
have external link, and downstream port always has a
upstream port. So in this case, when we allocated
pcie_link_state for downstream port 02:00.0, it try
to get parent bus pcie_link_state,
parent = pdev->bus->parent->self->link_state;
because root bus self is NULL, system will crash here.

Use pdev->has_secondary_link(introduced in previous patch)
to fix this issue.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aspm.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 7d4fcdc..8830740 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -561,8 +561,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
 
 	if (!pci_is_pcie(pdev) || pdev->link_state)
 		return;
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
-	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
+
+	if (!pdev->has_secondary_link)
 		return;
 
 	/* VIA has a strange chipset, root port is under a bridge */
@@ -723,8 +723,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem,
 	if (!pci_is_pcie(pdev))
 		return;
 
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)
+	if (pdev->has_secondary_link)
 		parent = pdev;
 	if (!parent || !parent->link_state)
 		return;
-- 
1.7.1

