Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795580153;
	b=ebDgiPFTIQAcV/9saNQLoUO4cf76QBcQZ9ZrCzVNNIZTXvjGptGntuYoBJtRl6/on324
	 lgx91I+tdcIIsFlk7ZKblzsLGC1FLLJK+gYx2gfxJdeAMydoFhov62pBMpwZwAxZH+WLx
	 +hGyxQmLQDmCH87lfEpbJ2JN8Ahtkf6XVMdgvRLQBPHzr/MNzWTS+CYXVBodN/mFC9ayg
	 +FlCH/MVle+WjZHcj2jeS5sKLITzcTtSiDNm+N9A+LJWXsE05Hod1CKibJ15IZGvanePY
	 s8P13xkHaPM8agZ8euIr683uyLf78CKyLisvWIR2N+Xcuf83Sc+QFSe1ONUX4mVDrmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795580153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l/An17xbbZKWKsPVuEV7Fg7v2kZIObiSbVLl1Nx8Lkc=;
	b=MbSKgGTmSqxnmvgRLbPL0td5NuaVJ/p7p9ONOFeeZc6UUtgZcUotJui/Yyfxoe4hGFSh
	 G1zr1bL85VhZgOP7J5JmYAuXFfHBJ/5CUVIybi/AShOMGNwJemcm08XQhBzBx6a1O0x82
	 8ynwHqcmGmfjOGrz4ZOl+8EMNsYluAiAlW9xBRzZgCCLgL8zQJ/TfHJRSUPhmA2/dYa16
	 u3ulYpaWaw+Lq7MKFbUKxgIr3zKSQWAbBm8C6zAaxGCf7dT6QFELlY5tUMH8W8j+v6iL7
	 Hbpo8+F44EoUnk/8xE4J4r5eENrWm2PXt855dBqRuupc8ElKwaZsnNoZUsUZjhd31Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aJtV7n3T;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC86606A338
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 04:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC86606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aJtV7n3T
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2e9ae391a05so36160945ad.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 20:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795580152; x=1796184952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/An17xbbZKWKsPVuEV7Fg7v2kZIObiSbVLl1Nx8Lkc=;
        b=aJtV7n3TwVI9fmzbghSEAo+m7qM7rKlLMtXaZATW/QlPjD346uRl+50LoDCBDiU0rX
         UnhxkskDml9c02Nw2g3SbRyv1aBIu6snum/7ItKlfrF/D1rd8JgcSw1Zj0JAXm7hm1Ds
         xkaJgqQO+Uc/yvxGR210QBIc7HMP04j+13eaCndGq1HPYQ04EYgRY8UP17FdNAJ3r5ZR
         o/069KaygUTItMTnH/4esPujknkixBp7RwyLkz975NH1FtUMByHEMf6h8QJohrTpei34
         vFxKcbdZn+2DXZ5ImP6dMXxob0w3W0qBtxRTWtYQtxH/lQit/hElMIgjFmfbUvAvLJti
         AOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795580152; x=1796184952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l/An17xbbZKWKsPVuEV7Fg7v2kZIObiSbVLl1Nx8Lkc=;
        b=X2HQfE+eWQfoeEmd4SiZvB2PvbDxaqxxjKVswceZNegnbmZp3H8tLc4rd269dVaFS3
         1x1TB+IEAeQHtPo3Qp/PCMVxG4drFe3cAtvmnWBgTimR7YzxXCsXStLUTNcEyVWnfGes
         2Cg9vZyOYfDaeXjMsZlvJwUQbcLZrUypfwmh7NOKu9GT9SyVqbWob2GHkU+AHITC8yE7
         4s2PRolD7CSg5a+Gid+IbHjCS4BYZjaDyH5qSp1OYtt2OyLhq8vF91UDTD0y2IpV01Lj
         K6NiR6ri8oByoC+RvC/3VFFGyafLC8sEDHZN6RQvhINkvCNhuedlah7XpMilqIfrMzZy
         bdSg==
X-Gm-Message-State: APuU4Z9KcN8/ARJqWKuhY7sz1tnczQRWX/jklU3WLIwRSPDWytwPpOSj
	jT3mKw3aTn8nTv14GNmqx3I/ddsRT/LdhWDJfwmEwbcU8jhd/A8py4jO
