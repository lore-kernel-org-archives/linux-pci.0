Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238D47C0FD;
	Mon, 19 Oct 2026 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392735; cv=none; b=TJh42lrcxkgoSwsElnxy54Jcju8Zf7T9EyOMwFimIy7TxyA3EDVq+3pSfXTBiun9qMX/qjUc5KhaHqAHNvsjkO2BUHe1JVLzPRnJN1Qb2E+C5siw+ILeqohYIbSmZ9pya+PTS6Jxzg1bzuMDhMYJKZkfvzlJVX956Sx6E1R1kjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392735; c=relaxed/simple;
	bh=6JWnjyjH5ExT5pwYSGrBdnpu5oPkuyxUDpLyx9m5qRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwyv+yzwrQnuiwJQkZbVoPGQ8YBiKVg2uJOmw4Xie2hz5YrljefW0COfqExcg8vaJNBn61D29kvgjfbllt06fMt8OurjAVCKGBwfgSgDqP2nTlrIW/j6bMDvaSK8e3rtgzzVU7X9FZYpQ8fbFEnYLwRNiFMliyfyHmtxuuMWL6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jA8Z5W4b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jA8Z5W4b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8421F000C5;
	Mon, 19 Oct 2026 06:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392733;
	bh=spHmFTzUXRj6NAh0MDNbh+7nSYlyrSA42yE24rMBBXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jA8Z5W4bx4tpxJEklWXrRV+OHGjcehasomS5J661ZFxL3YaO4/VnnOI0fdbpS4AsZ
	 ZiJgQqt2z4CW7l8HJXM0Hpfcrc6ZX87PD3Wk9x5uBNA5/iO5AR7b3746tbj0kLvyNv
	 Mv8TaGXnjjHuAzvFazI+umd/qbniwlSQU4ZIayROK3fXKMAePMGdXWQulCJ8INaMlv
	 mpCEVeiUJe8jfMg5JO0Lfta+OnrC+7M84xQDwW12y5BBxoZVlxH8X9me5WjziYtOTH
	 WxI4ZSsmKv6kmc0pkNqojv6bqUW02oex2+WHhB6Hn6wjN7WKRD0GdWOzcQh/LzGpJA
	 ueh5HPe47I8lg==
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 14/14] PCI: rzg3s-host: Add bridge::reset_root_port()
Date: Mon, 19 Oct 2026 09:50:25 +0300
Message-ID: <20261019065025.2146539-15-claudiu.beznea@kernel.org>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add bridge::reset_root_port(). This allows, on some devices, performing
reads and writes to an NVMe endpoint after a link down/link up cycle
without failures.

The implementation of struct pci_host_bridge::reset_root_port() masks all
enabled interrupts and synchronizes them before resetting the controller
to prevent asynchronous events from interfering with the reset operation.

The struct rzg3s_pcie_host::resetting member is used to prevent the IRQ
setting calls done through the IRQ subsystem (mask, unmask) from
accessing the controller registers while .reset_root_port() has powered
down the IP. It also rejects a concurrent .reset_root_port() with -EBUSY.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- added struct rzg3s_pcie_host::resetting to avoid concurrency b/w IRQ
  subsystem and the .reset_root_port() and b/w .reset_root_port() and
  the link IRQ thread
- in rzg3s_pcie_link_event()
-- dropped the usage of __free(pci_dev_put)
-- don't continue if the .reset_root_port() filed to start the IP or
   if there is a reset in progress
- in rzg3s_pcie_event_irq_thread() don't continue if the reset is in
  progress
- access host->started with READ_ONCE()/WRITE_ONCE()
- use disable_irq() in .reset_root_port()
- in rzg3s_pcie_pm_notifier() checked host->resetting and host->started
  before accessing IP registers

Changes in v6:
- call pci_host_handle_link_down() if at least a link event occured
  and there are devices on the bus.
- dropped struct rzg3s_pcie_host::stared from here since it is now
  part of patch 8/9
- read the link IRQs in .reset_root_port() and restore them at the
  end
- flush the IRQ mask before synchronize()
- in .reset_root_port() clear the link IRQ before enabling it to cope
  with the new link handling procedure
- due to these dropped the tags

Changes in v5:
- lock around reads/writes on RZG3S_PCI_PINTRCVIE
- in rzg3s_pcie_host_reset_root_port() kept non-relaxed reads/writes
  on interrupt disable registers (even though the spin lock/unlock are around
  them) to emphasize the need for updates before the IRQs are synchronized and
  relaxed variants on interrupt enable path
- collected tags

