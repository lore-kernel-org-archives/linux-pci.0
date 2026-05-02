Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22FE324716
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716828; cv=none; b=khFelIQEUjDrg6EZpKoWhakSNDRX7vVd3YP8m4UwGXXO1KPplmQI8GhAiYxqcWsR2QOTeIZnfKybAzs6wb2srLORhLm7weG92vo0UFb6wMQyGMPGmcGzkZWg+20gfLqJe/jjX9jtmmj/UcWyYqDK07TjnLtdnoyHM470YOkpPV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716828; c=relaxed/simple;
	bh=gEjev9liaNaMDJWD4B3vuXkcNGIuaztQH3cR5GkLXz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwd+1eEx07sMPjdvyOu8/GtAATuvSn9ku5JUuLx2Icu7mewTxJVLv+9IqGE3ESyf4IyJ1cOTUaWxXMJZpW2HgLZPHHCBQtPCFegIQh5jfgLyKDPHUv5UPz/+SG19GTH+EsNPTTzrORj1M792fBZVn2lVxJ/ekWKPm90APQS5iR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+SDHlH0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+SDHlH0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b788a98557so22600295ad.2
        for <linux-pci@vger.kernel.org>; Sat, 02 May 2026 03:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777716824; x=1778321624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcMticRbbnlhc13eC+umkLKNNwt7Hul0SNRld9/CX3o=;
        b=r+SDHlH0xQkfOXSRpsDx9ariCPBW2itqBHi0j3/5svsATKlEC9QtJzthMWaXtvkn1y
         IHBoPiPotV6WnoysyPAMsG+aSiTiW2GEg0yksiFgIJ7C22FNtBWTnya99jbtlpG1vaHD
         TLLUWaDb+xeyAL3fUA7D6YFHfmGrouZFW93RREvi9lfDYNAIqAEw2JIA/LEdz+xu8vSM
         wsnyAhY2FxxDfws/PlK6gLLCW3P9SsLP9nXAnu82/BNAFiddpZ5bmM7GwERPJqjIOqFW
         sVP7TTlWd8DHs624Z6KL+CWUeN3KrGZBAkjg6zv/TI/KiOJFpxDnA7IEefThQyUPg8S8
         hRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777716824; x=1778321624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WcMticRbbnlhc13eC+umkLKNNwt7Hul0SNRld9/CX3o=;
        b=saZyEQKVVq+TuiFikhEYrNRzBP6L2RuBG0a2M2GVuaxYOenNBsS2D5TaOt6OC4BO+8
         PDuenfM+Cmv6z49XAaIwtU40krOVqUMu7XPl5i6xcGy8h2Rrh2uUnxgstsyYkCZxLMhl
         tYnFl2BPDEKgA5azBQ3McYtpAgjIPNz09N5pUfbgCShnCw03NdiqMIAIcurA45jg0K1/
         +0iiwMvdzzbCH0VKxx9NpJOF+fnSq+WFc4Vk60nmVsGYIYNc8fVHe4TjRiSCJb3HaVQC
         yE9fVaryiy2M8JdFionLOLG/IDydwyQHMYHGRY2rk1Re35PnyIlYemW12seR5mj/KbxG
         bt7Q==
X-Gm-Message-State: AOJu0YwNB8IkYFGHrd8zrwqXvdkszv2wM86keF1unhuLG9H5DFObJIhI
	C3zay5K1NBqjbfBEhXG3mlR+jQQpxlu2aAGSIkbdr0nJhoKxj3SbVNFr
X-Gm-Gg: AeBDietBmqQeMJBhVXYhcbIBhCfRxqoCWt+9QyBDifIJf4rWy1UQYDUjk2usGfklTLH
	ah49o4eRpU3V9laUd8bmcwyZC8HW5lGlrygKsAUezVIAn012inMNZmesmaulu7LCGhbI33cgTVW
	TcX6B4K5MXJlg+1ld8kZRc27kuFYOjkLHG/eKxXATlgrZqWVDu99wHaT/vXNTgACOhHck452nnp
	5tNrqrCNpP6ti27Ex7NEpPB3Xjk5CjBxtVi3/7KjWc7I+HDAsnzN0ThbfTnen9ovkvlDoGHJCSV
	yUZiW4KpsaGrbusYwSj+vx6h7ZF5x03rMw75vmtJRMxTXGBAvioprOZAAvSMbPbVoq+kjMI7RAM
	Nzxw4SNu9TXhWU/QL2aOG4e+vIJmoWlkhOEvuIcInGQOtoZClWYotRCQJlQXF/aTGL8G2C3j/xi
	OqcYAs7QTnRaOsOZWjtHgGvetARuQiHnpY/g==
X-Received: by 2002:a17:903:2ecc:b0:2b2:4dd2:dcf5 with SMTP id d9443c01a7336-2b9f260b757mr24434785ad.20.1777716824197;
        Sat, 02 May 2026 03:13:44 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae68476sm45629345ad.80.2026.05.02.03.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 03:13:43 -0700 (PDT)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Alex Elder <elder@riscstar.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 1/5] PCI: spacemit-k1: Add device data support
Date: Sat,  2 May 2026 18:13:14 +0800
Message-ID: <20260502101319.2364052-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260502101319.2364052-1-inochiama@gmail.com>
References: <20260502101319.2364052-1-inochiama@gmail.com>
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
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 35 ++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..cd3cd038ad2b 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -57,6 +57,13 @@ struct k1_pcie {
 	u32 pmu_off;
 };
 
+struct k1_pcie_device_data {
+	const struct dw_pcie_host_ops *host_ops;
+	const struct dw_pcie_ops *ops;
+	int (*parse_port)(struct k1_pcie *k1);
+	int (*post_init)(struct k1_pcie *k1);
+};
+
 #define to_k1_pcie(dw_pcie) \
 		platform_get_drvdata(to_platform_device((dw_pcie)->dev))
 
@@ -278,10 +285,15 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 
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
@@ -299,11 +311,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
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
@@ -320,7 +332,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, k1);
 
-	ret = k1_pcie_parse_port(k1);
+	ret = data->parse_port(k1);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to parse root port\n");
 
@@ -328,6 +340,15 @@ static int k1_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to initialize host\n");
 
+	if (data->post_init) {
+		ret = data->post_init(k1);
+		if (ret) {
+			dw_pcie_host_deinit(&k1->pci.pp);
+			return dev_err_probe(dev, ret,
+					     "Failed to post init\n");
+		}
+	}
+
 	return 0;
 }
 
@@ -338,8 +359,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
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
2.54.0