X-Gm-Gg: AZFdTZdEd921uawYJdRSnG4YsS/GCfOhLxlyIZl5TtZhmAWkbqW+gqOOqOkeeWOyxAk
	vctb8+8eolWdtiqnOil44t/akkhNZkugzjIheeYVEQroBVlqtTLjpYq0gC82FLkmrDQvZMcaf59
	LgSbq6Cg1jHqn0ySZem0KzDBYimQHyuZ/srLLne3ho0f2we5U0m88OAkm4DZwpFmejJ6UW6VgiD
	EuxoYOoXuzGHWYn39UFPdvTf9Fa4JonyJon3vkNiygbXYm8aqCdOcg7/pYJYW3o63dvdzAxQSDP
	Ovx9Kq0uUWQ9yY8GyyIeolPIxXX4SBkY+QG8Fr/qkLpNpElrWGpAGiVoS9kqe7jWCINS1lRN5O7
	t6vOVBcoHOBABq4jycMuJLbqpEQ3sEfVt8VhMuSkzxn5lQ5agmrMx6yh/OyqadEJkPMtQMjgBiQ
	DVyrhI5ZrbtoX0LR1LPwxS+7puEXo87wKaBH8ManJe7ISdRNVRy7ggm2qDoxvbzAMylLITgFpWs
	Ig3QOQqquDiW7dvjs8kqe8EYLEt/ldAZfWe+DP3oaOz1Xa005giNsegS+SCoO1kDHrOT6Mazr2o
	FhHX5Kj1OQdQTB71AWScvYC9az8=
X-Received: by 2002:a17:902:e88d:b0:2f0:4578:138f with SMTP id d9443c01a7336-2f04578152amr109329415ad.24.1795580152128;
        Tue, 24 Nov 2026 20:15:52 -0800 (PST)
Received: from localhost ([2001:19f0:8000:4ce8:5400:7ff:fe0e:e6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0457fd68dsm69685505ad.39.2026.11.24.20.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 20:15:51 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LECOINTRE Philippe <philippe.lecointre@thalesgroup.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Alex Elder <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v8 6/6] PCI: spacemit-k1: Add Spacemit K3 PCIe host controller support
Date: Wed, 25 Nov 2026 12:15:20 +0800
Message-ID: <20261125041523.242588-7-inochiama@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125041523.242588-1-inochiama@gmail.com>
References: <20261125041523.242588-1-inochiama@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe controller on Spacemit K3 is almost a standard Synopsys
DesignWare PCIe IP with extra link and reset control. Unlike
the PCIe controller on K1, this controller supports external MSI
interrupt controller and can use multiple PHYs at the same time.

For PCIe controller on Spacemit K3, each controller can have
multiple phys for many lanes in one port. Each phy can provide
1/2 lanes, depends on the APMU configuration. This driver does
not care about the APMU configuration and only consume the phy
phandles in the device tree.

Add driver to support PCIe controller on Spacemit K3 PCIe.

Link: https://spacemit.com/community/document/info?lang=en&nodepath=hardware/key_stone/k3/k3_docs/k3_usermanual/14_connectivity/pcie.md
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/Kconfig            |   4 +-
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 137 ++++++++++++++++++
 2 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0a0d56fcf0ac..b936672fa306 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -443,7 +443,7 @@ config PCIE_SOPHGO_DW
 	  Sophgo SoCs.
 
 config PCIE_SPACEMIT_K1
-	tristate "SpacemiT K1 PCIe controller (host mode)"
+	tristate "SpacemiT PCIe controller (host mode)"
 	depends on ARCH_SPACEMIT || COMPILE_TEST
 	depends on HAS_IOMEM
 	select PCIE_DW_HOST
@@ -451,7 +451,7 @@ config PCIE_SPACEMIT_K1
 	default ARCH_SPACEMIT
 	help
 	  Enables support for the DesignWare based PCIe controller in
-	  the SpacemiT K1 SoC operating in host mode.  Three controllers
+	  the SpacemiT SoC operating in host mode. Three controllers
 	  are available on the K1 SoC; the first of these shares a PHY
 	  with a USB 3.0 host controller (one or the other can be used).
 
diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index f20c74eca73e..9fd0c946bc59 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -31,8 +31,18 @@
 #define SMLH_LINK_UP			BIT(1)
 #define RDLH_LINK_UP			BIT(12)
 
+#define INTR_STATUS				0x0010
+
 #define INTR_ENABLE				0x0014
 #define MSI_CTRL_INT			BIT(11)
+#define RDLH_LINK_UP_INT		BIT(20)
+
+#define K3_PHY_AHB_IRQSTATUS_INTX		0x0008
+
+#define K3_ADDR_INTR_STATUS1			0x0018
+
+#define K3_CACHE_MSTR_AWCACHE_MODE	GENMASK(14, 11)
+#define K3_CACHE_MSTR_AWCACHE_BEHAVIOR	0xf
 
 /* Some controls require APMU regmap access */
 #define SYSCON_APMU			"spacemit,apmu"
@@ -47,6 +57,9 @@
 
 #define PCIE_CONTROL_LOGIC			0x0004
 #define PCIE_SOFT_RESET			BIT(0)
+#define PCIE_PERSTN_OE			BIT(24)
+#define PCIE_PERSTN_OUT			BIT(25)
+#define PCIE_IGNORE_PERSTN		BIT(31)
 
 struct k1_pcie;
 
@@ -318,6 +331,121 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 	return ret;
 }
 
