Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266633D75B5
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837922; cv=none; b=mKJ6IEVU8bBBDkXqvlaqHYNw7ImiJA0GjPP/7/4kQqCJDrsToGaBl8ydRhjCls6W0WPB1WNERolSI8BFwe9XwMSChWWz2Biamx7lC8KaZZYKYqKi9G4zqZ3xgB2BdYeJpogbkdQtSDvDLqc5AVPrJ614QoUDSti1RUOU/xTC2IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837922; c=relaxed/simple;
	bh=RjHl7j/Lg5vZPB4YXi7xN2rOYCqftOPO41V9TjL/Piw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPeXlbgWFSdpqbtiBVcLqU8N+9lYkxrybwTE4pBiM09uzygkgctmWmrM1UXizcHNICY68nGXTpQLJpgBqqyJqQ617whVNBgrt0dthT8upe/CecS+kh5zscPhPS7f3JLWn6xPeCbHUMJMA33HTaFemgSkAITF9zVTgpOvj3mIqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqmas3KB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqmas3KB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so6809652f8f.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773837913; x=1774442713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2beXNldnnMW0fC5Mifqd0YZdlJwrApukwctaOe5qsiI=;
        b=Lqmas3KBg/R7DZ50IkY6cNDr0fR+hTLq+KlfGmy0CfwFM08gZVoS2REHTMuZcylBAC
         wYq21G5yCkZQuiQl0WAO0FHBztcVExohLhT7RIeDGR93rSyqbrCaSBtYLqZJR99zwvo8
         YPWsjBk8ze27yBeSiMKHeyjl3jWGQaGurz9pyfuANf8/MO6+jZiuy4996MyLAGD5+1pv
         4GllsZ5VgoES7ZBcqpoafNtAvt22TjGFnL39jwakj+iXYSpvJMw5rR7e9E/4GgtuhuQz
         hfgPiVBiC9YOIT/ZYww0Dayxc/M1DsaLmbbQuU80vWutE+GETbi4vrXyaZpWQHl/k3NH
         Nk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837913; x=1774442713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2beXNldnnMW0fC5Mifqd0YZdlJwrApukwctaOe5qsiI=;
        b=lpV9SL1p1brnKV4Te8QlXa0FFqImMNjjO4tO3ym1tKtr2Vb2lA+e/Mq8wEXKTBtNLC
         gSUez3yLdzDupX2tjvu56ZsTmVbW4cymX0YiO4sQxFC+mB3fKQjcv7KKIM+TyLRkk6ZZ
         ARYKdy3haTeHI4uGHYSPt8UByaSQIEg65gxpliK2QUeLNV2xSl/Bzti5w4tL+7+cYD0Q
         sg44dUnb1PAo/KM94fstVwHw4PpVBASijeanEEgRYTPaFkSZ1HiTDKymbMq0nhrM5y6K
         mEjSq3uEqB9YidPZi2qCGytXavRY4h+7goWrMu+k8XMuLHRhZKdRoWVirOphkJ+j2keH
         MCVw==
X-Forwarded-Encrypted: i=1; AJvYcCWJZBUYnk2MJz0LGVpoP0xvDFPtVheOMbmKinVHyoT8tFwuKxjv7BSBiiqCFIe+sGLIQBAgxh7n2RI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0+7IyhxZ7Rrq6cdsMn9MUzuM23EyVmlw4vfm/sDIP9kDDKfH
	VEmYL9q+0hLGy5d90b5kjp7z02L7dhuSD4t/iyRScOVpCh3lkqlertZx
X-Gm-Gg: ATEYQzwhItFynMC7uwBFGrDVqyNrk1QnxRnHVy8OMo0rIRcgVJ3m2yZd9tbXnj5Ic+V
	hryHN5NEeSRh8LgZ7s+acXvCQyQcQYdZlJfHtxJ3FuhWGfZ3GqEkOUyEVNe52D/N7DnkdqkYB7P
	5DlI6bzFo+sFnxV7DmvdD/6w6mYQaLy12VVKa8i1EKdS+l2Yzyr9u54pFZJ/72k8ATwvCDa1Ek1
	S14D6Pv8z4O90kprJ+j+wX6lAB3NCNLXEpjhAQszcZcTNcZLfsguqI9uOayeGvhuLSxJwrhll1c
	gZuhBL0WNyZAO2ofzNDT+9kYT4K2/alImvUtiziRoeAbcZlK05mf2qM5AR57j4Kj5ZGj//ewex0
	kqztmUfZW5g/3PousY1csFSFQgnA8jgP1uMHwOGbt9xZD2PzG9adp5t2jqnmrhpoFyQcl1WYJOi
	KT+oUB3ZjCrQZO/TRMM5bg6MO4anTqH3vUq8eRYgjtfmsKFVc8nfOG9DrvRHfdyV6EHc+4CTXVm
	c/XoK58JEwSMI+hjKyFiredCLjgPRyxogrYEaSl5keasdE=
X-Received: by 2002:a05:6000:26cc:b0:43b:4921:8745 with SMTP id ffacd0b85a97d-43b527aa3f5mr5799725f8f.21.1773837912986;
        Wed, 18 Mar 2026 05:45:12 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5f14:a98b:b4be:efbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518985f6sm7888162f8f.25.2026.03.18.05.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:45:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: John Madieu <john.madieu.xa@bp.renesas.com>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/5] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
Date: Wed, 18 Mar 2026 12:44:50 +0000
Message-ID: <20260318124450.163471-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260318124450.163471-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for the RZ/V2H(P) SoC PCIe controller to the rzg3s-host
driver.

The RZ/V2H(P) SoC features two independent PCIe channels that share
physical lanes. The hardware supports two configuration modes: single
x4 mode where one controller uses all four lanes, or dual x2 mode
where both controllers use two lanes each.

