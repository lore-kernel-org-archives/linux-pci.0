Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1D3A544D
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295759; cv=none; b=K2y/R/9aNlLPz+5/oqRVMKhsm/59qIhnP2CcEqcIC/FSwyz2TRJygrdWk5XOYvlANVN5A+BB9fvhbcgJU5yWsWOlMWwMcqWMMPgphUfruZJpGhdGJz7EHe+rBdnLJf/iZkcSLQr+r9nM+8yw+88nNM2Cc4EvnmNVhtFxrROOPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295759; c=relaxed/simple;
	bh=KAhzL7kuPf7TDtuhxPvX/+A05jUcMp0Qu4qTKAZAKI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f43O+atu0JYsZCmUHYO+XTBx2HCz7fa8HA+MUT2MHp+tFr8L2HpFwoZrxGiXevQxj6F2urMv4Y9c4kimvFCKkjSrqS32JJDyNBjP02L95PqegOccT/tDx8pvIqBMKM5M4Gg/ou2O/WppVCxrZEyBb2ASmkgPs2U4u7jd3AzhNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kR//idYI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kR//idYI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48fde648a71so37903345e9.0
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779295755; x=1779900555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYJvdDeAzqbJzpWMdXR3dlBUpIWW8S3jv24vj3I7EAM=;
        b=kR//idYIccnSyjiPyd7+os9Mqrxp8M1YmoKshhtV6+R2SScHeRhMuDf2H3Ru7ipTs1
         T6C3n2c7SxzFgE1EDdRWJl0OXd6OIxIyeEAMz8Xe+2pyHq1Ts0sUBZtfGBeKp5BLq01J
         2ObsHYzfYLTjGo+ECufJlh//eO6qhIdlSLEpCzavzz76mSlyyiM9GFw5jwG6sLRPUWiB
         SOTixQru7RyiVqiq3xZ3CSsSBtBgSimWN/py+vjKqfsMwvBhmXSSqfPM7ztRDvtYQKVa
         45VpDAS5nmhuxJAJs8j4laLXD+Z8RzgAUfNEqSMeyVGPFnTpzsEkdqowSfedmLPPOh2d
         /bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779295755; x=1779900555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LYJvdDeAzqbJzpWMdXR3dlBUpIWW8S3jv24vj3I7EAM=;
        b=r9hQgSdQln3GQ2U8atfDcvqX9gUt0zZWcYS0RIM3Kyn/kmsS2XVkxbjqefEcNUltVX
         QDRhjCbW8IyM0Z51M5Ew0o6Y/rd4asrDpokDpLKXb15ol9osUkPzTz9iCFPTFYtuWtCa
         o6Fbf8aoELhSe43i+RVxDulsfeqIhArTZzlRbqKSpcZ5amT2amu82Etpj3gMFLfoeAYJ
         d93Q1PilkvPXdSOPjEk+1TKQQrlJWt4bBwOZyydqsy8BFIoT9XGx4Za/h0lDsti6TcBS
         MIUFXlPwloK3LKvfdxYVoiGxDuZjBjvSc6Z9yMdDYoPVeemU4oop8W+DOK48SUwBD8mB
         nMJQ==
X-Gm-Message-State: AOJu0YzbQFyk/9ofvqvuefvi3hdAvkMFp+HcPLvRHTfGQPcVYre7Jcqc
	S7c4OJjBRnt8DmOVtHxI8mHJAz5NHVpFvKQ7K3lXi4M25QjYYLXV8o5A