+static int k3_pcie_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+	u32 reset_ctrl = k1->pmu_off + PCIE_CLK_RESET_CONTROL;
+	u32 val;
+	int ret;
+
+	regmap_clear_bits(k1->pmu, reset_ctrl, LTSSM_EN);
+
+	k1_pcie_toggle_soft_reset(k1);
+
+	/* K3: Set IGNORE_PERSTN and drive PERSTN_OE high (assert reset) */
+	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
+			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE |
+			   PCIE_PERSTN_OUT,
+			   PCIE_IGNORE_PERSTN | PCIE_PERSTN_OE);
+
+	ret = k1_pcie_enable_resources(k1);
+	if (ret)
+		goto failed_resources;
+
+	regmap_set_bits(k1->pmu, reset_ctrl, PCIE_AUX_PWR_DET);
+	regmap_clear_bits(k1->pmu, reset_ctrl, APP_HOLD_PHY_RST);
+
+	ret = phy_bulk_init(k1->phy_count, k1->phys);
+	if (ret)
+		goto failed_phy_init;
+
+	ret = phy_bulk_power_on(k1->phy_count, k1->phys);
+	if (ret)
+		goto failed_phy_power_on;
+
+	msleep(PCIE_T_PVPERL_MS);
+
+	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
+			PCIE_PERSTN_OUT | PCIE_PERSTN_OE);
+
+	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CTRL);
+	val = u32_replace_bits(val, BIT(7), GEN3_EQ_CTRL_PSET_REQ_VEC);
+	dw_pcie_writel_dbi(pci, GEN3_EQ_CTRL, val);
+
+	k1_pcie_set_device_id(k1);
+
+	/* Finally, as a workaround, disable ASPM L1 */
+	k1_pcie_disable_aspm_l1(k1);
+
+	return 0;
+
+failed_phy_power_on:
+	phy_bulk_exit(k1->phy_count, k1->phys);
+failed_phy_init:
+	k1_pcie_disable_resources(k1);
+failed_resources:
+	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
+			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE, PCIE_PERSTN_OE);
+
+	return ret;
+}
+
+static void k3_pcie_deinit(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct k1_pcie *k1 = to_k1_pcie(pci);
+
+	/* Assert fundamental reset (drive PERST# low) */
+	regmap_update_bits(k1->pmu, k1->pmu_off + PCIE_CONTROL_LOGIC,
+			   PCIE_PERSTN_OUT | PCIE_PERSTN_OE, PCIE_PERSTN_OE);
+
+	phy_bulk_power_off(k1->phy_count, k1->phys);
+	phy_bulk_exit(k1->phy_count, k1->phys);
+
+	k1_pcie_disable_resources(k1);
+}
+
+static int k3_pcie_msi_host_init(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u32 val;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	/* For IMSIC interrupt */
+	val = dw_pcie_readl_dbi(pci, COHERENCY_CTRL3);
+	val = u32_replace_bits(val, K3_CACHE_MSTR_AWCACHE_BEHAVIOR,
+			       K3_CACHE_MSTR_AWCACHE_MODE);
+	dw_pcie_writel_dbi(pci, COHERENCY_CTRL3, val);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
+static const struct dw_pcie_host_ops k3_pcie_host_ops = {
+	.init		= k3_pcie_init,
+	.deinit		= k3_pcie_deinit,
+	.msi_init	= k3_pcie_msi_host_init,
+};
+
+static int k3_pcie_parse_port(struct k1_pcie *k1)
+{
+	u32 status0, status1, status2;
+
+	/* Clear the status registers */
+	status0 = readl_relaxed(k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
+	status1 = readl_relaxed(k1->link + INTR_STATUS);
+	status2 = readl_relaxed(k1->link + K3_ADDR_INTR_STATUS1);
+
+	writel_relaxed(status0, k1->link + K3_PHY_AHB_IRQSTATUS_INTX);
+	writel_relaxed(status1, k1->link + INTR_STATUS);
+	writel_relaxed(status2, k1->link + K3_ADDR_INTR_STATUS1);
+
+	return k1_pcie_parse_port(k1);
+}
+
 static int k1_pcie_probe(struct platform_device *pdev)
 {
 	const struct k1_pcie_device_data *data;
@@ -395,8 +523,17 @@ static const struct k1_pcie_device_data k1_pcie_device_data = {
 	.device_id	= PCI_DEVICE_ID_SPACEMIT_K1,
 };
 
+static const struct k1_pcie_device_data k3_pcie_device_data = {
+	.host_ops	= &k3_pcie_host_ops,
+	.ops		= &k1_pcie_ops,
+	.parse_port	= k3_pcie_parse_port,
+	.max_phy_count	= 6,
+	.device_id	= PCI_DEVICE_ID_SPACEMIT_K3,
+};
+
 static const struct of_device_id k1_pcie_of_match_table[] = {
 	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data },
+	{ .compatible = "spacemit,k3-pcie", .data = &k3_pcie_device_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, k1_pcie_of_match_table);
-- 
2.56.1

