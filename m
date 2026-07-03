Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9CF22FF22
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044043; cv=none; b=cW/n+625kwvvz9fVPoaRf5daR1bVWsXAZcwBaj8bsbr29VlWDwtGFZqucr+u7E8jiWyRw2jSbLz7kkCv4DDRoMY03Oz57EN3cah2zcaAp41LZikYwPQW4X34P0PN9eWLij1duEqTFrQCdeAvDB6a4hdYKQms4MlKOn7zgyFAVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044043; c=relaxed/simple;
	bh=04yEbrBAj5g/Fp2zUPgpONY8/+NGEPJo0vMYeCOwxNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dExsVh8Eqdh29nsyUp2qqLQjAUYT+w9HdSxaXHCy6yzrONFRaMB5r2pLKXcTkrkOSEZqUY0NMP02SgcyEl9AFrDinppsq6HeMjQXIM+XawgjpvHPe29v+chj0arsx+5f3YEbs/ikzHsXDKu23bLuShUUUitAfbGfxkJtbzIobho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4IaH3T7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4IaH3T7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3811f512167so44380a91.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783044042; x=1783648842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkWnYh3cllnXcTwBIcvBSJWZoRydH1m54nLp+o8irTo=;
        b=N4IaH3T75ATNNA/UInlYAagFayOjttQBH4rjtmJCKaoLP/Y4JrR5t0Kl4aLRcXwXTp
         S8PiC083gog4Dl4oqosCp356B8ycrDs8ls05CUwbOkv+DunK+aDvXA4M6KNY54qn4KZH
         vVY/ojrchwc/7xItbxNChfXt46k2xt/MzfG5Arodw4M2Q8acmPyRczNb6z6bOqIQXH6B
         p5f+FKA/v4xq3wfbmVQ7M2PHzbfr0WEpbHhemjmyPn8Vd1uSCJYSksa9SRWMZufkNQUC
         64ZmzjU6JYT1ijt+5AKTJYEsj+lviNjWYwypr3LMP1Wp1rxMs01TLalgd7pNmgXoZWs3
         yXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044042; x=1783648842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KkWnYh3cllnXcTwBIcvBSJWZoRydH1m54nLp+o8irTo=;
        b=JRXxN/7J/Pur9Rfq2R+y+gjpXDGJpahfBEUWMkIKPwiFW+UlCmsA5BrvOicv4CqGud
         eDenNKZmWQKr4x9WFkNV9eUjfnRC0U/gwslGMGvVsBWTo22do0JoWBXah14+7ePv5WMr
         RFk84D+K85RikhnjDLLT+hrrmiD9NQstNK04mo8WRtuLrpQGj+io0m6M5PWcQMAkwDp6
         tcsZvHdNJMqBX4Kz+uzw3Qyn1nqQSRvBEaxYg15dj2/ME3UkMn3VW/5VQqdbaqCEHpJH
         lFTOfmQIggFOMskJrX4yLVYCFYdWUm9iqkbbIGY9UQSu97arHuqs8SJi7BMnOT2aG/9a
         EtDA==
X-Gm-Message-State: AOJu0Yw8JnVXL471ABkW2SlXx/MvUC8IJBMwcUEWtAV+bbWcaNeU8HFT
	8YfBfRVyffr2hpZkR/Xgvf6a2JQcrbaQOaLoFcySYtHg6ee/J874OGbj
X-Gm-Gg: AfdE7ckznMunTAQKsBm/BscdnVE10EUfHCdACyB1QIFbXqP0DC1DFm5BBmnlqUipyDM
	vHbaz+QpZmYdmh9rkPT8RsuooFzbIMF4SDMPHYFagsdPUJmvhnQGbNc79S42uNPsoroojAowmKj
	eftKlRJOTQ8f2wJNHLd6ESA8eishktbnkuJ+MAZukf9hYpITGKrOkxzxI3wXPwcza9mGhKnNx9f
	LAPqc9Jq0PzT8cXzTOKb7zkGC4uqXTfFE3NrixrDi+6HwmsmJGEMcZeKDlgrdBKBNfAI8JqzR2A
	Y/f57vvaJRr42TVuzJZgPyUvtmXeQpX/MwmAgwZ1G8TgeK9gk/oazqf/cu3m6zlpo8/AsVDPMWl
	cCLlZ8oDZnqWDHoSxw5kB9VaHNn/ntUWgN9duX1vfx/Gt9JjHyp4miinjGHCjvAseqImzsGrQC6
	f+PF8B4GHQZGE=
X-Received: by 2002:a17:90b:2c87:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-380aa0e0512mr8521066a91.14.1783044041818;
        Thu, 02 Jul 2026 19:00:41 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c12792sm190602a91.5.2026.07.02.19.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:00:41 -0700 (PDT)
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 1/6] PCI: spacemit-k1: Add device data support
Date: Fri,  3 Jul 2026 09:59:57 +0800
Message-ID: <20260703020003.485436-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703020003.485436-1-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
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

