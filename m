Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4661130CDB6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982559; cv=none; b=P0/FU1XiSQP2YV3Frmku4BfC4nsH3jYdzlB44Y6h7i6CH/2MMqqNR3KDHPMz7ALHNQ+hI4sqcC/mLlsddJLGlAf12h2w4DYcc+VYQrz52ZtFRgKIdKUwOV5J3Vc0TNslQH7u3d3yucW+nb60gaTEuR8bIuZ8EVVfzih5ErKkhiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982559; c=relaxed/simple;
	bh=WBdA7jneFwFvik3c3/9FHniN5rPBo5pwL0bBpzNvnnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6gNFe0lWIhIHfqxxikoOv8NpeRmzStSRl5SOIRQFGfvVVZkSqrkOdBGI/pcaZpS4uQbtN6prcMJ1t8uBEmczRwUqEFuNd/psV80o/PwTgsVH7p9JEuineDykdbWvB1jEF9o7E6MTD3gGWVzWw+fGrwsKe9v7f9tUKnwzQ7d+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsGyteRZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsGyteRZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba21d32776so7565795ad.2
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982557; x=1779587357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=holLKJOKlFbzdQi8DERchaO2LakweIJGKpZqbMi14i4=;
        b=YsGyteRZIwdGnMk0G/Wprl6PrcXFgRUR/yfVmhOLZ6jtFBH/rEdbJs5pKaxBS6qQSc
         h6gg6RddNqyBrPRjzew8rVHarVjha8axpoxexW+B0V3/CzW5w7CZi9Ho7SK/paXV7LC9
         ROZ7cdw53sCFhxUlHU0vuHf3qVsVoReX7V9eQupo1FYcGwVpuqxHZvy6vD5v0z2QrJpH
         9dTSa92jg8WiSeLzgWPzqWpiHtKljJo4g0eSEUh4QZx1GOH5+CFWXK1hSqN+O0k0Cpew
         M6uXGAZd6uXMvq6rmH12wVFkysWLydrbItH4CQCpWBUS910VBB8FqU1cmpnSAISnBfNO
         Dvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982557; x=1779587357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=holLKJOKlFbzdQi8DERchaO2LakweIJGKpZqbMi14i4=;
        b=DLByQUSGk9fLwvSXnKWv+hP0IRlJOvpVdJgnqO6CF+5Fm5LpkjrNU+R2CpUVHSi/Fe
         llxv2IygADj/gK4kqNJe7652JJ3pqqadpdVDsLBFEAztiaRJHVpOSFTF8NRGbxB7/Y8I
         qfHOjEFh3CyRKPLglppAEkCWDTmyrPZ4ki1DZgc3eIHhgTM1FCpFUI+Z0JIKJGsXrX+1
         /e5ZnCANmb92ymXGsT2a9eJJ6dpIliidx5Uzfc799+W/K54blhyVGPeoTzCNIzm46gXe
         bkcMZRgTeSvcbBCc4/L8zxn6sFLyWMfN9BCRMvlsbKX5SKC4ovBVLOWK2N8Ydj4PoB8t
         LzoQ==
X-Gm-Message-State: AOJu0Yx5q3HSxPZ0cKI0DNp9x6rXYUnqZEjBBfEFb3ZAVvmxLuC1++dD
	741oJ4C8lgzI8lodYTT/Gw4u+gmYkPOhLov8cdKrVB38xUeHvLLV8IwK
X-Gm-Gg: Acq92OEdRb9FXdDbnvsVMO3UaYHNVoKEFjBYiskWW/KG0LWPOAvsfdEsW/EJDRv7fGA
	SfqCaeO0JRGnA36OJVxJLZ6IJzfSqOyATaUqRigm92tdZ0xsQcWejfVip52lx/4O/QpREY7o23V
	FACXbmiEo0LBeZz5FWEE9ugJRz1GaDbsCAX7MFZqyGPIU794JCi+ycEOq6Cy8AIm0HRCdaDkwWx
	K6E3T1OUD0Ym87nd3cLJMqoP/vI4Pzt+FdPU6fu7VAycyht6dwZJJ5Y3Sc8rmG85BpC1YySxvBo
	E0rRGQuo7sQn5wglrw0PfPfxWohau2tXwLiKI3Y3E8mlKeqSBS/BO3LQ07WTlhUVG+Ai3AoVBwc
	OzgEZKqobpXo+p9I7sFoZ19mno0wwmuMjfH3vqrppSEHXpxc7qk+ceminNZMHd17use1VL18Ip8
	hN4dA38RS2Ks3buDxm9j5Q9J0=
X-Received: by 2002:a17:902:d702:b0:2b9:ef36:434b with SMTP id d9443c01a7336-2bd7e7de8f2mr75213045ad.12.1778982557515;
        Sat, 16 May 2026 18:49:17 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe8baesm107831685ad.47.2026.05.16.18.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:49:17 -0700 (PDT)
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
	Christian Bruel <christian.bruel@foss.st.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Alex Elder <elder@riscstar.com>,
	Nam Cao <namcao@linutronix.de>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Randolph Lin <randolph@andestech.com>,
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
Subject: [PATCH v2 1/5] PCI: spacemit-k1: Add device data support
Date: Sun, 17 May 2026 09:48:36 +0800
Message-ID: <20260517014841.254085-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517014841.254085-1-inochiama@gmail.com>
References: <20260517014841.254085-1-inochiama@gmail.com>
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
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 25 ++++++++++++++++---
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index be20a520255b..1b519d49dcc0 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -57,6 +57,12 @@ struct k1_pcie {
 	u32 pmu_off;
 };
 
+struct k1_pcie_device_data {
+	const struct dw_pcie_host_ops *host_ops;
+	const struct dw_pcie_ops *ops;
+	int (*parse_port)(struct k1_pcie *k1);
+};
+
 #define to_k1_pcie(dw_pcie) \
 		platform_get_drvdata(to_platform_device((dw_pcie)->dev))
 
@@ -278,10 +284,15 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 
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
@@ -299,11 +310,11 @@ static int k1_pcie_probe(struct platform_device *pdev)
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
@@ -320,7 +331,7 @@ static int k1_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, k1);
 
-	ret = k1_pcie_parse_port(k1);
+	ret = data->parse_port(k1);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to parse root port\n");
 
@@ -338,8 +349,14 @@ static void k1_pcie_remove(struct platform_device *pdev)
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

