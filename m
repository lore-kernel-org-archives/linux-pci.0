Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3D3148BB
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770980; cv=none; b=LucR8hpT+cxPlJqOfEPexUIUxyhe4EYgGpInxiJ/Vc2/LZZ41a7hdp6EVonPf6iDeXOMlmbeSO0sO+4vhHaUA2vwhKiY6UzKqKJdwKKn9wRhd9lWOEAWQJwg12bjMW2CldDUz2yrqwvOsZx3W4PxYAehh2xCmHRC719GmpeLAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770980; c=relaxed/simple;
	bh=D/QnvqVQKw3+hku4W0PbVKbIlNg/307YWT8882BTo44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHe6onQsI3aVIX0Dk38Q76pG1wEMlvafeexpIfn5I6OtHtpjZcEEpDUf11KVuw/Zkrb5MjKX7kMpep7RmAuLXq8UUPM2VZ0vXVAZTPG59k2W9KY8xf56yftWWdbrnWXNeMwetdfGlzzb7ihJaWD+rxVek3WrY1lImn/La5RjBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQgORlCI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQgORlCI"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4631679f204so5441f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782770976; x=1783375776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0ytINI397kEo5KGFJlej3pgbCpyLxmgDbViCKlkV3k=;
        b=GQgORlCIDQmCKHxN8Qf3r/WtyyxV8oN37COJLb1eRvioTus+nFwvAADq6D3T+/UBRb
         Swdup3qxEuk2/RSh1W93QamUcvffK/ceJyW0FQwNqkwMPkD69c5FUyHXwf5x/Bmp1DaZ
         AbXOTkBGlFAMCAaJrWll8n5SrNJI6usJZHY6RS5MpszdRKd19xMfFtVGNzeE1IORCwjw
         HAhJh6QiyERGjuUH2XwsXg5kwsu1hnDy71b8UnSBAwfGRxRcKrTPWOB9MB627RMBa6En
         i7sq1er+IhBEyNdJxX/66VsNrlpbBItlwIehIeXpgbhggzNmxH9Ew115J8aZ+21Abo2F
         +sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770976; x=1783375776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0ytINI397kEo5KGFJlej3pgbCpyLxmgDbViCKlkV3k=;
        b=nTwWLrchE7QIR0vGRDmUzkcxZei8e498h26PnTDEX2zQdbxmZpL3j2mu4F97WLiqoJ
         5VEvNLcDbrP3XofRJfWeSHCqodZg5caqUwoN6Q57Sd37IkSfh5XfBt46jjoqvx5oF0dP
         Pymey6Fil81FAFKC2mbdDGOR8VXhU69PmGzbKm8a6Fbt7zgvyQDNPmrLAlCngFF/56NA
         +5Tz0mYeLlKVRayiK91jroPlCHlpJ6huaFnv6QarAqX8Q7FvxvVel7RWm3M/V1hwQtU2
         RhODKs9WvHJn3OtJ4qeroP1TnRAI/75/0RhGn2HWVnq9/e2NYVYhR13kFdlvLqe2shb7
         SIRw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7fVJ/xKuajFzc2uxCYgDK1f6CcJrvng7pHvzrpy5rwxoDwThvTzjbrycvZLWb3+EugmKvda6Ori0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVS62mXRV9pMWuXSbdGmurbXWYQINsI/bHg99sDsDSPfLKGoy
	GKCNhQK58al7qOsCfNXWcZkEmSQ9JfXP7yZ3zx374nQZf1goIJv2yY6dvkMGzJPS
X-Gm-Gg: AfdE7cnvfGyd+VJmNKMgWVlHB51YSj2tEen2Y4C4ILrUP8waQSA7Y0VDNlx4ZFL/lyp
	+Yv4mfPWNY4Hox1XqhQz1e7HKKTidvifGlwPSiTU41LnkJJiPKCT1hA9s29+XMY5AtsDkhq96YQ
	7/isrEOspLILSW7wVtRmTdGCWqUEzrl7gi02lW4Wb8Rdd/U6MfVEbJRbA8w6fxp2EGRPJ2N+Z2n
	agswWmppuTanDFTYpy3KNVK/nuRiF6XAvZiXAijPb/R//wm9g3/1Ps2tZwY18Mga+hypL1iSljP
	/epXW9XexEYd0P8VeKa9YLZityb+xld3Mo2+o9igkD64XcfHCn90zwCxki++zV2rfW30HkbzPZA
	wjz4ZuFNgALHMomkuhdp451fZl+2ATYIeTmqgY/m0qMgDRICwEnGZdoTVJQQLJG36KuHSvDYtOG
	tQT/UH7lqgK9y8Jkzx2oMyiMpe/B+21RZ5mqKryhpm6wFhN1DGV5fo4JexKhjaz+/jeLNn8uzYb
	RYWKdTUecKK2PU+AAlm9otPFx0=
