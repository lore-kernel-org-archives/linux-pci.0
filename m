Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:34545 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbaHFOyo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 10:54:44 -0400
From: Gerhard Sittig <gsi@denx.de>
To: linux-pci@vger.kernel.org, Jon Mason <jon.mason@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Detlev Zundel <dzu@denx.de>,
	Gerhard Sittig <gsi@denx.de>
Subject: [PATCH RFC v1 4/4] ntb: de-couple data transport from hardware support
Date: Wed,  6 Aug 2014 16:53:55 +0200
Message-Id: <1407336835-30586-5-git-send-email-gsi@denx.de>
In-Reply-To: <1407336835-30586-1-git-send-email-gsi@denx.de>
References: <1407336835-30586-1-git-send-email-gsi@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The previous implementation at compile time statically linked one
specific hardware driver (Intel) against the generic data transport
over PCI NTB.

Make the hardware driver's public routines static, to register them with
the data transport at runtime.  And make the data transport wrap those
routines, to raise appropriate error codes or provide neutral return
values in the absence of hardware support.  There still is only support
for exactly one hardware driver that is used by the data transport.

Adjust the build support to reflect the fact that the data transport and
the hardware support can get built independently from each other.
Multiple hardware support drivers can implement PCI NTB intrinsics, and
the data transport picks up at runtime whatever matches the found
hardware.

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/ntb/Kconfig         |   45 ++++++++---
 drivers/ntb/Makefile        |    5 +-
 drivers/ntb/ntb_hw.h        |   72 +++++++++++------
 drivers/ntb/ntb_hw_intel.c  |   71 ++++++++++++-----
 drivers/ntb/ntb_transport.c |  184 +++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 320 insertions(+), 57 deletions(-)

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index f69df793dbe2..3c5f8f88c55d 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -1,13 +1,34 @@
-config NTB
-       tristate "Intel Non-Transparent Bridge support"
-       depends on PCI
-       depends on X86
-       help
-        The PCI-E Non-transparent bridge hardware is a point-to-point PCI-E bus
-        connecting 2 systems.  When configured, writes to the device's PCI
-        mapped memory will be mirrored to a buffer on the remote system.  The
-        ntb Linux driver uses this point-to-point communication as a method to
-        transfer data from one system to the other.
-
-        If unsure, say N.
+menuconfig NTB
+	bool "PCI Non-Transparent Bridge support"
+	depends on PCI
+	help
+	  The PCI non-transparent bridge hardware is a point-to-point PCI bus
+	  connecting two systems.  When configured, reads and writes to the
+	  device's PCI mapped memory will be mirrored to a buffer on the remote
+	  system.  The Linux ntb driver uses this point-to-point communication
+	  as a method to transfer data from one system to the other.
 
+	  If unsure, say N.
+
+if NTB
+
+config NTB_TRANSPORT
+	tristate "Data Transport over PCI Non-Transparent Bridges"
+	depends on NTB
+	help
+	  Enable support for data transports over the PCIe non-transparent
+	  bridge connections.  This requires specific hardware support for
+	  PCI NTBs to become operational.
+
+	  If unsure, say N.
+
+config NTB_HW_INTEL
+	tristate "Intel Hardware Support for PCI NTB"
+	depends on X86
+	depends on NTB_TRANSPORT
+	help
+	  Enable support for PCIe non-transparent bridges on Intel hardware.
+
+	  If unsure, say N.
+
+endif # NTB
diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 468ca8ea395e..021a5c66b862 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -1,3 +1,2 @@
-obj-$(CONFIG_NTB) += ntb.o
-
-ntb-objs := ntb_hw_intel.o ntb_transport.o
+obj-$(CONFIG_NTB_HW_INTEL) += ntb_hw_intel.o
+obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
diff --git a/drivers/ntb/ntb_hw.h b/drivers/ntb/ntb_hw.h
index fe4c6306f11c..3cd9df3dd690 100644
--- a/drivers/ntb/ntb_hw.h
+++ b/drivers/ntb/ntb_hw.h
@@ -203,29 +203,57 @@ static inline struct dentry *ntb_query_debugfs(struct ntb_device *ndev)
 	return ndev->debugfs_dir;
 }
 
