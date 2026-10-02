Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432548E0E9;
	Fri,  2 Oct 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939424; cv=none; b=m6819oCYclD/CzVqxVFRmB0lIRhlyM1bOv0eFCqVAaJSbScgVCIpfnCXxGOHC3YHFskCAR6xUVNwhU6WMArnl6Q20exWe3BupF42g38umgpxYGs93qcliyMRyPsN2Al9trDD4GJSDYIWHu6G+11GKGJviKD2GrzxS5aLlKkoJ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939424; c=relaxed/simple;
	bh=M/9jKTLFwh/GK1ISIbGi2SX9DUvdHdG2FUm5zFlNBrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oisV2LpzdtBfpuBeTo6XckoePXSK7Id08o0VDmv2XN6Ahg5Wh6TZ+rCMHXX2QesrysdVFAptIoAltNJiCifLU2hETNqjXzkNo12BZ5FUr+f1G0Rkc0A4GGwFg0srzMUJSatD9Cqb07Wicc6L5WXNFB61sIJNdcnlkSJ3rQN54/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuZ37eSw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuZ37eSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2E91F00899;
	Fri,  2 Oct 2026 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939415;
	bh=mv9YIQu4WyxIt27eG+C05efH4K2fW0EweM7Bu+0dLTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iuZ37eSwMFTkJM1BTwFILq+0SC8aawyZX6VhEPE2aQ2aKDlHHb+VHwSXuum5ztoSW
	 IhkQmTf4Fkim9m5QWT5kxyFWFoOp7sqqqgHihLt4IE3ynkzaky67iM3Wk/nywfvcIi
	 XXogV+XczX27i7Q6WPAh1fXtoykP6B+rD/eE6gx4fkQahkZlHBC34+SlSKcQsiKdQo
	 ZtZjPz7/OFQaEwJaEWkQl9euW1kslqehkY/lsd7C8Be/7y1ncvepzV0xqXpUCzzM6l
	 w//sW0s8FCCn8pHzT+RgihJRwcLuNz4xTOUD9ubjIntqPomevvlnF4C+ZDCsM7Hd2i
	 r+3o+MYPhSteQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	18255117159@163.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 8/9] PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes
Date: Fri,  2 Oct 2026 14:09:34 +0300
Message-ID: <20261002110935.2004349-9-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Madieu <john.madieu.xa@bp.renesas.com>

The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers do not expose the
standard PCIe Slot Capability registers, so the generic pciehp driver
cannot be used. The only link-state signal the hardware provides is the
DL_UpDown bit in the PEIS0 event status register, which is raised on every
Data Link layer up/down transition.

Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
can react to link-state changes: a device that trains after boot gets
enumerated, and a device that disappears on link loss is removed. This
provides hotplug-like behavior without the PCI hotplug core, which is
unavailable for the reason above.

On a DL_UpDown event the handler acks the W1C status bit and inspects
PCSTAT1.DL_DOWN_STS:

  - link up: re-run max link speed negotiation, wait for the link to
    settle and rescan the root bus;
  - link down: walk the bus in reverse and pci_stop_and_remove_bus_device()
    each child.

Both paths take pci_lock_rescan_remove() to serialize against the PCI
core.

Link events are processed only after the controller has been fully
initialized.

Add rzg3s_host_pm_notifier() to avoid the link event interrupt interfering
with the suspend/resume of the other PCIe devices in the topology, and to
avoid deadlocks caused by pci_dev_lock() being taken from the link event
handler while suspend/resume is in progress. The notifier disables the link
event interrupt before suspend and enables it and rescans the bus, on
resume, to pick up devices that may have been plugged or unplugged while
the system was suspended.

While at it, make probe tolerant of an absent device. Previously, if the
link failed to come up during rzg3s_pcie_host_init(), probe tore the
controller back down and failed. Distinguish this case with -ENODEV,
leave the controller and refclk running, and let the link-up path
enumerate the device once it appears.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- in rzg3s_pcie_link_event(), on link up path, added pcie_bus_configure_settings();
  and dropped pci_rescan_bus() and inlined its instructions
- pm_runtime_get_sync(&bridge->dev)/pm_runtime_put_sync(&bridge->dev) to avoid
  "pci 0000:00:00.0: runtime PM trying to activate child device 0000:00:00.0 but
  parent (pci0000:00) is not active"
- added a PM notifier and disable/enable the link interrupt
  before suspend/after resume to avoid deadlocks b/w PM core and any PCI
  core code calling pci_dev_lock(); the next patch uses pci_host_handle_link_down()
  which calls pci_dev_lock() on the following path:
  pci_host_handle_link_down() -> 
    pci_host_reset_root_port() ->
      pci_bus_error_reset() ->
        pci_reset_bridge() ->
          pci_slot_reset() ->
            pci_slot_lock() ->
              __pci_bus_lock() ->
                pci_dev_lock()
