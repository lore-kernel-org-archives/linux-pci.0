Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9821D48DB57;
	Mon, 19 Oct 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392732; cv=none; b=JUucUh402Rbr4S1IJPcV6YW89iVC+1ffkMPEe7msyoOixQ1MR3aKSMUwxj4tQQtEXaGOAujJo9dbz7Nc0WN0DVazjxKMsRlpjCXKffGwVp9Mlo7OMaopoxBIXemVIeS0zZeYvjie/unliTysdHAgj5wprDUsRO1feynZfldYopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392732; c=relaxed/simple;
	bh=C9AONGm64A8ad5KvqjY/z8X8flVBNIJ6Y5Y0E5LN4qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehDCGcFLEsD6pUQeMueJPQv2hsZku431KP1Dd4dWzi8gVUmQESLAteRz8hTuOcB3jgwAC2rT5+5Mnx2KG3lE0txujyczM1WGL23qo58lasGbUHY6uDAnjookiLIZnvOKItkoReiWtzt7GkEsQ9iwH894JfOu0YK55L4DWQ8O2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9VmcQ02; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9VmcQ02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD541F000C4;
	Mon, 19 Oct 2026 06:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392730;
	bh=8trHJHLWv6CvPEaJaDK0LR27q0zgxLegYdvLEO0Aoe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j9VmcQ02WLltt2Wz98MMvw93oPGdgj3D9xkMT2oa1Etr6VVJHMbmHztvXypd9iVZb
	 ZwgZZ8Agdw0JeFpD9HdD/rvUnyLi3nv9BmyHXZjyC+m8sUYMY2GjbEbvdGHtp8hdNm
	 PLNljLXyI1QQskZ4bSf5ywlC4NFkTxSPlAWU48YflHttYhQQEnx5jtAisYkv/bxOzc
	 8r6FeedK2sAMJlcE+i3SVxNRAX/V2AClMx9+eZITQj4zRNBEOoqrMqjnYfmn5wVFRL
	 kYw6vhIOm+mTz678fRWFMLD+KLsllQdrQQvtp0KAEu09tTcjuzuWgnVzjgECOi1zQo
	 dgK5gJr6KXvxA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 13/14] PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes
Date: Mon, 19 Oct 2026 09:50:24 +0300
Message-ID: <20261019065025.2146539-14-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
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

- Link up: re-run max link speed negotiation, wait for the link to settle
  and rescan the root bus. To cover the case where the device is replaced
  or removed while the system is suspended add the
  rzg3s_pcie_device_replaced(). It reads the vendor ID, device ID,
  revision ID and class code of the device behind the root port and
  compares them against the values cached in the corresponding
  struct pci_dev, along with the Device Serial Number cached in
  struct rzg3s_pcie_host::con_dev_dsn, mirroring pciehp_device_replaced().
  If the device is detected as replaced (or no longer present),
  pci_dev_set_disconnected() is called for all the devices on the bus
  below the root port, so that the teardown of the old devices does not
  end up accessing the newly connected device, and the devices are then
  removed. If a link up/down cycle occurred while devices are on the bus
  (fast link transitions coalesced into a single DL_UpDown event), the
  devices are removed and re-enumerated even if the connected device did
  not change.
- Link down: walk the bus in reverse and pci_stop_and_remove_bus_device()
  each child.

Both paths take pci_lock_rescan_remove() to serialize against the PCI
core.

Link events are processed only after the controller has been fully
initialized.

Add rzg3s_pcie_pm_notifier() to avoid the link event interrupt interfering
with the suspend/resume of the other PCIe devices in the topology, and to
avoid deadlocks caused by pci_dev_lock() being taken from the link event
handler while suspend/resume is in progress. The notifier disables the link
event interrupt before suspend and enables it and rescans the bus, on
resume, to pick up devices that may have been plugged or unplugged while
the system was suspended. struct rzg3s_pcie_host::started was added to
avoid touching the controller registers in case the resume failed.

