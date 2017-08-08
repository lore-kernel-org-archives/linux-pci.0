Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34273 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdHHEo3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2017 00:44:29 -0400
Received: by mail-qt0-f177.google.com with SMTP id s6so14032385qtc.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Aug 2017 21:44:29 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH 1/2] PCI: iproc: Implement PCI hotplug support
Date: Tue,  8 Aug 2017 10:14:14 +0530
Message-Id: <1502167455-10516-2-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com>
References: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch implements PCI hotplug support for iproc family chipsets.

Iproc based SOC (e.g. Stingray) does not have hotplug controller
integrated.
Hence, standard PCI hotplug framework hooks can-not be used.
e.g. controlled power up/down of slot.

The mechanism, for e.g. Stingray has adopted for PCI hotplug is as follows:
PCI present lines are input to GPIOs depending on the type of
connector (x2, x4, x8).

GPIO array needs to be present if hotplug is supported.
HW implementation is SOC/Board specific, and also it depends on how
add-in card is designed
(e.g. how many present pins are implemented).

If x8 card is connected, then it might be possible that all the
3 present pins could go low, or at least one pin goes low.
If x4 card is connected, then it might be possible that 2 present
pins go low, or at least one pin goes low.

The implementation essentially takes care of following:
> Initializing hotplug irq thread.
> Detecting the endpoint device based on link state.
> Handling PERST and detecting the plugged devices.
> Ordered hot plug-out, where User is expected
  to write 1 to /sys/bus/pci/devices/<pci_dev>/remove
> Handling spurious interrupt
> Handling multiple interrupts and makes sure that card is
  enumerated only once.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 9512960..e51bbd2 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -89,6 +89,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->need_ob_cfg = true;
 	}
 
+	if (of_property_read_bool(np, "brcm,pci-hotplug"))
+		pcie->enable_hotplug = true;
+
 	/* PHY use is optional */
 	pcie->phy = devm_phy_get(dev, "pcie-phy");
 	if (IS_ERR(pcie->phy)) {
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index ee40651..c6d1add 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -28,6 +28,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
+#include <linux/gpio.h>
 
 #include "pcie-iproc.h"
 
@@ -65,6 +66,17 @@
 #define PCIE_DL_ACTIVE_SHIFT         2
 #define PCIE_DL_ACTIVE               BIT(PCIE_DL_ACTIVE_SHIFT)
 
+#define CFG_RC_LTSSM                 0x1cf8
+#define CFG_RC_PHY_CTL               0x1804
+#define CFG_RC_LTSSM_TIMEOUT         1000
+#define CFG_RC_LTSSM_STATE_MASK      0xff
+#define CFG_RC_LTSSM_STATE_L1        0x1
+
+#define CFG_RC_CLR_LTSSM_HIST_SHIFT  29
+#define CFG_RC_CLR_LTSSM_HIST_MASK   BIT(CFG_RC_CLR_LTSSM_HIST_SHIFT)
+#define CFG_RC_CLR_RECOV_HIST_SHIFT  31
+#define CFG_RC_CLR_RECOV_HIST_MASK   BIT(CFG_RC_CLR_RECOV_HIST_SHIFT)
+
 #define APB_ERR_EN_SHIFT             0
 #define APB_ERR_EN                   BIT(APB_ERR_EN_SHIFT)
 
@@ -1306,12 +1318,106 @@ static int iproc_pcie_rev_init(struct iproc_pcie *pcie)
 	return 0;
 }
 