X-Received: by 2002:a05:6000:2913:b0:461:a15f:7aa5 with SMTP id ffacd0b85a97d-4754c0d809amr1325479f8f.21.1782770976538;
        Mon, 29 Jun 2026 15:09:36 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:dfcc:acfa:dec0:e556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563d195b3sm1644670f8f.8.2026.06.29.15.09.35
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
Subject: [PATCH v5 3/4] PCI: rzg3s-host: Prepare System Controller handling for multiple controllers
Date: Mon, 29 Jun 2026 23:09:31 +0100
Message-ID: <20260629220932.861445-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Prepare the driver to handle multiple PCIe controllers with distinct
System Controller (SYSC) register sets, as required by RZ/V2H(P). The
current design stores a single sysc_info structure per SoC, which is
insufficient for multi-controller configurations.

Introduce controller identifiers and extend struct rzg3s_pcie_soc_data
to hold a sysc_info array indexed per PCIe controller. Add a
controller_id field to struct rzg3s_pcie_host and select the appropriate
System Controller information during probe based on the hardware
instance.

Keep existing single-controller SoCs functionally unchanged while
preparing the driver for RZ/V2H(P) multi-controller support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
v4->v5:
- No change

v3->v4:
- Added RB/TB tags.

v2->v3:
- No change.

v1->v2:
- Renamed RZG3S_PCIE_CHANNEL_ID* to RZG3S_PCIE_CONTROLLER_ID* for clarity.
- Updated commit message.
---
 drivers/pci/controller/pcie-rzg3s-host.c | 48 ++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index cca2617f2915..03d79e98c9c9 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -242,6 +242,18 @@ struct rzg3s_pcie_msi {
 	int irq;
 };
 
+/**
+ * enum rzg3s_pcie_controller_id - RZ/G3S PCIe controller IDs
+ * @RZG3S_PCIE_CONTROLLER_ID_0: PCIe controller 0
+ * @RZG3S_PCIE_CONTROLLER_ID_1: PCIe controller 1
+ * @RZG3S_PCIE_CONTROLLER_ID_MAX: Max PCIe controllers
+ */
+enum rzg3s_pcie_controller_id {
+	RZG3S_PCIE_CONTROLLER_ID_0,
+	RZG3S_PCIE_CONTROLLER_ID_1,
+	RZG3S_PCIE_CONTROLLER_ID_MAX,
+};
+
 struct rzg3s_pcie_host;
 
 /**
@@ -254,7 +266,7 @@ struct rzg3s_pcie_host;
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
  *              configuration
- * @sysc_info: SYSC info
+ * @sysc_info: System Controller info for each controller
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
  */
@@ -265,7 +277,7 @@ struct rzg3s_pcie_soc_data {
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
-	struct rzg3s_sysc_info sysc_info;
+	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CONTROLLER_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
 };
@@ -297,6 +309,7 @@ struct rzg3s_pcie_port {
  * @hw_lock: lock for access to the HW resources
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
+ * @controller_id: PCIe controller identifier, used for System Controller access
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -312,6 +325,7 @@ struct rzg3s_pcie_host {
 	raw_spinlock_t hw_lock;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
+	enum rzg3s_pcie_controller_id controller_id;
 };
 
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
@@ -1699,7 +1713,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sysc = host->sysc;
-	sysc->info = &host->data->sysc_info;
+	sysc->info = &host->data->sysc_info[host->controller_id];
 
 	host->axi = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->axi))
@@ -1892,10 +1906,12 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.config_deinit = rzg3s_pcie_config_deinit,
 	.init_phy = rzg3s_soc_pcie_init_phy,
 	.sysc_info = {
-		.functions = {
-			[RZG3S_SYSC_FUNC_ID_RST_RSM_B] = {
-				.offset = 0xd74,
-				.mask = BIT(0),
+		[RZG3S_PCIE_CONTROLLER_ID_0] = {
+			.functions = {
+				[RZG3S_SYSC_FUNC_ID_RST_RSM_B] = {
+					.offset = 0xd74,
+					.mask = BIT(0),
+				},
 			},
 		},
 	},
@@ -1910,14 +1926,16 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
 	.config_post_init = rzg3e_pcie_config_post_init,
 	.config_deinit = rzg3e_pcie_config_deinit,
 	.sysc_info = {
-		.functions = {
-			[RZG3S_SYSC_FUNC_ID_L1_ALLOW] = {
-				.offset = 0x1020,
-				.mask = BIT(0),
-			},
-			[RZG3S_SYSC_FUNC_ID_MODE] = {
-				.offset = 0x1024,
-				.mask = BIT(0),
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
 			},
 		},
 	},
-- 
2.54.0

