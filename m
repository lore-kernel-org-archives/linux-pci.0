Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FA3ACA7F;
	Fri,  6 Mar 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807743; cv=none; b=GlAZWan6wzNMpgx4pEqHNgA8gugahb6UWHkXvje/43UgZJNkhPQBGKg3j8402rxL98xWreYvS4rh42mrjfBWOIF+1wsrigN+pQynbecxbPVTwer/KTsZgEzQHQ5LS95ZCt7wlQtVc5Z9kJu5Oo6hwVbUiBlSiWrtyGFhJe3hhCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807743; c=relaxed/simple;
	bh=e6wZoPnfPSx9XO58b1avE3iqveBOFHsQZs+JFbES64I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ddo/oy8I0ui/gR4BHdzvoCrPgWWKTzW6r/BNwqpXdh4DOy78bfh7eJKWReFpZxJ8NHMVX5w80hog8KaVJR/Xpkcao/Q3SNkz3SI5Lhn2gBaQ0eiHY7CtVo1U2+td/N8MsmhYRNckpt33Wcq3lZdlHy2/Oaj5rEQdRUepHc2JyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: pvBd/CynQjmE5FQSnfCQMA==
X-CSE-MsgGUID: 3zzXwjSDTea09k3+gkmZrQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2026 23:35:38 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 280EB4008546;
	Fri,  6 Mar 2026 23:35:32 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v8 09/15] PCI: rzg3s-host: Add SoC-specific configuration and initialization callbacks
Date: Fri,  6 Mar 2026 15:34:16 +0100
Message-ID: <20260306143423.19562-10-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
References: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
reset framework with dedicated reset lines, other SoC variants like RZ/G3E
control configuration resets through PCIe AXI registers.

As Linux reset bulk API gracefully handles optional NULL reset lines
(num_cfg_resets = 0 for RZ/G3E), the driver continues to use the standard
reset framework when reset lines are available, while custom callbacks
are only invoked when provided.

This provides a balanced pattern where:
- RZ/G3S: Uses callbacks that fall back to the reset framework
- RZ/G3E: Sets num_cfg_resets=0, provides
  cfg_pre_init/cfg_post_init/cfg_deinit

Add cfg_pre_init, cfg_post_init, and cfg_deinit callbacks to support
custom configuration mechanism in preparation to RZ/G3E PCIe support.

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v8: Updated commit description

v7:
 - Fixed commit message: clarified that RZ/G3S callbacks fall
   back to the reset framework
 - Fixed checkpatch 75-char line length warning in commit
   description

v6:
  - Fix config_reinit error path in suspend_noirq: call config_pre_init
    before config_post_init as spotted by Claudiu.

v5:
  - Reorder got labels as per Claudiu's requirements

v4: No changes
v3: No changes

v2:
  - Renamed callbacks as per Claudiu's comments
  - Reworded goto labels to be consistents with callbacks

 drivers/pci/controller/pcie-rzg3s-host.c | 61 +++++++++++++++++-------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index c741d5ac2594..f8f03b669153 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -233,6 +233,9 @@ struct rzg3s_pcie_host;
 /**
  * struct rzg3s_pcie_soc_data - SoC specific data
  * @init_phy: PHY initialization function
+ * @config_pre_init: Optional callback for SoC-specific pre-configuration
+ * @config_post_init: Callback for SoC-specific post-configuration
+ * @config_deinit: Callback for SoC-specific de-initialization
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -243,6 +246,9 @@ struct rzg3s_pcie_host;
  */
 struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
+	void (*config_pre_init)(struct rzg3s_pcie_host *host);
+	int (*config_post_init)(struct rzg3s_pcie_host *host);
+	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info;
@@ -1109,6 +1115,18 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 	return 0;
 }
 
+static int rzg3s_pcie_config_post_init(struct rzg3s_pcie_host *host)
+{
+	return reset_control_bulk_deassert(host->data->num_cfg_resets,
+					   host->cfg_resets);
+}
+
+static int rzg3s_pcie_config_deinit(struct rzg3s_pcie_host *host)
+{
+	return reset_control_bulk_assert(host->data->num_cfg_resets,
+					 host->cfg_resets);
+}
+
 static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
 {
 	/*
@@ -1256,22 +1274,26 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 	u32 val;
 	int ret;
 
+	/* SoC-specific pre-configuration */
+	if (host->data->config_pre_init)
+		host->data->config_pre_init(host);
+
 	/* Initialize the PCIe related registers */
 	ret = rzg3s_pcie_config_init(host);
 	if (ret)
-		return ret;
+		goto config_deinit;
 
 	ret = rzg3s_pcie_host_init_port(host);
 	if (ret)
-		return ret;
+		goto config_deinit;
 
 	/* Initialize the interrupts */
 	rzg3s_pcie_irq_init(host);
 
-	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
-					  host->cfg_resets);
+	/* SoC-specific post-configuration */
+	ret = host->data->config_post_init(host);
 	if (ret)
-		goto disable_port_refclk;
+		goto config_deinit_and_refclk;
 
 	/* Wait for link up */
 	ret = readl_poll_timeout(host->axi + RZG3S_PCI_PCSTAT1, val,
@@ -1280,18 +1302,20 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
 				 PCIE_LINK_WAIT_MAX_RETRIES);
 	if (ret)
-		goto cfg_resets_deassert;
+		goto config_deinit_post;
 
 	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
 
 	return 0;
 
-cfg_resets_deassert:
-	reset_control_bulk_assert(host->data->num_cfg_resets,
-				  host->cfg_resets);
-disable_port_refclk:
+config_deinit_post:
+	host->data->config_deinit(host);
+config_deinit_and_refclk:
 	clk_disable_unprepare(host->port.refclk);
+config_deinit:
+	if (host->data->config_pre_init)
+		host->data->config_deinit(host);
 	return ret;
 }
 
@@ -1652,7 +1676,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 
 host_probe_teardown:
 	rzg3s_pcie_teardown_irqdomain(host);
-	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);
+	host->data->config_deinit(host);
 rpm_put:
 	pm_runtime_put_sync(dev);
 rpm_disable:
@@ -1685,15 +1709,15 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 
 	clk_disable_unprepare(port->refclk);
 
-	ret = reset_control_bulk_assert(data->num_cfg_resets,
-					host->cfg_resets);
+	/* SoC-specific de-initialization */
+	ret = data->config_deinit(host);
 	if (ret)
 		goto refclk_restore;
 
 	ret = reset_control_bulk_assert(data->num_power_resets,
 					host->power_resets);
 	if (ret)
-		goto cfg_resets_restore;
+		goto config_reinit;
 
 	ret = rzg3s_sysc_config_func(sysc, RZG3S_SYSC_FUNC_ID_RST_RSM_B, 0);
 	if (ret)
@@ -1705,9 +1729,10 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
-cfg_resets_restore:
-	reset_control_bulk_deassert(data->num_cfg_resets,
-				    host->cfg_resets);
+config_reinit:
+	if (data->config_pre_init)
+		data->config_pre_init(host);
+	data->config_post_init(host);
 refclk_restore:
 	clk_prepare_enable(port->refclk);
 	pm_runtime_resume_and_get(dev);
@@ -1772,6 +1797,8 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets = rzg3s_soc_cfg_resets,
 	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.config_post_init = rzg3s_pcie_config_post_init,
+	.config_deinit = rzg3s_pcie_config_deinit,
 	.init_phy = rzg3s_soc_pcie_init_phy,
 	.sysc_info = {
 		.functions = {
-- 
2.25.1

