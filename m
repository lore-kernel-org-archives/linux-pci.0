Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79653054E4
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778982562; cv=none; b=Tg5M1gfcvEficlJQlfUTaYQDXRwznBBCiURcIP/5QV0pyam9mkRRo+HUBQUxktK3DMlejgayj31xbU3sWw2E39QMmGLjLRmHNrBk7LOMt1cm4pSIjBP2kXcV5gAj1OsfKujap7jg1vGOdrIFqQFa2YZfmV2HbqY/L+HxNePqGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778982562; c=relaxed/simple;
	bh=7xXazUW++/Ihl/B9YC+Gc9/dkyUHgTw/pMGMhxHIGmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlDvASc/7nzUMC1GMv5DCFt3ybrXdcTpufQ39YYWF6L7ARDWgpeym+hX6ngj/6yV2iv//eswPNvrXKnfllOFERQtFEkUyxy+nFNlP8TOXWn8wqOfMf3Ch0SJ2tu7OxXH0gK2SlyhwTQMw1fjsYm9/463zjNi9NEGlxU1neH2Jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyREupKY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyREupKY"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c7980c060cfso407629a12.2
        for <linux-pci@vger.kernel.org>; Sat, 16 May 2026 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778982560; x=1779587360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soU3PERBuMP9kXvFqB8tDnXdMIQE2fWpQSLyN/x1tn8=;
        b=QyREupKYPNmrCerLbQWbbxZQMYkt2XXXfU6efpmrCdeLneDR8Lbpa3r6W9KSdqZA+J
         uQR0mhpnp58MYiUaQI5J8uaQMAbsi31EzGEG/mLiYBKp5TZC+KckhT+q4Z9VMG8BedJl
         Ajiyt6haXa6ft/z4mCpHSICt9mbO2ltAzgcQ8dlshn+Mpv6ekIkCJR0whvq+9KllC7uq
         RFffdZwmMp4vFfnhjZW5bPZLdH891rZ4DzfmF8A3Ouh6Kw0vuOU7rH04YPMXV2HV/kor
         5/N538riu7ziFTMUsWCpcSqWx+k2vZNI3mmDuujQ9jN1PjtrMgxd8VvZu6v0i8dvm1Bw
         ivig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778982560; x=1779587360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=soU3PERBuMP9kXvFqB8tDnXdMIQE2fWpQSLyN/x1tn8=;
        b=r4as2HvKAs+yr+Z1wxcZB1jY9sEcghbJYI69gDj5sYgU552Baqoq3Zqxrve8tnu0H8
         EzG0kF8FO7VMAZk9lVobl7NhsVHcC/PaVmFQdMK7h7j9hQCm3TIMBjsvup+bxjliXEGw
         RUuc/HQxp3794FPqqyrbKg/RPd57HWTh+NseTXgjg0dnwNvL2+JFQQorFCZVUmXWeqll
         nIEz8eX6AZ7Nb568vRlUdyK6e21ZO1EkHL2kfroz+YrfSu81E+uKEZKDtXWgty8RTbcS
         rIUwB6CwMKwYFPz/uT3AFiddr5c8TBQTgcYN3dPk/ZSUhPgJbxulDgjqIbR6sigz7q10
         DvnA==
X-Gm-Message-State: AOJu0Yzp6IrMrWGukwVW9NyRGmAyPkiPVYJoJCjfPN1KVjJUShESvMYK
	EBBZVAw6gimgaB4igMjBLeV57wAZiWzdkcagR0jZs3PuZQudPV5UtbBn
X-Gm-Gg: Acq92OFI+Y8UjYSN49d+vN5XSpPQ3T2irO8iLtVQNpFmNJGJ5EOyI330y1uigy7iI9x
	FibsroUenih8SDoMi64kAX1lecIKYBFtJRUGBxLA3kY5jiFQj4TKlNr1T2aMauxCx9oPf/RmJ5R
	C6JH3DC4pbKyUiG6mxpglJGR4gzeAkF9/Eg7sixTRhBYTbb2Yge3vJ/wBwWCXsL1FMxfE0evBEW
	AeODWF44cAl3fstEvK0LKgYX5dKMuPkzH8UNLZ0BTiyHadF3Adx44GtLLzo5Gi9dFEPXWXLRhvN
	JRe7iwcLbto8/JhkLvJYdVR+2ofl67KRd37W4/QaPsjw19nQO0rD+Z1kIZ1fc6uc62054v6NwoK
	cXikD32d+ccITajUsHGhy2X4TJd9xHVMiw0JAvorD8KA4FyLWuum5JzPkPDHwzIhCz25zMrn2ry
	dKQfxq1NIyAv+pmgpbPU9MB5o=
X-Received: by 2002:a05:6a00:a1b:b0:81e:f1c3:89df with SMTP id d2e1a72fcca58-83f33de1258mr9305811b3a.50.1778982559999;
        Sat, 16 May 2026 18:49:19 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19778ad1sm10531320b3a.17.2026.05.16.18.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 18:49:19 -0700 (PDT)
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
Subject: [PATCH v2 2/5] PCI: spacemit-k1: Add multiple PHY handles support
Date: Sun, 17 May 2026 09:48:37 +0800
Message-ID: <20260517014841.254085-3-inochiama@gmail.com>
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

The PCIe controller on Spacemit K3 may use multiple PHYs at the
same time. The feature is not support by the current driver.
So extend the PHY definition to support multiple PHY handles.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 1b519d49dcc0..7f6f1df31cd8 100644
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
@@ -171,7 +172,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 	 */
 	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
 
-	ret = phy_init(k1->phy);
+	ret = phy_init(k1->phy[0]);
 	if (ret) {
 		k1_pcie_disable_resources(k1);
 
@@ -191,12 +192,14 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
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
@@ -277,7 +280,12 @@ static int k1_pcie_parse_port(struct k1_pcie *k1)
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
-	k1->phy = phy;
+	k1->phy = devm_kmalloc_array(dev, 1, sizeof(*k1->phy), GFP_KERNEL);
+	if (!k1->phy)
+		return -ENOMEM;
+
+	k1->phy[0] = phy;
+	k1->phy_count = 1;
 
 	return 0;
 }
-- 
2.54.0

