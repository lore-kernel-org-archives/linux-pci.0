Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908373D669E
	for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837920; cv=none; b=WtHeHxV2BSPV+DZF3hPMCJLxWuwWS/j3+Z8wM8eqOfwSoyqFVcs85jH2Zont1KXu7E0ZdtiXanQbPwns5CisIpW3iVIqZ6oeVbegzCsYz7Tu2IhFgF6l8rpF8WH5akmw/5tEtMlS6kH1FfPxVIeqaG2FJFdCv6gI2fwhaxxIHxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837920; c=relaxed/simple;
	bh=P6rovmF21O0HxvN3YC5rjtbQloF/pDPLKdTiJ8CCtSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAMYKHp4hqK1YGEaGL44+zQA7yQlG11TnLMYmGkpQq1u+u3oEtjF4fINqqw4XpS5gcoi+/6tOL4NXJyWnw5fgDfY3r4ZDFUaO28kvzHPLnbNnc1NIrIajs1XLsBnwbUZ4ysCqzswRAbi9KzeAhV/F560qr8ivHQN4RacxgVqRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=angjU91P; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="angjU91P"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so6709020f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Mar 2026 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773837912; x=1774442712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIfxYsZxRlkkxMpcjHfUtwo6SOeCbLjlKgGjjFzsSYI=;
        b=angjU91Pu0UCSTdbeGGizbvRXHsegj4vkmn60RZrwZb8KQ7G3VE1lq7bedKclZtDMM
         +4qeXdY/t/xrSVoAc08JfN8Z8mh2oPvWdG0YgwSUGTBLFDWe7g4alTJmsuKEcL5lf2tb
         luEQsYBPT4RDpQA2ez82g6odNdHp3ccks1yVyJQ21+HFwLoFnjvyhH/WeIXi5toJesVC
         dO3PJZWTfdZ7I+ywU6x7Jp1i2S3GUx0tn9mjjxeraw2BKPaGliehChaoYMOFuo8sFVQB
         dSDvJSotHWecqxvYVIj9xGEBTHd4BW5JobbMMdMvI25KspHUFRcXmTINlex+RRe7uZOS
         vM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837912; x=1774442712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIfxYsZxRlkkxMpcjHfUtwo6SOeCbLjlKgGjjFzsSYI=;
        b=bYrdUcN7Iia4mgFeoRz/seuFrUWMLfD2U+tDPJrSynvwtdMQwbrybp6l82WGAN+v84
         NzwLiRqekg8a5Bn/EZZCW0S+Qulj7C0ZTmycIz5+ZnD6gta5GbwEV7gX97cJUw7Ed67g
         foZOXIKZkP7UWI+aqfOOpKJ9/wJPyMC2DhqnFhxuWco20AMmnA+bfY7jtIY16GEmvL+k
         xkuLcY5Jdyf7kGq+rxtsTQ6HBX55Sopsf1S4dDucR7aRHhZ+YSGFjsNhM2wbd+df/kxv
         eQtdv2njjFtI+hwxfApV9vZNeN+aW5hnM3gSym6OTvSJ/N1I4BrNQmsoQaXKgscDWhe4
         mHdg==
X-Forwarded-Encrypted: i=1; AJvYcCWtbuUaLw0acO6bsmsWyvOCSSqg85auvwU3zpFEvJBUCdLMdrNLTV0wxtrP6ayFHDJuyGWsUUcEha4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzivx4HDeuls1TQiWeyaWsPc0gHSSuHwRPLRqCLcl5ThbBvP0OW
	Q89EBrTrxGlHPXTQLRhyAykv40cVA7kbx9C1qG/9I+6qgYCAZ9UnNGQR
X-Gm-Gg: ATEYQzyq/Az9D9TYd0eHF8KqEyz1Og3POnudwqbrNZawIbUK+WT7tZGJh9a9U2jd8c9
	kK9FbugUWV23JZE8u6GVE5HIoBpnJtsSA7N4ggg8bCiZnontGL8LsOr2awVEL9nR6KWtusvA4hs
	CLHBNIy1UiXTCLT7BltERC07vCGCcOjpZ9A1C9/32QKL8KxiMHhc2oQ4V1HFr1zvm6G2sVBmtJI
	MlqpbQAJADDTr8lHli6gWJDohXzgrTxL0FjF5L3ScpdAwl9Y7maoAt1W5X9w2/AxWMSs7NQtiZP
	nupJyNl+eX6WNFtlPGcYXdEKRz5QB3553ucwriEYytEFqvMQpVjlCr12hcYtk1kIbzwx7/VZ/ZM
	bdtPIDNr50TF9yyL3LENqFEnVeLq8F1PbO9dSg0cZvF5fyfjPEfDsJJOoCfnqU395pmtwtHXFmh
	VJ99d8djDa+ZJEnNVkRRVJPp0KvymMzOklsF4tpv2oX/3RWbRh5O42FscrrPguWJf2LSSNqLFd1
	LVEEZ5P3oaOBibQ6+oZzMxi2yFTebE1ca1HucmpOn65Os4=
