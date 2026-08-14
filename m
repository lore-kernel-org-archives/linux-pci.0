Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0C13C10B9;
	Fri, 14 Aug 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716831; cv=none; b=uzuIy7D8KlFh+nd+lIWe0GEzPfh/6rCSkjIukLtFtcXyJSg0AFZ3d7OkPbtYnLVGFCJGJAhYlyuYuicNlMn2yCADhfvXstC0aHJyfmcRRvcVA+BxvjLbAkzJXEkyAJhkwJU55rI1UzrY93jfTwSgBLl+sMDKZrtGY47bTppeKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716831; c=relaxed/simple;
	bh=1HhfSk74GV8E6A+13x4wnKQ+2C4VmOsAH+RmVRxx5Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSsbjy8XEj4sxyVc0fg36mP8osGI/WYvperohKurQR9TpthoWCvQ5XAKENRvqXk7AmR5hObqLy332mZqg3UE5yQ/Ly4C3FS6U52zYGeO7/XmnQTbUAaR+9w6siXrbUQ4CXNKL9i859sIn5Voj2rgkGvH64wgGi+A/SjdsQO6+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945F61F00AC4;
	Fri, 14 Aug 2026 14:13:37 +0000 (UTC)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 5/7] PCI: rzg3s-host: Move suspend/resume code into dedicated functions
Date: Fri, 14 Aug 2026 17:13:10 +0300
Message-ID: <20260814141312.2947972-6-claudiu.beznea+renesas@tuxon.dev>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

In preparation for implementing hotplug using
pci_host_bridge::reset_root_port(), move the suspend/resume code into
rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
will later be reused by the hotplug implementation through
pci_host_bridge::reset_root_port().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 237 ++++++++++++-----------
 1 file changed, 124 insertions(+), 113 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 579386d1aaa3..834b03d56713 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1742,6 +1742,128 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	return ret;
 }
 
+static int rzg3s_pcie_host_stop(struct rzg3s_pcie_host *host)
+{
+	const struct rzg3s_pcie_soc_data *data = host->data;
+	struct rzg3s_pcie_port *port = &host->port;
+	struct rzg3s_sysc *sysc = host->sysc;
+	int ret;
+
+	clk_disable_unprepare(port->refclk);
+
+	/* SoC-specific de-initialization */
+	ret = data->config_deinit(host);
+	if (ret)
+		goto refclk_restore;
+
+	ret = reset_control_bulk_assert(data->num_power_resets,
+					host->power_resets);
+	if (ret)
+		goto config_reinit;
+
+	/*
+	 * Since:
+	 * - the runtime PM usage count was incremented by
+	 *   pm_runtime_get_noresume() in the system suspend/resume code before
+	 *   executing the subsystem-level .prepare() callback
+	 *   (in device_prepare()),
+	 * - runtime PM has been disabled by the system suspend/resume code
+	 *   before executing the subsystem-level .suspend_late() callback
+	 *   (in device_suspend_late()), and
+	 * - the PCIe driver's runtime PM state remains RPM_ACTIVE (it was
+	 *   runtime resumed in probe()),
+	 *
+	 * any runtime PM operation becomes a no-op and may lead to unexpected
+	 * failures.
+	 *
+	 * Let the power domain's genpd_suspend_noirq() callback disable the
+	 * clocks, as it already does.
+	 */
+
+	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
+	if (ret)
+		goto power_resets_restore;
+
+	return 0;
+
+	/* Restore the previous state if any error happens */
+power_resets_restore:
+	reset_control_bulk_deassert(data->num_power_resets,
+				    host->power_resets);
+config_reinit:
+	if (data->config_pre_init)
+		data->config_pre_init(host);
+	data->config_post_init(host);
+refclk_restore:
+	clk_prepare_enable(port->refclk);
+	return ret;
+}
+
+static int rzg3s_pcie_host_start(struct rzg3s_pcie_host *host)
+{
+	const struct rzg3s_pcie_soc_data *data = host->data;
+	struct rzg3s_sysc *sysc = host->sysc;
+	int ret;
+
+	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
+	if (ret)
+		return ret;
+
+	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
+	if (ret)
+		return ret;
+
+	if (host->num_lanes) {
+		ret = rzg3s_sysc_config_func(host->sysc,
+					     RZG3S_SYSC_FUNC_ID_LINK_MASTER,
+					     host->num_lanes == 2  ?
+					     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
+					     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
+		if (ret)
+			goto assert_rst_rsm_b;
+	}
+
+	/*
+	 * Since:
+	 * - the runtime PM usage count was incremented by
+	 *   pm_runtime_get_noresume() in the system suspend/resume code before
+	 *   executing the subsystem-level .prepare() callback
+	 *   (in device_prepare()),
+	 * - runtime PM has been disabled by the system suspend/resume code
+	 *   before executing the subsystem-level .suspend_late() callback
+	 *   (in device_suspend_late()),
+	 * - on resume pm_runtime_enable() is called after executing the
+	 *   subsystem-level .resume_early() (in device_resume_early())
+	 *
+	 * any runtime PM operation becomes a no-op and may lead to unexpected
+	 * failures.
+	 *
+	 * Let the power domain's genpd_resume_noirq() callback enable the
+	 * clocks, as it already does.
+	 */
+
+	ret = rzg3s_pcie_power_resets_deassert(host);
+	if (ret)
+		goto assert_rst_rsm_b;
+
+	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
+				    rzg3s_pcie_msi_hw_teardown);
+	if (ret)
+		goto assert_power_resets;
+
+	return 0;
+
+	/*
+	 * If any error happens there is no way to recover the IP. Put it in the
+	 * lowest possible power state.
+	 */
+assert_power_resets:
+	reset_control_bulk_assert(data->num_power_resets, host->power_resets);
+assert_rst_rsm_b:
+	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
+	return ret;
+}
+
 static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
 {
 	struct device_node *np = host->dev->of_node;
@@ -1939,126 +2061,15 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 static int rzg3s_pcie_suspend_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
-	const struct rzg3s_pcie_soc_data *data = host->data;
-	struct rzg3s_pcie_port *port = &host->port;
-	struct rzg3s_sysc *sysc = host->sysc;
-	int ret;
-
-	clk_disable_unprepare(port->refclk);
-
-	/* SoC-specific de-initialization */
-	ret = data->config_deinit(host);
-	if (ret)
-		goto refclk_restore;
-
-	ret = reset_control_bulk_assert(data->num_power_resets,
-					host->power_resets);
-	if (ret)
-		goto config_reinit;
-
-	/*
-	 * Since:
-	 * - the runtime PM usage count was incremented by
-	 *   pm_runtime_get_noresume() in the system suspend/resume code before
-	 *   executing the subsystem-level .prepare() callback
-	 *   (in device_prepare()),
-	 * - runtime PM has been disabled by the system suspend/resume code
-	 *   before executing the subsystem-level .suspend_late() callback
-	 *   (in device_suspend_late()), and
-	 * - the PCIe driver's runtime PM state remains RPM_ACTIVE (it was
-	 *   runtime resumed in probe()),
-	 *
-	 * any runtime PM operation becomes a no-op and may lead to unexpected
-	 * failures.
-	 *
-	 * Let the power domain's genpd_suspend_noirq() callback disable the
-	 * clocks, as it already does.
-	 */
-
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
-	if (ret)
-		goto power_resets_restore;
-
-	return 0;
 
-	/* Restore the previous state if any error happens */
-power_resets_restore:
-	reset_control_bulk_deassert(data->num_power_resets,
-				    host->power_resets);
-config_reinit:
-	if (data->config_pre_init)
-		data->config_pre_init(host);
-	data->config_post_init(host);
-refclk_restore:
-	clk_prepare_enable(port->refclk);
-	return ret;
+	return rzg3s_pcie_host_stop(host);
 }
 
 static int rzg3s_pcie_resume_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