While at it, make probe tolerant of an absent device. Previously, if the
link failed to come up during rzg3s_pcie_host_setup(), probe tore the
controller back down and failed. Ignore the timeout returned by
rzg3s_pcie_wait_for_link_up(), leave the controller and refclk running,
and let the link-up path enumerate the device once it appears.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- in rzg3s_pcie_remove_devices() set the device and the subordinate ones
  as disconnected before stop and remove them
- in rzg3s_pcie_event_irq_thread() kept the line 80 chars aligned
- in rzg3s_pcie_pm_notifier():
-- suspend path: disable the link IRQ at controller level as well
   (prerequisite for the next patch)
-- resume path: keep the sequence of enabling the link IRQ same as
   in probe
- due to this, dropped Prabakar's Rb tag

Changes in v6:
- moved the struct rzg3s_pcie_host::started in this patch to avoid
  setting the controller in failure cases (started = false)
- adopted the approch from pciehp driver with regards to checking the
  DSN of the connected device and decide, based on this, if the bus
  devices need to be removed + rescanned; the DSN of the connected
  device is cached in probe and link up events
- in case of link up events with !list_empty(&bus->devices) remove
  first the devices from the bus and re-scan (adopted from pciehp driver)
- in rzg3s_pcie_pm_notifier() touch the HW registers only if host->started
- in rzg3s_pcie_resume_noirq() call pci_dev_set_disconnected() for the
  devices on the bus if the connected device is changed at the resume
  similar to what the pciehp driver is doing
- made adjustments to rzg3s_pcie_wait_for_link_up()
- dropped the tags
- adjusted patch description

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

 drivers/pci/controller/pcie-rzg3s-host.c | 321 +++++++++++++++++++++--
 1 file changed, 303 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 1ced6d83c7c1..a1c9e29f43e5 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -33,6 +33,7 @@
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/units.h>
 
 #include "pci-host-common.h"
@@ -87,6 +88,7 @@
 #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
 
 #define RZG3S_PCI_PEIE0				0x200
+#define RZG3S_PCI_PEIE0_DL_UPDOWN		BIT(9)
 
 #define RZG3S_PCI_PEIS0				0x204
 #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
@@ -324,9 +326,16 @@ struct rzg3s_pcie_port {
  * @msi: MSI data structure
  * @port: PCIe Root Port
  * @hw_lock: lock for access to the HW resources
+ * @pm_nb: PM notifier block (for link events)
+ * @con_dev_dsn: Device Serial Number for the connected device, used to
+ * determine whether a hotplugged device was replaced with a different one
+ * during system sleep
+ * @event_irq: PCIe event interrupt for DL_UpDown detection
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
+ * @link_rescan: The PCIe link rescan state
+ * @started: The PCIe controller state (started or not)
  * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
@@ -341,9 +350,14 @@ struct rzg3s_pcie_host {
 	struct rzg3s_pcie_msi msi;
 	struct rzg3s_pcie_port port;
 	raw_spinlock_t hw_lock;
+	struct notifier_block pm_nb;
+	u64 con_dev_dsn;
+	int event_irq;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
+	bool link_rescan;
+	bool started;
 	u8 num_lanes;
 };
 
@@ -1094,12 +1108,187 @@ static int rzg3s_pcie_wait_for_link_up(struct rzg3s_pcie_host *host)
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI,
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
 				 PCIE_LINK_WAIT_MAX_RETRIES);
-	if (ret)
-		return ret;
+	if (ret) {
+		dev_info(host->dev,
+			 "PCIe link down, waiting for DL_UpDown\n");
+	}
 
 	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
 