Changes in v4:
- this patch is new and is a split from patch 7 of v3
- use a boolean to keep track of the controller start state; with this
  the state management code from patch 7 of v3 was dropped 


 drivers/pci/controller/Kconfig           |   1 +
 drivers/pci/controller/pcie-rzg3s-host.c | 184 ++++++++++++++++++++---
 2 files changed, 167 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 7e550c474b7a..c747bd5a9ec1 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -296,6 +296,7 @@ config PCIE_RENESAS_RZG3S_HOST
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select MFD_SYSCON
 	select IRQ_MSI_LIB
+	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S
 	  SoC.
diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index a1c9e29f43e5..f6823c9bc414 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -336,6 +336,7 @@ struct rzg3s_pcie_port {
  * @controller_id: PCIe controller identifier, used for System Controller access
  * @link_rescan: The PCIe link rescan state
  * @started: The PCIe controller state (started or not)
+ * @resetting: Mentions if the root port reset is in progress
  * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
@@ -358,6 +359,7 @@ struct rzg3s_pcie_host {
 	enum rzg3s_pcie_controller_id controller_id;
 	bool link_rescan;
 	bool started;
+	bool resetting;
 	u8 num_lanes;
 };
 
@@ -653,6 +655,9 @@ static void rzg3s_pcie_msi_irq_mask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	if (host->resetting)
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
 			       BIT(reg_bit));
 }
@@ -666,6 +671,9 @@ static void rzg3s_pcie_msi_irq_unmask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	if (host->resetting)
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_MSIRM(reg_id), BIT(reg_bit),
 			       0);
 }
@@ -972,6 +980,9 @@ static void rzg3s_pcie_intx_irq_mask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	if (host->resetting)
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
 			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq), 0);
 }
@@ -982,6 +993,9 @@ static void rzg3s_pcie_intx_irq_unmask(struct irq_data *d)
 
 	guard(raw_spinlock_irqsave)(&host->hw_lock);
 
+	if (host->resetting)
+		return;
+
 	rzg3s_pcie_update_bits(host->axi, RZG3S_PCI_PINTRCVIE,
 			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq),
 			       RZG3S_PCI_PINTRCVIE_INTX(d->hwirq));
@@ -1185,12 +1199,46 @@ static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bounced)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
 	struct pci_bus *bus = bridge->bus, *child;
+	unsigned long flags;
 	u32 val;
 	int ret;
 
