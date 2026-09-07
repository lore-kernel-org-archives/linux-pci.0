Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3051476055
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780401; cv=none; b=qIDSHJbomJxZumDZFbTmt6kPxaakl2aJ0lWtslrVUrEey208NXyT5C4dojYRxFvr5TzI/DZf96hc5afpMAaMimn6SoK8Ph5YdckY8ME3kUrsTFF3tFWHYqPU6G2w1Ifzcn/0nFjlLp3s/mGfRBC2OO+wrotx6V6OBh7Ezp1rlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780401; c=relaxed/simple;
	bh=mdCPQeEcSAMoGJw0IrGjVzlTvAigGgNLqFZhPQ1+zZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzgjVfto8wuidm4lQkyHgWsnAq4IoNZu2WTdCFRr0QfQRfM65c1fhpwjYLLD8cVShFo+oef6YhWvk47QXLXnJ4b7/7V4jZC1WrIqtgrsgp5Qzhea6ruCyn/i5HxmIGGZxlewfR0PGRNtEEZr+0yD/LpTB2WEiqJJ2JXNbu1hSPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWbpjmi/; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWbpjmi/"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso2269062a12.2
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780399; x=1789385199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYNU3JutMTV98e9RCfpqkVsEuBCUrUdbqqssfR9cXXM=;
        b=TWbpjmi/LkluEWP0L3frAlkV52+WxtLHPLYCDRdK1S+8Fr9BFEEnO/vtowh1jOB7NJ
         omAfsKFO8e31GU9ohi0tEIX8YHDSXewzxQxL5QVTGPpFYbkJl6h6N38WFuBSTplWg813
         ken0MVA9dbLBQOR4EuUDPNS1DHiFviSTNsuPPYNFX31som1FtJp4kheNK2yQ5WPvt71k
         gEgM40elsLrZGSEZhxZ/OWkM2OtAepF/lF76OZdAJGh7ilNQOwg0cFSuDG1hyCXhZAY9
         kxUIC/lzC4j6rW65F2OADONXQwGfK38GQDiv3HSfUIRQxe18Qo8NsmdDVx43bjwd/1S9
         /9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780399; x=1789385199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYNU3JutMTV98e9RCfpqkVsEuBCUrUdbqqssfR9cXXM=;
        b=jhcLfJdzsZ1kCVTMw2BRaUvYyyMRw8EgvYVcExCCv2M29RFsWabZfuSqbKG73AKB0P
         dCh9LlZ0nKyIML97QuFF2ro5Ti65YH0USJCwqX8tt9rHpBLUGmW4coYtkZPjQ2DPOEyZ
         WlfQFyx26qyXEwxJSDuf1xM7uNbEXPCIQ0+HRaTN+fwFNxChW89eAURB3J+nJA+Cu/xe
         0wXfyClxGFgy+3UOFIAmOoVQpFbMHWG2dc5okllMaiceq1Yhd8s2j7ej7cE3QvSHoKA0
         GoKJAf4cLFvTu0YpiuOqa7CgR89DnQyXjOE37LVjCJ6bT5FcVgcbrga8s9dqaBAwM/z0
         juVg==
X-Gm-Message-State: AFuF++kZMGwQbSDJ5mM3STosfxLzg5E544UDN9xDtsSwBEpgU5AK9Pg0
	xgEYsDydbltP0aycp4BkF20eOPQbJ1P4say4jeIFnX0QfqEP1uWEzZ93
X-Gm-Gg: AYBFou383nyNanjE2eAnudrkomiNcS08lIFiwYzJ0C4yJvzqdoCJUTxTGs9asbTI3nF
	yfhJmhQIfDrbuFlQrI8cTCQ2curhsL+d9mHnj6HJskSGvtcxAErZnbHk+YiUqRtdBA6IyRk8vjZ
	/7IztzPhgK6PrAI/5mzR7X2frBGZjX14b7LFGyYchfC1YRc0ndrBQ31HcUI8DDws+4bI7+GbMET
	319cGcfcAhOYJRDbk32sidhLX9WfHEXXYqWd1Opgm5PPQ0Dv8gwJfB3zF6jvwvPCS4w7lU0vbOF
	A7EWe9ztdwUcxfzXzHkoSBIYBpWJ1Etj9sJmSuws6IkzQBgA1bwKSg4wLPbxlDyLWAdbudsUexs
	MUv6EsrUK5wBh5oooDIOgBzQqcj06faYLbzqB0vtqGiAuDVCht4DiD6rxtzsNyN/FdTXrmc3sxx
	gtmD/Lav0Wh4tMUUZNHYncOK20rpQbQvXZhIjM
X-Received: by 2002:a17:90b:510c:b0:398:9be6:f999 with SMTP id 98e67ed59e1d1-39b262e27a9mr37011195a91.24.1788780398731;
        Mon, 07 Sep 2026 04:26:38 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm19984853a91.13.2026.09.07.04.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:26:38 -0700 (PDT)
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
	Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alex Elder <elder@riscstar.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 1/6] PCI: spacemit-k1: Add device data support
Date: Mon,  7 Sep 2026 19:26:00 +0800
Message-ID: <20260907112606.465778-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907112606.465778-1-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
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
index 0564c46e2f48..9512556d4539 100644
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