+	return ret;
+}
+
+static struct pci_dev
+*rzg3s_pcie_get_connected_dev(struct rzg3s_pcie_host *host)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	struct pci_dev *port __free(pci_dev_put) =
+		pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+
+	if (!port || !port->subordinate)
+		return NULL;
+
+	return pci_get_slot(port->subordinate, PCI_DEVFN(0, 0));
+}
+
+static void rzg3s_pcie_cache_connected_dev_id(struct rzg3s_pcie_host *host)
+{
+	struct pci_dev *con_dev __free(pci_dev_put) =
+		rzg3s_pcie_get_connected_dev(host);
+
+	host->con_dev_dsn = con_dev ? pci_get_dsn(con_dev) : 0;
+}
+
+static bool rzg3s_pcie_device_replaced(struct rzg3s_pcie_host *host)
+{
+	struct pci_dev *con_dev __free(pci_dev_put) =
+		rzg3s_pcie_get_connected_dev(host);
+	u32 reg;
+
+	if (!con_dev)
+		return true;
+
+	if (pci_read_config_dword(con_dev, PCI_VENDOR_ID, &reg) ||
+	    reg != (con_dev->vendor | (con_dev->device << 16)) ||
+	    pci_read_config_dword(con_dev, PCI_CLASS_REVISION, &reg) ||
+	    reg != (con_dev->revision | (con_dev->class << 8)))
+		return true;
+
+	if (con_dev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
+	    (pci_read_config_dword(con_dev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
+	     reg != (con_dev->subsystem_vendor |
+		     (con_dev->subsystem_device << 16))))
+		return true;
+
+	if (pci_get_dsn(con_dev) != host->con_dev_dsn)
+		return true;
+
+	return false;
+}
+
+static void rzg3s_pcie_remove_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev, *tmp;
+
+	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
+		pci_dev_set_disconnected(dev, NULL);
+		if (pci_has_subordinate(dev)) {
+			pci_walk_bus(dev->subordinate, pci_dev_set_disconnected,
+				     NULL);
+		}
+		pci_stop_and_remove_bus_device(dev);
+	}
+}
+
+static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bounced)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
+	struct pci_bus *bus = bridge->bus, *child;
+	u32 val;
+	int ret;
+
+	pci_lock_rescan_remove();
+
+	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
+	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
+		if (!list_empty(&bus->devices)) {
+			dev_info(host->dev,
+				 "PCIe link down, removing devices\n");
+			rzg3s_pcie_remove_devices(bus);
+		}
+		goto unlock;
+	}
+
+	if (!list_empty(&bus->devices)) {
+		bool replaced = rzg3s_pcie_device_replaced(host);
+
+		/*
+		 * If bounced = false it means link rescanning (after probe
+		 * or system resume), no link transition was recorded. The
+		 * enumerated devices are intact, so remove them only if the
+		 * connected device was replaced while link events were not
+		 * delivered.
+		 *
+		 * If bounced = true it means at least one real link down/up
+		 * cycle occurred.
+		 */
+		if (!bounced && !replaced)
+			goto unlock;
+
+		rzg3s_pcie_remove_devices(bus);
+	}
+
+	dev_info(host->dev, "PCIe link up, rescanning bus\n");
+
+	ret = rzg3s_pcie_set_max_link_speed(host);
+	if (ret)
+		dev_info(host->dev, "Failed to set max link speed\n");
+
+	pci_host_common_link_train_delay(host->max_link_speed);
+
+	pm_runtime_get_sync(&bridge->dev);
+
+	pci_scan_child_bus(bus);
+	pci_assign_unassigned_bus_resources(bus);
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+	pci_bus_add_devices(bus);
+
+	rzg3s_pcie_cache_connected_dev_id(host);
+
+	pm_runtime_put_sync(&bridge->dev);
+unlock:
+	pci_unlock_rescan_remove();
+}
+
+static irqreturn_t rzg3s_pcie_event_irq_thread(int irq, void *data)
+{
+	struct rzg3s_pcie_host *host = data;
+	bool bounced;
+	u32 status;
+
+	status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
+	bounced = status & RZG3S_PCI_PEIS0_DL_UPDOWN;
+
+	if (!bounced && !READ_ONCE(host->link_rescan))
+		return IRQ_NONE;
+
+	/* Clear the DL_UpDown status (W1C) */
+	if (bounced) {
+		writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
+			       host->axi + RZG3S_PCI_PEIS0);
+	}
+	WRITE_ONCE(host->link_rescan, false);
+
+	rzg3s_pcie_link_event(host, bounced);
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
 	return 0;
 }
 
