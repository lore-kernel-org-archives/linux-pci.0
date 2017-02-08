Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH v1 2/3] PCI: versatile: Configure PCIe MPS settings
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Date: Wed, 08 Feb 2017 16:09:02 -0600
Message-ID: <20170208220902.8352.12732.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170208215558.8352.90635.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208215558.8352.90635.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Michal Simek <michal.simek@xilinx.com>, Jon Mason <jon.mason@broadcom.com>,
 Ray Jui <ray.jui@broadcom.com>, linux-arm-kernel@lists.infradead.org,
 devel@linuxdriverproject.org, "K. Y. Srinivasan" <kys@microsoft.com>,
 =?utf-8?b?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Tanmay Inamdar <tinamdar@apm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Make sure PCIe MPS settings are valid when we enumerate a new hierarchy.

Based-on-patch-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-versatile.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index b7dc07002f13..5ebee7d37ff5 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -124,7 +124,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	int ret, i, myslot = -1;
 	u32 val;
 	void __iomem *local_pci_cfg_base;
-	struct pci_bus *bus;
+	struct pci_bus *bus, *child;
 	LIST_HEAD(pci_res);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -204,6 +204,8 @@ static int versatile_pci_probe(struct platform_device *pdev)
 
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_assign_unassigned_bus_resources(bus);
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 
 	return 0;


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
