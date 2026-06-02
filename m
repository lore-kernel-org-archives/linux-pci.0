Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5562352010
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780429831; cv=none; b=mRtnsvikRm5pjYzi5Dphky0yvyqDXZcnF+iNPLpsdi+xGP2UFznAhfbR6Q0zLckpEcS14LyIcC6MpoMkHpL1Bhf9EuCxSTdMdc4XYabI7PPgzBRIXruM5Zwk1udyu01uN8Fbra3pURkExHNBkmFhPBae7vK0OG2jqtLddq951XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780429831; c=relaxed/simple;
	bh=caT2SiyFRVe1tQnApula+Tg1pRxT4kUa1c+sMzr3lwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piy+SqvHFMGN3XVmASzdoVYdlYrtjlM7RVsV2oJSU+mIIT574YpipVNluzgodez0t4t0p8bIJ1lyN/GFqxgfjXAb/SI8a5IEwMyQld4YskGxwflFH31jJ6P8/nYzrwz1MlBDwlGsDwE0GATk/ERhBua4ZMsf1FfxOtB8Fl1n4Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M70HasNR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M70HasNR"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so120622615e9.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2026 12:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780429826; x=1781034626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjilDvsFAgDJCrCqQ2GjmgGRXnCNlPL3o8T3tdVudnQ=;
        b=M70HasNRsP2BYDeScyP4cInCOF54UeFuAJp1plKuabNPp8ToTgzp6UK9IDf7/s2fnU
         9sE18UZJApkYfIk2vpgrOZwcsI9v8e7j2/sjUhWy0hK+YlBZVs2HtZzYPsKp+hLvMUA5
         J7EedlTxfoWBx27PN6dN4vre2l7Z9KH1rwM2LMXSkdsQMBxQDC/XxcuB1LNQvTSvjJmO
         qfDiRcD9pVEZVsiim4KDEYXzHZscsqMXSQnaQvxPrllscCnTK3HCe6F77d8qUQ7z8/w3
         p9GarzFOkADnXv+i4x1AHi0p6UZUy5+mt4QWVOjzPmcz8GyvyJG+z9gBpdpTr/5A5hQz
         Z4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780429826; x=1781034626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xjilDvsFAgDJCrCqQ2GjmgGRXnCNlPL3o8T3tdVudnQ=;
        b=hv2Nc8NT8RoxnTxtm1KItHQpF3vBCiehc44SSXaJZXLTNKWxlPuch77j+YA/hgh9eA
         taBQKMz6G8ayJISaWVgrPu6ahzh6qI1exkVokLiwgvmGJey7e8xVQzBjXAH65LxUVQJ0
         EvR4AFDTBS/gGRKaskppFjZ7END6hrK94jdGL0pK/Ed4vaFWyosUnv2hzbDIq+mTJcGT
         FFqd98A45sR5CoId+GAmVunyn9nCm+UCrg7PUOtMhabq2mFXTLgjVqwdfEcXmw+XozMq
         iobUy/wrdlUGDAJAtilVJqWhz001IdAWWZykKc7VapKTihIoLT9RTz1hUAdTwKe0PQxi
         HtiQ==
X-Forwarded-Encrypted: i=1; AFNElJ93OfM0/bI0BlcpD7gBCSb5Rh5WgCHFNlwxQZnigkeIQyzZg0HX2MRZsSOQnifBDMBUEjOBBZTmqOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YygfwX0ley4l+H3+0jmIiw/yVxg5l4zMq5Y3eYlIiYf3hoAtgBK
	r6WUL29lDOt0lgfuwT1eVnMlr3OXC6eGv0B9gEPKTyGWsNG5OaqrFP9E
X-Gm-Gg: Acq92OG/QVxSa0C//t/j/4vK0HJe/U9r+vDhkEmtjE0ecUwtCchxyPBCPev32+zJ614
	fVuiHXMXgznrXJCDvSowB+7wkb1eo2baTixFM+4vffeLh/IpptDUMQ5KWnR0B2hHJIdWnHjIKBK
	O+joK7CiGplb24XelKYV+M5fx33EN7ytO0XQCEDGAsOrO7/0RRDsl8rgZSQV20s3AYl3NVu5ai8
	rWk6hkmMwu8XlSUYJbGlJMlwXknf9O6jSUB85jDAZhj5+X/UsbzK+2S4nkuFxbf65v2eWFa233S
	X7xyyqndM6OFm5r4yaC6ejLkO0yIz8dWBvSnbZWYKPL1QHjl46w+SyVKT5UXt0gpet0Oj4yEGIu
	7Q6gBsmNC9zQpdFxfq2hRAMMQDtudDF3qRc4IbnmzvKn+pEk8XhMqI8ALnvwvP0kbFBznFN+rwE
	W3NM8v/8JoSLPHJcNBZJNuZ2JGfqL0y/87eaks+jVUtH0XN9w+oURhsSvXlIi1BZo3Ltj86Qoe7
	jJYrssKQWoiwT5NDZpbuX7LELiD0vXFiCaa2t78R2qS9E6hQVnTZz1M
X-Received: by 2002:a05:600c:810c:b0:490:afc5:f95d with SMTP id 5b1f17b1804b1-490b5e82e89mr4565035e9.29.1780429826082;
        Tue, 02 Jun 2026 12:50:26 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e13eefsm87353395e9.2.2026.06.02.12.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:50:25 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 3/4] PCI: rzg3s-host: Prepare System Controller handling for multiple controllers
Date: Tue,  2 Jun 2026 20:50:18 +0100
Message-ID: <20260602195019.1798126-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260602195019.1798126-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
index a5192e4b58df..edb49af7429a 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -241,6 +241,18 @@ struct rzg3s_pcie_msi {
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
@@ -253,7 +265,7 @@ struct rzg3s_pcie_host;
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
  *              configuration
- * @sysc_info: SYSC info
+ * @sysc_info: System Controller info for each controller
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
  */
@@ -264,7 +276,7 @@ struct rzg3s_pcie_soc_data {
 	int (*config_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
-	struct rzg3s_sysc_info sysc_info;
+	struct rzg3s_sysc_info sysc_info[RZG3S_PCIE_CONTROLLER_ID_MAX];
 	u8 num_power_resets;
 	u8 num_cfg_resets;
 };
@@ -296,6 +308,7 @@ struct rzg3s_pcie_port {
  * @hw_lock: lock for access to the HW resources
  * @intx_irqs: INTx interrupts
  * @max_link_speed: maximum supported link speed
+ * @controller_id: PCIe controller identifier, used for System Controller access
  */
 struct rzg3s_pcie_host {
 	void __iomem *axi;
@@ -311,6 +324,7 @@ struct rzg3s_pcie_host {
 	raw_spinlock_t hw_lock;
 	int intx_irqs[PCI_NUM_INTX];
 	int max_link_speed;
+	enum rzg3s_pcie_controller_id controller_id;
 };
 
 #define rzg3s_msi_to_host(_msi)	container_of(_msi, struct rzg3s_pcie_host, msi)
@@ -1698,7 +1712,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sysc = host->sysc;
-	sysc->info = &host->data->sysc_info;
+	sysc->info = &host->data->sysc_info[host->controller_id];
 
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
+		[RZG3S_PCIE_CONTROLLER_ID_0] = {
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

