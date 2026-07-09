Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6235C183
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 04:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569685; cv=none; b=QkGtPw4HbbU5KVKIo2ZxhbEs+ivkNaSkJ9vhvhxX72YXe8IRi99kK9RQRU0/Nl3xt3TTsRBLx8aQ2pi06KunWaDpUfAGTX/dy35x8Z3ADarmlp3JDDnzW+QBrapyESZcny7/eb6jsVSVF8L60B7AZ2mUYTsCokW1/4DFHRjm1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569685; c=relaxed/simple;
	bh=04yEbrBAj5g/Fp2zUPgpONY8/+NGEPJo0vMYeCOwxNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeGg83IoxqdgAAhQNLlfPV7uPZ4pZh9EYNa9DSjBRfR2dyvxTHBkLCLQ/Pu3gMsGnC/uIDRSKVFOK6vVhHcZr1AJhdJkG8U7PB6w/+K5CIOOHPWUllmVObzIQdJFNCISL3y6gCwigt6Dz/HD6bi8Yds14NGCpvoxLwpacxoulo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldKqWGw0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldKqWGw0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso1670913a91.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 21:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569683; x=1784174483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkWnYh3cllnXcTwBIcvBSJWZoRydH1m54nLp+o8irTo=;
        b=ldKqWGw0vGH4WK4C/mda9vhYZbhZFY9B+ZBX9Gps1LfOEeuZMz3A2CPSYBg4/qUYXA
         UIoe+lEfhS7H/NU4sE486S4Qb9HtPZtck+FhpH8NkuB6kST/Z1lQK7g7qDdTxyq1H1+Q
         Kt5sJ9uT/SQtwlERa4fcOPIKKxRfqSMF0vOFiMTmq3f3bedSQMdsDXmTjwg8OBR9UFqy
         7MQOz69B8D5pDwYowSwlGHk7+PGihILESFK4O97jUd/gzVll2UaAKvR2WRj17x2P32qi
         QVu+1HhQawX186qgPWrTv+Qdw3Qr51adfKn19jJqI2+G/YhO1f9O+wTi4gcZ/k3qGSRC
         Boug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569683; x=1784174483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkWnYh3cllnXcTwBIcvBSJWZoRydH1m54nLp+o8irTo=;
        b=hQ3kgSk5GWbgabr2rAL5gd2Uc/eNol50/GQnooFEDXyKOdX0RsXMotpecQ4wsgysP5
         s3BmbXEx9jYKkEj6IWL3ISMBDTRwjEnhdsRCUp0Ve9Iz93HKfaAqm2WFLF/iGrjfhMQi
         AwMWZiA6MOd7hzCn8R8agLqJX7kGDDZWCg2Q4gXSGlH/0sVr/FIWcTcrOPkJkUCW+Kir
         4OdOD/Kh86q9immr2yUl8UuH8yAW/5H2bOMpVlajdqBHg2ylroz66Up7niNhB64KvfJh
         IxXvGP07XtfMes08cs18FOY9mmlzosOiX6msp+3hW9dw05HvUpkufN2duF3mGTJmMUhT
         TCjw==
X-Gm-Message-State: AOJu0Yw0v0w+4OQWKPIPq586PzeOydlliPiQnPyw/fCHcjKLD9i7dyeF
	uiDaJab458v283GSjmonk+fmT1sFtmY9A5VqfalUHy2bMMd0NmQ0lh9B
X-Gm-Gg: AfdE7ckjsXPhSONZI4gOIRi8Us9bhVF4PlTI60OguwsqsIXuvViThjgw3InNie7/gXy
	7X3SkcPPCI3170LD15P6WoIfr0ZWVuoGqTM1YNNZCUC0YodRnbqAlRhGYlK70Law+P7666kDGB6
	VcK/ubVTutHxVUzYB2JYnOEPeVABzN0r+Pw98pj+3NEhPBh6xWCyjc/OwU4RtflRK3gvmzjEZfN
	PVXKfSK4nZCJWIKhxUFSBCZ7z3TMq3Je0QtKfWtjTMr24vAFRP4tCeC+I4hTcVBCHDrq3YT39UA
	ScFU4AtdCiRlJLliwrZYzEglN5Z6ItSf4KXb2ghnU2FxKIP/VVZB5B3z9w7c0/rpMvciGAW4zKO
	3raW7pvOultIlKvsy8lRsUh5kiYda723kAsxqMwRdcmF2Zbg8aKZp6ye6YTAuiGkl+GN5rkzKDC
	o=
X-Received: by 2002:a17:90b:56c8:b0:36d:66d4:270e with SMTP id 98e67ed59e1d1-38941101e99mr5534226a91.5.1783569683198;
        Wed, 08 Jul 2026 21:01:23 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b418sm423373a91.2.2026.07.08.21.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:01:22 -0700 (PDT)
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
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Nam Cao <namcao@linutronix.de>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 1/6] PCI: spacemit-k1: Add device data support
Date: Thu,  9 Jul 2026 12:00:21 +0800
Message-ID: <20260709040027.958400-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709040027.958400-1-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reuse the K1 PCIe driver logic for K3 PCIe controller, add device
data to handle the K1 specific logic and make room for the incoming
logic for K3.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 30 ++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..f6ae8ff3589a 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -49,8 +49,17 @@
 #define PCIE_CONTROL_LOGIC			0x0004
 #define PCIE_SOFT_RESET			BIT(0)
 
+struct k1_pcie;
+
+struct k1_pcie_device_data {
+	const struct dw_pcie_host_ops *host_ops;
+	const struct dw_pcie_ops *ops;
+	int (*parse_port)(struct k1_pcie *k1);
+};
+
 struct k1_pcie {
 	struct dw_pcie pci;
+	const struct k1_pcie_device_data *data;
 	struct phy *phy;
 	void __iomem *link;
 	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
@@ -278,14 +287,21 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 
 static int k1_pcie_probe(struct platform_device *pdev)
 {
+	const struct k1_pcie_device_data *data;
 	struct device *dev = &pdev->dev;
 	struct k1_pcie *k1;
 	int ret;
 
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
 	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
 	if (!k1)
 		return -ENOMEM;
 
+	k1->data = data;
+
 	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
 						       SYSCON_APMU, 1,
 						       &k1->pmu_off);
@@ -299,11 +315,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
 				     "failed to map \"link\" registers\n");
 
 	k1->pci.dev = dev;
-	k1->pci.ops = &k1_pcie_ops;
+	k1->pci.ops = data->ops;
 	k1->pci.pp.num_vectors = MAX_MSI_IRQS;
 	dw_pcie_cap_set(&k1->pci, REQ_RES);
 
-	k1->pci.pp.ops = &k1_pcie_host_ops;
+	k1->pci.pp.ops = data->host_ops;
 
 	/* Hold the PHY in reset until we start the link */
 	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
@@ -320,7 +336,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, k1);
 
-	ret = k1_pcie_parse_port(k1);
+	ret = data->parse_port(k1);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to parse root port\n");
 
@@ -338,8 +354,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
 	dw_pcie_host_deinit(&k1->pci.pp);
 }
 
+static const struct k1_pcie_device_data k1_pcie_device_data = {
+	.host_ops	= &k1_pcie_host_ops,
+	.ops		= &k1_pcie_ops,
+	.parse_port	= k1_pcie_parse_port,
+};
+
 static const struct of_device_id k1_pcie_of_match_table[] = {
-	{ .compatible = "spacemit,k1-pcie", },
+	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data},
 	{ }
 };
 
-- 
2.55.0