-struct ntb_device *ntb_register_transport(struct pci_dev *pdev,
-					  void *transport);
-void ntb_unregister_transport(struct ntb_device *ndev);
-void ntb_set_mw_addr(struct ntb_device *ndev, unsigned int mw, u64 addr);
-int ntb_register_db_callback(struct ntb_device *ndev, unsigned int idx,
-			     void *data, int (*db_cb_func)(void *data,
-							   int db_num));
-void ntb_unregister_db_callback(struct ntb_device *ndev, unsigned int idx);
-int ntb_register_event_callback(struct ntb_device *ndev,
-				void (*event_cb_func)(void *handle,
-						      enum ntb_hw_event event));
-void ntb_unregister_event_callback(struct ntb_device *ndev);
-int ntb_get_max_spads(struct ntb_device *ndev);
-int ntb_write_local_spad(struct ntb_device *ndev, unsigned int idx, u32 val);
-int ntb_read_local_spad(struct ntb_device *ndev, unsigned int idx, u32 *val);
-int ntb_write_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 val);
-int ntb_read_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 *val);
-resource_size_t ntb_get_mw_base(struct ntb_device *ndev, unsigned int mw);
-void __iomem *ntb_get_mw_vbase(struct ntb_device *ndev, unsigned int mw);
-u64 ntb_get_mw_size(struct ntb_device *ndev, unsigned int mw);
-void ntb_ring_doorbell(struct ntb_device *ndev, unsigned int idx);
-void *ntb_find_transport(struct pci_dev *pdev);
+/*
+ * These are a hardware driver's public routines, which the transport will
+ * reference.  Phrasing them as callbacks allows for registration and
+ * unregistration of hardware drivers at runtime, and allows for multiple
+ * hardware drivers to implement NTB support.
+ */
+typedef void (*event_cb_func_t)(void *handle, enum ntb_hw_event event);
+typedef int (*doorbell_cb_func_t)(void *data, int db_num);
+struct ntb_hw_desc {
+	const char *ntb_hardware_name;
+	/* transports */
+	struct ntb_device *(*ntb_register_transport)(struct pci_dev *pdev,
+						     void *transport);
+	void (*ntb_unregister_transport)(struct ntb_device *ndev);
+	void *(*ntb_find_transport)(struct pci_dev *pdev);
+	/* doorbells */
+	int (*ntb_register_db_callback)(struct ntb_device *ndev,
+					unsigned int idx, void *data,
+					doorbell_cb_func_t db_cb_func);
+	void (*ntb_unregister_db_callback)(struct ntb_device *ndev,
+					   unsigned int idx);
+	void (*ntb_ring_doorbell)(struct ntb_device *ndev, unsigned int idx);
+	/* events */
+	int (*ntb_register_event_callback)(struct ntb_device *ndev,
+					   event_cb_func_t event_cb_func);
+	void (*ntb_unregister_event_callback)(struct ntb_device *ndev);
+	/* scratch pad */
+	int (*ntb_write_local_spad)(struct ntb_device *ndev, unsigned int idx,
+				    u32 val);
+	int (*ntb_read_local_spad)(struct ntb_device *ndev, unsigned int idx,
+				   u32 *val);
+	int (*ntb_write_remote_spad)(struct ntb_device *ndev, unsigned int idx,
+				     u32 val);
+	int (*ntb_read_remote_spad)(struct ntb_device *ndev, unsigned int idx,
+				    u32 *val);
+	/* memory windows */
+	void (*ntb_set_mw_addr)(struct ntb_device *ndev, unsigned int mw,
+				u64 addr);
+	resource_size_t (*ntb_get_mw_base)(struct ntb_device *ndev,
+					   unsigned int mw);
+	void __iomem *(*ntb_get_mw_vbase)(struct ntb_device *ndev,
+					  unsigned int mw);
+	u64 (*ntb_get_mw_size)(struct ntb_device *ndev, unsigned int mw);
+};
 
