Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF843AFD07
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671092; cv=none; b=lqT1SERmrTdu8+Zg/2rdQU/TE/IuROSpp6todgea7N3MFFzRd0Z1k3vtpYHIiVEOuYMLeCHsuZa8qo9Jnm9zPNuxo0VzlCBk96z62hwFzo3N3YMSzq7vEsrGGneRwfSuPCxctdS3yMjT15KX99HO07gPjcBBhIC/UdCVhLcu2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671092; c=relaxed/simple;
	bh=tzjrnSGriiNsUvWgycospNy4s2NeOSuRgB+TBE7F6QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NL4lEvpmh+MC8bbZ+fgulwLvDvG7vY4VZxTyJRaLXOy6VKr1k6QDjthfQCuvGJmiOWR4laew6s393BUPC715gnJrv8CIGc/RAm8YXlgbZJABPQS43bkHAMSsBBp4C9AQMvcbFXf8Wz1Wj5R4rDHdzxymJrjugTc/zDoCdW9oZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAagpgNO; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAagpgNO"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc74520b20bso987853a12.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790671090; x=1791275890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hb0/W1AZf3MAAAZ7FNUC0CLHYr19qqSE//LGC9bNTDk=;
        b=XAagpgNOMHT/v5CeDsbmzERCUlwI/ubaWZrIorftx+6Qhj6uiPORQPXUTtzxmJf4xz
         3iJ72T52zgXLswicPr0IdDQWWUfK141/UsDGzNAcbcN6/hT+6a7mJTIPQHwEYXG/1iBQ
         SmOYeuctTc4RxnZtutvmIMjdAT20wFOAkjDz7QrKxXxARVAsLmkui+ZIKN6Zvb2T8WRW
         8+ntYmdJGKLu3rXkvq4f4In3iqajF/dxI2mjCVhV8xZA7cER8wzbH4OyRYKc8ejVB+I6
         DbQlbUXc6S8YBQiHwC5Dja7ipvquJ6OjztZtjeHR5Tp7ulUhFru3QYMeN10YpxBkTJrp
         ODow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671090; x=1791275890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hb0/W1AZf3MAAAZ7FNUC0CLHYr19qqSE//LGC9bNTDk=;
        b=UYbnWEov6v8ZmghZ7mSmf2XraGjMfx1FZKSLtJa2evIqMQqm+1/iwjiXUs46+qO/3P
         UKyJCpwja8QMRcRt+WGglWzu+1Tt+MObVo5hjTDnYwzKmr+WHYy3Lv+fRF+gH1Hkal5C
         LGA/EC1BTbV9DGSXP+Rzcllc6Z5WjHRKy8anoPiLKNfJuY00VQdVaeePy6wWawHQ1l5t
         GIJWjzCaLNFjuqm87OTUyLQJ7CXZvMAJa2ofKoOZNLgLLkDCzMLhFpE4voZ8C9FhbT4v
         LwZtqoMy0o8Sj0jZCiTAc+EE0HkB/xwoZGR2hhAEzStCYQVea7CoV9opWWsd5CoFFBoR
         224Q==
X-Gm-Message-State: AFq9FYK+B35yUvElI3dIM+VrNQch1aI9dqNjA5a97PM/sXGpWwY0EcUs
	tY7n/KS5XskDVvNItaLf96nnw+1rftusJA5ZpV1oYsRqu0EomsumKe3Q
X-Gm-Gg: AYBFou3jGoRerb5lW2c3IYvxTWp7ZjyiIoeeNsMvFiFKYJQbeQcuXWombHEzpPktOy6
	bzmC2BV0hNhOthFIhAgGMSDH/MhwReZr5FVma+r513r1BJf3N2T37MtgBv2y2J96DtZ2eVkcsIv
	SOwjkosW5qnfh6iTcElsz3G8AC+Lin/qRLRg31pMGGxWbUze7n91QTRmdEJUY4zwKmsEzt84FtT
	GG9/p0jWtTE2eBOL27XpInh/Y951PaITU6YLfrPzR0xTJ3IMHyLOn2tV2B41IUBJZVELI2mKCuq
	IYDknT/UZDNPmrja11AAvnicS+F0mlVIkNbPtRHv7hTSFdsjGCjtrZJ4EpX5PYdTkLV2b701gkc
	8vRLqdL/1v8lnAagJmB0Jnf/vPD+zh4S235tOlHZ4o309fQbhtc9hEhpNhsUJpIXbVdrNy1nRwm
	BCai5rjOnFNcfOmXMM8hd7BwDcTW5PGj/VaXlWqmE2HujJ8fQ3J/vSim9jtyU4OLKwae9X
X-Received: by 2002:a17:90b:538c:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-3a49c0b06cbmr995624a91.6.1790671090167;
        Tue, 29 Sep 2026 01:38:10 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498c4b665sm1745414a91.2.2026.09.29.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:38:09 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Niklas Cassel <cassel@kernel.org>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Randolph Lin <randolph@andestech.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v7 1/6] PCI: spacemit-k1: Add device data support
Date: Tue, 29 Sep 2026 16:37:47 +0800
Message-ID: <20260929083755.458238-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929083755.458238-1-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
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
index 0564c46e2f48..ab2953ad8f56 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -45,8 +45,17 @@
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
@@ -274,14 +283,21 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 
 static int k1_pcie_probe(struct platform_device *pdev)
 {
+	const struct k1_pcie_device_data *data;
 	struct device *dev = &pdev->dev;
 	struct k1_pcie *k1;
 	int ret;
 
+	data = device_get_match_data(dev);
+	if (!data)
+		return -ENODATA;
+
 	k1 = devm_kzalloc(dev, sizeof(*k1), GFP_KERNEL);
 	if (!k1)
 		return -ENOMEM;
 
+	k1->data = data;
+
 	k1->pmu = syscon_regmap_lookup_by_phandle_args(dev_of_node(dev),
 						       SYSCON_APMU, 1,
 						       &k1->pmu_off);
@@ -295,11 +311,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
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
@@ -316,7 +332,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, k1);
 
-	ret = k1_pcie_parse_port(k1);
+	ret = data->parse_port(k1);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to parse root port\n");
 
@@ -334,8 +350,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
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
+	{ .compatible = "spacemit,k1-pcie", .data = &k1_pcie_device_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, k1_pcie_of_match_table);
-- 
2.55.0

