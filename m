Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:58828 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbESDpP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 23:45:15 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH] PCI/ASPM: Remove redundant checking for pcie port type
Date: Tue, 19 May 2015 11:41:34 +0800
Message-ID: <1432006894-12203-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Only pcie root port or downstream port would allocate
a pcie_link_state when call alloc_pcie_link_state() in
pcie_aspm_init_link_state(). So when call another ASPM
functions to configure pcie_link_state, checking
pdev->link_state is enough, it's no need to check pcie
port type again in these functions.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aspm.c |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 8830740..16a1ffb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -675,10 +675,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
 
-	if (aspm_disabled || !pci_is_pcie(pdev) || !link)
-		return;
-	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
+	if (aspm_disabled || !link)
 		return;
 	/*
 	 * Devices changed PM state, we should recheck if latency
@@ -696,16 +693,12 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link = pdev->link_state;
 
-	if (aspm_disabled || !pci_is_pcie(pdev) || !link)
+	if (aspm_disabled || !link)
 		return;
 
 	if (aspm_policy != POLICY_POWERSAVE)
 		return;
 
-	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
-		return;
-
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	pcie_config_aspm_path(link);
@@ -906,9 +899,7 @@ void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
 
-	if (!pci_is_pcie(pdev) ||
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
-	     pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM) || !link_state)
+	if (!link_state)
 		return;
 
 	if (link_state->aspm_support)
@@ -923,9 +914,7 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
 {
 	struct pcie_link_state *link_state = pdev->link_state;
 
-	if (!pci_is_pcie(pdev) ||
-	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
-	     pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM) || !link_state)
+	if (!link_state)
 		return;
 
 	if (link_state->aspm_support)
-- 
1.7.1