- added struct rzg3s_pcie_host::link_rescan to force a link rescan on return
  from resume and handle scenarios where devices dissaper while in suspend
- updated the commit message to reflect this
- didn't collect the tags from v4 dues to these changes

Changes in v4:
- dropped .reset_root_port() changes

Changes in v3:
- added RZG3S_PCI_PEIE0_DL_UPDOWN
- re-worked the support by implemeting
  struct pci_host_bridge::reset_root_port()
- introduced the struct rzg3s_pcie_host::state to:
-- avoid touching the controller while a reset root port is in progress
-- and avoid touching the controller in case a reset root port failed
-- and to be able to re-use the already existing code in the reset
   root port function
-- and added CLASS() constructs helpers for it to keep the state handling
   code simpler
- updated the patch description to reflect the updates

 drivers/pci/controller/pcie-rzg3s-host.c | 193 +++++++++++++++++++++--
 1 file changed, 177 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 3b62b1be5b2a..78e783928b9d 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -33,6 +33,7 @@
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/units.h>
 
 #include "pci-host-common.h"
@@ -86,6 +87,7 @@
 #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
 
 #define RZG3S_PCI_PEIE0				0x200
+#define RZG3S_PCI_PEIE0_DL_UPDOWN		BIT(9)
 
 #define RZG3S_PCI_PEIS0				0x204
 #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
@@ -323,9 +325,12 @@ struct rzg3s_pcie_port {
  * @msi: MSI data structure
  * @port: PCIe Root Port
  * @hw_lock: lock for access to the HW resources
+ * @pm_nb: PM notifier block (for link events)
+ * @event_irq: PCIe event interrupt for DL_UpDown detection
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
+ * @link_rescan: The PCIe link rescan state
  * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
@@ -340,9 +345,12 @@ struct rzg3s_pcie_host {
 	struct rzg3s_pcie_msi msi;
 	struct rzg3s_pcie_port port;
 	raw_spinlock_t hw_lock;
+	struct notifier_block pm_nb;
+	int event_irq;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
+	bool link_rescan;
 	u8 num_lanes;
 };
 
@@ -1095,6 +1103,98 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	struct pci_bus *bus = bridge->bus;
+	u32 val;
+
+	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
+	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
+		struct pci_dev *dev, *tmp;
+
+		dev_info(host->dev, "PCIe link down, removing devices\n");
+
+		pci_lock_rescan_remove();
+		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
+						 bus_list)
+			pci_stop_and_remove_bus_device(dev);
+		pci_unlock_rescan_remove();
+	} else {
+		struct pci_bus *child;
+		int ret;
+
+		dev_info(host->dev, "PCIe link up, rescanning bus\n");
+
+		/*
+		 * Attempt link speed negotiation now that the link is up.
+		 * Failure is non-fatal: the device works at the negotiated
+		 * speed.
+		 */
+		ret = rzg3s_pcie_set_max_link_speed(host);
+		if (ret)
+			dev_info(host->dev, "Failed to set max link speed\n");
+
+		pci_host_common_link_train_delay(host->max_link_speed);
+
+		pm_runtime_get_sync(&bridge->dev);
+		pci_lock_rescan_remove();
+		pci_scan_child_bus(bus);
+		pci_assign_unassigned_bus_resources(bus);
+		list_for_each_entry(child, &bus->children, node)
+			pcie_bus_configure_settings(child);
+		pci_bus_add_devices(bus);
+		pci_unlock_rescan_remove();
+		pm_runtime_put_sync(&bridge->dev);
+	}
+}
+
+static irqreturn_t rzg3s_pcie_event_irq_thread(int irq, void *data)
+{
+	struct rzg3s_pcie_host *host = data;
+	u32 status;
+
+	status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
+
+	if (!(status & RZG3S_PCI_PEIS0_DL_UPDOWN) &&
+	    !READ_ONCE(host->link_rescan))
+		return IRQ_NONE;
+
+	/* Clear the DL_UpDown status (W1C) */
+	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
+	WRITE_ONCE(host->link_rescan, false);
+
+	rzg3s_pcie_link_event(host);
+
+	return IRQ_HANDLED;
+}
+
+static int rzg3s_pcie_request_event_irq(struct rzg3s_pcie_host *host)
+{
+	struct device *dev = host->dev;
+	struct platform_device *pdev = to_platform_device(dev);
+	const char *evt_name;
+	int ret, irq;
+
+	evt_name = devm_kasprintf(dev, GFP_KERNEL, "%s-evt", dev_name(dev));
+	if (!evt_name)
+		return -ENOMEM;
+
+	irq = platform_get_irq_byname(pdev, "pcie_evt");
+	if (irq < 0)
+		return irq;
+
+	ret = request_threaded_irq(irq, NULL, rzg3s_pcie_event_irq_thread,
+				   IRQF_ONESHOT, evt_name, host);
+	if (ret) {
+		return dev_err_probe(dev, ret,
+				     "Failed to request pcie_evt IRQ\n");
+	}
+	host->event_irq = irq;
+
+	return 0;
+}
+
 static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
 {
 	while (--count >= 0) {
@@ -1106,6 +1206,17 @@ static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
 		irq_domain_remove(host->intx_domain);
 }
 
+static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
+{
+	if (host->event_irq > 0)
+		free_irq(host->event_irq, host);
+
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rzg3s_pcie_teardown_msi(host);
+
+	rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
+}
+
 static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 {
 	struct device *dev = host->dev;
@@ -1152,22 +1263,21 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
 			goto teardown_intx;
 	}
 
+	ret = rzg3s_pcie_request_event_irq(host);
+	if (ret)
+		goto teardown_msi;
+
 	return 0;
 
+teardown_msi:
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		rzg3s_pcie_teardown_msi(host);
 teardown_intx:
 	rzg3s_pcie_teardown_intx(host, i);
 
 	return ret;
 }
 
