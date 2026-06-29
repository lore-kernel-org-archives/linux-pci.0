Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963D3CBE86
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770981; cv=none; b=Ht0xWe8PskHWXMtyYM6esa6BkNsG5kG6W6XPmSiFKvUYDBagRA+h/6+YKhrJbzzUPSHSjgIrlZxjm8qaSz+K0oP2hyXkZH7ZTOy/fpVedBcdWffIONsh9ozA+GBWQJeYMqdHZkHXAS/wl937/HykFXRaEKz85heDGwcwvnTw6ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770981; c=relaxed/simple;
	bh=AO3pjUA02fuoluztAxfQlLBXwNp5s8TbF9D/Elkj8Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ00aujf9Vz9CKwWaLW5iZAGLaz9L3/PTPZqSVDFxRDqDUChVIKIE5McByEBXqx5G3mQZKNh0cxyoQN8T/8iTc7aEft9aqTiLbRU9JaMFqTe3HpLOT5b5tjYzV7k5CzvuQeOg8qUrgsbK0rlJKP6TRycH13RVR0AQLtoXPNqE6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdF7GlFy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdF7GlFy"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47248615e4dso2123241f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782770977; x=1783375777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux8a3tK86qwLdPR6FBd7m6/mXK+YbhT+gnE1wZLRZfg=;
        b=FdF7GlFySbp4pMTEhMSoCMOiI79el0fbqPvBr+5jEa6VAN4dvOyf+gs+MvNPGS8MVn
         ZBrEa8+vN2jvQl4aNFZTO9cEyN54AtnFi9eh4WYO4Cujm3pTjylMAK4pDMo7+CXd4/4f
         mUTZcYVXDsdva8i+MJ0KpFlPgUpqJHFDm1iXWWeGtGfX86Q049HNp/nNMJT0LlV5LClz
         clFFEwC87NVEhKcPqvYZt2pG6dyL0CUxTHMXxULN2YB4KlPklGPNuLe5lLWW8KYqXy+p
         +uvOS1yRaFiSYXS/ljWMfguQf+u7f/Rz3M28OnnCCPmT8kXpnp0fbwnb13acu7oUgXB0
         a+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770977; x=1783375777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ux8a3tK86qwLdPR6FBd7m6/mXK+YbhT+gnE1wZLRZfg=;
        b=sYGTDG/rQsuzY7TatbB7g+NhaaB5cFgn+DGfsgkl8da6g4T4nY03RYw9l+3Bggkuz9
         R+EGSXBLziGGFZuB4FXGZgKjc1GdPvYqwZTmlc6vj8BAUdJoqC8XlJCh80+/QmvYvm6R
         tEjewft8Tncfl1eN6H0PjprWVkFEWxr744yi4xaE4N0/K/xwO4D5d6H9z08HjFK72ajL
         D1JW73gdoJnwCQiH6YRosP3tx/V/6uvSE5hCYaOm/iHvMrzwzb1ju2miQRr+SLRp2FTT
         Y2qD0GSCT14xskuAViXDphH2q7lqTss0g3GoS14Y1XkHf7ZJwhT+jGty8M1WZpw9HsRT
         5fJw==
X-Forwarded-Encrypted: i=1; AHgh+RoQgN1CluMraYeYwYZkff2a0RKPt84n+hLJ4/539QpKyS7WW5NH5cQQt1hydt2oNUwYcwC4uilI+Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxgBb08qsN8w35vQAQEv+v2jaByZYjZjQVTYxD88Zqi98uaOwu
	uOsSd/ubKqV6SkZ6Bo3R670MQLN2rw6Xzf5QCJc6l/RBKv+/QjXcp6XJ
X-Gm-Gg: AfdE7clbFjSnV50q8CJ9UCHu4W0G4gm3pmCI3aHhiDqlZmYdLIf8QnZEzWLSOHV8UsC
	AObtp1qJSquu5YWh5Njfbwz0VdL+/nYgJFR6oReDPQfc6FewdYaeLKjoaHKFec7XiGp2ZSaMUjw
	IR/EUCEmVeKqhEdftDmsh/wS4KWF52jKDSEQY508R9gadpl2gHzzm17Pz0a3uh3jw89xlOLGvcv
	qWIoZ38orgAzbEUe1qI+t9YfvWvYCkGSjhIestuemD1I5Gbkpbx3BVpx7CMFMJb4JiORx7gZ4rs
	tN9r0l637fSo3DHeBBtzUEMypLbE+BBLg69BZLXW98vM/iuSpHCe1mCtyqGBa/m8WuksAmant9s
	xLlfnah4HBGNtd020t4dOp66idRKzHkgO8xOMX1rMRlZ3rg95y7vtDkdCy5K8BSLtT0CKz2As7k
	Xiq5nQQKdyzV9rK6i2B8s7itTFCgOOtVIKgt6s/Ye3zTxK23KVYaEWErTVjCzwO7QfzYw4lI9WK
	SoY7YuYEkdC86m2+/FmEaDdM7o=