X-Gm-Gg: Acq92OHuzig/Hv3S642nZHev2iH2OUAUVhiqVOBewMRDEUxCNn41avUqVsyLniNVUS3
	swmuLJ5hsdGlHF4LOT8zKYhgRJCjFUmaU0Tq2Yxautnv5jdGUpBpawghHqL+ze3j4zNqzr3Mtxu
	BF+ZmQ10NSfGFGF/13Flmo55tQ33tNuq/QXWAtq6NYBXEhUTp2ZuBW+Ra1Bv7a4JQ+yY/l70nR+
	i3Tw5yNZKSy/FK7AJsAylsU44d3EXEBWDc1hpgQDxByvVPNb1/0E/7qcg254lqtp9F0LX6TOf8Q
	P8L8vrml/Xs1NZUftd46OPxh07iB0ELCGupEtSPwpYp7Z2lIc09YDo2HIdGWp1diMoNSVe6UEjr
	bw15bCvQ9iRRtFpDz4PzNOwGWlj5ymr7sBuMebXccoaSRR/ek7myHvzO3J6l50ydyyWJTw1sxaE
	S4ImlUWUyPIYE9uMRw+MzMLFbfl0uLseyCapa4BqxbOsJ7DQR4Et3rpp+rmbyhCY2F+9/XuPy4y
	rdLCsA/L/h/dirMXpliLc2nx26/CnQLFjq0Iqhbf8xr0iw=
X-Received: by 2002:a05:600c:c0c1:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-49033d3f1f1mr3438225e9.8.1779295754507;
        Wed, 20 May 2026 09:49:14 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:dcb8:81c1:dc9e:cd68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49033d8e71dsm3110285e9.9.2026.05.20.09.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:49:14 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 4/4] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
Date: Wed, 20 May 2026 17:48:23 +0100
Message-ID: <20260520164823.436992-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260520164823.436992-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
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
 drivers/pci/controller/pcie-rzg3s-host.c | 180 +++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index edb49af7429a..15879b2c0bd2 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -179,6 +179,16 @@
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
@@ -194,12 +204,14 @@ struct rzg3s_sysc_function {
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
 
@@ -261,6 +273,7 @@ struct rzg3s_pcie_host;
  * @config_pre_init: Optional callback for SoC-specific pre-configuration
  * @config_post_init: Callback for SoC-specific post-configuration
  * @config_deinit: Callback for SoC-specific de-initialization
+ * @setup_lanes: Callback for setting up the number of lanes
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -268,17 +281,20 @@ struct rzg3s_pcie_host;
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
@@ -309,6 +325,7 @@ struct rzg3s_pcie_port {
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @controller_id: PCIe controller identifier, used for System Controller access
+ * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -325,10 +342,23 @@ struct rzg3s_pcie_host {
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
@@ -1155,6 +1185,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
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
 
@@ -1687,6 +1724,75 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
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
+	if (!ret) {
+		rzv2h_num_total_lanes += num_lanes;
+		host->num_lanes = num_lanes;
+	}
+
+	return ret;
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
@@ -1711,6 +1817,10 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (!host->sysc)
 		return -ENOMEM;
 
+	ret = rzg3s_pcie_get_controller_id(host);
+	if (ret)
+		return ret;
+
 	sysc = host->sysc;
 	sysc->info = &host->data->sysc_info[host->controller_id];
 
@@ -1740,6 +1850,16 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
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
@@ -1854,6 +1974,16 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
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
@@ -1901,6 +2031,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets = rzg3s_soc_cfg_resets,
 	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.num_pcie_controllers = 1,
 	.config_post_init = rzg3s_pcie_config_post_init,
 	.config_deinit = rzg3s_pcie_config_deinit,
 	.init_phy = rzg3s_soc_pcie_init_phy,
@@ -1921,6 +2052,7 @@ static const char * const rzg3e_soc_power_resets[] = { "aresetn" };
 static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	.power_resets = rzg3e_soc_power_resets,
 	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_pcie_controllers = 1,
 	.config_pre_init = rzg3e_pcie_config_pre_init,
 	.config_post_init = rzg3e_pcie_config_post_init,
 	.config_deinit = rzg3e_pcie_config_deinit,
@@ -1940,6 +2072,50 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
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
@@ -1949,6 +2125,10 @@ static const struct of_device_id rzg3s_pcie_of_match[] = {
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

