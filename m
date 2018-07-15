Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: [PATCH 1/8] PCI: xgene: Fix I/O space page leak
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
Message-ID: <e217754c-6488-4d2e-510c-6984cc5fc375@cogentembedded.com>
Date: Sun, 15 Jul 2018 19:03:51 +0300
MIME-Version: 1.0
In-Reply-To: <3e862a05-084a-d732-3060-6e2b234e9718@cogentembedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When testing the R-Car PCIe driver on the Condor board,  I noticed that if
I left  the PCIe PHY driver disabled, the kernel crashed with this BUG:

[    1.225819] kernel BUG at lib/ioremap.c:72!
[    1.230007] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    1.235496] Modules linked in:
[    1.238561] CPU: 0 PID: 39 Comm: kworker/0:1 Not tainted 4.17.0-dirty #1092
[    1.245526] Hardware name: Renesas Condor board based on r8a77980 (DT)
[    1.252075] Workqueue: events deferred_probe_work_func
[    1.257220] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    1.262024] pc : ioremap_page_range+0x370/0x3c8
[    1.266558] lr : ioremap_page_range+0x40/0x3c8
[    1.271002] sp : ffff000008da39e0
[    1.274317] x29: ffff000008da39e0 x28: 00e8000000000f07
[    1.279636] x27: ffff7dfffee00000 x26: 0140000000000000
[    1.284954] x25: ffff7dfffef00000 x24: 00000000000fe100
[    1.290272] x23: ffff80007b906000 x22: ffff000008ab8000
[    1.295590] x21: ffff000008bb1d58 x20: ffff7dfffef00000
[    1.300909] x19: ffff800009c30fb8 x18: 0000000000000001
[    1.306226] x17: 00000000000152d0 x16: 00000000014012d0
[    1.311544] x15: 0000000000000000 x14: 0720072007200720
[    1.316862] x13: 0720072007200720 x12: 0720072007200720
[    1.322180] x11: 0720072007300730 x10: 00000000000000ae
[    1.327498] x9 : 0000000000000000 x8 : ffff7dffff000000                      
[    1.332816] x7 : 0000000000000000 x6 : 0000000000000100
[    1.338134] x5 : 0000000000000000 x4 : 000000007b906000
[    1.343452] x3 : ffff80007c61a880 x2 : ffff7dfffeefffff
[    1.348770] x1 : 0000000040000000 x0 : 00e80000fe100f07
[    1.354090] Process kworker/0:1 (pid: 39, stack limit = 0x        (ptrval))  
[    1.361056] Call trace:
[    1.363504]  ioremap_page_range+0x370/0x3c8
[    1.367695]  pci_remap_iospace+0x7c/0xac
[    1.371624]  pci_parse_request_of_pci_ranges+0x13c/0x190
[    1.376945]  rcar_pcie_probe+0x4c/0xb04
[    1.380786]  platform_drv_probe+0x50/0xbc
[    1.384799]  driver_probe_device+0x21c/0x308
[    1.389072]  __device_attach_driver+0x98/0xc8
[    1.393431]  bus_for_each_drv+0x54/0x94
[    1.397269]  __device_attach+0xc4/0x12c
[    1.401107]  device_initial_probe+0x10/0x18
[    1.405292]  bus_probe_device+0x90/0x98
[    1.409130]  deferred_probe_work_func+0xb0/0x150
[    1.413756]  process_one_work+0x12c/0x29c
[    1.417768]  worker_thread+0x200/0x3fc
[    1.421522]  kthread+0x108/0x134
[    1.424755]  ret_from_fork+0x10/0x18
[    1.428334] Code: f9004ba2 54000080 aa0003fb 17ffff48 (d4210000)

It turned out that pci_remap_iospace() wasn't undone when the driver's
probe failed, and since devm_phy_optional_get() returned -EPROBE_DEFER,
the probe was retried,  finally causing the BUG due to trying to remap
already remapped pages.

The most feasible solution seemed to introduce devm_pci_remap_iospace()
and call it instead of pci_remap_iospace(), so that the pages get unmapped
automagically on any probe failure.

Looking at the PCI drivers having the same issue, the XGene driver turned
out  to be the earliest broken, so I'll have to start with fixing it...

Fixes: 5f6b6ccdbe1c ("PCI: xgene: Add APM X-Gene PCIe driver")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>

---
 drivers/pci/controller/pci-xgene.c |    2 -
 drivers/pci/pci.c                  |   38 +++++++++++++++++++++++++++++++++++++
 include/linux/pci.h                |    2 +
 3 files changed, 41 insertions(+), 1 deletion(-)

Index: pci/drivers/pci/controller/pci-xgene.c
===================================================================
--- pci.orig/drivers/pci/controller/pci-xgene.c
+++ pci/drivers/pci/controller/pci-xgene.c
@@ -423,7 +423,7 @@ static int xgene_pcie_map_ranges(struct
 		case IORESOURCE_IO:
 			xgene_pcie_setup_ob_reg(port, res, OMR3BARL, io_base,
 						res->start - window->offset);
-			ret = pci_remap_iospace(res, io_base);
+			ret = devm_pci_remap_iospace(dev, res, io_base);
 			if (ret < 0)
 				return ret;
 			break;
Index: pci/drivers/pci/pci.c
===================================================================
--- pci.orig/drivers/pci/pci.c
+++ pci/drivers/pci/pci.c
@@ -3579,6 +3579,44 @@ void pci_unmap_iospace(struct resource *
 }
 EXPORT_SYMBOL(pci_unmap_iospace);
 
+static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
+{
+	struct resource **res = ptr;
+
+	pci_unmap_iospace(*res);
+}
+
+/**
+ * devm_pci_remap_iospace - Managed pci_remap_iospace()
+ * @dev: Generic device to remap IO address for
+ * @res: Resource describing the I/O space
+ * @phys_addr: physical address of range to be mapped
+ *
+ * Managed pci_remap_iospace().  Map is automatically unmapped on driver
+ * detach.
+ */
+int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
+			   phys_addr_t phys_addr)
+{
+	const struct resource **ptr;
+	int error;
+
+	ptr = devres_alloc(devm_pci_unmap_iospace, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	error = pci_remap_iospace(res, phys_addr);
+	if (error) {
+		devres_free(ptr);
+	} else	{
+		*ptr = res;
+		devres_add(dev, ptr);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(devm_pci_remap_iospace);
+
 /**
  * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
  * @dev: Generic device to remap IO address for
Index: pci/include/linux/pci.h
===================================================================
--- pci.orig/include/linux/pci.h
+++ pci/include/linux/pci.h
@@ -1240,6 +1240,8 @@ int pci_register_io_range(struct fwnode_
 unsigned long pci_address_to_pio(phys_addr_t addr);
 phys_addr_t pci_pio_to_address(unsigned long pio);
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
+int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
+			   phys_addr_t phys_addr);
 void pci_unmap_iospace(struct resource *res);
 void __iomem *devm_pci_remap_cfgspace(struct device *dev,
 				      resource_size_t offset,

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