X-Received: by 2002:a05:6000:2893:b0:472:edc7:b4c9 with SMTP id ffacd0b85a97d-475524a7e38mr1293244f8f.38.1782770977381;
        Mon, 29 Jun 2026 15:09:37 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:dfcc:acfa:dec0:e556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm1644670f8f.8.2026.06.29.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 15:09:36 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v5 4/4] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
Date: Mon, 29 Jun 2026 23:09:32 +0100
Message-ID: <20260629220932.861445-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for the RZ/V2H(P) SoC PCIe controllers to the rzg3s-host
driver.

The RZ/V2H(P) SoC features two independent PCIe controllers that share
four physical lanes. The hardware supports two configuration modes:
single x4 mode where the first controller uses all four lanes, or dual
x2 mode where both controllers use two lanes each.

Introduce a setup_lanes() function pointer to configure the PCIe lanes
based on the hardware instance. Implement rzv2h_pcie_setup_lanes() to
detect the configuration at boot time and program the lane mode via the
system controller.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v4->v5:
- No change

v3->v4:
- In rzv2h_pcie_setup_lanes() returned early in case of error
- Added RB/TB tags

v2->v3:
- Parsed controller-id from the "renesas,sysc" property instead of
  using linux,pci-domain.

v1->v2:
- Updated commit message.
- Added locks to protect shared lane configuration state and
  prevent concurrent access issues during probe.
- Added cleanup action to release lanes on driver removal.
- Reconfigured RZG3S_SYSC_FUNC_ID_LINK_MASTER in resume path.
- Renamed num_channels to num_pcie_controllers for clarity.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 181 +++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 03d79e98c9c9..a1a78bdb7af1 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -180,6 +180,16 @@
 /* Timeouts experimentally determined */
 #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
 
+/**
+ * enum rzg3s_sysc_link_mode - PCIe link configuration modes
+ * @RZG3S_SYSC_LINK_MODE_SINGLE_X4: Single port with x4 lanes
+ * @RZG3S_SYSC_LINK_MODE_DUAL_X2: Dual ports with x2 lanes each
+ */
+enum rzg3s_sysc_link_mode {
+	RZG3S_SYSC_LINK_MODE_SINGLE_X4 = 1,
+	RZG3S_SYSC_LINK_MODE_DUAL_X2 = 3,
+};
+
 /**
  * struct rzg3s_sysc_function - System Controller function descriptor
  * @offset: Register offset from the System Controller base address
@@ -195,12 +205,14 @@ struct rzg3s_sysc_function {
  * @RZG3S_SYSC_FUNC_ID_RST_RSM_B: RST_RSM_B SYSC function ID
  * @RZG3S_SYSC_FUNC_ID_L1_ALLOW: L1 allow SYSC function ID
  * @RZG3S_SYSC_FUNC_ID_MODE: Mode SYSC function ID
+ * @RZG3S_SYSC_FUNC_ID_LINK_MASTER: Link master SYSC function ID
  * @RZG3S_SYSC_FUNC_ID_MAX: Max SYSC function ID
  */
 enum rzg3s_sysc_func_id {
 	RZG3S_SYSC_FUNC_ID_RST_RSM_B,
 	RZG3S_SYSC_FUNC_ID_L1_ALLOW,
 	RZG3S_SYSC_FUNC_ID_MODE,
+	RZG3S_SYSC_FUNC_ID_LINK_MASTER,
 	RZG3S_SYSC_FUNC_ID_MAX,
 };
 
@@ -262,6 +274,7 @@ struct rzg3s_pcie_host;
  * @config_pre_init: Optional callback for SoC-specific pre-configuration
  * @config_post_init: Callback for SoC-specific post-configuration
  * @config_deinit: Callback for SoC-specific de-initialization