-static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		rzg3s_pcie_teardown_msi(host);
-
-	rzg3s_pcie_teardown_intx(host, PCI_NUM_INTX);
-}
-
 static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
@@ -1679,16 +1789,21 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
 				 PCIE_LINK_WAIT_MAX_RETRIES);
-	if (ret)
-		goto config_deinit_post;
+	if (ret) {
+		/*
+		 * Link is down. Leave the controller running so the
+		 * DL_UpDown handler can enumerate a device that appears
+		 * later.
+		 */
+		dev_info(host->dev, "PCIe link down, waiting for DL_UpDown\n");
+		ret = -ENODEV;
+	}
 
 	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
 
-	return 0;
+	return ret;
 
-config_deinit_post:
-	host->data->config_deinit(host);
 config_deinit_and_refclk:
 	clk_disable_unprepare(host->port.refclk);
 config_deinit:
@@ -1723,8 +1838,14 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 
 	ret = rzg3s_pcie_host_init(host);
 	if (ret) {
-		dev_err_probe(dev, ret, "Failed to initialize the HW!\n");
-		goto teardown_irqdomain;
+		if (ret != -ENODEV) {
+			dev_err_probe(dev, ret,
+				      "Failed to initialize the HW!\n");
+			goto teardown_irqdomain;
+		}
+
+		/* Link is down: hotplug via DL_UpDown will recover. */
+		return 0;
 	}
 
 	ret = rzg3s_pcie_set_max_link_speed(host);
@@ -1905,6 +2026,31 @@ static void rzv2h_pcie_release_lanes(void *data)
 	rzv2h_num_total_lanes -= host->num_lanes;
 }
 
+static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct rzg3s_pcie_host *host = container_of(nb, struct rzg3s_pcie_host,
+						    pm_nb);
+
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+		/* Disable link up/down interrupts. */
+		disable_irq(host->event_irq);
+		break;
+
+	case PM_POST_SUSPEND:
+		/* Enable link up/down interrupts and force link re-scan. */
+		writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
+			       host->axi + RZG3S_PCI_PEIE0);
+		WRITE_ONCE(host->link_rescan, true);
+		enable_irq(host->event_irq);
+		irq_wake_thread(host->event_irq, host);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int rzg3s_pcie_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *bridge;
@@ -1997,15 +2143,30 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_resets_assert;
 
+	host->pm_nb.notifier_call = rzg3s_pcie_pm_notifier;
+	ret = register_pm_notifier(&host->pm_nb);
+	if (ret)
+		goto host_probe_teardown;
+
 	bridge->sysdata = host;
 	bridge->ops = &rzg3s_pcie_root_ops;
 	bridge->child_ops = &rzg3s_pcie_child_ops;
 	ret = pci_host_probe(bridge);
 	if (ret)
-		goto host_probe_teardown;
+		goto pm_notifier_unregister;
+
+	/*
+	 * Unmask the PCIe event IRQ at the end of probe to avoid
+	 * spurious link-state events during controller setup and bus
+	 * enumeration. From here on, DL_UpDown events trigger the link
+	 * IRQ thread to (re)scan the bus.
+	 */
+	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
 
 	return 0;
 
+pm_notifier_unregister:
+	unregister_pm_notifier(&host->pm_nb);
 host_probe_teardown:
 	clk_disable_unprepare(host->port.refclk);
 	rzg3s_pcie_teardown_irqdomain(host);
-- 
2.43.0

