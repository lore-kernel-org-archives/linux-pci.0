Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF63C76BC;
	Fri, 14 Aug 2026 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716846; cv=none; b=s9BLZ34+MoCtCI8XihQpHyfk4hAzoDMg+bZw4jvKLFHWj/Uakn99+gyJ/9chV5qgtYV2YOI1o48GIMeTaMriJ4BkgQAGkikbBOyVsuE2DCWY0xJKMed58aCw1nLpMQS/LYeXFjAjSm/dCpaTxoZX2ldP/sOGPAp6iWicDizBj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716846; c=relaxed/simple;
	bh=IqMJKh5ySlsYc5SdE7bs21XEd+j9WvBNHk/OG1TsCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM3KaDUK7CviCBPJmiomzwr5bU2aZRhTN6Rnpx68H7HGl+LwfgwVXKNF1Txwpo2sKYopt2o6iV/b56lt/KAJTWLIVYwwZSbG9ucBRygERrrw65ToOsPo6Ps0qg/XmLqNSgJo5c9vccuW8uH7/LGksMt+qzkZ77PYPfH/6n/xYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAF11F00A3E;
	Fri, 14 Aug 2026 14:13:43 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 7/7] PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes
Date: Fri, 14 Aug 2026 17:13:12 +0300
Message-ID: <20260814141312.2947972-8-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260814141312.2947972-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Madieu <john.madieu.xa@bp.renesas.com>

The RZ/G3{E, S}, RZ/V2{H(P), N} PCIe controllers does not expose the
standard PCIe Slot Capability registers, so the generic pciehp driver
cannot be used. The only link-state signal the hardware provides is the
DL_UpDown bit in the PEIS0 event status register, which is raised on every
Data Link layer up/down transition.

Enable DL_UpDown in PEIE0 and hook up an interrupt handler so the driver
can react to link-state changes: a device that trains after boot gets
enumerated, and a device that disappears on link loss is removed. This
provides hotplug-like behavior without the PCI hotplug core, which is
unavailable for the reason above.

On a DL_UpDown event the handler acks the W1C status bit and schedules a
worker that inspects PCSTAT1.DL_DOWN_STS:

  - link up: re-run max link speed negotiation, wait for the link to
    settle and pci_rescan_bus() the root bus;
  - link down: reset the root port, walk the bus in reverse and
    pci_stop_and_remove_bus_device() each child.

Both paths take pci_lock_rescan_remove() to serialize against the PCI
core.

While enumeration succeeds without resetting the root port, performing
reads and writes to an NVMe endpoint after a link down/link up cycle
results in failures on some devices. Address this by implementing
pci_host_bridge::reset_root_port() for the RZ/G3S PCIe driver.

The implementation of pci_host_bridge::reset_root_port() masks all
enabled interrupts and synchronizes them before resetting the controller
to prevent asynchronous events from interfering with the reset operation.

After the controller is reset, all previously masked interrupts are
restored.

Since rzg3s_pcie_host_stop() or rzg3s_pcie_host_start() can fail
during a root port reset, introduce struct rzg3s_pcie_host::state to
track the host controller state. The interrupt handlers and register
access paths consult this state to avoid accessing the controller after a
failed reset. This was implemented to be able to re-use the
rzg3s_pcie_host_stop()/rzg3s_pcie_host_start() as is (since they call
functions which can sleep).

The introduced states are START, STOP, PROCESS, and PORT_RESET. The initial
state is STOP. After the controller is initialized, the state is switched
to START. Any API exposed through struct pci_ops switches the controller
to the PROCESS state, as do the interrupt handlers.

rzg3s_pcie_host_reset_root_port() switches the state to PORT_RESET to
prevent any controller access while the Root Port reset is in progress.

A controller left in a broken state (STOP) after a failed root port reset
can recover after a system suspend/resume cycle, since
rzg3s_pcie_host_start() is invoked again during resume.

Link events are processed only after the controller has been fully
initialized.

While at it, make probe tolerant of an absent device. Previously, if the
link failed to come up during rzg3s_pcie_host_init(), probe tore the
controller back down and failed. Distinguish this case with -ENODEV,
leave the controller and refclk running, and let the link-up path
enumerate the device once it appears.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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

 drivers/pci/controller/pcie-rzg3s-host.c | 375 +++++++++++++++++++++--
 1 file changed, 356 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 4765ac1befba..b3531468ef38 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -86,6 +86,7 @@
 #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
 
 #define RZG3S_PCI_PEIE0				0x200
