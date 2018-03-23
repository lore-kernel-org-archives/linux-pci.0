Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:57618 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbeCWHyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2018 03:54:54 -0400
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] PCI: rockchip: Fix compile errors and warnings
Date: Fri, 23 Mar 2018 15:47:59 +0800
Message-Id: <1521791279-148357-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

pcie-rockchip.c uses devm_pci_remap_cfg_resource which should
depends on CONFIG_PCI. And as we could allow to build the host
driver as a module, we should export the function. This patch
also make rockchip_pcie_{prog, clear}_ep_ob_atu static.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Fixes: 52f3757afc06 ("PCI: rockchip: Create individual folder for rockchip drivers");
Fixes: 7257f9f50c02 ("PCI: rockchip: Add Endpoint controller driver for Rockchip PCIe controller")
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/pci/rockchip/Kconfig            |  1 +
 drivers/pci/rockchip/pcie-rockchip-ep.c | 10 ++++++----
 drivers/pci/rockchip/pcie-rockchip.c    |  7 +++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/rockchip/Kconfig b/drivers/pci/rockchip/Kconfig
index 668f850..f4ac165 100644
--- a/drivers/pci/rockchip/Kconfig
+++ b/drivers/pci/rockchip/Kconfig
@@ -4,6 +4,7 @@ menu "Rockchip PCIe controllers support"
 
 config PCIE_ROCKCHIP
 	bool
+	depends on PCI
 
 config PCIE_ROCKCHIP_HOST
 	tristate "Rockchip PCIe host controller"
diff --git a/drivers/pci/rockchip/pcie-rockchip-ep.c b/drivers/pci/rockchip/pcie-rockchip-ep.c
index 01997ce..8aa31a3 100644
--- a/drivers/pci/rockchip/pcie-rockchip-ep.c
+++ b/drivers/pci/rockchip/pcie-rockchip-ep.c
@@ -49,7 +49,8 @@ struct rockchip_pcie_ep {
 	u8			irq_pending;
 };
 
-void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip, u32 region)
+static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
+					  u32 region)
 {
 	rockchip_pcie_write(rockchip, 0,
 			    ROCKCHIP_PCIE_AT_OB_REGION_PCI_ADDR0(region));
@@ -65,9 +66,10 @@ void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip, u32 region)
 			    ROCKCHIP_PCIE_AT_OB_REGION_CPU_ADDR1(region));
 }
 
-void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
-				  u32 r, u32 type, u64 cpu_addr, u64 pci_addr,
-				  size_t size)
+static void rockchip_pcie_prog_ep_ob_atu(struct rockchip_pcie *rockchip, u8 fn,
+					 u32 r, u32 type, u64 cpu_addr,
+					 u64 pci_addr,
+					 size_t size)
 {
 	u64 sz = 1ULL << fls64(size - 1);
 	int num_pass_bits = ilog2(sz);
diff --git a/drivers/pci/rockchip/pcie-rockchip.c b/drivers/pci/rockchip/pcie-rockchip.c
index 9071178..9025a81 100644
--- a/drivers/pci/rockchip/pcie-rockchip.c
+++ b/drivers/pci/rockchip/pcie-rockchip.c
@@ -151,6 +151,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
 
 int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 {
@@ -291,6 +292,7 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 		phy_exit(rockchip->phys[i]);
 	return err;
 }
+EXPORT_SYMBOL_GPL(rockchip_pcie_init_port);
 
 int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 {
@@ -332,6 +334,7 @@ int rockchip_pcie_get_phys(struct rockchip_pcie *rockchip)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(rockchip_pcie_get_phys);
 
 void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
 {
@@ -344,6 +347,7 @@ void rockchip_pcie_deinit_phys(struct rockchip_pcie *rockchip)
 		phy_exit(rockchip->phys[i]);
 	}
 }
+EXPORT_SYMBOL_GPL(rockchip_pcie_deinit_phys);
 
 int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 {
@@ -384,6 +388,7 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
 	clk_disable_unprepare(rockchip->aclk_pcie);
 	return err;
 }
+EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
 
 void rockchip_pcie_disable_clocks(void *data)
 {
@@ -394,6 +399,7 @@ void rockchip_pcie_disable_clocks(void *data)
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
 	clk_disable_unprepare(rockchip->aclk_pcie);
 }
+EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
 
 void rockchip_pcie_cfg_configuration_accesses(
 		struct rockchip_pcie *rockchip, u32 type)
@@ -414,3 +420,4 @@ void rockchip_pcie_cfg_configuration_accesses(
 	rockchip_pcie_write(rockchip, ob_desc_0, PCIE_CORE_OB_REGION_DESC0);
 	rockchip_pcie_write(rockchip, 0x0, PCIE_CORE_OB_REGION_DESC1);
 }
+EXPORT_SYMBOL_GPL(rockchip_pcie_cfg_configuration_accesses);
-- 
1.9.1