X-Received: by 2002:a05:6000:4284:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-43b527a089amr5086490f8f.9.1773837911629;
        Wed, 18 Mar 2026 05:45:11 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5f14:a98b:b4be:efbd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518985f6sm7888162f8f.25.2026.03.18.05.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:45:11 -0700 (PDT)
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
Subject: [PATCH 4/5] PCI: rzg3s-host: Prepare System Controller handling for multiple PCIe channels
Date: Wed, 18 Mar 2026 12:44:49 +0000
Message-ID: <20260318124450.163471-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Prepare the driver to handle multiple PCIe channels with distinct System
Controller register sets, as required by RZ/V2H(P). The current design
stores a single sysc_info structure per SoC, which is insufficient for
multi-channel configurations.

Introduce channel identifiers and extend struct rzg3s_pcie_soc_data to
hold a sysc_info array indexed per PCIe channel. Add a channel field to
struct rzg3s_pcie_host and select the appropriate System Controller
information during probe based on the channel.

Keep existing single-channel SoCs functionally unchanged while
preparing the driver for RZ/V2H(P) multi-channel support.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 48 ++++++++++++++++--------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index c61e011f8302..a629e861bbd0 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -241,6 +241,18 @@ struct rzg3s_pcie_msi {
 	int irq;
 };
 
+/**
+ * enum rzg3s_pcie_channel_id - RZ/G3S PCIe channel IDs
+ * @RZG3S_PCIE_CHANNEL_ID_0: PCIe channel 0
+ * @RZG3S_PCIE_CHANNEL_ID_1: PCIe channel 1
+ * @RZG3S_PCIE_CHANNEL_ID_MAX: Max PCIe channels
+ */
+enum rzg3s_pcie_channel_id {
+	RZG3S_PCIE_CHANNEL_ID_0,
+	RZG3S_PCIE_CHANNEL_ID_1,
+	RZG3S_PCIE_CHANNEL_ID_MAX,
+};
+
 struct rzg3s_pcie_host;
 
 /**
@@ -253,7 +265,7 @@ struct rzg3s_pcie_host;
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
  *              configuration
- * @sysc_info: SYSC info
+ * @sysc_info: System Controller info for each PCIe channel
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
  */
@@ -264,7 +276,7 @@ struct rzg3s_pcie_soc_data {
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
-	struct rzg3s_sysc_info sysc_info;
+	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CHANNEL_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
 };
@@ -296,6 +308,7 @@ struct rzg3s_pcie_port {
  * @hw_lock: lock for access to the HW resources
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
+ * @channel_id: PCIe channel identifier, used for System Controller access
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -311,6 +324,7 @@ struct rzg3s_pcie_host {
 	raw_spinlock_t hw_lock;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
+	enum rzg3s_pcie_channel_id channel_id;
 };
 
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
@@ -1698,7 +1712,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sysc = host->sysc;
-	sysc->info = &host->data->sysc_info;
+	sysc->info = &host->data->sysc_info[host->channel_id];
 
 	host->axi = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->axi))
@@ -1891,10 +1905,12 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.config_deinit = rzg3s_pcie_config_deinit,
 	.init_phy = rzg3s_soc_pcie_init_phy,
 	.sysc_info = {
-		.functions = {
-			[RZG3S_SYSC_FUNC_ID_RST_RSM_B] = {
-				.offset = 0xd74,
-				.mask = BIT(0),
+		[RZG3S_PCIE_CHANNEL_ID_0] = {
+			.functions = {
+				[RZG3S_SYSC_FUNC_ID_RST_RSM_B] = {
+					.offset = 0xd74,
+					.mask = BIT(0),
+				},
 			},
 		},
 	},
@@ -1909,14 +1925,16 @@ static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
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
 			},
 		},
 	},
-- 
2.53.0