+ * @setup_lanes: Callback for setting up the number of lanes
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -269,17 +282,20 @@ struct rzg3s_pcie_host;
  * @sysc_info: System Controller info for each controller
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
+ * @num_pcie_controllers: number of PCIe controllers
  */
 struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
 	void (*config_pre_init)(struct rzg3s_pcie_host *host);
 	int (*config_post_init)(struct rzg3s_pcie_host *host);
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
+	int (*setup_lanes)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CONTROLLER_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
+	u8 num_pcie_controllers;
 };
 
 /**
@@ -310,6 +326,7 @@ struct rzg3s_pcie_port {
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
+ * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -326,10 +343,23 @@ struct rzg3s_pcie_host {
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_controller_id controller_id;
+	u8 num_lanes;
 };
 
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
 
+/*
+ * RZ/V2H(P) supports a total of 4 lanes shared across two controllers.
+ * rzv2h_lane_lock serialises both the counter update and the SYSC
+ * register write so that concurrent async probes cannot race on the
+ * shared LINK_MASTER register (offset 0x1060).
+ * rzv2h_num_total_lanes tracks global lane usage to prevent
+ * over-allocation or invalid bifurcation modes.
+ */
+#define RZV2H_PCIE_MAX_LANES		4
+static DEFINE_SPINLOCK(rzv2h_lane_lock);
+static u8 rzv2h_num_total_lanes;
+
 static int rzg3s_sysc_config_func(struct rzg3s_sysc *sysc,
 				  enum rzg3s_sysc_func_id fid, u32 val)
 {
@@ -1156,6 +1186,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
 	rzg3s_pcie_update_bits(host->pcie, PCI_CLASS_REVISION, mask,
 			       field_prep(mask, PCI_CLASS_BRIDGE_PCI_NORMAL));
 
+	if (host->num_lanes) {
+		rzg3s_pcie_update_bits(host->pcie + RZG3S_PCI_CFG_PCIEC,
+				       PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_MLW,
+				       FIELD_PREP(PCI_EXP_LNKCAP_MLW,
+						  host->num_lanes));
+	}
+
 	/* Disable access control to the CFGU */
 	writel_relaxed(0, host->axi + RZG3S_PCI_PERM);
 
@@ -1688,6 +1725,76 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	return ret;
 }
 
+static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
+{
+	struct device_node *np = host->dev->of_node;
+	struct of_phandle_args sysc_args;
+	int ret;
+
+	if (host->data->num_pcie_controllers == 1)
+		return 0;
+
+	ret = of_parse_phandle_with_fixed_args(np, "renesas,sysc", 1, 0, &sysc_args);
+	if (ret)
+		return ret;
+
+	of_node_put(sysc_args.np);
+
+	if (sysc_args.args[0] >= host->data->num_pcie_controllers ||
+	    sysc_args.args[0] >= RZG3S_PCIE_CONTROLLER_ID_MAX)
+		return -EINVAL;
+
+	host->controller_id = sysc_args.args[0];
+
+	return 0;
+}
+
+static int rzv2h_pcie_setup_lanes(struct rzg3s_pcie_host *host)
+{
+	struct device_node *np = host->dev->of_node;
+	u32 num_lanes;
+	int ret;
+
+	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
+	if (ret)
+		return ret;
+
+	/*
+	 * RZ/V2H(P) supports up to 4 lanes, but only in single x4 mode
+	 * for the first controller. Dual x2 mode is supported with 2
+	 * lanes for both controllers.
+	 */
+	if (num_lanes != 4 && num_lanes != 2)
+		return -EINVAL;
+
+	if (host->controller_id == RZG3S_PCIE_CONTROLLER_ID_1 && num_lanes > 2)
+		return -EINVAL;
+
+	guard(spinlock)(&rzv2h_lane_lock);
+	if (rzv2h_num_total_lanes + num_lanes > RZV2H_PCIE_MAX_LANES)
+		return -EINVAL;
+
+	ret = rzg3s_sysc_config_func(host->sysc, RZG3S_SYSC_FUNC_ID_LINK_MASTER,
+				     num_lanes == 2 ?
+				     RZG3S_SYSC_LINK_MODE_DUAL_X2 :
+				     RZG3S_SYSC_LINK_MODE_SINGLE_X4);
+	if (ret)
+		return ret;
+
+	rzv2h_num_total_lanes += num_lanes;
+	host->num_lanes = num_lanes;
+
+	return 0;
+}
+
+static void rzv2h_pcie_release_lanes(void *data)
+{
+	struct rzg3s_pcie_host *host = data;
+
+	guard(spinlock)(&rzv2h_lane_lock);
+	rzv2h_num_total_lanes -= host->num_lanes;
+}
+
 static int rzg3s_pcie_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *bridge;
