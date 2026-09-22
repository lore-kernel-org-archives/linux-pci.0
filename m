Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4938F951;
	Tue, 22 Sep 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088425; cv=none; b=obDM/3ZBq/85cTfTwCTCJQhZz3crVXAsta56FBg2BQBBAkHXMlPBdH097r8lmpDlbVdUParKQNNfJo2Nbbtze8bg7wu3JdesmOpUsbUrIdzO6v4xmi1w5/kydbBW/fcXFD/fgTK8Nr0zuhq/sN8U5DSHq6oSaxAkYH4g7wq5X+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088425; c=relaxed/simple;
	bh=y0G68FUnKuhdlz8E/0b/HHB6com4da912sJGuCuDPkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1mVUQ9uGu/osQMeFdOhN6+YVn50g9CA79tklBESTPRxS3Lz5LVI0Z4CK0N8q95xrBl86XLTQCPOXl7FmDBRzUsOmffNM+LKDIFhyubGeCjCSuFuou2jq3spWDlwrjAecdKbrIXgAUd94fUPCDfsSz07/3h16ixHVJua7vsd8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmiGelxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmiGelxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2951F00893;
	Tue, 22 Sep 2026 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088423;
	bh=joSU7EzkrZ0Mny1IL9YvQWzLKBnb8avCW8mYTMW38Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NmiGelxWy5lPiI8OSB7ZySUbaMHIu6ompdUPDNn1kAzT6kajoDfGXkyn6TDUK6ns8
	 /joNrPl6SbZCMkt1DY62m4TkeBwOZv1Tv9M+D77yz8YEUiNdUv4ePMo0S8p2vnzwNT
	 CFq10sRbKPI1KqyAMWSyd6JlSuUe+5QBMRG6BzNi5W+Tv7sOmUlWyXwXkv4IUKKAao
	 U4hJB90Wq/H4ws2QsfqM2FzwKWTtypuRUHicpUYV4ZO0Di13iFuLLTOWyaWdDrQiMJ
	 UgxWiXo1U6w8sxWH4uWFKNHzc7FKHoxB6Q6JKl1pDpmheUqYBCjxPNUXYmZZKO8wbe
	 sJ/NIylLGB8Ig==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
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
Subject: [PATCH v4 7/8] PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes
Date: Tue, 22 Sep 2026 17:46:27 +0300
Message-ID: <20260922144629.586997-8-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922144629.586997-1-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
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
  - link down: walk the bus in reverse and pci_stop_and_remove_bus_device()
    each child.

Both paths take pci_lock_rescan_remove() to serialize against the PCI
core.

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

 drivers/pci/controller/pcie-rzg3s-host.c | 155 ++++++++++++++++++++---
 1 file changed, 139 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index f4b27a77a89d..1c0353598b59 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -86,6 +86,7 @@
 #define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
 
 #define RZG3S_PCI_PEIE0				0x200
+#define RZG3S_PCI_PEIE0_DL_UPDOWN		BIT(9)
 
 #define RZG3S_PCI_PEIS0				0x204
 #define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
@@ -323,6 +324,7 @@ struct rzg3s_pcie_port {
  * @msi: MSI data structure
  * @port: PCIe Root Port
  * @hw_lock: lock for access to the HW resources
+ * @event_irq: PCIe event interrupt for DL_UpDown detection
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
@@ -340,6 +342,7 @@ struct rzg3s_pcie_host {
 	struct rzg3s_pcie_msi msi;
 	struct rzg3s_pcie_port port;
 	raw_spinlock_t hw_lock;
+	int event_irq;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
@@ -1095,6 +1098,89 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
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
@@ -1106,6 +1192,17 @@ static void rzg3s_pcie_teardown_intx(struct rzg3s_pcie_host *host, int count)
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
@@ -1152,22 +1249,21 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pcie_host *host)
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
@@ -1679,16 +1775,21 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
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
@@ -1723,8 +1824,14 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 
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
@@ -2004,6 +2111,14 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
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
@@ -2039,8 +2154,16 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 static int rzg3s_pcie_resume_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
+	int ret;
 
-	return rzg3s_pcie_host_start(host);
+	ret = rzg3s_pcie_host_start(host);
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