+static bool iproc_pci_hp_check_ltssm(struct iproc_pcie *pcie)
+{
+	struct pci_bus *bus = pcie->root_bus;
+	u32 val, timeout = CFG_RC_LTSSM_TIMEOUT;
+
+	/* Clear LTSSM history. */
+	pci_bus_read_config_dword(pcie->root_bus, 0,
+				  CFG_RC_PHY_CTL, &val);
+	pci_bus_write_config_dword(bus, 0, CFG_RC_PHY_CTL,
+				   val | CFG_RC_CLR_RECOV_HIST_MASK |
+				   CFG_RC_CLR_LTSSM_HIST_MASK);
+	/* write back the origional value. */
+	pci_bus_write_config_dword(bus, 0, CFG_RC_PHY_CTL, val);
+
+	do {
+		pci_bus_read_config_dword(pcie->root_bus, 0,
+					  CFG_RC_LTSSM, &val);
+		/* check link state to see if link moved to L1 state. */
+		if ((val & CFG_RC_LTSSM_STATE_MASK) ==
+		     CFG_RC_LTSSM_STATE_L1)
+			return true;
+		timeout--;
+		usleep_range(500, 1000);
+	} while (timeout);
+
+	return false;
+}
+
+static irqreturn_t iproc_pci_hotplug_thread(int irq, void *data)
+{
+	struct iproc_pcie *pcie = data;
+	struct pci_bus *bus = pcie->root_bus, *child;
+	bool link_status;
+
+	iproc_pcie_perst_ctrl(pcie, true);
+	iproc_pcie_perst_ctrl(pcie, false);
+
+	link_status = iproc_pci_hp_check_ltssm(pcie);
+
+	if (link_status &&
+	    !iproc_pcie_check_link(pcie, bus) &&
+	    !pcie->ep_is_present) {
+		pci_rescan_bus(bus);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+		pcie->ep_is_present = true;
+		dev_info(pcie->dev,
+			 "PCI Hotplug: <device detected and enumerated>\n");
+	} else if (link_status && pcie->ep_is_present)
+		/*
+		 * ep_is_present makes sure, enumuration done only once.
+		 * So it can handle spurious intrrupts, and also if we
+		 * get multiple interrupts for all the implemented pins,
+		 * we handle it only once.
+		 */
+		dev_info(pcie->dev,
+			 "PCI Hotplug: <device already present>\n");
+	else {
+		iproc_pcie_perst_ctrl(pcie, true);
+		pcie->ep_is_present = false;
+		dev_info(pcie->dev,
+			 "PCI Hotplug: <device removed>\n");
+	}
+	return IRQ_HANDLED;
+}
+
+static int iproc_pci_hp_gpio_irq_get(struct iproc_pcie *pcie)
+{
+	struct gpio_descs *hp_gpiod;
+	struct device *dev = pcie->dev;
+	int i;
+
+	hp_gpiod = devm_gpiod_get_array(dev, "brcm,prsnt", GPIOD_IN);
+	if (PTR_ERR(hp_gpiod) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	if (!IS_ERR(hp_gpiod) && (hp_gpiod->ndescs > 0)) {
+		for (i = 0; i < hp_gpiod->ndescs; ++i) {
+			gpiod_direction_input(hp_gpiod->desc[i]);
+			if (request_threaded_irq(gpiod_to_irq
+						 (hp_gpiod->desc[i]),
+						 NULL, iproc_pci_hotplug_thread,
+						 IRQF_TRIGGER_FALLING,
+						 "PCI-hotplug", pcie))
+				dev_err(dev,
+					"PCI hotplug prsnt: request irq failed\n");
+			}
+	}
+	pcie->ep_is_present = false;
+
+	return 0;
+}
+
 int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 {
 	struct device *dev;
 	int ret;
 	void *sysdata;
 	struct pci_bus *bus, *child;
+	bool is_link_active;
 
 	dev = pcie->dev;
 
@@ -1337,6 +1443,12 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		goto err_exit_phy;
 	}
 
+	if (pcie->enable_hotplug) {
+		ret = iproc_pci_hp_gpio_irq_get(pcie);
+		if (ret < 0)
+			return ret;
+	}
+
 	iproc_pcie_perst_ctrl(pcie, true);
 	iproc_pcie_perst_ctrl(pcie, false);
 
@@ -1367,8 +1479,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	}
 	pcie->root_bus = bus;
 
-	ret = iproc_pcie_check_link(pcie, bus);
-	if (ret) {
+	is_link_active = iproc_pcie_check_link(pcie, bus);
+	if (is_link_active && pcie->enable_hotplug) {
+		dev_err(dev, "no PCIe EP device detected\n");
+		iproc_pcie_perst_ctrl(pcie, true);
+	} else if (is_link_active) {
 		dev_err(dev, "no PCIe EP device detected\n");
 		goto err_rm_root_bus;
 	}
@@ -1379,14 +1494,17 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		if (iproc_pcie_msi_enable(pcie))
 			dev_info(dev, "not using iProc MSI\n");
 
-	pci_scan_child_bus(bus);
-	pci_assign_unassigned_bus_resources(bus);
+	if (!is_link_active) {
+		pci_scan_child_bus(bus);
+		pci_assign_unassigned_bus_resources(bus);
+	}
 
 	if (pcie->map_irq)
 		pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
 
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
+	if (!is_link_active)
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
 
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index a6b55ce..e5d0cd4 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -77,6 +77,10 @@ struct iproc_pcie_ib {
  * @ib: inbound mapping related parameters
  * @ib_map: outbound mapping region related parameters
  *
+ * @enable_hotplug: indicates PCI hotplug feature is enabled
+ * @ep_is_present: when PCIe hotplug is enabled, this flag is used to
+ * indicate whether or not the endpoint device is present
+ *
  * @need_msi_steer: indicates additional configuration of the iProc PCIe
  * controller is required to steer MSI writes to external interrupt controller
  * @msi: MSI data
@@ -104,6 +108,9 @@ struct iproc_pcie {
 	struct iproc_pcie_ib ib;
 	const struct iproc_pcie_ib_map *ib_map;
 
+	bool enable_hotplug;
+	bool ep_is_present;
+
 	bool need_msi_steer;
 	struct iproc_msi *msi;
 };
-- 
1.9.1