+#define RZG3S_PCI_PEIE0_DL_UPDOWN		BIT(9)
 
 #define RZG3S_PCI_PEIS0				0x204
 #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
@@ -310,6 +311,24 @@ struct rzg3s_pcie_port {
 	u32 device_id;
 };
 
+/**
+ * enum rzg3s_pcie_host_state - RZ/G3S PCIe Host state
+ * @RZG3S_PCIE_HOST_STATE_STOP: Host is stopped (initial state, reached from
+ *                              PORT_RESET, START)
+ * @RZG3S_PCIE_HOST_STATE_START: Host is started (reached from STOP, PROCESS,
+ *                               PORT_RESET)
+ * @RZG3S_PCIE_HOST_STATE_PROCESS: Host is started and is processing requests
+ *                                 (reached from START)
+ * @RZG3S_PCIE_HOST_STATE_PORT_RESET: Host root port is resetting (reached from
+ *                                    START)
+ */
+enum rzg3s_pcie_host_state {
+	RZG3S_PCIE_HOST_STATE_STOP,
+	RZG3S_PCIE_HOST_STATE_START,
+	RZG3S_PCIE_HOST_STATE_PORT_RESET,
+	RZG3S_PCIE_HOST_STATE_PROCESS,
+};
+
 /**
  * struct rzg3s_pcie_host - RZ/G3S PCIe data structure
  * @axi: base address for AXI registers
@@ -323,6 +342,8 @@ struct rzg3s_pcie_port {
  * @msi: MSI data structure
  * @port: PCIe Root Port
  * @hw_lock: lock for access to the HW resources
+ * @state: PCIe controller state
+ * @event_irq: PCIe event interrupt for DL_UpDown detection
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
@@ -340,6 +361,8 @@ struct rzg3s_pcie_host {
 	struct rzg3s_pcie_msi msi;
 	struct rzg3s_pcie_port port;
 	raw_spinlock_t hw_lock;
+	atomic_t state;
+	int event_irq;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
@@ -348,6 +371,61 @@ struct rzg3s_pcie_host {
 
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
 
+/**
+ * struct rzg3s_pcie_host_atomic_state - RZ/G3S PCIe state data structure
+ * @state: Atomic state variable to operate on. Should point to
+ *         struct rzg3s_pcie_host::state.
+ * @expect: Expected host state. The host state is not changed if the
+ *          current host state differs from the expected state.
+ * @saved: Saved host state. When the host state is changed, the previous
+ *         state is saved in this variable. This is necessary to restore
+ *         the previous state after the protected section is executed.
+ *
+ * This structure is necessary for state setting and restoration using
+ * CLASS() constructs.
+ */
+struct rzg3s_pcie_host_atomic_state {
+	atomic_t *state;
+	enum rzg3s_pcie_host_state expect;
+	enum rzg3s_pcie_host_state saved;
+};
+
+static struct rzg3s_pcie_host_atomic_state
+rzg3s_pcie_host_atomic_state_save(atomic_t *state, int expect, int newval)
+{
+	return (struct rzg3s_pcie_host_atomic_state){
+		.state = state,
+		.expect = expect,
+		.saved = atomic_cmpxchg(state, expect, newval),
+	};
+}
+
+static void
+rzg3s_pcie_host_atomic_state_restore(struct rzg3s_pcie_host_atomic_state state)
+{
+	if (state.saved == state.expect)
+		atomic_xchg(state.state, state.expect);
+}
+
+DEFINE_CLASS(rzg3s_pcie_host_state_lock,
+	     struct rzg3s_pcie_host_atomic_state,
+	     rzg3s_pcie_host_atomic_state_restore(_T),
+	     rzg3s_pcie_host_atomic_state_save(state, expect, newval),
+	     atomic_t *state, int expect, int newval)
+
+/* Use it to change the state w/o the need to restore it on function exit. */
+#define RZG3S_PCIE_HOST_STATE_CHANGE(_state, _from, _to) \
+	CLASS(rzg3s_pcie_host_state_lock, _lock) \
+	      (_state, RZG3S_PCIE_HOST_STATE_##_from, \
+		       RZG3S_PCIE_HOST_STATE_##_to) \
+
+/*
+ * Use it to check if the state change failed. _from is the initial state.
+ * Use it in conjunction with RZG3S_PCIE_HOST_STATE_CHANGE().
+ */
+#define RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(_from) \
+	(_lock.saved != RZG3S_PCIE_HOST_STATE_##_from)
+
 /*
  * RZ/V2H(P) supports a total of 4 lanes shared across two controllers.
  * rzv2h_lane_lock serialises both the counter update and the SYSC
@@ -459,6 +537,10 @@ static int rzg3s_pcie_child_read(struct pci_bus *bus, unsigned int devfn,
 	struct rzg3s_pcie_host *host = bus->sysdata;
 	int ret;
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return PCIBIOS_SET_FAILED;
+
 	ret = rzg3s_pcie_child_read_conf(host, bus, devfn, where, val);
 	if (ret != PCIBIOS_SUCCESSFUL)
 		return ret;
@@ -504,6 +586,10 @@ static int rzg3s_pcie_child_write(struct pci_bus *bus, unsigned int devfn,
 	u32 data, shift;
 	int ret;
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return PCIBIOS_SET_FAILED;
+
 	if (size == 4)
 		return rzg3s_pcie_child_write_conf(host, bus, devfn, where, val);
 
@@ -559,9 +645,35 @@ static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
 	return host->pcie + where;
 }
 
+/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
+static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
+				 int where, int size, u32 val)
+{
+	struct rzg3s_pcie_host *host = bus->sysdata;
+
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return PCIBIOS_SET_FAILED;
+
+	return pci_generic_config_write(bus, devfn, where, size, val);
+}
+
+/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
+static int rzg3s_pcie_root_read(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	struct rzg3s_pcie_host *host = bus->sysdata;
+
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return PCIBIOS_SET_FAILED;
+
+	return pci_generic_config_read(bus, devfn, where, size, val);
+}
+
 static struct pci_ops rzg3s_pcie_root_ops = {
-	.read		= pci_generic_config_read,
-	.write		= pci_generic_config_write,
+	.read		= rzg3s_pcie_root_read,
+	.write		= rzg3s_pcie_root_write,
 	.map_bus	= rzg3s_pcie_root_map_bus,
 };
 
@@ -627,6 +739,10 @@ static void rzg3s_pcie_msi_irq_ack(struct irq_data *d)
 	u8 reg_bit = d->hwirq % RZG3S_PCI_MSI_INT_PER_REG;
 	u8 reg_id = d->hwirq / RZG3S_PCI_MSI_INT_PER_REG;
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return;
+
 	writel_relaxed(BIT(reg_bit), host->axi + RZG3S_PCI_MSIRS(reg_id));
 }
 
@@ -639,6 +755,10 @@ static void rzg3s_pcie_msi_irq_mask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
 			       BIT(reg_bit));
 }
@@ -652,6 +772,10 @@ static void rzg3s_pcie_msi_irq_unmask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
 			       0);
 }
@@ -663,6 +787,10 @@ static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
 	struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
 	u32 lo, hi;
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return;
+
 	/*
 	 * Enable and msg data enable bits are part of the address lo. Drop
 	 * them along with the unused bit.
@@ -958,6 +1086,10 @@ static void rzg3s_pcie_intx_irq_ack(struct irq_data *d)
 {
 	struct rzg3s_pcie_host *host = irq_data_get_irq_chip_data(d);
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIS,
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq),
 			       RZG3S_PCI_PINTRCVIS_INTX(d->hwirq));
@@ -969,6 +1101,10 @@ static void rzg3s_pcie_intx_irq_mask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
 			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq), 0);
 }
@@ -979,6 +1115,10 @@ static void rzg3s_pcie_intx_irq_unmask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	RZG3S_PCIE_HOST_STATE_CHANGE(&host->state, START, PROCESS);
+	if (RZG3S_PCIE_HOST_STATE_CHANGE_FAILED(START))
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
 			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq),
 			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq));
@@ -1095,6 +1235,94 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
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
+		for_each_pci_bridge(dev, bridge->bus) {
+			if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+				pci_host_handle_link_down(dev);
+		}
+
+		pci_lock_rescan_remove();
+		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
+						 bus_list)
+			pci_stop_and_remove_bus_device(dev);
+		pci_unlock_rescan_remove();
+	} else {
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
+		pci_lock_rescan_remove();
+		pci_rescan_bus(bus);
+		pci_unlock_rescan_remove();
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
+	if (!(status & RZG3S_PCI_PEIS0_DL_UPDOWN))
+		return IRQ_NONE;
+
+	/* Clear the DL_UpDown status (W1C) */
+	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
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
 	if (host->intx_domain)
@@ -1106,6 +1334,17 @@ static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
 	}
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
@@ -1152,22 +1391,21 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
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
@@ -1679,16 +1917,21 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
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
@@ -1723,8 +1966,14 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 
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
@@ -1748,6 +1997,9 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
+	if (atomic_read(&host->state) == RZG3S_PCIE_HOST_STATE_STOP)
+		return 0;
+
 	clk_disable_unprepare(port->refclk);
 
 	/* SoC-specific de-initialization */
@@ -1783,6 +2035,8 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto power_resets_restore;
 
+	atomic_set(&host->state, RZG3S_PCIE_HOST_STATE_STOP);
+
 	return 0;
 
 	/* Restore the previous state if any error happens */
@@ -1798,12 +2052,15 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
-static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
+static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host, bool set_state)
 {
 	const struct rzg3s_pcie_soc_data *data = host->data;
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
+	if (atomic_read(&host->state) == RZG3S_PCIE_HOST_STATE_START)
+		return 0;
+
 	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
 	if (ret)
 		return ret;
@@ -1850,6 +2107,9 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto assert_power_resets;
 
+	if (set_state)
+		atomic_set(&host->state, RZG3S_PCIE_HOST_STATE_START);
+
 	return 0;
 
 	/*
@@ -1863,6 +2123,64 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridge,
+					   struct pci_dev *pdev)
+{
+	struct rzg3s_pcie_host *host = pci_host_bridge_priv(bridge);
+	enum rzg3s_pcie_host_state state;
+	u32 irqs;
+	int ret;
+
+	state = atomic_cmpxchg(&host->state, RZG3S_PCIE_HOST_STATE_START,
+			       RZG3S_PCIE_HOST_STATE_PORT_RESET);
+	if (state != RZG3S_PCIE_HOST_STATE_START)
+		return -EBUSY;
+
+	/* Mask link up/down interrupts. */
+	writel(0, host->axi + RZG3S_PCI_PEIE0);
+
+	/* Mask INTx and MSI interrupts. */
+	irqs = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
+	writel(0, host->axi + RZG3S_PCI_PINTRCVIE);
+
+	/*
+	 * Make sure the next operations are not disturbed by any pending
+	 * IRQs.
+	 */
+	synchronize_irq(host->msi.irq);
+	for (unsigned int i = 0; i < PCI_NUM_INTX; i++)
+		synchronize_irq(host->intx_irqs[i]);
+
+	ret = rzg3s_pcie_host_stop(host);
+	if (ret) {
+		dev_err(host->dev, "Failed to stop the host!\n");
+		goto unmask_irqs;
+	}
+
+	ret = rzg3s_pcie_host_start(host, false);
+	if (ret) {
+		dev_err(host->dev, "Failed to start the host!\n");
+
+		/*
+		 * Don't unmask IRQs. We are in a bad state here and we
+		 * can recover only through a suspend/resume cycle. Just
+		 * return and preserve the STOP state.
+		 */
+		return ret;
+	}
+
+unmask_irqs:
+	/* Unmask INTx and MSI interrupts. */
+	writel_relaxed(irqs, host->axi + RZG3S_PCI_PINTRCVIE);
+
+	/* Unmask link up/down interrupts. */
+	writel(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
+
+	atomic_xchg(&host->state, state);
+
+	return ret;
+}
+
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
 {
 	struct device_node *np = host->dev->of_node;
@@ -2025,13 +2343,24 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_resets_assert;
 
+	atomic_set(&host->state, RZG3S_PCIE_HOST_STATE_START);
+
 	bridge->sysdata = host;
 	bridge->ops = &rzg3s_pcie_root_ops;
 	bridge->child_ops = &rzg3s_pcie_child_ops;
+	bridge->reset_root_port = rzg3s_pcie_host_reset_root_port;
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto host_probe_teardown;
 
+	/*
+	 * Unmask the PCIe event IRQ at the end of probe to avoid
+	 * spurious link-state events during controller setup and bus
+	 * enumeration. From here on, DL_UpDown events trigger the link
+	 * IRQ thread to (re)scan the bus.
+	 */
+	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
+
 	return 0;
 
 host_probe_teardown:
@@ -2067,8 +2396,16 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 static int rzg3s_pcie_resume_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
+	int ret;
 
-	return rzg3s_pcie_host_start(host);
+	ret = rzg3s_pcie_host_start(host, true);
+	if (ret)
+		return ret;
+
+	/* Unmask link up/down IRQ. */
+	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
+
+	return 0;
 }
 
 static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
-- 
2.43.0

