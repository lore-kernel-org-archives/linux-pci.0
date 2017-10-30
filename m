Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4884 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932400AbdJ3LG2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2017 07:06:28 -0400
From: Vidya Sagar <vidyas@nvidia.com>
To: <treding@nvidia.com>, <bhelgaas@google.com>, <rajatja@google.com>,
        <yinghai@kernel.org>, <david.daney@cavium.com>,
        <Julia.Lawall@lip6.fr>
CC: <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>
Subject: [PATCH 1/4] PCI/ASPM: Add API to supply LTR L1.2 threshold
Date: Mon, 30 Oct 2017 16:33:02 +0530
Message-ID: <1509361385-21224-2-git-send-email-vidyas@nvidia.com>
In-Reply-To: <1509361385-21224-1-git-send-email-vidyas@nvidia.com>
References: <1509361385-21224-1-git-send-email-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

adds API for host controller drivers to specify LTR L1.2
threshold value if it is different from the default value.
weak implementation of the API is added to supply default
value

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pcie/aspm.c  | 11 ++++++++---
 include/linux/pci-aspm.h |  6 ++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 1dfa10cc566b..c6e8604796e5 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -436,6 +436,11 @@ static struct pci_dev *pci_function_0(struct pci_bus *linkbus)
 	return NULL;
 }
 
+u32 __weak pcie_aspm_get_ltr_l_1_2_threshold(void)
+{
+	return LTR_L1_2_THRESHOLD_BITS;
+}
+
 /* Calculate L1.2 PM substate timing parameters */
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				struct aspm_register_info *upreg,
@@ -458,10 +463,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	else
 		link->l1ss.ctl1 |= val2 << 8;
 	/*
-	 * We currently use LTR L1.2 threshold to be fixed constant picked from
-	 * Intel's coreboot.
+	 * Get LTR L1.2 threshold value specific to a platform if present
+	 * Otherwise, get a constant value picked from Intel's coreboot.
 	 */
-	link->l1ss.ctl1 |= LTR_L1_2_THRESHOLD_BITS;
+	link->l1ss.ctl1 |= pcie_aspm_get_ltr_l_1_2_threshold();
 
 	/* Choose the greater of the two T_pwr_on */
 	val1 = (upreg->l1ss_cap >> 19) & 0x1F;
diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
index 207c561fb40e..7ffde0f57688 100644
--- a/include/linux/pci-aspm.h
+++ b/include/linux/pci-aspm.h
@@ -30,6 +30,7 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 void pci_disable_link_state(struct pci_dev *pdev, int state);
 void pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
+u32 pcie_aspm_get_ltr_l_1_2_threshold(void);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev)
 {
@@ -49,6 +50,11 @@ static inline void pci_disable_link_state(struct pci_dev *pdev, int state)
 static inline void pcie_no_aspm(void)
 {
 }
+
+static inline u32 pcie_aspm_get_ltr_l_1_2_threshold(void)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCIEASPM_DEBUG /* this depends on CONFIG_PCIEASPM */
-- 
2.7.4
