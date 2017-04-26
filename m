Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-pci@vger.kernel.org
Subject: [RFC/RFT PATCH 11/18] PCI: Remove pci_scan_root_bus_msi()
Date: Wed, 26 Apr 2017 12:18:02 +0100
Message-Id: <20170426111809.19922-12-lorenzo.pieralisi@arm.com>
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

The pci_scan_root_bus_bridge() function allows passing a parameterized
struct pci_host_bridge and scanning the resulting PCI bus; since the
struct msi_controller is part of the struct pci_host_bridge and the
struct pci_host_bridge can now be passed to pci_scan_root_bus_bridge()
explicitly, there is no need for a scan interface with a MSI controller
parameter.

With all PCI host controller drivers and platform code relying
on pci_scan_root_bus_msi() converted over to pci_scan_root_bus_bridge()
the pci_scan_root_bus_msi() becomes obsolete and can be removed.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c | 27 +++++----------------------
 include/linux/pci.h |  4 ----
 2 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c7a7f72..de259f3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2311,9 +2311,8 @@ void __weak pcibios_remove_bus(struct pci_bus *bus)
 {
 }
 
-static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
-		int bus, struct pci_ops *ops, void *sysdata,
-		struct list_head *resources, struct msi_controller *msi)
+struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	int error;
 	struct pci_host_bridge *bridge;
@@ -2328,7 +2327,6 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	bridge->sysdata = sysdata;
 	bridge->busnr = bus;
 	bridge->ops = ops;
-	bridge->msi = msi;
 
 	error = pci_register_host_bridge(bridge);
 	if (error < 0)
@@ -2340,13 +2338,6 @@ static struct pci_bus *pci_create_root_bus_msi(struct device *parent,
 	kfree(bridge);
 	return NULL;
 }
-
-struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	return pci_create_root_bus_msi(parent, bus, ops, sysdata, resources,
-				       NULL);
-}
 EXPORT_SYMBOL_GPL(pci_create_root_bus);
 
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
@@ -2450,9 +2441,8 @@ int pci_scan_root_bus_bridge(struct pci_host_bridge *bridge)
 	return 0;
 }
 
-struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata,
-		struct list_head *resources, struct msi_controller *msi)
+struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
+		struct pci_ops *ops, void *sysdata, struct list_head *resources)
 {
 	struct resource_entry *window;
 	bool found = false;
@@ -2465,7 +2455,7 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 			break;
 		}
 
-	b = pci_create_root_bus_msi(parent, bus, ops, sysdata, resources, msi);
+	b = pci_create_root_bus(parent, bus, ops, sysdata, resources);
 	if (!b)
 		return NULL;
 
@@ -2483,13 +2473,6 @@ struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
 
 	return b;
 }
-
-struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
-		struct pci_ops *ops, void *sysdata, struct list_head *resources)
-{
-	return pci_scan_root_bus_msi(parent, bus, ops, sysdata, resources,
-				     NULL);
-}
 EXPORT_SYMBOL(pci_scan_root_bus);
 
 struct pci_bus *pci_scan_bus(int bus, struct pci_ops *ops,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 757779a..6aa0090 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -840,10 +840,6 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busmax);
 int pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
 void pci_bus_release_busn_res(struct pci_bus *b);
-struct pci_bus *pci_scan_root_bus_msi(struct device *parent, int bus,
-				      struct pci_ops *ops, void *sysdata,
-				      struct list_head *resources,
-				      struct msi_controller *msi);
 struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
 					     struct pci_ops *ops, void *sysdata,
 					     struct list_head *resources);
-- 
2.10.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