Introduce configure_lanes() function pointer to configure the PCIe
lanes based on the number of channels enabled. Implement
rzv2h_pcie_configure_lanes() to detect the active PCIe channels at
boot time and program the lane mode via the system controller using
the new RZG3S_SYSC_FUNC_ID_LINK_MASTER function ID.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 142 +++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index a629e861bbd0..d1bf1e750d9b 100644
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
  * @sysc_info: System Controller info for each PCIe channel
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
+ * @num_channels: number of PCIe channels
  */
 struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
 	void (*config_pre_init)(struct rzg3s_pcie_host *host);
 	int (*config_post_init)(struct rzg3s_pcie_host *host);
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
+	int (*setup_lanes)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CHANNEL_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
+	u8 num_channels;
 };
 
 /**
@@ -309,6 +325,7 @@ struct rzg3s_pcie_port {
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
  * @channel_id: PCIe channel identifier, used for System Controller access
+ * @num_lanes: The number of lanes
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -325,6 +342,7 @@ struct rzg3s_pcie_host {
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
 	enum rzg3s_pcie_channel_id channel_id;
+	u8 num_lanes;
 };
 
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
@@ -1155,6 +1173,13 @@ static int rzg3s_pcie_config_init(struct rzg3s_pcie_host *host)
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
 
@@ -1687,6 +1712,63 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	return ret;
 }
 
+static int rzg3s_pcie_get_controller_id(struct rzg3s_pcie_host *host)
+{
+	struct device_node *np = host->dev->of_node;
+	u32 domain;
+	int ret;
+
+	if (host->data->num_channels == 1)
+		return 0;
+
+	ret = of_property_read_u32(np, "linux,pci-domain", &domain);
+	if (ret)
+		return ret;
+
+	if (domain >= host->data->num_channels)
+		return -EINVAL;
+
+	host->channel_id = domain;
+
+	return 0;
+}
+
+static int rzv2h_pcie_setup_lanes(struct rzg3s_pcie_host *host)
+{
+	struct device_node *np = host->dev->of_node;
+	static u8 rzv2h_num_total_lanes;
+	u32 num_lanes;
+	int ret;
+
+	ret = of_property_read_u32(np, "num-lanes", &num_lanes);
+	if (ret)
+		return ret;
+
+	/*
+	 * RZ/V2H(P) supports up to 4 lanes, but only in single x4 mode.
+	 * Dual x2 mode is only supported with 2 total lanes. Validate
+	 * the configuration to avoid conflicts with other host, if any.
+	 */
+	if (num_lanes != 4 && num_lanes != 2)
+		return -EINVAL;
+
+	if (rzv2h_num_total_lanes == 2 && num_lanes != 2)
+		return -EINVAL;
+
+	if (rzv2h_num_total_lanes == 4)
+		return -EINVAL;
+
+	rzv2h_num_total_lanes += num_lanes;
+
+	host->num_lanes = num_lanes;
+
+	return rzg3s_sysc_config_func(host->sysc,
+				      RZG3S_SYSC_FUNC_ID_LINK_MASTER,
+				      num_lanes == 2 ?
+				      RZG3S_SYSC_LINK_MODE_DUAL_X2 :
+				      RZG3S_SYSC_LINK_MODE_SINGLE_X4);
+}
+
 static int rzg3s_pcie_probe(struct platform_device *pdev)
 {
 	struct pci_host_bridge *bridge;
@@ -1711,6 +1793,10 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (!host->sysc)
 		return -ENOMEM;
 
+	ret = rzg3s_pcie_get_controller_id(host);
+	if (ret)
+		return ret;
+
 	sysc = host->sysc;
 	sysc->info = &host->data->sysc_info[host->channel_id];
 
@@ -1740,6 +1826,12 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto port_refclk_put;
 
+	if (host->data->setup_lanes) {
+		ret = host->data->setup_lanes(host);
+		if (ret)
+			goto sysc_signal_restore;
+	}
+
 	ret = rzg3s_pcie_resets_prepare_and_get(host);
 	if (ret)
 		goto sysc_signal_restore;
@@ -1901,6 +1993,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets = rzg3s_soc_cfg_resets,
 	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.num_channels = 1,
 	.config_post_init = rzg3s_pcie_config_post_init,
 	.config_deinit = rzg3s_pcie_config_deinit,
 	.init_phy = rzg3s_soc_pcie_init_phy,
@@ -1921,6 +2014,7 @@ static const char * const rzg3e_soc_power_resets[] = { "aresetn" };
 static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	.power_resets = rzg3e_soc_power_resets,
 	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_channels = 1,
 	.config_pre_init = rzg3e_pcie_config_pre_init,
 	.config_post_init = rzg3e_pcie_config_post_init,
 	.config_deinit = rzg3e_pcie_config_deinit,
@@ -1940,6 +2034,50 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	},
 };
 
+static const struct rzg3s_pcie_soc_data rzv2h_soc_data = {
+	.power_resets = rzg3e_soc_power_resets,
+	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.num_channels = 2,
+	.config_pre_init = rzg3e_pcie_config_pre_init,
+	.config_post_init = rzg3e_pcie_config_post_init,
+	.config_deinit = rzg3e_pcie_config_deinit,
+	.setup_lanes = rzv2h_pcie_setup_lanes,
+	.sysc_info = {
+		[RZG3S_PCIE_CHANNEL_ID_0] = {
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
+		[RZG3S_PCIE_CHANNEL_ID_1] = {
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
@@ -1949,6 +2087,10 @@ static const struct of_device_id rzg3s_pcie_of_match[] = {
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
2.53.0