+/*
+ * These are the transport's public routines, and get referenced
+ * from hardware drivers.
+ */
+int ntb_transport_addhw(struct ntb_hw_desc *desc);
+void ntb_transport_delhw(struct ntb_hw_desc *desc);
 int ntb_transport_init(struct pci_dev *pdev);
 void ntb_transport_free(void *transport);
 
diff --git a/drivers/ntb/ntb_hw_intel.c b/drivers/ntb/ntb_hw_intel.c
index a81a06c50148..3ab1fcbf52cc 100644
--- a/drivers/ntb/ntb_hw_intel.c
+++ b/drivers/ntb/ntb_hw_intel.c
@@ -121,9 +121,8 @@ MODULE_DEVICE_TABLE(pci, ntb_pci_tbl);
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int ntb_register_event_callback(struct ntb_device *ndev,
-				void (*func)(void *handle,
-					     enum ntb_hw_event event))
+static int ntb_register_event_callback(struct ntb_device *ndev,
+				       event_cb_func_t func)
 {
 	if (ndev->event_cb)
 		return -EINVAL;
@@ -139,7 +138,7 @@ int ntb_register_event_callback(struct ntb_device *ndev,
  *
  * This function unregisters the existing callback from transport
  */
-void ntb_unregister_event_callback(struct ntb_device *ndev)
+static void ntb_unregister_event_callback(struct ntb_device *ndev)
 {
 	ndev->event_cb = NULL;
 }
@@ -175,8 +174,8 @@ static void ntb_irq_work(unsigned long data)
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int ntb_register_db_callback(struct ntb_device *ndev, unsigned int idx,
-			     void *data, int (*func)(void *data, int db_num))
+static int ntb_register_db_callback(struct ntb_device *ndev, unsigned int idx,
+				    void *data, doorbell_cb_func_t func)
 {
 	unsigned long mask;
 
@@ -208,7 +207,8 @@ int ntb_register_db_callback(struct ntb_device *ndev, unsigned int idx,
  * This function unregisters a callback function for the doorbell interrupt
  * on the primary side. The function will also mask the said doorbell.
  */
-void ntb_unregister_db_callback(struct ntb_device *ndev, unsigned int idx)
+static void ntb_unregister_db_callback(struct ntb_device *ndev,
+				       unsigned int idx)
 {
 	unsigned long mask;
 
@@ -233,7 +233,7 @@ void ntb_unregister_db_callback(struct ntb_device *ndev, unsigned int idx)
  *
  * RETURNS: pointer to transport.
  */
-void *ntb_find_transport(struct pci_dev *pdev)
+static void *ntb_find_transport(struct pci_dev *pdev)
 {
 	struct ntb_device *ndev = pci_get_drvdata(pdev);
 	return ndev->ntb_transport;
@@ -248,7 +248,8 @@ void *ntb_find_transport(struct pci_dev *pdev)
  *
  * RETURNS: pointer to ntb_device, NULL on error.
  */
-struct ntb_device *ntb_register_transport(struct pci_dev *pdev, void *transport)
+static struct ntb_device *ntb_register_transport(struct pci_dev *pdev,
+						 void *transport)
 {
 	struct ntb_device *ndev = pci_get_drvdata(pdev);
 
@@ -266,7 +267,7 @@ struct ntb_device *ntb_register_transport(struct pci_dev *pdev, void *transport)
  * This function unregisters the transport from the HW driver and performs any
  * necessary cleanups.
  */
-void ntb_unregister_transport(struct ntb_device *ndev)
+static void ntb_unregister_transport(struct ntb_device *ndev)
 {
 	int i;
 
@@ -292,7 +293,8 @@ void ntb_unregister_transport(struct ntb_device *ndev)
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int ntb_write_local_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
+static int ntb_write_local_spad(struct ntb_device *ndev, unsigned int idx,
+				u32 val)
 {
 	if (idx >= ndev->limits.max_spads)
 		return -EINVAL;
@@ -316,7 +318,8 @@ int ntb_write_local_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int ntb_read_local_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
+static int ntb_read_local_spad(struct ntb_device *ndev, unsigned int idx,
+			       u32 *val)
 {
 	if (idx >= ndev->limits.max_spads)
 		return -EINVAL;
@@ -341,7 +344,8 @@ int ntb_read_local_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int ntb_write_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
+static int ntb_write_remote_spad(struct ntb_device *ndev, unsigned int idx,
+				 u32 val)
 {
 	if (idx >= ndev->limits.max_spads)
 		return -EINVAL;
@@ -365,7 +369,8 @@ int ntb_write_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int ntb_read_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
+static int ntb_read_remote_spad(struct ntb_device *ndev, unsigned int idx,
+				u32 *val)
 {
 	if (idx >= ndev->limits.max_spads)
 		return -EINVAL;
@@ -386,7 +391,7 @@ int ntb_read_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
  *
  * RETURNS: address, or NULL on error.
  */
-resource_size_t ntb_get_mw_base(struct ntb_device *ndev, unsigned int mw)
+static resource_size_t ntb_get_mw_base(struct ntb_device *ndev, unsigned int mw)
 {
 	if (mw >= ntb_max_mw(ndev))
 		return 0;
@@ -404,7 +409,7 @@ resource_size_t ntb_get_mw_base(struct ntb_device *ndev, unsigned int mw)
  *
  * RETURNS: pointer to virtual address, or NULL on error.
  */
-void __iomem *ntb_get_mw_vbase(struct ntb_device *ndev, unsigned int mw)
+static void __iomem *ntb_get_mw_vbase(struct ntb_device *ndev, unsigned int mw)
 {
 	if (mw >= ntb_max_mw(ndev))
 		return NULL;
@@ -421,7 +426,7 @@ void __iomem *ntb_get_mw_vbase(struct ntb_device *ndev, unsigned int mw)
  *
  * RETURNS: the size of the memory window or zero on error
  */
-u64 ntb_get_mw_size(struct ntb_device *ndev, unsigned int mw)
+static u64 ntb_get_mw_size(struct ntb_device *ndev, unsigned int mw)
 {
 	if (mw >= ntb_max_mw(ndev))
 		return 0;
@@ -439,7 +444,7 @@ u64 ntb_get_mw_size(struct ntb_device *ndev, unsigned int mw)
  * memory address is where data from the remote system will be transfered into
  * or out of depending on how the transport is configured.
  */
-void ntb_set_mw_addr(struct ntb_device *ndev, unsigned int mw, u64 addr)
+static void ntb_set_mw_addr(struct ntb_device *ndev, unsigned int mw, u64 addr)
 {
 	if (mw >= ntb_max_mw(ndev))
 		return;
@@ -469,7 +474,7 @@ void ntb_set_mw_addr(struct ntb_device *ndev, unsigned int mw, u64 addr)
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-void ntb_ring_doorbell(struct ntb_device *ndev, unsigned int db)
+static void ntb_ring_doorbell(struct ntb_device *ndev, unsigned int db)
 {
 	dev_dbg(&ndev->pdev->dev, "%s: ringing doorbell %d\n", __func__, db);
 
@@ -1401,6 +1406,26 @@ static void ntb_hw_link_down(struct ntb_device *ndev)
 	writel(ntb_cntl, ndev->reg_ofs.lnk_cntl);
 }
 
+static struct ntb_hw_desc hwdesc = {
+	.ntb_hardware_name = NTB_HW_INTEL_NAME,
+	.ntb_register_transport = ntb_register_transport,
+	.ntb_unregister_transport = ntb_unregister_transport,
+	.ntb_find_transport = ntb_find_transport,
+	.ntb_register_db_callback = ntb_register_db_callback,
+	.ntb_unregister_db_callback = ntb_unregister_db_callback,
+	.ntb_ring_doorbell = ntb_ring_doorbell,
+	.ntb_register_event_callback = ntb_register_event_callback,
+	.ntb_unregister_event_callback = ntb_unregister_event_callback,
+	.ntb_write_local_spad = ntb_write_local_spad,
+	.ntb_read_local_spad = ntb_read_local_spad,
+	.ntb_write_remote_spad = ntb_write_remote_spad,
+	.ntb_read_remote_spad = ntb_read_remote_spad,
+	.ntb_set_mw_addr = ntb_set_mw_addr,
+	.ntb_get_mw_base = ntb_get_mw_base,
+	.ntb_get_mw_vbase = ntb_get_mw_vbase,
+	.ntb_get_mw_size = ntb_get_mw_size,
+};
+
 static int ntb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct ntb_device *ndev;
@@ -1485,14 +1510,19 @@ static int ntb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		ntb_write_remote_spad(ndev, i, 0);
 	}
 
-	rc = ntb_transport_init(pdev);
+	rc = ntb_transport_addhw(&hwdesc);
 	if (rc)
 		goto err6;
+	rc = ntb_transport_init(pdev);
+	if (rc)
+		goto err7;
 
 	ntb_hw_link_up(ndev);
 
 	return 0;
 
+err7:
+	ntb_transport_delhw(&hwdesc);
 err6:
 	ntb_free_interrupts(ndev);
 err5:
@@ -1523,6 +1553,7 @@ static void ntb_pci_remove(struct pci_dev *pdev)
 	ntb_hw_link_down(ndev);
 
 	ntb_transport_free(ndev->ntb_transport);
+	ntb_transport_delhw(&hwdesc);
 
 	ntb_free_interrupts(ndev);
 	ntb_free_callbacks(ndev);
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 70f358c8cc09..527c1b53b77f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -210,6 +210,190 @@ enum {
 	MAX_SPAD,
 };
 
+/*
+ * This transport layer can use one of several hardware drivers.  So
+ * wrap the hardware driver's routines such that they can get registered
+ * and unregistered at runtime.  Since hardware drivers can always
+ * return error codes, this transport layer should transparently cope
+ * with the situation of not (yet) registered hardware drivers.
+ *
+ * At the moment there is no support for parallel registration of
+ * multiple hardware drivers at the same time, which should be
+ * acceptable.
+ */
+static struct ntb_hw_desc *hwdesc;
+
+struct ntb_device *ntb_register_transport(struct pci_dev *pdev,
+					  void *transport)
+{
+	if (!hwdesc)
+		return NULL;
+	if (!hwdesc->ntb_register_transport)
+		return NULL;
+	return hwdesc->ntb_register_transport(pdev, transport);
+}
+
+void ntb_unregister_transport(struct ntb_device *ndev)
+{
+	if (!hwdesc)
+		return;
+	if (!hwdesc->ntb_unregister_transport)
+		return;
+	return hwdesc->ntb_unregister_transport(ndev);
+}
+
+void *ntb_find_transport(struct pci_dev *pdev)
+{
+	if (!hwdesc)
+		return NULL;
+	if (!hwdesc->ntb_find_transport)
+		return NULL;
+	return hwdesc->ntb_find_transport(pdev);
+}
+
+int ntb_register_db_callback(struct ntb_device *ndev, unsigned int idx,
+			     void *data, doorbell_cb_func_t db_cb_func)
+{
+	if (!hwdesc)
+		return -ENXIO;
+	if (!hwdesc->ntb_register_db_callback)
+		return -ENXIO;
+	return hwdesc->ntb_register_db_callback(ndev, idx, data, db_cb_func);
+}
+
+void ntb_unregister_db_callback(struct ntb_device *ndev, unsigned int idx)
+{
+	if (!hwdesc)
+		return;
+	if (!hwdesc->ntb_unregister_db_callback)
+		return;
+	return hwdesc->ntb_unregister_db_callback(ndev, idx);
+}
+
+void ntb_ring_doorbell(struct ntb_device *ndev, unsigned int idx)
+{
+	if (!hwdesc)
+		return;
+	if (!hwdesc->ntb_ring_doorbell)
+		return;
+	return hwdesc->ntb_ring_doorbell(ndev, idx);
+}
+
+int ntb_register_event_callback(struct ntb_device *ndev,
+				event_cb_func_t event_cb_func)
+{
+	if (!hwdesc)
+		return -ENXIO;
+	if (!hwdesc->ntb_register_event_callback)
+		return -ENXIO;
+	return hwdesc->ntb_register_event_callback(ndev, event_cb_func);
+}
+
+void ntb_unregister_event_callback(struct ntb_device *ndev)
+{
+	if (!hwdesc)
+		return;
+	if (!hwdesc->ntb_unregister_event_callback)
+		return;
+	return hwdesc->ntb_unregister_event_callback(ndev);
+}
+
+int ntb_write_local_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
+{
+	if (!hwdesc)
+		return -ENXIO;
+	if (!hwdesc->ntb_write_local_spad)
+		return -ENXIO;
+	return hwdesc->ntb_write_local_spad(ndev, idx, val);
+}
+
+int ntb_read_local_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
+{
+	if (!hwdesc)
+		return -ENXIO;
+	if (!hwdesc->ntb_read_local_spad)
+		return -ENXIO;
+	return hwdesc->ntb_read_local_spad(ndev, idx, val);
+}
+
+int ntb_write_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 val)
+{
+	if (!hwdesc)
+		return -ENXIO;
+	if (!hwdesc->ntb_write_remote_spad)
+		return -ENXIO;
+	return hwdesc->ntb_write_remote_spad(ndev, idx, val);
+}
+
+int ntb_read_remote_spad(struct ntb_device *ndev, unsigned int idx, u32 *val)
+{
+	if (!hwdesc)
+		return -ENXIO;
+	if (!hwdesc->ntb_read_remote_spad)
+		return -ENXIO;
+	return hwdesc->ntb_read_remote_spad(ndev, idx, val);
+}
+
+void ntb_set_mw_addr(struct ntb_device *ndev, unsigned int mw, u64 addr)
+{
+	if (!hwdesc)
+		return;
+	if (!hwdesc->ntb_set_mw_addr)
+		return;
+	return hwdesc->ntb_set_mw_addr(ndev, mw, addr);
+}
+
+resource_size_t ntb_get_mw_base(struct ntb_device *ndev, unsigned int mw)
+{
+	if (!hwdesc)
+		return 0;
+	if (!hwdesc->ntb_get_mw_base)
+		return 0;
+	return hwdesc->ntb_get_mw_base(ndev, mw);
+}
+
+void __iomem *ntb_get_mw_vbase(struct ntb_device *ndev, unsigned int mw)
+{
+	if (!hwdesc)
+		return NULL;
+	if (!hwdesc->ntb_get_mw_vbase)
+		return NULL;
+	return hwdesc->ntb_get_mw_vbase(ndev, mw);
+}
+
+u64 ntb_get_mw_size(struct ntb_device *ndev, unsigned int mw)
+{
+	if (!hwdesc)
+		return 0;
+	if (!hwdesc->ntb_get_mw_size)
+		return 0;
+	return hwdesc->ntb_get_mw_size(ndev, mw);
+}
+
+int ntb_transport_addhw(struct ntb_hw_desc *desc)
+{
+	if (hwdesc) {
+		pr_warn("PCI NTB: %s already registered, rejecting %s\n",
+			hwdesc->ntb_hardware_name, desc->ntb_hardware_name);
+		return -EBUSY;
+	}
+	pr_info("PCI NTB: registered %s hardware routines\n",
+		hwdesc->ntb_hardware_name);
+	hwdesc = desc;
+	return 0;
+}
+EXPORT_SYMBOL(ntb_transport_addhw);
+
+void ntb_transport_delhw(struct ntb_hw_desc *desc)
+{
+	if (desc != hwdesc)
+		return;
+	pr_info("PCI NTB: unregistering %s hardware routines\n",
+		hwdesc->ntb_hardware_name);
+	hwdesc = NULL;
+}
+EXPORT_SYMBOL(ntb_transport_delhw);
+
 #define QP_TO_MW(ndev, qp)	((qp) % ntb_max_mw(ndev))
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
-- 
1.7.10.4