-	const struct rzg3s_pcie_soc_data *data = host->data;
-	struct rzg3s_sysc *sysc = host->sysc;
-	int ret;
 
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_MODE, 1);
-	if (ret)
-		return ret;
-
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 1);
-	if (ret)
-		return ret;
-
-	if (host->num_lanes) {
-		ret = rzg3s_sysc_config_func(host->sysc,
-					     RZG3S_SYSC_FUNC_ID_LINK_MASTER,
-					     host->num_lanes == 2  ?
-					     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
-					     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
-		if (ret)
-			goto assert_rst_rsm_b;
-	}
-
-	/*
-	 * Since:
-	 * - the runtime PM usage count was incremented by
-	 *   pm_runtime_get_noresume() in the system suspend/resume code before
-	 *   executing the subsystem-level .prepare() callback
-	 *   (in device_prepare()),
-	 * - runtime PM has been disabled by the system suspend/resume code
-	 *   before executing the subsystem-level .suspend_late() callback
-	 *   (in device_suspend_late()),
-	 * - on resume pm_runtime_enable() is called after executing the
-	 *   subsystem-level .resume_early() (in device_resume_early())
-	 *
-	 * any runtime PM operation becomes a no-op and may lead to unexpected
-	 * failures.
-	 *
-	 * Let the power domain's genpd_resume_noirq() callback enable the
-	 * clocks, as it already does.
-	 */
-
-	ret = rzg3s_pcie_power_resets_deassert(host);
-	if (ret)
-		goto assert_rst_rsm_b;
-
-	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_msi_hw_setup,
-				    rzg3s_pcie_msi_hw_teardown);
-	if (ret)
-		goto assert_power_resets;
-
-	return 0;
-
-	/*
-	 * If any error happens there is no way to recover the IP. Put it in the
-	 * lowest possible power state.
-	 */
-assert_power_resets:
-	reset_control_bulk_assert(data->num_power_resets,
-				  host->power_resets);
-assert_rst_rsm_b:
-	rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
-	return ret;
+	return rzg3s_pcie_host_start(host);
 }
 
 static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
-- 
2.43.0

