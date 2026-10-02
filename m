Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F730489FAA;
	Fri,  2 Oct 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939423; cv=none; b=rTqMrNWJh5XpAB7swy0ZHR+bthBW7E/IJTSvQmmmINzUsKOgH3hDtZ+MX3hQdrKz976JfOni7g66QO4BdmPu3bZoIyt4bgxilG4j1ExGR3GNVSHHsOMMIh0aCDXj3fvGHb2L/m7wjqLS+47/nBZezjIdSxhd0wws8LhgwOljN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939423; c=relaxed/simple;
	bh=l86qQdFQwE10D8LWz0nWmhH2McjCve0EpVBLGl31yuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJHaRpY3V8K5NZpjRDxDojejXYpuKuKOFW99h9FzaM8/AsllIPsimx92B/TJSEH4ky2dcnHzwTY9JA2TLpr2j5PWwf7hwnVT8M+i9KX0wt73oRfZioeOyuEph3qt2u4UGWuKL78J7PeWQfvoH9/CIjcyVk2WazchCrVsTBR5z+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZYuf5+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZYuf5+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B811F0089A;
	Fri,  2 Oct 2026 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939420;
	bh=FPkwt06n0jKtSuuvZrrxqqEe9JJuuqN62qB3KjQaCmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZYuf5+gNw19zoExWAozMmSBn3X45KgKUWgp/69lAwi1uTjRGvUqD0H2utfxYgZXK
	 qSsPU5eY+jxs97n4GAiNbn+tAEDW9e2dkcDJxjhH/tQnc0QnP4fIDPphJEL5iVzwIL
	 sMK+sHHlRmmuHqFaZ1jX24G7oKqMqS23xU7VXuP2CZ+ZB73taflA5/oCcqEc5ajHFf
	 jJ9xiVqahCXTDlIhBXFC8BexiS7guGtcY2PGqR9cZgBaMLm5dhjraVgxi6ilIyzCVl
	 i1KK9mC4zfFeaVuiZBHTeraqOkykNVzFOhIShahoHNuH2TOlMw+pS4ZptEH74gp9ij
	 oWY59iinRSdIw==
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 9/9] PCI: rzg3s-host: Add bridge::reset_root_port()
Date: Fri,  2 Oct 2026 14:09:35 +0300
Message-ID: <20261002110935.2004349-10-claudiu.beznea@kernel.org>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add bridge::reset_root_port(). This allows, on some devices, performing
reads and writes to an NVMe endpoint after a link down/link up cycle
without failures.

The implementation of struct pci_host_bridge::reset_root_port() masks all
enabled interrupts and synchronizes them before resetting the controller
to prevent asynchronous events from interfering with the reset operation.

struct rzg3s_pcie_host::started boolean was added to keep track of the
controller state, since rzg3s_pcie_host_start() and rzg3s_pcie_host_stop()
are called from multiple paths: .reset_root_port(), .suspend_noirq() and
.resume_noirq(). The flag prevents double start/stop and breaking
reference counters for clocks and resets.

rzg3s_pcie_pm_notifier() disables the link event IRQ, and disable_irq()
waits for a running IRQ thread to complete. If that thread is handling a
link down event, it calls .reset_root_port(), which unmasks the link
interrupt before returning, undoing the mask. Therefore, mask the link
interrupt again after disable_irq() has returned.

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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

 drivers/pci/controller/pcie-rzg3s-host.c | 83 +++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 78e783928b9d..eea215818633 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -331,6 +331,7 @@ struct rzg3s_pcie_port {
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
  * @link_rescan: The PCIe link rescan state
+ * @started: The PCIe controller state (started or not)
  * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
@@ -351,6 +352,7 @@ struct rzg3s_pcie_host {
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
 	bool link_rescan;
+	bool started;
 	u8 num_lanes;
 };
 
@@ -1115,6 +1117,11 @@ static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host)
 
 		dev_info(host->dev, "PCIe link down, removing devices\n");
 
+		for_each_pci_bridge(dev, bridge->bus) {
+			if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+				pci_host_handle_link_down(dev);
+		}
+
 		pci_lock_rescan_remove();
 		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
 						 bus_list)
@@ -1869,6 +1876,9 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
+	if (!host->started)
+		return 0;
+
 	clk_disable_unprepare(port->refclk);
 
 	/* SoC-specific de-initialization */
@@ -1890,6 +1900,8 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto power_resets_restore;
 
+	host->started = false;
+
 	return 0;
 
 	/* Restore the previous state if any error happens */
@@ -1905,12 +1917,15 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
-static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
+static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host, bool set_started)
 {
 	const struct rzg3s_pcie_soc_data *data = host->data;
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
+	if (host->started)
+		return 0;
+
 	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
 	if (ret)
 		return ret;
@@ -1943,6 +1958,9 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto assert_power_resets;
 
+	if (set_started)
+		host->started = true;
+
 	return 0;
 
 	/*
@@ -1956,6 +1974,64 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridge,
+					   struct pci_dev *pdev)
+{
+	struct rzg3s_pcie_host *host = pci_host_bridge_priv(bridge);
+	unsigned long flags;
+	u32 irqs;
+	int ret;
+
+	/* Mask link up/down interrupts. */
+	writel(0, host->axi + RZG3S_PCI_PEIE0);
+
+	/* Mask INTx and MSI interrupts. */
+	raw_spin_lock_irqsave(&host->hw_lock, flags);
+	irqs = readl(host->axi + RZG3S_PCI_PINTRCVIE);
+	writel(0, host->axi + RZG3S_PCI_PINTRCVIE);
+	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
+
+	/*
+	 * Make sure the next operations are not disturbed by any pending
+	 * IRQs.
+	 */
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		synchronize_irq(host->msi.irq);
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
+		 * return and preserve the stop state.
+		 */
+		return ret;
+	}
+
+unmask_irqs:
+	/* Unmask INTx and MSI interrupts. */
+	raw_spin_lock_irqsave(&host->hw_lock, flags);
+	writel_relaxed(irqs, host->axi + RZG3S_PCI_PINTRCVIE);
+	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
+
+	/* Unmask link up/down interrupts. */
+	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
+
+	host->started = true;
+
+	return ret;
+}
+
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
 {
 	struct device_node *np = host->dev->of_node;
@@ -2036,6 +2112,7 @@ static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
 	case PM_SUSPEND_PREPARE:
 		/* Disable link up/down interrupts. */
 		disable_irq(host->event_irq);
+		writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
 		break;
 
 	case PM_POST_SUSPEND:
@@ -2143,6 +2220,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_resets_assert;
 
+	host->started = true;
 	host->pm_nb.notifier_call = rzg3s_pcie_pm_notifier;
 	ret = register_pm_notifier(&host->pm_nb);
 	if (ret)
@@ -2151,6 +2229,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = host;
 	bridge->ops = &rzg3s_pcie_root_ops;
 	bridge->child_ops = &rzg3s_pcie_child_ops;
+	bridge->reset_root_port = rzg3s_pcie_host_reset_root_port;
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto pm_notifier_unregister;
@@ -2201,7 +2280,7 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
 
-	return rzg3s_pcie_host_start(host);
+	return rzg3s_pcie_host_start(host, true);
 }
 
 static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
-- 
2.43.0