@@ -1114,6 +1303,17 @@ static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
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
@@ -1158,22 +1358,21 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
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
@@ -1685,14 +1884,8 @@ rzg3s_pcie_host_init(struct rzg3s_pcie_host *host,
 	if (ret)
 		goto teardown_irqdomain;
 
-	ret = rzg3s_pcie_wait_for_link_up(host);
-	if (ret)
-		goto config_deinit_post;
-
 	return 0;
 
-config_deinit_post:
-	host->data->config_deinit(host);
 teardown_irqdomain:
 	teardown_irqdomain(host);
 config_deinit_and_refclk:
@@ -1728,6 +1921,10 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 		return dev_err_probe(dev, ret,
 				     "Failed to initialize the HW!\n");
 
+	ret = rzg3s_pcie_wait_for_link_up(host);
+	if (ret)
+		return 0;
+
 	ret = rzg3s_pcie_set_max_link_speed(host);
 	if (ret)
 		dev_info(dev, "Failed to set max link speed\n");
@@ -1744,6 +1941,9 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
+	if (!host->started)
+		return 0;
+
 	clk_disable_unprepare(port->refclk);
 
 	/* SoC-specific de-initialization */
@@ -1765,6 +1965,8 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto power_resets_restore;
 
+	host->started = false;
+
 	return 0;
 
 	/* Restore the previous state if any error happens */
@@ -1786,6 +1988,9 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
+	if (host->started)
+		return 0;
+
 	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
 	if (ret)
 		return ret;
@@ -1818,6 +2023,8 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto assert_power_resets;
 
+	host->started = true;
+
 	return 0;
 
 	/*
@@ -1901,6 +2108,44 @@ static void rzv2h_pcie_release_lanes(void *data)
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
+		if (host->started)
+			writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
+		disable_irq(host->event_irq);
+		break;
+
+	case PM_POST_SUSPEND:
+		/* Enable link up/down interrupts and force link re-scan. */
+		if (host->started) {
+			/*
+			 * The link re-train in resume triggers the link up IRQ
+			 * if there are connected devices. Clear the DL_UpDown
+			 * status and trigger link_rescan to avoid
+			 * re-enumerating the already connected devices.
+			 */
+			writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
+				       host->axi + RZG3S_PCI_PEIS0);
+			WRITE_ONCE(host->link_rescan, true);
+			writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
+				       host->axi + RZG3S_PCI_PEIE0);
+		}
+		enable_irq(host->event_irq);
+		if (host->started)
+			irq_wake_thread(host->event_irq, host);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int rzg3s_pcie_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *bridge;
@@ -1999,15 +2244,38 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_resets_assert;
 
+	host->started = true;
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
+	pci_lock_rescan_remove();
+	rzg3s_pcie_cache_connected_dev_id(host);
+	pci_unlock_rescan_remove();
+
+	/*
+	 * The link re-train triggers the link up IRQ if there are connected
+	 * devices. Clear DL_UpDown status and trigger link_rescan to avoid
+	 * re-enumerating the devices detected while pci_host_probe() and loose
+	 * any potential event.
+	 */
+	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
+	WRITE_ONCE(host->link_rescan, true);
+	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
+	irq_wake_thread(host->event_irq, host);
 
 	return 0;
 
+pm_notifier_unregister:
+	unregister_pm_notifier(&host->pm_nb);
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
 	clk_disable_unprepare(host->port.refclk);
@@ -2041,8 +2309,25 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 static int rzg3s_pcie_resume_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
+	int ret;
 
-	return rzg3s_pcie_host_start(host);
+	ret = rzg3s_pcie_host_start(host);
+	if (ret)
+		return ret;
+
+	if (rzg3s_pcie_device_replaced(host)) {
+		struct pci_host_bridge *bridge =
+			pci_host_bridge_from_priv(host);
+		struct pci_dev *port __free(pci_dev_put) =
+			pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+
+		if (port && port->subordinate) {
+			pci_walk_bus(port->subordinate,
+				     pci_dev_set_disconnected, NULL);
+		}
+	}
+
+	return 0;
 }
 
 static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
-- 
2.43.0

