Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:50502 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbESDbe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 23:31:34 -0400
From: Yijing Wang <wangyijing@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>,
	Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH v3 1/2] PCI: Fix NULL pointer when find parent pcie_link_state
Date: Tue, 19 May 2015 11:26:45 +0800
Message-ID: <1432006005-9758-1-git-send-email-wangyijing@huawei.com>
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

This patch fix this issue based on the following
assumption suggested by Bjorn.
1. Root port is always on the upstream end of a link.
2. The pcie hierarchy should alternate between links
and internal switch logic, there should be no adjacent
links or internal buses in pcie tree.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/pcie/aspm.c |    7 +++----
 drivers/pci/probe.c     |   12 ++++++++++++
 include/linux/pci.h     |    1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

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
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index a9c5e63..ad26ff2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -982,6 +982,18 @@ void set_pcie_port_type(struct pci_dev *pdev)
 	pdev->pcie_flags_reg = reg16;
 	pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
 	pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
+
+	/*
+	 * We assume root port is always on the upstream end of
+	 * a link, and the pcie hierarchy should alternate
+	 * between links and internal switch logic.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+		pdev->has_secondary_link = 1;
+
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM
+			&& !pdev->bus->self->has_secondary_link)
+		pdev->has_secondary_link = 1;
 }
 
 void set_pcie_hotplug_bridge(struct pci_dev *pdev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 50b7c7d..141fcc1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -355,6 +355,7 @@ struct pci_dev {
 	unsigned int	broken_intx_masking:1;
 	unsigned int	io_window_1k:1;	/* Intel P2P bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
+	unsigned int	has_secondary_link:1;
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
1.7.1

