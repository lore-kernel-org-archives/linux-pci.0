Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFAE5540BD;
	Tue, 22 Sep 2026 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088428; cv=none; b=faggQqu2ExE5WZfmay0B/KEaiNgSPzgVhWoONnJ9m68j74rSk05raXow9hCONKeQqYDbYagYw40WRWsKeph7ZJZiKqloZLPW9PjvxOwLPyTdxi9la+Gt2VMog1VMZB/695SYnK6TAO9bjcHcCmFt84sotglKpPcC0BUTj+NOf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088428; c=relaxed/simple;
	bh=1Im1ZNFIJrfPREwypW1FsEYCrX+6t9WZt5z+WJz1I+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJN25j/pFc0qeFOfjl+bh3r6KGkoquRGIYX0mBDomJ+JKtLcZQ+vnWlD1AXwRFWnL5xn3K8PSub8sjxPW4k9UoaRZoNqHH5gytX7304qBi/gHXDK/TT3V+jfH8fBmyQUDB8QVZ3KQ6nA+r4oVVQ6v9k32bo2XYxQJxVW0CAV3bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+m9bqcK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+m9bqcK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD831F00898;
	Tue, 22 Sep 2026 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088426;
	bh=DEEddTTRgzBSKA0H/RopE6I+anHr4ayJ/E3G54xl/zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+m9bqcKpAqgKKUqFefEpFRVG/j9FzKeqdrasfDm7OP9hUsf+FJ3EN4Rv2hHc/Gwi
	 le4ke/FFDy30BBseC8U1n0770KMK/iN05YULeutV4l7WAJOUMQxVQtJ7YF629oYOK1
	 QTPDnHrwjy8SpfYqZnzxh28aYm7A+Kh6mfNKNBCG5kvPhYVdSJD7Z0j7utI+1C29/n
	 /UGyHsQNaVizRqtXIhOaXl1I82DofZCSRXQ8f68Aq8SLSc+Z3VCHJr3bnrr44XbnVe
	 N/7YbgVKwrYnlTBlw2ETDKcL24wmqFCzd8YxZ5cUtzOs3gMnBLkXxQgY38zo8ZINNo
	 a8js4vQywFW6g==
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 8/8] PCI: rzg3s-host: Add bridge::reset_root_port()
Date: Tue, 22 Sep 2026 17:46:28 +0300
Message-ID: <20260922144629.586997-9-claudiu.beznea@kernel.org>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- this patch is new and is a split from patch 7 of v3
- use a boolean to keep track of the controller start state; with this
  the state management code from patch 7 of v3 was dropped 

 drivers/pci/controller/pcie-rzg3s-host.c | 77 +++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 1c0353598b59..9cba898a9536 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -328,6 +328,7 @@ struct rzg3s_pcie_port {
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
+ * @started: The PCIe controller state (started or not)
  * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
@@ -346,6 +347,7 @@ struct rzg3s_pcie_host {
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
+	bool started;
 	u8 num_lanes;
 };
 
@@ -1110,6 +1112,11 @@ static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host)
 
 		dev_info(host->dev, "PCIe link down, removing devices\n");
 
+		for_each_pci_bridge(dev, bridge->bus) {
+			if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+				pci_host_handle_link_down(dev);
+		}
+
 		pci_lock_rescan_remove();
 		list_for_each_entry_safe_reverse(dev, tmp, &bus->devices,
 						 bus_list)
@@ -1855,6 +1862,9 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
+	if (!host->started)
+		return 0;
+
 	clk_disable_unprepare(port->refclk);
 
 	/* SoC-specific de-initialization */
@@ -1876,6 +1886,8 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto power_resets_restore;
 
+	host->started = false;
+
 	return 0;
 
 	/* Restore the previous state if any error happens */
@@ -1891,12 +1903,15 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
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
@@ -1929,6 +1944,9 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto assert_power_resets;
 
+	if (set_started)
+		host->started = true;
+
 	return 0;
 
 	/*
@@ -1942,6 +1960,58 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
+static int rzg3s_pcie_host_reset_root_port(struct pci_host_bridge *bridge,
+					   struct pci_dev *pdev)
+{
+	struct rzg3s_pcie_host *host = pci_host_bridge_priv(bridge);
+	u32 irqs;
+	int ret;
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
+		 * return and preserve the stop state.
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
+	host->started = true;
+
+	return ret;
+}
+
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
 {
 	struct device_node *np = host->dev->of_node;
@@ -2104,9 +2174,12 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto power_resets_assert;
 
+	host->started = true;
+
 	bridge->sysdata = host;
 	bridge->ops = &rzg3s_pcie_root_ops;
 	bridge->child_ops = &rzg3s_pcie_child_ops;
+	bridge->reset_root_port = rzg3s_pcie_host_reset_root_port;
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto host_probe_teardown;
@@ -2156,7 +2229,7 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = rzg3s_pcie_host_start(host);
+	ret = rzg3s_pcie_host_start(host, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

