Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:43350 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758579AbeAIOoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jan 2018 09:44:25 -0500
Received: by mail-wm0-f67.google.com with SMTP id g1so3064451wmg.2
        for <linux-pci@vger.kernel.org>; Tue, 09 Jan 2018 06:44:25 -0800 (PST)
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com,
        niklas.cassel@axis.com,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI: dwc: fix enumeration end when reaching root subordinate
Date: Tue,  9 Jan 2018 15:42:21 +0100
Message-Id: <1515508941-20055-1-git-send-email-koen.vandeputte@ncentric.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The subordinate value indicates the highest bus number which can be
reached downstream though a certain device.

Commit a20c7f36bd3d ("PCI: Do not allocate more buses than available in
parent")
ensures that downstream devices cannot assign busnumbers higher than the
upstream device subordinate number, which was indeed illogical.

By default, dw_pcie_setup_rc() inits the Root Complex subordinate to a
value of 0x01.

Due to this combined with above commit, enumeration stops digging deeper
downstream as soon as bus num 0x01 has been assigned, which is always
the case for a bridge device.

This results in all devices behind a bridge bus to remain undetected, as
these would be connected to bus 0x02 or higher.

Fix this by initializing the RC to a subordinate value of 0xff, meaning
that all busses [0x00-0xff] are reachable through this RC.

Fixes: a20c7f36bd3d ("PCI: Do not allocate more buses than available in
parent")
Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
Tested-by: Niklas Cassel <niklas.cassel@axis.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---

Will send separate patches to stable as this file got moved/renamed


 drivers/pci/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index bf558df5b7b3..2b5470173196 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -616,7 +616,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 	/* setup bus numbers */
 	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
 	val &= 0xff000000;
-	val |= 0x00010100;
+	val |= 0x00ff0100;
 	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
 
 	/* setup command register */
-- 
2.7.4
