Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39817 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965095AbcHBMnK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 2 Aug 2016 08:43:10 -0400
From: Baole Ni <baolex.ni@intel.com>
To: bhelgaas@google.com, paulus@samba.org, mpe@ellerman.id.au,
	sbranden@broadcom.com, m.chehab@samsung.com, pawel@osciak.com,
	m.szyprowski@samsung.com, kyungmin.park@samsung.com,
	k.kozlowski@samsung.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	luto@kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
Subject: [PATCH 0827/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:50:16 +0800
Message-Id: <20160802115016.5112-1-baolex.ni@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/pci/pcie/aspm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 2dfe7fd..920df3f 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -814,7 +814,7 @@ static int pcie_aspm_get_policy(char *buffer, struct kernel_param *kp)
 }
 
 module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
-	NULL, 0644);
+	NULL, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 
 #ifdef CONFIG_PCIEASPM_DEBUG
 static ssize_t link_state_show(struct device *dev,
@@ -886,8 +886,8 @@ static ssize_t clk_ctl_store(struct device *dev,
 	return n;
 }
 
-static DEVICE_ATTR(link_state, 0644, link_state_show, link_state_store);
-static DEVICE_ATTR(clk_ctl, 0644, clk_ctl_show, clk_ctl_store);
+static DEVICE_ATTR(link_state, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, link_state_show, link_state_store);
+static DEVICE_ATTR(clk_ctl, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, clk_ctl_show, clk_ctl_store);
 
 static char power_group[] = "power";
 void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
-- 
2.9.2

