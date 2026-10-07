Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934B63F54D2;
	Wed,  7 Oct 2026 05:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351458; cv=none; b=fekZWxiSJlNDz12lmX1+EUEQTxU3rLZQ4wP+XiVB8z25l4cE9AFhYjDkq8Q2tqRt38G/3QNCr9OIl/TS2YY0oowNRyarGz/OCmkYAvM9YlxdzpNmUO79E339fItBGd3efwQTlznQKiR8SQ8ZgnasSFQOpdPbJlVzhNxd4A8a4/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351458; c=relaxed/simple;
	bh=tpeMv282DilLaomJA2XG7KqvNDSf0Q+we/gm7Rdc/Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPDciy3C4kDtW6ye3qEqr4yoGfSKRctw/mptELtuy6ygHwbXdntR6veQws8zflfj95wHxiZrybglEscEafGzImzCURCWaAz/CyOnkwCfEY/2X4zum+CyJsElJmcNVeGSpmGaR7tuikWo1kAw30nfH8DvPYD5dh/OHMPq4L5R5f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0T9EfPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0T9EfPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D429C1F0089C;
	Wed,  7 Oct 2026 05:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351457;
	bh=NHo7h+EVXimFjrXq9uBiUuIH/fxMx9JnngGZQSMdSAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g0T9EfPYAa+HuQcX/njpSe2L58wxjiey33zGHVpCXqSvUz5lQDmdSrwj/1HsfnXj9
	 v4NzEEp8AKccQp94WSwL1g8xwEzHy8rRrZpMvfDZmdq28C6lbcTq6WmlbWgMZDtKGf
	 Vjkzn/+PkTUJJL6r6+3rFYo+qVTTEyNCXL+LZqKJC+JdJFo0hw9lKffDLYjSizoUs2
	 x6cdq6Dqg0pp/h3zaeSlJXW52S062XITsAowy5wwBGdIK+BWcXUap+bFP81JqvsHtn
	 QcFJUvgaTl553vClF2YPShZACMRsIl+2jUpnqP3D3O2KO5qNFpYo/fKcr6gnu2m8WJ
	 w0W3rQ8yW5UWg==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 9/9] PCI: rzg3s-host: Add bridge::reset_root_port()
Date: Wed,  7 Oct 2026 08:36:45 +0300
Message-ID: <20261007053645.1391545-10-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
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

rzg3s_pcie_pm_notifier() disables the link event IRQ, and waits for a
running IRQ thread to complete (through disable_irq()). If that thread is
handling a link down event, it calls .reset_root_port(), which unmasks the
link interrupt before returning, undoing the mask. Therefore, mask the link
interrupt again after disable_irq() has returned.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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
 drivers/pci/controller/pcie-rzg3s-host.c | 100 ++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index d246bbe37948..3e2889a7f1a0 100644
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
index c2fbacfe6704..a8b222625a2a 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1193,8 +1193,27 @@ static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bounced)
 	u32 val;
 	int ret;
 
+	/*
+	 * A latched DL_UpDown means at least one real link transition took
+	 * place since the last enumeration. If devices are enumerated
+	 * recover the Root Port first.
+	 */
+	if (bounced && !list_empty(&bus->devices)) {
+		struct pci_dev *port __free(pci_dev_put) =
+			pci_get_slot(bus, PCI_DEVFN(0, 0));
+
+		if (port && pci_pcie_type(port) == PCI_EXP_TYPE_ROOT_PORT)
+			pci_host_handle_link_down(port);
+	}
+
 	pci_lock_rescan_remove();
 
+	/*
+	 * Read the link state after the recovery: the .reset_root_port()
+	 * retrains the link, so a device that is still present comes back
+	 * up here and is re-enumerated right away instead of waiting for
+	 * the next DL_UpDown event.
+	 */
 	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
 	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
 		if (!list_empty(&bus->devices)) {
@@ -1997,7 +2016,7 @@ static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
 	return ret;
 }
 
-static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
+static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host, bool set_started)
 {
 	const struct rzg3s_pcie_soc_data *data = host->data;
 	struct rzg3s_sysc *sysc = host->sysc;
@@ -2038,7 +2057,8 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
 	if (ret)
 		goto assert_power_resets;
 
-	host->started = true;
+	if (set_started)
+		host->started = true;
 
 	return 0;
 
@@ -2053,6 +2073,77 @@ static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
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
+	/* Mask link up/down interrupts. */
+	link_irqs = readl_relaxed(host->axi + RZG3S_PCI_PEIE0);
+	writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
+
+	/* Mask INTx and MSI interrupts. */
+	raw_spin_lock_irqsave(&host->hw_lock, flags);
+	irqs = readl_relaxed(host->axi + RZG3S_PCI_PINTRCVIE);
+	writel_relaxed(0, host->axi + RZG3S_PCI_PINTRCVIE);
+	raw_spin_unlock_irqrestore(&host->hw_lock, flags);
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
+	host->started = true;
+
+	return ret;
+}
+
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
 {
 	struct device_node *np = host->dev->of_node;
@@ -2133,6 +2224,8 @@ static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
 	case PM_SUSPEND_PREPARE:
 		/* Disable link up/down interrupts. */
 		disable_irq(host->event_irq);
+		if (host->started)
+			writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
 		break;
 
 	case PM_POST_SUSPEND:
@@ -2259,6 +2352,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = host;
 	bridge->ops = &rzg3s_pcie_root_ops;
 	bridge->child_ops = &rzg3s_pcie_child_ops;
+	bridge->reset_root_port = rzg3s_pcie_host_reset_root_port;
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto pm_notifier_unregister;
@@ -2317,7 +2411,7 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
 	int ret;
 
-	ret = rzg3s_pcie_host_start(host);
+	ret = rzg3s_pcie_host_start(host, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

