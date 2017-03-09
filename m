Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
 <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 05/23] PCI: endpoint: Create configfs entry for EPC device
 and EPF driver
Date: Thu, 9 Mar 2017 13:27:16 +0530
Message-ID: <1489046254-19919-6-git-send-email-kishon@ti.com>
In-Reply-To: <1489046254-19919-1-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: hch@infradead.org, nsekhar@ti.com, kishon@ti.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Invoke API's provided by pci-ep-cfs to create configfs entry for
every EPC device and EPF driver to help users in creating EPF device
and binding the EPF device to the EPC device.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c |    4 ++++
 drivers/pci/endpoint/pci-epf-core.c |    4 ++++
 include/linux/pci-epc.h             |    2 ++
 include/linux/pci-epf.h             |    2 ++
 4 files changed, 12 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 06808ed..29cbe9a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -24,6 +24,7 @@
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
 
 static struct class *pci_epc_class;
 
@@ -441,6 +442,7 @@ void pci_epc_linkup(struct pci_epc *epc)
  */
 void pci_epc_destroy(struct pci_epc *epc)
 {
+	pci_ep_cfs_remove_epc_group(epc->group);
 	device_unregister(&epc->dev);
 	kfree(epc);
 }
@@ -507,6 +509,8 @@ struct pci_epc *
 	if (ret)
 		goto put_dev;
 
+	epc->group = pci_ep_cfs_add_epc_group(dev_name(dev));
+
 	return epc;
 
 put_dev:
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 4c903fc..9ec1639 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -24,6 +24,7 @@
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
 
 static struct bus_type pci_epf_bus_type;
 static struct device_type pci_epf_type;
@@ -143,6 +144,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar)
  */
 void pci_epf_unregister_driver(struct pci_epf_driver *driver)
 {
+	pci_ep_cfs_remove_epf_group(driver->group);
 	driver_unregister(&driver->driver);
 }
 EXPORT_SYMBOL_GPL(pci_epf_unregister_driver);
@@ -172,6 +174,8 @@ int __pci_epf_register_driver(struct pci_epf_driver *driver,
 	if (ret)
 		return ret;
 
+	driver->group = pci_ep_cfs_add_epf_group(driver->driver.name);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__pci_epf_register_driver);
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index ad0cd46..d6eb322 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -77,6 +77,7 @@ struct pci_epc_mem {
  * @ops: function pointers for performing endpoint operations
  * @mem: address space of the endpoint controller
  * @max_functions: max number of functions that can be configured in this EPC
+ * @group: configfs group representing the PCI EPC device
  * @lock: spinlock to protect pci_epc ops
  */
 struct pci_epc {
@@ -85,6 +86,7 @@ struct pci_epc {
 	const struct pci_epc_ops	*ops;
 	struct pci_epc_mem		*mem;
 	u8				max_functions;
+	struct config_group		*group;
 	/* spinlock to protect against concurrent access of EP controller */
 	spinlock_t			lock;
 };
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 54f1338..5ff2c5a 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -82,6 +82,7 @@ struct pci_epf_ops {
  * @driver: PCI EPF driver
  * @ops: set of function pointers for performing EPF operations
  * @owner: the owner of the module that registers the PCI EPF driver
+ * @group: configfs group corresponding to the PCI EPF driver
  * @id_table: identifies EPF devices for probing
  */
 struct pci_epf_driver {
@@ -91,6 +92,7 @@ struct pci_epf_driver {
 	struct device_driver	driver;
 	struct pci_epf_ops	*ops;
 	struct module		*owner;
+	struct config_group	*group;
 	const struct pci_epf_device_id	*id_table;
 };
 
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
