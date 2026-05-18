Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1A48AE0A
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779119633; cv=none; b=aOM5QujdKzB4y8wFAR1JaS3BTYIDh2SeDwzlB7ybWIQZX3fO++QSHwh44AKRMCIQF53EORa/869029Aeka/J11RNI52r3LhCrwGvnzQuvgx+7lemlNX3U+lpzM9nvbAa+K+ml/q0Q+nAa5NJMeX9weWOo6j0oASNUKm6TIFGMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779119633; c=relaxed/simple;
	bh=CxSAlqZ7dba8WGLnxqT4rZJN3bByhcX6cqdFZUyiWjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+9htCE+fgu7S9qMd1WgMh9QFvRkTWg8CMDA0FHnFPkp8IRt3J76O3/FCMqOEF3L6Sf/6xdSswXRbiId0A5+NzBfhMs96cldGeE7l19kBD3c8mkmHwQEUNVf6qUiWHEfo55+6Vzt2EhiVyIgwSEzsP11M7KeQw5Pufa6PB75RCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOCdOr/0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOCdOr/0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso13817815e9.3
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779119615; x=1779724415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okCjKKAtcfvdbZqaxqshuzwevShGdM2dj7d3ZLxBJtA=;
        b=nOCdOr/0ehr4jX61giOzQ11IXCLFALd5neVGcRnEPl+2VuBoEXNVaZWI3HOIFPhtH+
         NMKmC3tef1njyjN/WU/5bnfAwI2HhsJHJIGOB9dzF2uWPPrFPTXcKGra66orULHbtQjr
         smKBns1f26oyy+J/TxegvWZotNnHxyMjt1dPtlKQ+tVGUxBDIome3Qf09FvtoPEtfVbX
         30RxV471CCrJDRBD2L0eRFnnzR1DBo0mtYY6a1hdZ+8uFurUeGxCgt+qa/9KS7rrPYQG
         YtU4keKZ30+vcyA3GXGc9IOZRmx1uwMceQ9PIDM0HYeMfZ0i24TgX+wo35jiDigmnlNA
         bM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779119615; x=1779724415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okCjKKAtcfvdbZqaxqshuzwevShGdM2dj7d3ZLxBJtA=;
        b=Y44SYgXmpTktjd1GZeqBWYWqhwKrgl7MNkYV0lDz4O8EiT1IPpMLB0oAMcOIAnRYzu
         2ykBeAxXfLEe/07nQff5XT9OOijSRY/i+P+T3+hb3/IMS1cbgk4ygosLu85/IVaMnzlc
         A8O06U6UG/e6aE2jVdDAUw3nvcEhpzyn9s77z2X2nNv4leeq+iruCdjMEruOSl/DGdMl
         vk2w9I+SoWpu7CzmyTc2TOy7+TFP+CXpbWXhZah/+mfOBewwfeTpVNX4kqgp4EMVn3NM
         jpNXqxnljXQJsvA5OJucsnplGdMEz5T82XA2oT0kfYqAIV0vtqr+YLkmFdcuKTbPIm30
         wrcA==
X-Gm-Message-State: AOJu0YyxJ/nsq74m++3/E/7/kBo8QqUkCUOhY+pYpaJOSJvrBllzZPdg
	Yi3ozfyA3inH13GknGxjVrc5zme7n3jD1rm0V4K6jEai88I+kA/SoGzm
X-Gm-Gg: Acq92OGMKxIxjXfgZPtbOW/rQ7IvY6EokOV1CqsBnPdab46n97ds9WYv6Pci169Q7Rf
	u9I6cVSDuSHJ37xBLHxohs+23vItn08ULppjkWCOnUo7r9BKO8LiQA+Jp2Ou87Pjclu244LrcVj
	vohv2ONSut5R1/f5BECsM57N/2ODTLWNLzvtjlK0fF99AVOxYPPScQXq1vTlvgZctWhwoaMfSOo
	FDHY59/eI/o/jnVz8zBI1va0EylflnkEAAh8se4u+K5uIDKmh9ZbVDCVKW5TW8wY62It2yXhFMr
	efnCyF9/ubwgYXLmCVXafVrl4FUNFefX4CEomSL2fUJ8RZCYfsL3PoMqRMv7TPiq9au1dMPDwFR
	zk0ub+PmiFCLdP9jO8P8Mi1jc1xscE4tFeraaoRz3j4A645bsSBey1ETVvlmtJwq5z3jW1WitrW
	8VX42BGqQXUFu5E7oWo8mIwMp0kpeV6AksBF7/cXTsiISImp51vSW+tgmXqFg1CQ1N3XckMnZDd
	AL4OLvdu3mMkvM9B2VpkRN4U9XFRZpvq6cadw==
X-Received: by 2002:a05:600c:5296:b0:48a:65ad:1881 with SMTP id 5b1f17b1804b1-48fe60ed846mr243140075e9.13.1779119614693;
        Mon, 18 May 2026 08:53:34 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:2409:d26f:6d8b:b2cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm450054575e9.1.2026.05.18.08.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:53:34 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh@kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
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
Subject: [PATCH v2 3/4] PCI: rzg3s-host: Prepare System Controller handling for multiple controllers
Date: Mon, 18 May 2026 16:53:23 +0100
Message-ID: <20260518155324.168948-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518155324.168948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260518155324.168948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
---
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

