Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919AF483BF3;
	Mon, 19 Oct 2026 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392724; cv=none; b=SpuWFAKEST0dp50H64+VZHhUalRzF6yDcMtxvYpkPMeT+dXDeAXFLCfBfIflb99E7t8fEaOuEYnXKTE20RYPW5c0n8KKwJXv7z6wKPNk2FTybFcZLkPDXVo11rRx1F0j1j2j+ecb5lhemAb7aGLCXdweHBf/uGaFLziRlUGPpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392724; c=relaxed/simple;
	bh=uiUhqapEJPvRTgQ7H6XzFkvryIDzDNqYN5SnzGcvcrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMn9J1a4Igi5F9jYdj7yZrRQhG38IwF7M6eQ+SqigZb5vTfDtnV7wn9mHZQ5SLjB+wlrO/M0K24MbTGkb0Qvz5agTicRJy5+13yI3PT9HSXmiUZHNd1GoyisYsuejpxiZ1b4McTEVHbWRRaHzQ6VEZAdWR+WBOykYugZ23uhN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxAS2qG3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxAS2qG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDA81F000C4;
	Mon, 19 Oct 2026 06:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392719;
	bh=XDUKFL6g1vHJ2u4+zrrS2nZwJZVdew6sOIumFAyC6cE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jxAS2qG3mlW2wzBtqYQr4TIIniAhpYstZDkAyk2WfxUJ3e/5in5MW1h7AlTC7VSdd
	 eEw1MYembbPdMjnlnslL4JlU8aRK50lT0QtYr9slObn3TyVwmiIdINKVYXnfUKkxpL
	 HkC/znZemGdHUlmw19FQj5vBYzYHFHSDyVeP0dA/PFZWKkn6obzd882x7MZ6qCRdlw
	 booj6pbZLT6XbbeGgGYl+5KU9xXFa5vgkTNC8/3lZeHHsZX6xBZ50sFbgd9ALv8N4O
	 HOW7yiowjmB32GeD7OIJI9tkSIi8H0sU8/0l6/dzW6Sdz7Jon2u1wly5Yb/Mg4zqOo
	 I623iDNMV8/eQ==
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v7 10/14] PCI: rzg3s-host: Move suspend/resume code into dedicated functions
Date: Mon, 19 Oct 2026 09:50:21 +0300
Message-ID: <20261019065025.2146539-11-claudiu.beznea@kernel.org>
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

In preparation for implementing hotplug using
pci_host_bridge::reset_root_port(), move the suspend/resume code into
rzg3s_pcie_host_stop() and rzg3s_pcie_host_start(). These functions
will later be reused by the hotplug implementation through
pci_host_bridge::reset_root_port().

Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- collected tags

Changes in v4:
- none

Changes in v3:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 181 ++++++++++++-----------
 1 file changed, 96 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index b7035522ddfc..54d1fd200f35 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1728,6 +1728,100 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	return 0;
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
+	 * Since the power domain's genpd_suspend_noirq() will disable clocks,
+	 * there is no need to manually invoke runtime PM API here.
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
+	 * Since the power domain's genpd_resume_noirq() will enable clocks,
+	 * there is no need to manually invoke runtime PM API here.
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
@@ -1931,98 +2025,15 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
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
-	 * Since the power domain's genpd_suspend_noirq() will disable clocks,
-	 * there is no need to manually invoke runtime PM API here.
-	 */
-
-	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
-	if (ret)
-		goto power_resets_restore;
 
-	return 0;
-
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
-	 * Since the power domain's genpd_resume_noirq() will enable clocks,
-	 * there is no need to manually invoke runtime PM API here.
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