@@ -1712,6 +1819,10 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (!host->sysc)
 		return -ENOMEM;
 
+	ret = rzg3s_pcie_get_controller_id(host);
+	if (ret)
+		return ret;
+
 	sysc = host->sysc;
 	sysc->info = &host->data->sysc_info[host->controller_id];
 
@@ -1741,6 +1852,16 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto port_refclk_put;
 
+	if (host->data->setup_lanes) {
+		ret = host->data->setup_lanes(host);
+		if (ret)
+			goto sysc_signal_restore;
+
+		ret = devm_add_action_or_reset(dev, rzv2h_pcie_release_lanes, host);
+		if (ret)
+			goto sysc_signal_restore;
+	}
+
 	ret = rzg3s_pcie_resets_prepare_and_get(host);
 	if (ret)
 		goto sysc_signal_restore;
@@ -1855,6 +1976,16 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
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
 	ret = rzg3s_pcie_power_resets_deassert(host);
 	if (ret)
 		goto assert_rst_rsm_b;
@@ -1902,6 +2033,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets = rzg3s_soc_cfg_resets,
 	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.num_pcie_controllers = 1,
 	.config_post_init = rzg3s_pcie_config_post_init,
 	.config_deinit = rzg3s_pcie_config_deinit,
 	.init_phy = rzg3s_soc_pcie_init_phy,
@@ -1922,6 +2054,7 @@ static const char * const rzg3e_soc_power_resets[] = { "aresetn" };
 static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	.power_resets = rzg3e_soc_power_resets,
 	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers = 1,
 	.config_pre_init = rzg3e_pcie_config_pre_init,
 	.config_post_init = rzg3e_pcie_config_post_init,
 	.config_deinit = rzg3e_pcie_config_deinit,
@@ -1941,6 +2074,50 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	},
 };
 
+static const struct rzg3s_pcie_soc_data rzv2h_soc_data = {
+	.power_resets = rzg3e_soc_power_resets,
+	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers = 2,
+	.config_pre_init = rzg3e_pcie_config_pre_init,
+	.config_post_init = rzg3e_pcie_config_post_init,
+	.config_deinit = rzg3e_pcie_config_deinit,
+	.setup_lanes = rzv2h_pcie_setup_lanes,
+	.sysc_info = {
+		[RZG3S_PCIE_CONTROLLER_ID_0] = {
+			.functions = {
+				[RZG3S_SYSC_FUNC_ID_L1_ALLOW] = {
+					.offset = 0x1020,
+					.mask = BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_MODE] = {
+					.offset = 0x1024,
+					.mask = BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_LINK_MASTER] = {
+					.offset = 0x1060,
+					.mask = GENMASK(9, 8),
+				},
+			},
+		},
+		[RZG3S_PCIE_CONTROLLER_ID_1] = {
+			.functions = {
+				[RZG3S_SYSC_FUNC_ID_L1_ALLOW] = {
+					.offset = 0x1050,
+					.mask = BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_MODE] = {
+					.offset = 0x1054,
+					.mask = BIT(0),
+				},
+				[RZG3S_SYSC_FUNC_ID_LINK_MASTER] = {
+					.offset = 0x1060,
+					.mask = GENMASK(9, 8),
+				},
+			},
+		},
+	},
+};
+
 static const struct of_device_id rzg3s_pcie_of_match[] = {
 	{
 		.compatible = "renesas,r9a08g045-pcie",
@@ -1950,6 +2127,10 @@ static const struct of_device_id rzg3s_pcie_of_match[] = {
 		.compatible = "renesas,r9a09g047-pcie",
 		.data = &rzg3e_soc_data,
 	},
+	{
+		.compatible = "renesas,r9a09g057-pcie",
+		.data = &rzv2h_soc_data,
+	},
 	{}
 };
 
-- 
2.54.0

