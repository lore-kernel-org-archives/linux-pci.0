Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34422 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab3KRJl3 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Nov 2013 04:41:29 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so754373pde.41
        for <linux-pci@vger.kernel.org>; Mon, 18 Nov 2013 01:41:29 -0800 (PST)
From: Adam Lee <adam.lee@canonical.com>
To: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pci: check PCI_EXP_FLAGS_SLOT before setting hotplug bridge
Date: Mon, 18 Nov 2013 17:40:52 +0800
Message-Id: <1384767652-20567-1-git-send-email-adam.lee@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds the PCI_EXP_FLAGS_SLOT check back before setting
hotplug bridge, which is omitted by an API switching commit,
59875ae489609b2267548dc85160c5f0f0c6f9d4 "PCI/core: Use PCI Express
Capability accessors".

Some Lenovo laptops hang in booting without this fix.

Signed-off-by: Adam Lee <adam.lee@canonical.com>
---
 drivers/pci/probe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5e14f5a..b93d5ac 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -992,8 +992,13 @@ void set_pcie_port_type(struct pci_dev *pdev)
 
 void set_pcie_hotplug_bridge(struct pci_dev *pdev)
 {
+	u16 reg16;
 	u32 reg32;
 
+	pcie_capability_read_word(pdev, PCI_EXP_FLAGS, &reg16);
+	if (!(reg16 & PCI_EXP_FLAGS_SLOT))
+		return;
+
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &reg32);
 	if (reg32 & PCI_EXP_SLTCAP_HPC)
 		pdev->is_hotplug_bridge = 1;
-- 
1.8.4.3

