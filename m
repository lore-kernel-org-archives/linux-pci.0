Return-Path: <SRS0=A+B5=EI=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=A+B5=EI=fredlawl.com=fred@kernel.org>
From: Frederick Lawler <fred@fredlawl.com>
To: linux-pci@vger.kernel.org
Cc: helgaas@kernel.org,
	Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v3 3/3] PCI: Replace calls from dev_<level> to pci_<level> in pcie and hotplug
Date: Fri, 12 Jan 2018 22:58:38 -0600
Message-Id: <1515819518-6501-4-git-send-email-fred@fredlawl.com>
In-Reply-To: <1515819518-6501-1-git-send-email-fred@fredlawl.com>
References: <1515819518-6501-1-git-send-email-fred@fredlawl.com>
List-ID: <linux-pci.vger.kernel.org>

Replace dev_printk() with pci_printk() to simplify the
 code slightly for hotplug, AER, ASPM, PME, and PTM. 
 No functional change intended.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---

 drivers/pci/hotplug/cpqphp_core.c      |  2 +-
 drivers/pci/hotplug/pnv_php.c          | 40 +++++++++++++++-------------------
 drivers/pci/hotplug/sgi_hotplug.c      | 36 +++++++++++++++---------------
 drivers/pci/hotplug/shpchp.h           |  8 +++----
 drivers/pci/hotplug/shpchp_core.c      |  2 +-
 drivers/pci/pcie/aer/aer_inject.c      | 15 +++++--------
 drivers/pci/pcie/aer/aerdrv.c          |  2 +-
 drivers/pci/pcie/aer/aerdrv_core.c     | 21 ++++++++----------
 drivers/pci/pcie/aer/aerdrv_errprint.c | 22 +++++++++----------
 drivers/pci/pcie/aspm.c                |  9 ++++----
 drivers/pci/pcie/pme.c                 |  6 ++---
 drivers/pci/pcie/ptm.c                 |  2 +-
 12 files changed, 77 insertions(+), 88 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index 70967ac..d7bf300 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -835,7 +835,7 @@ static int cpqhpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	bus = pdev->subordinate;
 	if (!bus) {
-		dev_notice(&pdev->dev, "the device is not a bridge, skipping\n");
+		pci_notice(pdev, "the device is not a bridge, skipping\n");
 		rc = -ENODEV;
 		goto err_disable_device;
 	}
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 74f6a17..50c68c3 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -266,21 +266,20 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	fdt1 = kzalloc(0x10000, GFP_KERNEL);
 	if (!fdt1) {
 		ret = -ENOMEM;
-		dev_warn(&php_slot->pdev->dev, "Cannot alloc FDT blob\n");
+		pci_warn(php_slot->pdev, "Cannot alloc FDT blob\n");
 		goto out;
 	}
 
 	ret = pnv_pci_get_device_tree(php_slot->dn->phandle, fdt1, 0x10000);
 	if (ret) {
-		dev_warn(&php_slot->pdev->dev, "Error %d getting FDT blob\n",
-			 ret);
+		pci_warn(php_slot->pdev, "Error %d getting FDT blob\n", ret);
 		goto free_fdt1;
 	}
 
 	fdt = kzalloc(fdt_totalsize(fdt1), GFP_KERNEL);
 	if (!fdt) {
 		ret = -ENOMEM;
-		dev_warn(&php_slot->pdev->dev, "Cannot %d bytes memory\n",
+		pci_warn(php_slot->pdev, "Cannot %d bytes memory\n",
 			 fdt_totalsize(fdt1));
 		goto free_fdt1;
 	}
@@ -290,7 +289,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	dt = of_fdt_unflatten_tree(fdt, php_slot->dn, NULL);
 	if (!dt) {
 		ret = -EINVAL;
-		dev_warn(&php_slot->pdev->dev, "Cannot unflatten FDT\n");
+		pci_warn(php_slot->pdev, "Cannot unflatten FDT\n");
 		goto free_fdt;
 	}
 
@@ -300,7 +299,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	ret = pnv_php_populate_changeset(&php_slot->ocs, php_slot->dn);
 	if (ret) {
 		pnv_php_reverse_nodes(php_slot->dn);
-		dev_warn(&php_slot->pdev->dev, "Error %d populating changeset\n",
+		pci_warn(php_slot->pdev, "Error %d populating changeset\n",
 			 ret);
 		goto free_dt;
 	}
@@ -308,8 +307,7 @@ static int pnv_php_add_devtree(struct pnv_php_slot *php_slot)
 	php_slot->dn->child = NULL;
 	ret = of_changeset_apply(&php_slot->ocs);
 	if (ret) {
-		dev_warn(&php_slot->pdev->dev, "Error %d applying changeset\n",
-			 ret);
+		pci_warn(php_slot->pdev, "Error %d applying changeset\n", ret);
 		goto destroy_changeset;
 	}
 
@@ -345,14 +343,14 @@ int pnv_php_set_slot_power_state(struct hotplug_slot *slot,
 		if (be64_to_cpu(msg.params[1]) != php_slot->dn->phandle	||
 		    be64_to_cpu(msg.params[2]) != state			||
 		    be64_to_cpu(msg.params[3]) != OPAL_SUCCESS) {
-			dev_warn(&php_slot->pdev->dev, "Wrong msg (%lld, %lld, %lld)\n",
+			pci_warn(php_slot->pdev, "Wrong msg (%lld, %lld, %lld)\n",
 				 be64_to_cpu(msg.params[1]),
 				 be64_to_cpu(msg.params[2]),
 				 be64_to_cpu(msg.params[3]));
 			return -ENOMSG;
 		}
 	} else if (ret < 0) {
-		dev_warn(&php_slot->pdev->dev, "Error %d powering %s\n",
+		pci_warn(php_slot->pdev, "Error %d powering %s\n",
 			 ret, (state == OPAL_PCI_SLOT_POWER_ON) ? "on" : "off");
 		return ret;
 	}
@@ -379,7 +377,7 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
 	 */
 	ret = pnv_pci_get_power_state(php_slot->id, &power_state);
 	if (ret) {
-		dev_warn(&php_slot->pdev->dev, "Error %d getting power status\n",
+		pci_warn(php_slot->pdev, "Error %d getting power status\n",
 			 ret);
 	} else {
 		*state = power_state;
@@ -405,8 +403,7 @@ static int pnv_php_get_adapter_state(struct hotplug_slot *slot, u8 *state)
 		slot->info->adapter_status = presence;
 		ret = 0;
 	} else {
-		dev_warn(&php_slot->pdev->dev, "Error %d getting presence\n",
-			 ret);
+		pci_warn(php_slot->pdev, "Error %d getting presence\n", ret);
 	}
 
 	return ret;
@@ -629,8 +626,7 @@ static int pnv_php_register_slot(struct pnv_php_slot *php_slot)
 	ret = pci_hp_register(&php_slot->slot, php_slot->bus,
 			      php_slot->slot_no, php_slot->name);
 	if (ret) {
-		dev_warn(&php_slot->pdev->dev, "Error %d registering slot\n",
-			 ret);
+		pci_warn(php_slot->pdev, "Error %d registering slot\n", ret);
 		return ret;
 	}
 
@@ -683,7 +679,7 @@ static int pnv_php_enable_msix(struct pnv_php_slot *php_slot)
 	/* Enable MSIx */
 	ret = pci_enable_msix_exact(pdev, &entry, 1);
 	if (ret) {
-		dev_warn(&pdev->dev, "Error %d enabling MSIx\n", ret);
+		pci_warn(pdev, "Error %d enabling MSIx\n", ret);
 		return ret;
 	}
 
@@ -727,7 +723,7 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 		   (sts & PCI_EXP_SLTSTA_PDC)) {
 		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
 		if (ret) {
-			dev_warn(&pdev->dev, "PCI slot [%s] error %d getting presence (0x%04x), to retry the operation.\n",
+			pci_warn(pdev, "PCI slot [%s] error %d getting presence (0x%04x), to retry the operation.\n",
 				 php_slot->name, ret, sts);
 			return IRQ_HANDLED;
 		}
@@ -757,12 +753,12 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
 	 */
 	event = kzalloc(sizeof(*event), GFP_ATOMIC);
 	if (!event) {
-		dev_warn(&pdev->dev, "PCI slot [%s] missed hotplug event 0x%04x\n",
+		pci_warn(pdev, "PCI slot [%s] missed hotplug event 0x%04x\n",
 			 php_slot->name, sts);
 		return IRQ_HANDLED;
 	}
 
-	dev_info(&pdev->dev, "PCI slot [%s] %s (IRQ: %d)\n",
+	pci_info(pdev, "PCI slot [%s] %s (IRQ: %d)\n",
 		 php_slot->name, added ? "added" : "removed", irq);
 	INIT_WORK(&event->work, pnv_php_event_handler);
 	event->added = added;
@@ -782,7 +778,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 	/* Allocate workqueue */
 	php_slot->wq = alloc_workqueue("pciehp-%s", 0, 0, php_slot->name);
 	if (!php_slot->wq) {
-		dev_warn(&pdev->dev, "Cannot alloc workqueue\n");
+		pci_warn(pdev, "Cannot alloc workqueue\n");
 		pnv_php_disable_irq(php_slot, true);
 		return;
 	}
@@ -806,7 +802,7 @@ static void pnv_php_init_irq(struct pnv_php_slot *php_slot, int irq)
 			  php_slot->name, php_slot);
 	if (ret) {
 		pnv_php_disable_irq(php_slot, true);
-		dev_warn(&pdev->dev, "Error %d enabling IRQ %d\n", ret, irq);
+		pci_warn(pdev, "Error %d enabling IRQ %d\n", ret, irq);
 		return;
 	}
 
@@ -842,7 +838,7 @@ static void pnv_php_enable_irq(struct pnv_php_slot *php_slot)
 
 	ret = pci_enable_device(pdev);
 	if (ret) {
-		dev_warn(&pdev->dev, "Error %d enabling device\n", ret);
+		pci_warn(pdev, "Error %d enabling device\n", ret);
 		return;
 	}
 
diff --git a/drivers/pci/hotplug/sgi_hotplug.c b/drivers/pci/hotplug/sgi_hotplug.c
index 339bce0..293bd03 100644
--- a/drivers/pci/hotplug/sgi_hotplug.c
+++ b/drivers/pci/hotplug/sgi_hotplug.c
@@ -245,18 +245,18 @@ static int sn_slot_enable(struct hotplug_slot *bss_hotplug_slot,
 
 
 	if (rc == PCI_SLOT_ALREADY_UP) {
-		dev_dbg(&slot->pci_bus->self->dev, "is already active\n");
+		pci_dbg(slot->pci_bus->self, "is already active\n");
 		return 1; /* return 1 to user */
 	}
 
 	if (rc == PCI_L1_ERR) {
-		dev_dbg(&slot->pci_bus->self->dev, "L1 failure %d with message: %s",
+		pci_dbg(slot->pci_bus->self, "L1 failure %d with message: %s",
 			resp.resp_sub_errno, resp.resp_l1_msg);
 		return -EPERM;
 	}
 
 	if (rc) {
-		dev_dbg(&slot->pci_bus->self->dev, "insert failed with error %d sub-error %d\n",
+		pci_dbg(slot->pci_bus->self, "insert failed with error %d sub-error %d\n",
 			rc, resp.resp_sub_errno);
 		return -EIO;
 	}
@@ -281,23 +281,23 @@ static int sn_slot_disable(struct hotplug_slot *bss_hotplug_slot,
 
 	if ((action == PCI_REQ_SLOT_ELIGIBLE) &&
 	    (rc == PCI_SLOT_ALREADY_DOWN)) {
-		dev_dbg(&slot->pci_bus->self->dev, "Slot %s already inactive\n", slot->physical_path);
+		pci_dbg(slot->pci_bus->self, "Slot %s already inactive\n", slot->physical_path);
 		return 1; /* return 1 to user */
 	}
 
 	if ((action == PCI_REQ_SLOT_ELIGIBLE) && (rc == PCI_EMPTY_33MHZ)) {
-		dev_dbg(&slot->pci_bus->self->dev, "Cannot remove last 33MHz card\n");
+		pci_dbg(slot->pci_bus->self, "Cannot remove last 33MHz card\n");
 		return -EPERM;
 	}
 
 	if ((action == PCI_REQ_SLOT_ELIGIBLE) && (rc == PCI_L1_ERR)) {
-		dev_dbg(&slot->pci_bus->self->dev, "L1 failure %d with message \n%s\n",
+		pci_dbg(slot->pci_bus->self, "L1 failure %d with message \n%s\n",
 			resp.resp_sub_errno, resp.resp_l1_msg);
 		return -EPERM;
 	}
 
 	if ((action == PCI_REQ_SLOT_ELIGIBLE) && rc) {
-		dev_dbg(&slot->pci_bus->self->dev, "remove failed with error %d sub-error %d\n",
+		pci_dbg(slot->pci_bus->self, "remove failed with error %d sub-error %d\n",
 			rc, resp.resp_sub_errno);
 		return -EIO;
 	}
@@ -308,12 +308,12 @@ static int sn_slot_disable(struct hotplug_slot *bss_hotplug_slot,
 	if ((action == PCI_REQ_SLOT_DISABLE) && !rc) {
 		pcibus_info = SN_PCIBUS_BUSSOFT_INFO(slot->pci_bus);
 		pcibus_info->pbi_enabled_devices &= ~(1 << device_num);
-		dev_dbg(&slot->pci_bus->self->dev, "remove successful\n");
+		pci_dbg(slot->pci_bus->self, "remove successful\n");
 		return 0;
 	}
 
 	if ((action == PCI_REQ_SLOT_DISABLE) && rc) {
-		dev_dbg(&slot->pci_bus->self->dev, "remove failed rc = %d\n", rc);
+		pci_dbg(slot->pci_bus->self, "remove failed rc = %d\n", rc);
 	}
 
 	return rc;
@@ -366,7 +366,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 	num_funcs = pci_scan_slot(slot->pci_bus,
 				  PCI_DEVFN(slot->device_num + 1, 0));
 	if (!num_funcs) {
-		dev_dbg(&slot->pci_bus->self->dev, "no device in slot\n");
+		pci_dbg(slot->pci_bus->self, "no device in slot\n");
 		mutex_unlock(&sn_hotplug_mutex);
 		return -ENODEV;
 	}
@@ -412,7 +412,7 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 		phandle = acpi_device_handle(PCI_CONTROLLER(slot->pci_bus)->companion);
 
 		if (acpi_bus_get_device(phandle, &pdevice)) {
-			dev_dbg(&slot->pci_bus->self->dev, "no parent device, assuming NULL\n");
+			pci_dbg(slot->pci_bus->self, "no parent device, assuming NULL\n");
 			pdevice = NULL;
 		}
 
@@ -463,9 +463,9 @@ static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 	mutex_unlock(&sn_hotplug_mutex);
 
 	if (rc == 0)
-		dev_dbg(&slot->pci_bus->self->dev, "insert operation successful\n");
+		pci_dbg(slot->pci_bus->self, "insert operation successful\n");
 	else
-		dev_dbg(&slot->pci_bus->self->dev, "insert operation failed rc = %d\n", rc);
+		pci_dbg(slot->pci_bus->self, "insert operation failed rc = %d\n", rc);
 
 	return rc;
 }
@@ -643,16 +643,16 @@ static int sn_hotplug_slot_register(struct pci_bus *pci_bus)
 		if (rc)
 			goto register_err;
 	}
-	dev_dbg(&pci_bus->self->dev, "Registered bus with hotplug\n");
+	pci_dbg(pci_bus->self, "Registered bus with hotplug\n");
 	return rc;
 
 register_err:
-	dev_dbg(&pci_bus->self->dev, "bus failed to register with err = %d\n",
+	pci_dbg(pci_bus->self, "bus failed to register with err = %d\n",
 		rc);
 
 alloc_err:
 	if (rc == -ENOMEM)
-		dev_dbg(&pci_bus->self->dev, "Memory allocation error\n");
+		pci_dbg(pci_bus->self, "Memory allocation error\n");
 
 	/* destroy THIS element */
 	if (bss_hotplug_slot)
@@ -685,10 +685,10 @@ static int __init sn_pci_hotplug_init(void)
 
 		rc = sn_pci_bus_valid(pci_bus);
 		if (rc != 1) {
-			dev_dbg(&pci_bus->self->dev, "not a valid hotplug bus\n");
+			pci_dbg(pci_bus->self, "not a valid hotplug bus\n");
 			continue;
 		}
-		dev_dbg(&pci_bus->self->dev, "valid hotplug bus\n");
+		pci_dbg(pci_bus->self, "valid hotplug bus\n");
 
 		rc = sn_hotplug_slot_register(pci_bus);
 		if (!rc) {
diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index 70c7ea6..664b1da 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -62,15 +62,15 @@ do {									\
 #define ctrl_dbg(ctrl, format, arg...)					\
 	do {								\
 		if (shpchp_debug)					\
-			dev_printk(KERN_DEBUG, &ctrl->pci_dev->dev,	\
+			pci_printk(KERN_DEBUG, ctrl->pci_dev,		\
 					format, ## arg);		\
 	} while (0)
 #define ctrl_err(ctrl, format, arg...)					\
-	dev_err(&ctrl->pci_dev->dev, format, ## arg)
+	pci_err(ctrl->pci_dev, format, ## arg)
 #define ctrl_info(ctrl, format, arg...)					\
-	dev_info(&ctrl->pci_dev->dev, format, ## arg)
+	pci_info(ctrl->pci_dev, format, ## arg)
 #define ctrl_warn(ctrl, format, arg...)					\
-	dev_warn(&ctrl->pci_dev->dev, format, ## arg)
+	pci_warn(ctrl->pci_dev, format, ## arg)
 
 
 #define SLOT_NAME_SIZE 10
diff --git a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
index 7bfb87b..756e211 100644
--- a/drivers/pci/hotplug/shpchp_core.c
+++ b/drivers/pci/hotplug/shpchp_core.c
@@ -306,7 +306,7 @@ static int shpc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl) {
-		dev_err(&pdev->dev, "%s: Out of memory\n", __func__);
+		pci_err(pdev, "%s: Out of memory\n", __func__);
 		goto err_out_none;
 	}
 	INIT_LIST_HEAD(&ctrl->slot_list);
diff --git a/drivers/pci/pcie/aer/aer_inject.c b/drivers/pci/pcie/aer/aer_inject.c
index 2b6a592..b77c01e 100644
--- a/drivers/pci/pcie/aer/aer_inject.c
+++ b/drivers/pci/pcie/aer/aer_inject.c
@@ -344,14 +344,14 @@ static int aer_inject(struct aer_error_inj *einj)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev) {
-		dev_err(&dev->dev, "aer_inject: Root port not found\n");
+		pci_err(dev, "aer_inject: Root port not found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
 
 	pos_cap_err = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
 	if (!pos_cap_err) {
-		dev_err(&dev->dev, "aer_inject: Device doesn't support AER\n");
+		pci_err(dev, "aer_inject: Device doesn't support AER\n");
 		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
@@ -362,8 +362,7 @@ static int aer_inject(struct aer_error_inj *einj)
 
 	rp_pos_cap_err = pci_find_ext_capability(rpdev, PCI_EXT_CAP_ID_ERR);
 	if (!rp_pos_cap_err) {
-		dev_err(&rpdev->dev,
-			"aer_inject: Root port doesn't support AER\n");
+		pci_err(rpdev, "aer_inject: Root port doesn't support AER\n");
 		ret = -EPROTONOSUPPORT;
 		goto out_put;
 	}
@@ -411,16 +410,14 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!aer_mask_override && einj->cor_status &&
 	    !(einj->cor_status & ~cor_mask)) {
 		ret = -EINVAL;
-		dev_warn(&dev->dev,
-			 "aer_inject: The correctable error(s) is masked by device\n");
+		pci_warn(dev, "aer_inject: The correctable error(s) is masked by device\n");
 		spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
 	if (!aer_mask_override && einj->uncor_status &&
 	    !(einj->uncor_status & ~uncor_mask)) {
 		ret = -EINVAL;
-		dev_warn(&dev->dev,
-			 "aer_inject: The uncorrectable error(s) is masked by device\n");
+		pci_warn(dev, "aer_inject: The uncorrectable error(s) is masked by device\n");
 		spin_unlock_irqrestore(&inject_lock, flags);
 		goto out_put;
 	}
@@ -483,7 +480,7 @@ static int aer_inject(struct aer_error_inj *einj)
 			 einj->cor_status, einj->uncor_status, pci_name(dev));
 		aer_irq(-1, edev);
 	} else {
-		dev_err(&rpdev->dev, "aer_inject: AER device not found\n");
+		pci_err(rpdev, "aer_inject: AER device not found\n");
 		ret = -ENODEV;
 	}
 out_put:
diff --git a/drivers/pci/pcie/aer/aerdrv.c b/drivers/pci/pcie/aer/aerdrv.c
index 6ff5f5b..bf6c983 100644
--- a/drivers/pci/pcie/aer/aerdrv.c
+++ b/drivers/pci/pcie/aer/aerdrv.c
@@ -326,7 +326,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
 
 	pci_reset_bridge_secondary_bus(dev);
-	dev_printk(KERN_DEBUG, &dev->dev, "Root Port link has been reset\n");
+	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 7448052..ef3527a 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -226,9 +226,8 @@ static bool find_source_device(struct pci_dev *parent,
 	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
-		dev_printk(KERN_DEBUG, &parent->dev,
-				"can't find device of ID%04x\n",
-				e_info->id);
+		pci_printk(KERN_DEBUG, parent, "can't find device of ID%04x\n",
+			   e_info->id);
 		return false;
 	}
 	return true;
@@ -256,7 +255,7 @@ static int report_error_detected(struct pci_dev *dev, void *data)
 			 * of a driver for this device is unaware of
 			 * its hw state.
 			 */
-			dev_printk(KERN_DEBUG, &dev->dev, "device has %s\n",
+			pci_printk(KERN_DEBUG, dev, "device has %s\n",
 				   dev->driver ?
 				   "no AER-aware driver" : "no driver");
 		}
@@ -364,7 +363,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 {
 	struct aer_broadcast_data result_data;
 
-	dev_printk(KERN_DEBUG, &dev->dev, "broadcast %s message\n", error_mesg);
+	pci_printk(KERN_DEBUG, dev, "broadcast %s message\n", error_mesg);
 	result_data.state = state;
 	if (cb == report_error_detected)
 		result_data.result = PCI_ERS_RESULT_CAN_RECOVER;
@@ -413,7 +412,7 @@ static pci_ers_result_t broadcast_error_message(struct pci_dev *dev,
 static pci_ers_result_t default_reset_link(struct pci_dev *dev)
 {
 	pci_reset_bridge_secondary_bus(dev);
-	dev_printk(KERN_DEBUG, &dev->dev, "downstream link has been reset\n");
+	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
@@ -465,15 +464,13 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	} else if (udev->has_secondary_link) {
 		status = default_reset_link(udev);
 	} else {
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"no link-reset support at upstream device %s\n",
+		pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
 			pci_name(udev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED) {
-		dev_printk(KERN_DEBUG, &dev->dev,
-			"link reset at upstream device %s failed\n",
+		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
 			pci_name(udev));
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
@@ -537,12 +534,12 @@ static void do_recovery(struct pci_dev *dev, int severity)
 				"resume",
 				report_resume);
 
-	dev_info(&dev->dev, "AER: Device recovery successful\n");
+	pci_info(dev, "AER: Device recovery successful\n");
 	return;
 
 failed:
 	/* TODO: Should kernel panic here? */
-	dev_info(&dev->dev, "AER: Device recovery failed\n");
+	pci_info(dev, "AER: Device recovery failed\n");
 }
 
 /**
diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index 54c4b69..0a7004a 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -132,7 +132,7 @@ static const char *aer_agent_string[] = {
 static void __print_tlp_header(struct pci_dev *dev,
 			       struct aer_header_log_regs *t)
 {
-	dev_err(&dev->dev, "  TLP Header: %08x %08x %08x %08x\n",
+	pci_err(dev, "  TLP Header: %08x %08x %08x %08x\n",
 		t->dw0, t->dw1, t->dw2, t->dw3);
 }
 
@@ -155,10 +155,10 @@ static void __aer_print_error(struct pci_dev *dev,
 				aer_uncorrectable_error_string[i] : NULL;
 
 		if (errmsg)
-			dev_err(&dev->dev, "   [%2d] %-22s%s\n", i, errmsg,
+			pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 		else
-			dev_err(&dev->dev, "   [%2d] Unknown Error Bit%s\n",
+			pci_err(dev, "   [%2d] Unknown Error Bit%s\n",
 				i, info->first_error == i ? " (First)" : "");
 	}
 }
@@ -169,7 +169,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int id = ((dev->bus->number << 8) | dev->devfn);
 
 	if (!info->status) {
-		dev_err(&dev->dev, "PCIe Bus Error: severity=%s, type=Unaccessible, id=%04x(Unregistered Agent ID)\n",
+		pci_err(dev, "PCIe Bus Error: severity=%s, type=Unaccessible, id=%04x(Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity], id);
 		goto out;
 	}
@@ -177,11 +177,11 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	dev_err(&dev->dev, "PCIe Bus Error: severity=%s, type=%s, id=%04x(%s)\n",
+	pci_err(dev, "PCIe Bus Error: severity=%s, type=%s, id=%04x(%s)\n",
 		aer_error_severity_string[info->severity],
 		aer_error_layer[layer], id, aer_agent_string[agent]);
 
-	dev_err(&dev->dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
+	pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
 		dev->vendor, dev->device,
 		info->status, info->mask);
 
@@ -192,7 +192,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 out:
 	if (info->id && info->error_dev_num > 1 && info->id == id)
-		dev_err(&dev->dev, "  Error of this Agent(%04x) is reported first\n", id);
+		pci_err(dev, "  Error of this Agent(%04x) is reported first\n", id);
 
 	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
 			info->severity);
@@ -200,7 +200,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 
 void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
 {
-	dev_info(&dev->dev, "AER: %s%s error received: id=%04x\n",
+	pci_info(dev, "AER: %s%s error received: id=%04x\n",
 		info->multi_error_valid ? "Multiple " : "",
 		aer_error_severity_string[info->severity], info->id);
 }
@@ -242,13 +242,13 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-	dev_err(&dev->dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
+	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
 	cper_print_bits("", status, status_strs, status_strs_size);
-	dev_err(&dev->dev, "aer_layer=%s, aer_agent=%s\n",
+	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
 		aer_error_layer[layer], aer_agent_string[agent]);
 
 	if (aer_severity != AER_CORRECTABLE)
-		dev_err(&dev->dev, "aer_uncor_severity: 0x%08x\n",
+		pci_err(dev, "aer_uncor_severity: 0x%08x\n",
 			aer->uncor_severity);
 
 	if (tlp_header_valid)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9783e10..b89843e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -278,7 +278,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
 		return;
 
 	/* Training failed. Restore common clock configurations */
-	dev_err(&parent->dev, "ASPM: Could not configure common clock\n");
+	pci_err(parent, "ASPM: Could not configure common clock\n");
 	list_for_each_entry(child, &linkbus->devices, bus_list)
 		pcie_capability_write_word(child, PCI_EXP_LNKCTL,
 					   child_reg[PCI_FUNC(child->devfn)]);
@@ -328,8 +328,7 @@ static u32 calc_l1ss_pwron(struct pci_dev *pdev, u32 scale, u32 val)
 	case 2:
 		return val * 100;
 	}
-	dev_err(&pdev->dev, "%s: Invalid T_PwrOn scale: %u\n",
-		__func__, scale);
+	pci_err(pdev, "%s: Invalid T_PwrOn scale: %u\n", __func__, scale);
 	return 0;
 }
 
@@ -786,7 +785,7 @@ static int pcie_aspm_sanity_check(struct pci_dev *pdev)
 		 */
 		pcie_capability_read_dword(child, PCI_EXP_DEVCAP, &reg32);
 		if (!(reg32 & PCI_EXP_DEVCAP_RBER) && !aspm_force) {
-			dev_info(&child->dev, "disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'\n");
+			pci_info(child, "disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'\n");
 			return -EINVAL;
 		}
 	}
@@ -1027,7 +1026,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
 	 * ignored in this situation.
 	 */
 	if (aspm_disabled) {
-		dev_warn(&pdev->dev, "can't disable ASPM; OS doesn't have ASPM control\n");
+		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
 		return;
 	}
 
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index df290aa..046d9bf 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -198,14 +198,14 @@ static void pcie_pme_handle_request(struct pci_dev *port, u16 req_id)
 		 * assuming that the PME was reported by a PCIe-PCI bridge that
 		 * used devfn different from zero.
 		 */
-		dev_dbg(&port->dev, "PME interrupt generated for non-existent device %02x:%02x.%d\n",
+		pci_dbg(port, "PME interrupt generated for non-existent device %02x:%02x.%d\n",
 			busnr, PCI_SLOT(devfn), PCI_FUNC(devfn));
 		found = pcie_pme_from_pci_bridge(bus, 0);
 	}
 
  out:
 	if (!found)
-		dev_dbg(&port->dev, "Spurious native PME interrupt!\n");
+		pci_dbg(port, "Spurious native PME interrupt!\n");
 }
 
 /**
@@ -345,7 +345,7 @@ static int pcie_pme_probe(struct pcie_device *srv)
 		return ret;
 	}
 
-	dev_info(&port->dev, "Signaling PME with IRQ %d\n", srv->irq);
+	pci_info(port, "Signaling PME with IRQ %d\n", srv->irq);
 
 	pcie_pme_mark_devices(port);
 	pcie_pme_interrupt_enable(port, true);
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index bab8ac6..c9f9b15 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -33,7 +33,7 @@ static void pci_ptm_info(struct pci_dev *dev)
 			 dev->ptm_granularity);
 		break;
 	}
-	dev_info(&dev->dev, "PTM enabled%s, %s granularity\n",
+	pci_info(dev, "PTM enabled%s, %s granularity\n",
 		 dev->ptm_root ? " (root)" : "", clock_desc);
 }
 
-- 
2.7.4