-	pci_lock_rescan_remove();
+	/*
+	 * A latched DL_UpDown means at least one real link transition took
+	 * place since the last enumeration. If devices are enumerated
+	 * recover the Root Port first.
+	 */
+	if (bounced && !list_empty(&bus->devices)) {
+		struct pci_dev *port = pci_get_slot(bus, PCI_DEVFN(0, 0));
+
+		if (port && pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
+			pci_host_handle_link_down(port);
 
+		pci_dev_put(port);
+	}
+
+	raw_spin_lock_irqsave(&host->hw_lock, flags);
+
+	/*
+	 * Don't continue if reset in progress or .reset_root_port() failed to
+	 * start HW.
+	 */
+	if (host->resetting || !READ_ONCE(host->started)) {
+		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
+		return;
+	}
+
+	/*
+	 * Check the link state after the recovery: the .reset_root_port()
+	 * retrains the link, so a device that is still present comes back
+	 * up here and is re-enumerated right away instead of waiting for
+	 * the next DL_UpDown event.
+	 */
 	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
+	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
+
+	pci_lock_rescan_remove();
+
 	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
 		if (!list_empty(&bus->devices)) {
 			dev_info(host->dev,
@@ -1246,20 +1294,26 @@ static irqreturn_t rzg3s_pcie_event_irq_thread(int irq, void *data)
 {
 	struct rzg3s_pcie_host *host = data;
 	bool bounced;
-	u32 status;
 
-	status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
-	bounced = status & RZG3S_PCI_PEIS0_DL_UPDOWN;
+	scoped_guard(raw_spinlock_irqsave, &host->hw_lock) {
+		u32 status;
 
-	if (!bounced && !READ_ONCE(host->link_rescan))
-		return IRQ_NONE;
+		if (host->resetting)
+			return IRQ_NONE;
+
+		status = readl_relaxed(host->axi + RZG3S_PCI_PEIS0);
+		bounced = status & RZG3S_PCI_PEIS0_DL_UPDOWN;
+
+		if (!bounced && !READ_ONCE(host->link_rescan))
+			return IRQ_NONE;
 
-	/* Clear the DL_UpDown status (W1C) */
-	if (bounced) {
-		writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
-			       host->axi + RZG3S_PCI_PEIS0);
+		/* Clear the DL_UpDown status (W1C) */
+		if (bounced) {
+			writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
+				       host->axi + RZG3S_PCI_PEIS0);
+		}
+		WRITE_ONCE(host->link_rescan, false);
 	}
-	WRITE_ONCE(host->link_rescan, false);
 
 	rzg3s_pcie_link_event(host, bounced);
 
@@ -1982,13 +2036,13 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
-static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
+static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host, bool set_started)
 {
 	const struct rzg3s_pcie_soc_data *data = host->data;
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
-	if (host->started)
+	if (READ_ONCE(host->started))
 		return 0;
 
 	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
@@ -2023,7 +2077,10 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto assert_power_resets;
 
-	host->started = true;
+	if (set_started) {
+		WRITE_ONCE(host->started, true);
+		host->resetting = false;
+	}
 
 	return 0;
 
@@ -2038,6 +2095,91 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridge,
+					   struct pci_dev *pdev)
+{
+	struct rzg3s_pcie_host *host = pci_host_bridge_priv(bridge);
+	unsigned long flags;
+	u32 irqs, link_irqs;
+	int ret;
+
+	raw_spin_lock_irqsave(&host->hw_lock, flags);
+	if (host->resetting) {
+		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
+		return -EBUSY;
+	}
+	host->resetting = true;
+	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
+
+	/* Mask link up/down interrupts. */
+	link_irqs = readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
+	writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
+
+	/* Mask INTx and MSI interrupts. */
+	irqs = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
+	writel_relaxed(0, host->axi + RZG3S_PCI_PINTRCVIE);
+
+	/* Flush IRQ masks. */
+	readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
+	readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
+
+	/*
+	 * Make sure the next operations are not disturbed by any pending
+	 * IRQs.
+	 */
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		disable_irq(host->msi.irq);
+	for (unsigned int i = 0; i < PCI_NUM_INTX; i++)
+		disable_irq(host->intx_irqs[i]);
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
+		 * re-enable the IRQs and return.
+		 */
+		goto enable_irqs;
+	}
+
+unmask_irqs:
+	/* Unmask INTx and MSI interrupts. */
+	writel_relaxed(irqs, host->axi + RZG3S_PCI_PINTRCVIE);
+
+	/*
+	 * rzg3s_pcie_host_start() retrains the link. If the link comes
+	 * back up, DL_UpDown gets latched in PEIS0. Clear the latch.
+	 * The link state is evaluated after this function returns, so
+	 * the event is not lost. For the same reason there is no need
+	 * to set host->link_rescan.
+	 */
+	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
+	/* Unmask link up/down interrupts. */
+	writel_relaxed(link_irqs, host->axi + RZG3S_PCI_PEIE0);
+
+	raw_spin_lock_irqsave(&host->hw_lock, flags);
+	host->resetting = false;
+	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
+
+	WRITE_ONCE(host->started, true);
+
+enable_irqs:
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		enable_irq(host->msi.irq);
+	for (unsigned int i = 0; i < PCI_NUM_INTX; i++)
+		enable_irq(host->intx_irqs[i]);
+
+	return ret;
+}
+
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
 {
 	struct device_node *np = host->dev->of_node;
@@ -2113,18 +2255,22 @@ static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
 {
 	struct rzg3s_pcie_host *host = container_of(nb, struct rzg3s_pcie_host,
 						    pm_nb);
+	unsigned long flags;
 
 	switch (action) {
 	case PM_SUSPEND_PREPARE:
 		/* Disable link up/down interrupts. */
-		if (host->started)
+		raw_spin_lock_irqsave(&host->hw_lock, flags);
+		if (READ_ONCE(host->started) && !host->resetting)
 			writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
+		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
 		disable_irq(host->event_irq);
 		break;
 
 	case PM_POST_SUSPEND:
 		/* Enable link up/down interrupts and force link re-scan. */
-		if (host->started) {
+		raw_spin_lock_irqsave(&host->hw_lock, flags);
+		if (READ_ONCE(host->started) && !host->resetting) {
 			/*
 			 * The link re-train in resume triggers the link up IRQ
 			 * if there are connected devices. Clear the DL_UpDown
@@ -2137,8 +2283,9 @@ static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
 			writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
 				       host->axi + RZG3S_PCI_PEIE0);
 		}
+		raw_spin_unlock_irqrestore(&host->hw_lock, flags);
 		enable_irq(host->event_irq);
-		if (host->started)
+		if (READ_ONCE(host->started))
 			irq_wake_thread(host->event_irq, host);
 		break;
 	}
@@ -2253,6 +2400,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = host;
 	bridge->ops = &rzg3s_pcie_root_ops;
 	bridge->child_ops = &rzg3s_pcie_child_ops;
+	bridge->reset_root_port = rzg3s_pcie_host_reset_root_port;
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto pm_notifier_unregister;
@@ -2311,7 +2459,7 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = rzg3s_pcie_host_start(host);
+	ret = rzg3s_pcie_host_start(host, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

