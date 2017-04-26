Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [RFC/RFT PATCH 04/18] ARM: PCI: bios32: Convert PCI scan API to
 pci_scan_root_bus_bridge()
Date: Wed, 26 Apr 2017 12:17:55 +0100
Message-Id: <20170426111809.19922-5-lorenzo.pieralisi@arm.com>
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>,
 Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, linux-arm-kernel@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Simon Horman <horms@verge.net.au>,
 Roy Zang <tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge).

Convert ARM bios32 code to pci_scan_root_bus_bridge() to improve
the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/kernel/bios32.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 2f0e077..e2095f5 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -473,7 +473,7 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 		ret = hw->setup(nr, sys);
 
 		if (ret > 0) {
-			struct pci_host_bridge *host_bridge;
+			struct pci_host_bridge *bridge;
 
 			ret = pcibios_init_resource(nr, sys, hw->io_optional);
 			if (ret)  {
@@ -483,10 +483,31 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 
 			if (hw->scan)
 				sys->bus = hw->scan(nr, sys);
-			else
-				sys->bus = pci_scan_root_bus_msi(parent,
-					sys->busnr, hw->ops, sys,
-					&sys->resources, hw->msi_ctrl);
+			else {
+				bridge = pci_alloc_host_bridge(0);
+				if (!bridge) {
+					kfree(sys);
+					break;
+				}
+
+				list_splice_init(&sys->resources,
+						 &bridge->windows);
+				bridge->dev.parent = parent;
+				bridge->sysdata = sys;
+				bridge->busnr = sys->busnr;
+				bridge->ops = hw->ops;
+				bridge->msi = hw->msi_ctrl;
+				bridge->align_resource =
+						hw->align_resource;
+
+				ret = pci_scan_root_bus_bridge(bridge);
+				if (ret < 0) {
+					pci_free_host_bridge(bridge);
+					break;
+				}
+
+				sys->bus = bridge->bus;
+			}
 
 			if (WARN(!sys->bus, "PCI: unable to scan bus!")) {
 				kfree(sys);
@@ -496,9 +517,6 @@ static void pcibios_init_hw(struct device *parent, struct hw_pci *hw,
 			busnr = sys->bus->busn_res.end + 1;
 
 			list_add(&sys->node, head);
-
-			host_bridge = pci_find_host_bridge(sys->bus);
-			host_bridge->align_resource = hw->align_resource;
 		} else {
 			kfree(sys);
 			if (ret < 0)
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
