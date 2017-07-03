Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:44734 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752970AbdGCJV2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2017 05:21:28 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        stable@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI: rockchip: fix wrong access of root port register
Date: Mon,  3 Jul 2017 17:21:02 +0800
Message-Id: <1499073662-241267-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Rockchip's RC has two banks of register for root port,
one is strictly compatible to the PCIe spec(normal bank), but
the other one could be used to change the RO bit of root port
register(privileged bank).

When probing the RC driver, we was using the privileged bank to
do some basic setup work as some RO bits of the root port register
is hw-inited to wrong value. But we didn't change to use the normal
bank when finishing to probe the driver. This could lead to a serious
problem when the PME code try to clear the PME status by writing
PCI_EXP_RTSTA_PME to the register of PCI_EXP_RTSTA. Per the PCIe 3.0
spec, section 7.8.14, PME status bit is RW1C. So the PME code is doing
the right thing to clear the PME status but we find the RC doesn't
clear it but actually setting it to one. So finally the system trap in
pcie_pme_work_fn as PCI_EXP_RTSTA_PME is true now forever. And this
issue could be reproduced by booting kernel with pci=nomsi.

To fix it, we should change to use the normal bank of root port register
for PCI core to visit root port.

Fixes: e77f847d ("PCI: rockchip: Add Rockchip PCIe controller support")
Cc: stable@vger.kernel.org
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/host/pcie-rockchip.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index eb070ab..5acf869 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -139,6 +139,7 @@
 		 PCIE_CORE_INT_CT | PCIE_CORE_INT_UTC | \
 		 PCIE_CORE_INT_MMVC)
 
+#define PCIE_RC_CONFIG_NORMAL_BASE	0x800000
 #define PCIE_RC_CONFIG_BASE		0xa00000
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
 #define   PCIE_RC_CONFIG_SCC_SHIFT		16
@@ -301,7 +302,9 @@ static int rockchip_pcie_valid_device(struct rockchip_pcie *rockchip,
 static int rockchip_pcie_rd_own_conf(struct rockchip_pcie *rockchip,
 				     int where, int size, u32 *val)
 {
-	void __iomem *addr = rockchip->apb_base + PCIE_RC_CONFIG_BASE + where;
+	void __iomem *addr;
+
+	addr = rockchip->apb_base + PCIE_RC_CONFIG_NORMAL_BASE + where;
 
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
 		*val = 0;
@@ -325,11 +328,13 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 				     int where, int size, u32 val)
 {
 	u32 mask, tmp, offset;
+	void __iomem *addr;
 
 	offset = where & ~0x3;
+	addr = rockchip->apb_base + PCIE_RC_CONFIG_NORMAL_BASE + offset;
 
 	if (size == 4) {
-		writel(val, rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset);
+		writel(val, addr);
 		return PCIBIOS_SUCCESSFUL;
 	}
 
@@ -340,9 +345,9 @@ static int rockchip_pcie_wr_own_conf(struct rockchip_pcie *rockchip,
 	 * corrupt RW1C bits in adjacent registers.  But the hardware
 	 * doesn't support smaller writes.
 	 */
-	tmp = readl(rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset) & mask;
+	tmp = readl(addr) & mask;
 	tmp |= val << ((where & 0x3) * 8);
-	writel(tmp, rockchip->apb_base + PCIE_RC_CONFIG_BASE + offset);
+	writel(tmp, addr);
 
 	return PCIBIOS_SUCCESSFUL;
 }
-- 
1.9.1
