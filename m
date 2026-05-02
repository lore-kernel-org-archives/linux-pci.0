Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BA3264FD
	for <linux-pci@vger.kernel.org>; Sat,  2 May 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716830; cv=none; b=pLjy4qiJc6yqb2718a/Sd7FHAFr7XKMASqARemEPqTiyCjkkp1hEFTH685FbSw4gwgKtWzFRQr7opTmrjdrC5lz+2cttM2DubrlHGLzMkTbo1+ddlhpD5BAcg7ZFxcZatwcmeAXjefnzgpnXWVHoCr9hL1vJXw1IZ5x1ZQ+eQuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716830; c=relaxed/simple;
	bh=3pw1bdZuuXwrz+VnxjRJOnM0J5m0J5qcFaU9OOGALKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbICuxjHqQv5CjzcZsnoc9OSlVGA0eHcMpiIFHI/6+MqrHIXjzrgaerQxV032eDo9VlM3Clv05S1QQQBwkb0YLRdD03HJyEc6k23HEjGBnzh4jFN3D8wpscZXyE2BT4IjqjKWh/Zn6TBY5JF69YUR6b6T0MJ/5M70qrfMTDhlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTWVdTtO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTWVdTtO"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso2367135ad.0
        for <linux-pci@vger.kernel.org>; Sat, 02 May 2026 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777716826; x=1778321626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmMzz9kPOMJ2V6hEeqZMS4vdi4snOlkMyKNu1sYiAzY=;
        b=iTWVdTtOX5ZK62LXFvK4n1MwikrAxtRgCiAvF3VfshdeoXq69dmuzZbMWT5Uuq9vw7
         4OnDMilqRcS+9vFFm+fOLJKlgk8ONlCuj62Qd2aGU2jg7xeazqIvZ5l5t6Z1qXb3kma7
         HylTwmpK1lpxHdYSAxaIHjbMjgN3gn7WobDqQlziA9u86tTkpaCPEpy3/zpZPqcr0Ixr
         hQIDNZs9pFLSpJu5uG1wHS7bVU+1a3g0o3lZrUZ4SVqnlIpH4e39ShWXxTpFzB/wnDvY
         rIxUudTHtAlmQgKoUSOsHAgCBV5qDqjgkY1CiCYLYO1Wz+sWl+iwle5wG7///5OajFDY
         WDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777716826; x=1778321626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmMzz9kPOMJ2V6hEeqZMS4vdi4snOlkMyKNu1sYiAzY=;
        b=L+WUgbFcfq4AX+7o1GxMa1pu6EIUP70wVe8qEZjkDD9U2KAjnNgzk4U1Af8Df5spQN
         dA7KKIZ9D7VJMMeYDVxKcSYXYZZb8SwkCst52fveksShWb7Ls6Xg8w14Q9l4DAsbgy5A
         F/iiYkreFQlLOmhUQet8YaiiA5VYdiBJjyRbkvjnnGpuPeWBBqxghgMUHh/n+Q+0VAOY
         qUEVmvaBNkjgrucDIhTTTxHZLZOlKkWgf5kdxbmfkN4NjpWw+a8gh+TIuGvS0ncxFjN7
         khUn7AGj+3fTgc1VKKPl72PhiW+X+/bRz8OQ+LRSWOWMFg4Fr55a4wf2bV8vdqy3dWGV
         a3lg==
X-Gm-Message-State: AOJu0YznQiuTZzH7lHJjm2GclFdXRoFJvtqXXkeTWRLqkKh/RupxlsVs
	lxnACakRmQsecnk7uCQAAnkwsuVJsumg3WwDf3hbVnwtrQIZE+HoWwoc
X-Gm-Gg: AeBDieuy+XkLCRKmZ/N1uSzkcdyCwEyNogn0yqBRFOwzV6B8vbdqha1P6ZwE0zr4Z04
	WBACIfE334mcTI15LQR86rBr/jZQ4u9SOMPzP9EfkW8S3AjI4LKTbtvXeViMncSCVFNEuNfa4P6
	p+f9vQoUnG3fAh+yoWTtVKLjFifh6ncPpNYBwnQODyrQEdA2W3SBdUG8CMCr5RkVT+77aTeu/MS
	ry5TLSwKg23vV8tW2P0159rSmT/vvcMNOIUQKaxhojntg7nKiM7bvKam1cKiCPau1YDJNKPD0Va
	THiZu4uj+Uab9Ij6UJ8/ogqruqEBJgrpPTJ1xKdUZ/NXWGGd7ysljdef/TS10YBy1ix3ckklafa
	bdsYXYi6ydBcMaX3iDASKf2YHmRZnk3F1Fs7dQD5r3TdS4p8b4RvGUD4Fr6+9fVQmoyQ7XxyG5H
	SH7vs26qoQLw8kC/WpDdFjvlDCKTgSyHAuUQ==
X-Received: by 2002:a17:903:3d4c:b0:2b7:ade8:2407 with SMTP id d9443c01a7336-2b9f25e8353mr15599855ad.19.1777716826438;
        Sat, 02 May 2026 03:13:46 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaadb1esm48776715ad.20.2026.05.02.03.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 03:13:46 -0700 (PDT)
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
Subject: [PATCH 2/5] PCI: spacemit-k1: Add multiple phy handles support
Date: Sat,  2 May 2026 18:13:15 +0800
Message-ID: <20260502101319.2364052-3-inochiama@gmail.com>
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

The PCIe controller on Spacemit K3 may use multiple phys at the
same time. The feature is not support by the current driver.
So extend the phy definition to support multiple phy handles.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index cd3cd038ad2b..f2a722e5edb5 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -51,7 +51,8 @@
 
 struct k1_pcie {
 	struct dw_pcie pci;
-	struct phy *phy;
+	struct phy **phy;
+	int phy_count;
 	void __iomem *link;
 	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
 	u32 pmu_off;
@@ -172,7 +173,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 	 */
 	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
 
-	ret = phy_init(k1->phy);
+	ret = phy_init(k1->phy[0]);
 	if (ret) {
 		k1_pcie_disable_resources(k1);
 
@@ -192,12 +193,14 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct k1_pcie *k1 = to_k1_pcie(pci);
+	int i;
 
 	/* Assert fundamental reset (drive PERST# low) */
 	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
 			PCIE_RC_PERST);
 
-	phy_exit(k1->phy);
+	for (i = 0; i < k1->phy_count; i++)
+		phy_exit(k1->phy[i]);
 
 	k1_pcie_disable_resources(k1);
 }
@@ -278,7 +281,12 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	k1->phy = phy;
+	k1->phy = devm_kmalloc_array(dev, sizeof(*k1->phy), 1, GFP_KERNEL);
+	if (IS_ERR(k1->phy))
+		return PTR_ERR(k1->phy);
+
+	k1->phy[0] = phy;
+	k1->phy_count = 1;
 
 	return 0;
 }
-- 
2.54.0

